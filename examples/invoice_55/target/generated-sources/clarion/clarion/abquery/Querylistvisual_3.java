package clarion.abquery;

import clarion.Editqueue;
import clarion.abeip.Editdroplistclass;
import clarion.abeip.Editentryclass;
import clarion.abquery.Abquery;
import clarion.abquery.Qeditentryclass_3;
import clarion.abquery.Qeipmanager;
import clarion.abquery.Querylistclass_3;
import clarion.abquery.Querylistclass_4;
import clarion.abquery.Queryvisual_3;
import clarion.abquery.Stringlist;
import clarion.abquery.Valuelist;
import clarion.abquery.equates.Mconstants;
import clarion.abquery.equates.Mfeq;
import clarion.abquery.equates.Mquery;
import clarion.abutil.Fieldpairsclass;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Querylistvisual_3 extends Queryvisual_3
{
	public Querylistclass_4 qfc=null;
	public Valuelist vals=null;
	public Stringlist flds=null;
	public Stringlist ops=null;
	public Editdroplistclass opseip=null;
	public Editdroplistclass fldseip=null;
	public Editentryclass valueeip=null;
	public Querylistvisual_3()
	{
		qfc=null;
		vals=null;
		flds=null;
		ops=null;
		opseip=null;
		fldseip=null;
		valueeip=null;
	}

	public ClarionNumber init()
	{
		Querylistclass_3 qfc=null;
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber caseless=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber high=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		qfc=this.qfc;
		CMemory.clear(this);
		this.qfc=qfc;
		this.qc=qfc;
		rval.setValue(super.init());
		if (rval.boolValue()) {
			return rval.like();
		}
		CWin.createControl(Mfeq.LISTBOX,Create.LIST,Mfeq.CONTROLTAB,null);
		Clarion.getControl(Mfeq.LISTBOX).setProperty(Prop.FORMAT,ClarionString.staticConcat("91L|M~",Mconstants.DEFAULTQBEFIELDHDR,"~@s20@44C|M~",Mconstants.DEFAULTQBEOPSHDR,"~L@s10@120C|M~",Mconstants.DEFAULTQBEVALUEHDR,"~L@s30@"));
		this.vals=new Valuelist();
		Clarion.getControl(Mfeq.LISTBOX).setProperty(Prop.FROM,this.vals.getString());
		this.flds=new Stringlist();
		final int loop_1=this.qfc.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			this.flds.value.setValue(this.qfc.fields.title);
			this.flds.add(this.flds.ORDER().ascend(this.flds.value));
			while (true) {
				high.setValue(this.qfc.getlimit(this.vals.value,this.vals.ops,caseless,high.like()));
				if (this.vals.value.boolValue() || this.vals.ops.boolValue()) {
					if (caseless.boolValue() && !this.vals.value.stringAt(1).equals("^")) {
						this.vals.value.setValue(ClarionString.staticConcat("^",this.vals.value));
					}
					this.vals.field.setValue(this.qfc.fields.title);
					this.vals.add();
				}
				if (!high.boolValue()) break;
			}
		}
		CWin.setPosition(Mfeq.LISTBOX,11,20,290,168);
		CWin.unhide(Mfeq.LISTBOX);
		CWin.createControl(Mfeq.INSERT,Create.BUTTON,Mfeq.CONTROLTAB,null);
		Clarion.getControl(Mfeq.INSERT).setProperty(Prop.TEXT,"&Insert");
		CWin.setPosition(Mfeq.INSERT,162,192,45,14);
		CWin.createControl(Mfeq.CHANGE,Create.BUTTON,Mfeq.CONTROLTAB,null);
		Clarion.getControl(Mfeq.CHANGE).setProperty(Prop.TEXT,"&Change");
		CWin.setPosition(Mfeq.CHANGE,209,192,45,14);
		CWin.createControl(Mfeq.DELETE,Create.BUTTON,Mfeq.CONTROLTAB,null);
		Clarion.getControl(Mfeq.DELETE).setProperty(Prop.TEXT,"&Delete");
		CWin.setPosition(Mfeq.DELETE,256,192,45,14);
		CWin.unhide(Mfeq.INSERT,Mfeq.DELETE);
		CWin.setPosition(Mfeq.SHEETCONTROL,5,4,301,206);
		CWin.setPosition(0,null,null,310,232);
		this.ops=new Stringlist();
		this.ops.value.setValue(Mquery.CONTAINS);
		this.ops.add();
		this.ops.value.setValue(Mquery.BEGINS);
		this.ops.add();
		this.ops.value.setValue(Mquery.NOTEQUALS);
		this.ops.add();
		this.ops.value.setValue("=");
		this.ops.add();
		this.ops.value.setValue("<=");
		this.ops.add();
		this.ops.value.setValue(">=");
		this.ops.add();
		this.opseip=new Editdroplistclass();
		this.fldseip=new Editdroplistclass();
		this.valueeip=new Qeditentryclass_3();
		if (!(this.queries.records()!=0)) {
			this.firstfield.setValue(Mfeq.LISTBOX);
		}
		this.additem(Clarion.newNumber(Mfeq.CANCEL),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.okcontrol.setValue(Mfeq.OK);
		this.setalerts();
		return rval.like();
	}
	public ClarionNumber kill()
	{
		//this.vals;
		//this.flds;
		//this.ops;
		if (!(this.opseip==null)) {
			this.opseip.kill();
			//this.opseip;
		}
		if (!(this.fldseip==null)) {
			this.fldseip.kill();
			//this.fldseip;
		}
		if (!(this.valueeip==null)) {
			this.valueeip.kill();
			//this.valueeip;
		}
		return super.kill();
	}
	public void setalerts()
	{
		Clarion.getControl(Mfeq.LISTBOX).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,Constants.MOUSELEFT2);
		Clarion.getControl(Mfeq.LISTBOX).setProperty(Prop.ALRT,255,Constants.INSERTKEY);
		Clarion.getControl(Mfeq.LISTBOX).setProperty(Prop.ALRT,253,Constants.CTRLENTER);
		Clarion.getControl(Mfeq.LISTBOX).setProperty(Prop.ALRT,254,Constants.DELETEKEY);
	}
	public ClarionNumber takeaccepted()
	{
		Qeipmanager eip=new Qeipmanager();
		Editqueue e=new Editqueue();
		Fieldpairsclass f=new Fieldpairsclass();
		ClarionNumber rv=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString fld=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		ClarionString op=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionString vl=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1==Mfeq.INSERT) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Mfeq.DELETE) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Mfeq.CHANGE) {
				eip.q=this.vals;
				eip.visual=this;
				eip.eq=e;
				f.init();
				eip.fields=f;
				f.addpair(this.vals.field,fld);
				f.addpair(this.vals.ops,op);
				f.addpair(this.vals.value,vl);
				eip.listcontrol.setValue(Mfeq.LISTBOX);
				eip.addcontrol(this.fldseip,Clarion.newNumber(1));
				eip.addcontrol(this.opseip,Clarion.newNumber(2));
				eip.addcontrol(this.valueeip,Clarion.newNumber(3));
				rv.setValue(eip.run((CWin.accepted()==Mfeq.INSERT ? Clarion.newNumber(Constants.INSERTRECORD) : CWin.accepted()==Mfeq.CHANGE ? Clarion.newNumber(Constants.CHANGERECORD) : Clarion.newNumber(Constants.DELETERECORD)).getNumber()));
				f.kill();
				return rv.like();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return super.takeaccepted();
			}
		}
		return Clarion.newNumber();
	}
	public ClarionNumber takecompleted()
	{
		this.setresponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
		this.updatefields();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takefieldevent()
	{
		{
			int case_1=CWin.field();
			if (case_1==Mfeq.LISTBOX) {
				if (CWin.event()==Event.ALERTKEY) {
					{
						int case_2=CWin.keyCode();
						boolean case_2_break=false;
						if (case_2==Constants.MOUSELEFT2) {
							CWin.post(Event.ACCEPTED,(this.vals.records()==0 ? Clarion.newNumber(Mfeq.INSERT) : Clarion.newNumber(Mfeq.CHANGE)).intValue());
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.CTRLENTER) {
							CWin.post(Event.ACCEPTED,Mfeq.CHANGE);
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.INSERTKEY) {
							CWin.post(Event.ACCEPTED,Mfeq.INSERT);
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.DELETEKEY) {
							if (this.vals.records()!=0) {
								CWin.post(Event.ACCEPTED,Mfeq.DELETE);
							}
							case_2_break=true;
						}
					}
				}
				Clarion.getControl(Mfeq.DELETE).setProperty(Prop.DISABLE,CWin.choice(Mfeq.LISTBOX)==0 ? 1 : 0);
				Clarion.getControl(Mfeq.CHANGE).setProperty(Prop.DISABLE,CWin.choice(Mfeq.LISTBOX)==0 ? 1 : 0);
			}
		}
		return super.takefieldevent();
	}
	public void resetfromquery()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber caseless=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber high=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.vals.free();
		final int loop_1=this.qfc.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			while (true) {
				high.setValue(this.qfc.getlimit(this.vals.value,this.vals.ops,caseless,high.like()));
				if (this.vals.value.boolValue()) {
					if (caseless.boolValue() && !this.vals.value.stringAt(1).equals("^")) {
						this.vals.value.setValue(ClarionString.staticConcat("^",this.vals.value));
					}
					this.vals.field.setValue(this.qfc.fields.title);
					this.vals.add();
				}
				if (!high.boolValue()) break;
			}
		}
		return;
	}
	public void updatefields()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.qfc.reset();
		final int loop_1=this.vals.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.vals.get(i);
			{
				ClarionString case_1=this.vals.ops;
				boolean case_1_break=false;
				if (case_1.equals(">=")) {
					this.qfc.setlimit(this.qfc.getname(this.vals.field.like()),Clarion.newString(ClarionString.staticConcat(">=",this.vals.value)));
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals("<=")) {
					this.qfc.setlimit(this.qfc.getname(this.vals.field.like()),null,Clarion.newString(ClarionString.staticConcat("<=",this.vals.value)));
					case_1_break=true;
				}
				if (!case_1_break) {
					this.qfc.setlimit(this.qfc.getname(this.vals.field.like()),null,null,Abquery.makeoperator(this.vals.ops.like(),this.vals.value.like()));
				}
			}
		}
	}
	public void updatecontrol(ClarionString fieldname)
	{
		Clarion.getControl(this.valueeip.feq).setProperty(Prop.SCREENTEXT,CExpression.evaluate(this.qfc.getname(fieldname.like()).toString()));
	}
}
