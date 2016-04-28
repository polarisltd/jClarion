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
	public void resolveMacros(ClarionString str)
	{
		ClarionNumber p1=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		ClarionNumber p2=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		while (true) {
			p1.setValue(str.inString("%",1,p1.intValue()));
			p2.setValue(str.inString("%",1,p1.add(1).intValue()));
			if (!(p1.boolValue() && p2.boolValue())) {
				break;
			}
			if (p2.compareTo(p1.add(1))>0) {
				str.setValue(str.stringAt(1,p1.subtract(1)).concat(this.translateString(str.stringAt(p1.add(1),p2.subtract(1))),str.stringAt(p2.add(1),str.len())));
				p1.setValue(p2.add(1));
			}
		}
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
			while (Clarion.getControl(ctlID).getProperty(Proplist.EXISTS,colCnt).equals(Constants.TRUE)) {
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
		ClarionString rVal=Clarion.newString(Constants.MAXTLEN).setEncoding(ClarionString.CSTRING);
		Abutil.translateString_string_Recurse.decrement(1);
		CRun._assert(Abutil.translateString_string_Recurse.boolValue());
		rVal.setValue(lookFor.left());
		if (rVal.boolValue()) {
			this.queue.textProp.setValue(rVal);
			this.queue.get(this.queue.ORDER().ascend(this.queue.textProp));
			if (CError.errorCode()!=0) {
				if (this.extractText.boolValue()) {
					this.queue.textProp.setValue(lookFor);
					this.queue.replacement.setValue("");
					this.queue.add(this.queue.ORDER().ascend(this.queue.textProp));
					CRun._assert(!(CError.errorCode()!=0));
				}
			}
			else if (this.queue.replacement.boolValue()) {
				rVal.setValue(this.queue.replacement);
			}
			this.resolveMacros(rVal);
		}
		Abutil.translateString_string_Recurse.increment(1);
		return rVal.like();
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
