package clarion.abutil;

import clarion.Translatorgroup;
import clarion.abutil.Abutil;
import clarion.abutil.Constantclass;
import clarion.abutil.Extractfile;
import clarion.abutil.Translatorqueue;
import clarion.abutil.Typemappingqueue;
import clarion.abutil.equates.Mconstants;
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

@SuppressWarnings("all")
public class Translatorclass
{
	public ClarionString extracttext=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
	public Translatorqueue queue=null;
	public Typemappingqueue typemapping=null;
	public Translatorclass()
	{
		extracttext=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		queue=null;
		typemapping=null;
	}

	public void addtranslation(ClarionString source,ClarionString replacement)
	{
		CRun._assert(!(this.queue==null));
		if (source.len()!=0) {
			this.queue.textprop.setValue(source);
			this.queue.get(this.queue.ORDER().ascend(this.queue.textprop));
			if (CError.errorCode()!=0) {
				this.queue.textprop.setValue(source);
				this.queue.replacement.setValue(replacement);
				this.queue.add(this.queue.ORDER().ascend(this.queue.textprop));
				CRun._assert(!(CError.errorCode()!=0));
			}
			else {
				this.queue.replacement.setValue(replacement);
				this.queue.put(this.queue.ORDER().ascend(this.queue.textprop));
				CRun._assert(!(CError.errorCode()!=0));
			}
		}
	}
	public void addtranslation(Translatorgroup tg)
	{
		Constantclass cnst=new Constantclass();
		ClarionString text=Clarion.newString(Mconstants.MAXTLEN).setEncoding(ClarionString.CSTRING);
		ClarionString repl=Clarion.newString(Mconstants.MAXTLEN).setEncoding(ClarionString.CSTRING);
		cnst.init();
		cnst.additem(Clarion.newNumber(Consttype.PSTRING),text);
		cnst.additem(Clarion.newNumber(Consttype.PSTRING),repl);
		cnst.set(tg.getString());
		while (cnst.next().equals(Level.BENIGN)) {
			this.addtranslation(text.like(),repl.like());
		}
		cnst.kill();
	}
	public void init()
	{
		Constantclass cnst=new Constantclass();
		this.queue=new Translatorqueue();
		this.typemapping=new Typemappingqueue();
		this.addtranslation((Translatorgroup)Abutil.translation.castTo(Translatorgroup.class));
		cnst.init(Clarion.newNumber(Term.ENDGROUP));
		cnst.additem(Clarion.newNumber(Consttype.USHORT),this.typemapping.controltype);
		cnst.additem(Clarion.newNumber(Consttype.USHORT),this.typemapping.property);
		cnst.set(Abutil.translatortypemappings.getString());
		cnst.next(this.typemapping);
		cnst.kill();
		this.typemapping.sort(this.typemapping.ORDER().ascend(this.typemapping.controltype));
	}
	public void kill()
	{
		Extractfile extractfile=new Extractfile();
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber d=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber items=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (this.extracttext.boolValue()) {
			Abutil.kill_extractfilename.setValue(this.extracttext);
			extractfile.create();
			CRun._assert(!(CError.errorCode()!=0));
			extractfile.open();
			CRun._assert(!(CError.errorCode()!=0));
			this.extracttext.setValue(extractfile.getName());
			this.queue.get(1);
			while (!(CError.errorCode()!=0)) {
				if (!this.queue.replacement.boolValue()) {
					items.increment(1);
				}
				this.queue.get(this.queue.getPointer()+1);
			}
			d.setValue(this.extracttext.inString(".",1,1));
			if (!d.boolValue()) {
				d.setValue(this.extracttext.len()+1);
			}
			for (c.setValue(d.compareTo(this.extracttext.len())<=0 ? d : d.subtract(1));c.compareTo(0)>=0;c.increment(-1)) {
				if (c.boolValue() && this.extracttext.stringAt(c).equals("\\")) {
					break;
				}
			}
			extractfile.line.setValue(this.extracttext.stringAt(c.add(1),d.subtract(1)).sub(1,8).concat(" GROUP"));
			kill_addline(extractfile);
			extractfile.line.setValue(ClarionString.staticConcat("Items      USHORT(",items,")"));
			kill_addline(extractfile);
			this.queue.get(1);
			while (!(CError.errorCode()!=0)) {
				if (!this.queue.replacement.boolValue()) {
					extractfile.line.setValue(Clarion.newString(" ").all(11).concat("PSTRING('",this.queue.textprop.clip(),"')"));
					kill_addline(extractfile);
					extractfile.line.setValue(Clarion.newString(" ").all(11).concat("PSTRING('')"));
					kill_addline(extractfile);
				}
				this.queue.get(this.queue.getPointer()+1);
			}
			extractfile.line.setValue("   END");
			kill_addline(extractfile);
			extractfile.close();
			CRun._assert(!(CError.errorCode()!=0));
		}
		//this.queue;
		//this.typemapping;
	}
	public void kill_addline(Extractfile extractfile)
	{
		extractfile.add();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public void resolvemacros(ClarionString str)
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
				str.setValue(str.stringAt(1,p1.subtract(1)).concat(this.translatestring(str.stringAt(p1.add(1),p2.subtract(1))),str.stringAt(p2.add(1),str.len())));
				p1.setValue(p2.add(1));
			}
		}
	}
	public void translatecontrol(ClarionNumber p0)
	{
		translatecontrol(p0,(ClarionWindow)null);
	}
	public void translatecontrol(ClarionNumber ctlid,ClarionWindow win)
	{
		ClarionNumber colcnt=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		ClarionNumber ctrltype=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionAny beforetext=Clarion.newAny();
		CRun._assert(!(this.typemapping==null));
		ctrltype.setValue(win.getControl(ctlid).getProperty(Prop.TYPE));
		this.typemapping.controltype.setValue(ctrltype);
		this.typemapping.get(this.typemapping.ORDER().ascend(this.typemapping.controltype));
		while (!(CError.errorCode()!=0) && this.typemapping.controltype.equals(ctrltype)) {
			this.translateproperty(this.typemapping.property.like(),ctlid.like(),win);
			this.typemapping.get(this.typemapping.getPointer()+1);
		}
		if (CRun.inlist(ctrltype.toString(),new ClarionString[] {Clarion.newString(String.valueOf(Create.LIST)),Clarion.newString(String.valueOf(Create.COMBO)),Clarion.newString(String.valueOf(Create.DROPLIST)),Clarion.newString(String.valueOf(Create.DROPCOMBO))}).boolValue()) {
			while (Clarion.getControl(ctlid).getProperty(Proplist.EXISTS,colcnt).equals(Constants.TRUE)) {
				beforetext.setValue(win.getControl(ctlid).getProperty(Proplist.HEADER,colcnt));
				if (!beforetext.equals("")) {
					win.getControl(ctlid).setProperty(Proplist.HEADER,colcnt,this.translatestring(beforetext.getString()));
				}
				beforetext.setValue(win.getControl(ctlid).getProperty(Proplist.HEADER+Proplist.GROUP,colcnt));
				if (!beforetext.equals("")) {
					win.getControl(ctlid).setProperty(Proplist.HEADER+Proplist.GROUP,colcnt,this.translatestring(beforetext.getString()));
				}
				colcnt.increment(1);
			}
		}
	}
	public void translatecontrols(ClarionNumber p0,ClarionNumber p1)
	{
		translatecontrols(p0,p1,(ClarionWindow)null);
	}
	public void translatecontrols(ClarionNumber lowctlid,ClarionNumber highctlid,ClarionWindow win)
	{
		ClarionNumber thisfield=Clarion.newNumber(0).setEncoding(ClarionNumber.SIGNED);
		while (true) {
			thisfield.setValue(win.getProperty(Prop.NEXTFIELD,thisfield));
			if (thisfield.boolValue() && CRun.inRange(thisfield,lowctlid,highctlid)) {
				this.translatecontrol(thisfield.like(),win);
			}
			else {
				break;
			}
		}
	}
	public void translateproperty(ClarionNumber p0,ClarionNumber p1)
	{
		translateproperty(p0,p1,(ClarionWindow)null);
	}
	public void translateproperty(ClarionNumber property,ClarionNumber ctrlid,ClarionWindow win)
	{
		win.getControl(ctrlid).setProperty(property,this.translatestring(win.getControl(ctrlid).getProperty(property).getString()));
	}
	public ClarionString translatestring(ClarionString lookfor)
	{
		ClarionString rval=Clarion.newString(Mconstants.MAXTLEN).setEncoding(ClarionString.CSTRING);
		Abutil.translatestring_string_recurse.decrement(1);
		CRun._assert(Abutil.translatestring_string_recurse.boolValue());
		rval.setValue(lookfor.left());
		if (rval.boolValue()) {
			this.queue.textprop.setValue(rval);
			this.queue.get(this.queue.ORDER().ascend(this.queue.textprop));
			if (CError.errorCode()!=0) {
				if (this.extracttext.boolValue()) {
					this.queue.textprop.setValue(lookfor);
					this.queue.replacement.setValue("");
					this.queue.add(this.queue.ORDER().ascend(this.queue.textprop));
					CRun._assert(!(CError.errorCode()!=0));
				}
			}
			else if (this.queue.replacement.boolValue()) {
				rval.setValue(this.queue.replacement);
			}
			this.resolvemacros(rval);
		}
		Abutil.translatestring_string_recurse.increment(1);
		return rval.like();
	}
	public void translatewindow()
	{
		translatewindow((ClarionWindow)null);
	}
	public void translatewindow(ClarionWindow win)
	{
		ClarionNumber thisfield=Clarion.newNumber(0).setEncoding(ClarionNumber.SIGNED);
		win.setProperty(Prop.TEXT,this.translatestring(win.getProperty(Prop.TEXT).getString()));
		while (true) {
			thisfield.setValue(win.getProperty(Prop.NEXTFIELD,thisfield));
			if (thisfield.boolValue()) {
				this.translatecontrol(thisfield.like(),win);
			}
			else {
				break;
			}
		}
	}
}
