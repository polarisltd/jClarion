package clarion;

import clarion.Abutil;
import clarion.Constantclass;
import clarion.Extractfile;
import clarion.Translatorgroup;
import clarion.Translatorqueue;
import clarion.Typemappingqueue;
import clarion.equates.Constants;
import clarion.equates.Consttype;
import clarion.equates.Create;
import clarion.equates.File;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.equates.Term;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;

public class Translatorclass
{
	public ClarionString extractText;
	public Translatorqueue queue;
	public Typemappingqueue typeMapping;
	public Translatorclass()
	{
		extractText=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		queue=null;
		typeMapping=null;
	}

	public void addTranslation(ClarionString source,ClarionString replacement)
	{
		CRun._assert(!(this.queue==null));
		if (source.len()!=0) {
			this.queue.textProp.setValue(source);
			this.queue.get(this.queue.ORDER().ascend(this.queue.textProp));
			if (CError.errorCode()!=0) {
				this.queue.textProp.setValue(source);
				this.queue.replacement.setValue(replacement);
				this.queue.add(this.queue.ORDER().ascend(this.queue.textProp));
				CRun._assert(!(CError.errorCode()!=0));
			}
			else {
				this.queue.replacement.setValue(replacement);
				this.queue.put(this.queue.ORDER().ascend(this.queue.textProp));
				CRun._assert(!(CError.errorCode()!=0));
			}
		}
	}
	public void addTranslation(Translatorgroup tg)
	{
		Constantclass cnst=new Constantclass();
		ClarionString text=Clarion.newString(Constants.MAXTLEN).setEncoding(ClarionString.CSTRING);
		ClarionString repl=Clarion.newString(Constants.MAXTLEN).setEncoding(ClarionString.CSTRING);
		cnst.init();
		cnst.addItem(Clarion.newNumber(Consttype.PSTRING),text);
		cnst.addItem(Clarion.newNumber(Consttype.PSTRING),repl);
		cnst.set(tg.getString());
		while (cnst.next().equals(Level.BENIGN)) {
			this.addTranslation(text.like(),repl.like());
		}
		cnst.kill();
	}
	public void init()
	{
		Constantclass cnst=new Constantclass();
		this.queue=new Translatorqueue();
		this.typeMapping=new Typemappingqueue();
		this.addTranslation((Translatorgroup)Abutil.translation.castTo(Translatorgroup.class));
		cnst.init(Clarion.newNumber(Term.ENDGROUP));
		cnst.addItem(Clarion.newNumber(Consttype.USHORT),this.typeMapping.controlType);
		cnst.addItem(Clarion.newNumber(Consttype.USHORT),this.typeMapping.property);
		cnst.set(Abutil.translatorTypeMappings.getString());
		cnst.next(this.typeMapping);
		cnst.kill();
		this.typeMapping.sort(this.typeMapping.ORDER().ascend(this.typeMapping.controlType));
	}
	public void kill()
	{
		Extractfile extractFile=new Extractfile();
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber d=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber items=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (this.extractText.boolValue()) {
			Abutil.kill_ExtractFilename.setValue(this.extractText);
			extractFile.create();
			CRun._assert(!(CError.errorCode()!=0));
			extractFile.open();
			CRun._assert(!(CError.errorCode()!=0));
			this.extractText.setValue(extractFile.getName());
			this.queue.get(1);
			while (!(CError.errorCode()!=0)) {
				if (!this.queue.replacement.boolValue()) {
					items.increment(1);
				}
				this.queue.get(this.queue.getPointer()+1);
			}
			d.setValue(this.extractText.inString(".",1,1));
			if (!d.boolValue()) {
				d.setValue(this.extractText.len()+1);
			}
			for (c.setValue(d.compareTo(this.extractText.len())<=0 ? d : d.subtract(1));c.compareTo(0)>=0;c.increment(-1)) {
				if (c.boolValue() && this.extractText.stringAt(c).equals("\\")) {
					break;
				}
			}
			extractFile.line.setValue(this.extractText.stringAt(c.add(1),d.subtract(1)).sub(1,8).concat(" GROUP"));
			kill_AddLine(extractFile);
			extractFile.line.setValue(ClarionString.staticConcat("Items      USHORT(",items,")"));
			kill_AddLine(extractFile);
			this.queue.get(1);
			while (!(CError.errorCode()!=0)) {
				if (!this.queue.replacement.boolValue()) {
					extractFile.line.setValue(Clarion.newString(" ").all(11).concat("PSTRING('",this.queue.textProp.clip(),"')"));
					kill_AddLine(extractFile);
					extractFile.line.setValue(Clarion.newString(" ").all(11).concat("PSTRING('')"));
					kill_AddLine(extractFile);
				}
				this.queue.get(this.queue.getPointer()+1);
			}
			extractFile.line.setValue("   END");
			kill_AddLine(extractFile);
			extractFile.close();
			CRun._assert(!(CError.errorCode()!=0));
		}
		//this.queue;
		//this.typeMapping;
	}
	public void kill_AddLine(Extractfile extractFile)
	{
		extractFile.add();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public ClarionNumber translate(ClarionString str,ClarionString rVal,ClarionNumber level)
	{
		ClarionString s=null;
		ClarionNumber i1=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber i2=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber finger=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!str.boolValue()) {
			i2.setValue(CMemory.size(rVal)<CMemory.size(str) ? Clarion.newNumber(CMemory.size(rVal)) : Clarion.newNumber(CMemory.size(str)));
			for (i1.setValue(1);i1.compareTo(i2)<=0;i1.increment(1)) {
				rVal.setStringAt(i1," ");
			}
			return i2.like();
		}
		if (level.compareTo(Constants.MAXRECURSION)>0) {
			return Clarion.newNumber(0);
		}
		s=str;
		this.queue.textProp.setValue(str);
		this.queue.get(this.queue.ORDER().ascend(this.queue.textProp));
		if (CError.errorCode()!=0) {
			if (this.extractText.boolValue()) {
				this.queue.textProp.setValue(str);
				this.queue.replacement.setValue("");
				this.queue.add(this.queue.ORDER().ascend(this.queue.textProp));
			}
		}
		else if (this.queue.replacement.boolValue()) {
			s=this.queue.replacement.stringAt(1,this.queue.replacement.len());
		}
		if (CMemory.size(rVal)==0) {
			return Clarion.newNumber(0);
		}
		finger.setValue(0);
		i1.setValue(0);
		while (i1.compareTo(CMemory.size(s))<0) {
			i1.increment(1);
			if (s.stringAt(i1).equals("%")) {
				if (i1.compareTo(CMemory.size(s))<0) {
					i2.setValue(i1);
					while (i2.compareTo(CMemory.size(s))<0) {
						i2.increment(1);
						if (s.stringAt(i2).equals("%")) break;
					}
					if (s.stringAt(i2).equals("%")) {
						if (i2.equals(i1.add(1))) {
							i1.setValue(i2);
						}
						else {
							finger.increment(this.translate(s.stringAt(i1.add(1),i2.subtract(1)),rVal.stringAt(finger.add(1),CMemory.size(rVal)),level.add(1).getNumber()));
							if (finger.equals(CMemory.size(rVal))) {
								break;
							}
							i1.setValue(i2);
							continue;
						}
					}
				}
			}
			finger.increment(1);
			rVal.setStringAt(finger,s.stringAt(i1));
			if (finger.equals(CMemory.size(rVal))) break;
		}
		return finger.like();
	}
	public void translateControl(ClarionNumber p0)
	{
		translateControl(p0,(ClarionWindow)null);
	}
	public void translateControl(ClarionNumber ctlID,ClarionWindow win)
	{
		ClarionNumber colCnt=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		ClarionNumber ctrlType=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionAny beforeText=Clarion.newAny();
		CRun._assert(!(this.typeMapping==null));
		ctrlType.setValue(win.getControl(ctlID).getProperty(Prop.TYPE));
		this.typeMapping.controlType.setValue(ctrlType);
		this.typeMapping.get(this.typeMapping.ORDER().ascend(this.typeMapping.controlType));
		while (!(CError.errorCode()!=0) && this.typeMapping.controlType.equals(ctrlType)) {
			this.translateProperty(this.typeMapping.property.like(),ctlID.like(),win);
			this.typeMapping.get(this.typeMapping.getPointer()+1);
		}
		if (CRun.inlist(ctrlType.toString(),new ClarionString[] {Clarion.newString(String.valueOf(Create.LIST)),Clarion.newString(String.valueOf(Create.COMBO)),Clarion.newString(String.valueOf(Create.DROPLIST)),Clarion.newString(String.valueOf(Create.DROPCOMBO))}).boolValue()) {
			while (win.getControl(ctlID).getProperty(Proplist.EXISTS,colCnt).equals(Constants.TRUE)) {
				beforeText.setValue(win.getControl(ctlID).getProperty(Proplist.HEADER,colCnt));
				if (!beforeText.equals("")) {
					win.getControl(ctlID).setProperty(Proplist.HEADER,colCnt,this.translateString(beforeText.getString()));
				}
				beforeText.setValue(win.getControl(ctlID).getProperty(Proplist.HEADER+Proplist.GROUP,colCnt));
				if (!beforeText.equals("")) {
					win.getControl(ctlID).setProperty(Proplist.HEADER+Proplist.GROUP,colCnt,this.translateString(beforeText.getString()));
				}
				colCnt.increment(1);
			}
		}
	}
	public void translateControls(ClarionNumber p0,ClarionNumber p1)
	{
		translateControls(p0,p1,(ClarionWindow)null);
	}
	public void translateControls(ClarionNumber lowCtlID,ClarionNumber highCtlID,ClarionWindow win)
	{
		ClarionNumber thisField=Clarion.newNumber(0).setEncoding(ClarionNumber.SIGNED);
		while (true) {
			thisField.setValue(win.getProperty(Prop.NEXTFIELD,thisField));
			if (thisField.boolValue() && CRun.inRange(thisField,lowCtlID,highCtlID)) {
				this.translateControl(thisField.like(),win);
			}
			else {
				break;
			}
		}
	}
	public void translateProperty(ClarionNumber p0,ClarionNumber p1)
	{
		translateProperty(p0,p1,(ClarionWindow)null);
	}
	public void translateProperty(ClarionNumber property,ClarionNumber ctrlId,ClarionWindow win)
	{
		win.getControl(ctrlId).setProperty(property,this.translateString(win.getControl(ctrlId).getProperty(property).getString()));
	}
	public ClarionString translateString(ClarionString lookFor)
	{
		ClarionString str=null;
		ClarionString rVal=Clarion.newString(Constants.MAXTLEN);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		str=lookFor;
		l.setValue(this.translate(str,rVal,Clarion.newNumber(0)));
		return (l.equals(0) ? Clarion.newString("") : rVal.stringAt(1,l)).getString();
	}
	public void translateWindow()
	{
		translateWindow((ClarionWindow)null);
	}
	public void translateWindow(ClarionWindow win)
	{
		ClarionNumber thisField=Clarion.newNumber(0).setEncoding(ClarionNumber.SIGNED);
		win.setProperty(Prop.TEXT,this.translateString(win.getProperty(Prop.TEXT).getString()));
		while (true) {
			thisField.setValue(win.getProperty(Prop.NEXTFIELD,thisField));
			if (thisField.boolValue()) {
				this.translateControl(thisField.like(),win);
			}
			else {
				break;
			}
		}
	}
}
