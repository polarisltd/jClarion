package clarion;

import clarion.Abquery;
import clarion.Editdroplistclass;
import clarion.Editentryclass;
import clarion.Editqueue;
import clarion.Fieldpairsclass;
import clarion.Qeditentryclass;
import clarion.Qeipmanager;
import clarion.Querylistclass;
import clarion.Queryvisual;
import clarion.Stringlist;
import clarion.Valuelist;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Feq;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Query;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;

public class Querylistvisual extends Queryvisual
{
	public Querylistclass qfc;
	public Valuelist vals;
	public Stringlist flds;
	public Stringlist ops;
	public Editdroplistclass opsEIP;
	public Editdroplistclass fldsEIP;
	public Editentryclass valueEIP;
	public Querylistvisual()
	{
		qfc=null;
		vals=null;
		flds=null;
		ops=null;
		opsEIP=null;
		fldsEIP=null;
		valueEIP=null;
	}

	public ClarionNumber init()
	{
		Querylistclass qfc=null;
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber caseless=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber high=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		qfc=this.qfc;
		CMemory.clear(this);
		this.qfc=qfc;
		this.qc=qfc;
		rVal.setValue(super.init());
		if (rVal.boolValue()) {
			return rVal.like();
		}
		CWin.createControl(Feq.LISTBOX,Create.LIST,Feq.CONTROLTAB,null);
		Clarion.getControl(Feq.LISTBOX).setProperty(Prop.FORMAT,ClarionString.staticConcat("91L|M~",Constants.DEFAULTQBEFIELDHDR,"~@s20@44C|M~",Constants.DEFAULTQBEOPSHDR,"~L@s10@120C|M~",Constants.DEFAULTQBEVALUEHDR,"~L@s30@"));
		this.vals=new Valuelist();
		Clarion.getControl(Feq.LISTBOX).setProperty(Prop.FROM,this.vals.getString());
		this.flds=new Stringlist();
		for (i.setValue(1);i.compareTo(this.qfc.fields.records())<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			this.flds.value.setValue(this.qfc.fields.title);
			this.flds.add(this.flds.ORDER().ascend(this.flds.value));
			while (true) {
				this.vals.picture.setValue(this.qfc.fields.forceEditPicture.intValue()==1 ?this.qfc.fields.picture:Clarion.newString("@s30"));
				high.setValue(this.qfc.getLimit(this.vals.value,this.vals.ops,caseless,high.like()));
				if (this.vals.value.boolValue() || this.vals.ops.boolValue()) {
					if (this.vals.value.boolValue()) {
						if (this.vals.value.stringAt(1).equals("^")) {
							this.vals.value.setValue(this.vals.value.stringAt(2,this.vals.value.len()));
						}
					}
					this.vals.field.setValue(this.qfc.fields.title);
					this.vals.add();
				}
				if (!high.boolValue()) break;
			}
		}
		CWin.setPosition(Feq.LISTBOX,11,20,290,168);
		CWin.unhide(Feq.LISTBOX);
		CWin.createControl(Feq.INSERT,Create.BUTTON,Feq.CONTROLTAB,null);
		Clarion.getControl(Feq.INSERT).setProperty(Prop.TEXT,Constants.DEFAULTINSERTTEXT);
		CWin.setPosition(Feq.INSERT,162,192,45,14);
		CWin.createControl(Feq.CHANGE,Create.BUTTON,Feq.CONTROLTAB,null);
		Clarion.getControl(Feq.CHANGE).setProperty(Prop.TEXT,Constants.DEFAULTCHANGETEXT);
		CWin.setPosition(Feq.CHANGE,209,192,45,14);
		CWin.createControl(Feq.DELETE,Create.BUTTON,Feq.CONTROLTAB,null);
		Clarion.getControl(Feq.DELETE).setProperty(Prop.TEXT,Constants.DEFAULTDELETETEXT);
		CWin.setPosition(Feq.DELETE,256,192,45,14);
		CWin.unhide(Feq.INSERT,Feq.DELETE);
		CWin.setPosition(Feq.SHEETCONTROL,5,4,301,206);
		CWin.setPosition(0,null,null,310,232);
		this.ops=new Stringlist();
		this.ops.value.setValue(Query.CONTAINS);
		this.ops.add();
		this.ops.value.setValue(Query.BEGINS);
		this.ops.add();
		this.ops.value.setValue(Query.NOTEQUALS);
		this.ops.add();
		this.ops.value.setValue("=");
		this.ops.add();
		this.ops.value.setValue("<=");
		this.ops.add();
		this.ops.value.setValue(">=");
		this.ops.add();
		this.opsEIP=new Editdroplistclass();
		this.fldsEIP=new Editdroplistclass();
		this.valueEIP=new Qeditentryclass();
		if (!(this.queries.records()!=0)) {
			this.firstField.setValue(Feq.LISTBOX);
		}
		this.addItem(Clarion.newNumber(Feq.CANCEL),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.okControl.setValue(Feq.OK);
		this.setAlerts();
		return rVal.like();
	}
	public ClarionNumber kill()
	{
		//this.vals;
		//this.flds;
		//this.ops;
		if (!(this.opsEIP==null)) {
			this.opsEIP.kill();
			//this.opsEIP;
		}
		if (!(this.fldsEIP==null)) {
			this.fldsEIP.kill();
			//this.fldsEIP;
		}
		if (!(this.valueEIP==null)) {
			this.valueEIP.kill();
			//this.valueEIP;
		}
		return super.kill();
	}
	public void setAlerts()
	{
		Clarion.getControl(Feq.LISTBOX).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,Constants.MOUSELEFT2);
		Clarion.getControl(Feq.LISTBOX).setProperty(Prop.ALRT,255,Constants.INSERTKEY);
		Clarion.getControl(Feq.LISTBOX).setProperty(Prop.ALRT,253,Constants.CTRLENTER);
		Clarion.getControl(Feq.LISTBOX).setProperty(Prop.ALRT,254,Constants.DELETEKEY);
	}
	public ClarionNumber takeAccepted()
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
			if (case_1==Feq.INSERT) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Feq.DELETE) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Feq.CHANGE) {
				eip.q=this.vals;
				eip.visual=this;
				eip.eq=e;
				f.init();
				eip.fields=f;
				f.addPair(this.vals.field,fld);
				f.addPair(this.vals.ops,op);
				f.addPair(this.vals.value,vl);
				eip.listControl.setValue(Feq.LISTBOX);
				eip.addControl(this.fldsEIP,Clarion.newNumber(1));
				eip.addControl(this.opsEIP,Clarion.newNumber(2));
				eip.addControl(this.valueEIP,Clarion.newNumber(3));
				rv.setValue(eip.run((CWin.accepted()==Feq.INSERT ? Clarion.newNumber(Constants.INSERTRECORD) : CWin.accepted()==Feq.CHANGE ? Clarion.newNumber(Constants.CHANGERECORD) : Clarion.newNumber(Constants.DELETERECORD)).getNumber()));
				f.kill();
				return rv.like();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return super.takeAccepted();
			}
		}
		return Clarion.newNumber();
	}
	public ClarionNumber takeCompleted()
	{
		this.setResponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
		this.updateFields();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeFieldEvent()
	{
		ClarionNumber feq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		{
			int case_1=CWin.field();
			if (case_1==Feq.LISTBOX) {
				if (CWin.event()==Event.ALERTKEY) {
					feq.setValue(0);
					{
						int case_2=CWin.keyCode();
						boolean case_2_break=false;
						if (case_2==Constants.MOUSELEFT2) {
							feq.setValue(this.vals.records()==0 ? Clarion.newNumber(Feq.INSERT) : Clarion.newNumber(Feq.CHANGE));
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.CTRLENTER) {
							feq.setValue(Feq.CHANGE);
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.INSERTKEY) {
							feq.setValue(Feq.INSERT);
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.DELETEKEY) {
							if (this.vals.records()!=0) {
								feq.setValue(Feq.DELETE);
							}
							case_2_break=true;
						}
					}
					if (!feq.equals(0) && !Clarion.getControl(feq).getProperty(Prop.DISABLE).boolValue()) {
						CWin.post(Event.ACCEPTED,feq.intValue());
					}
				}
				Clarion.getControl(Feq.DELETE).setProperty(Prop.DISABLE,CWin.choice(Feq.LISTBOX)==0 ? 1 : 0);
				Clarion.getControl(Feq.CHANGE).setProperty(Prop.DISABLE,CWin.choice(Feq.LISTBOX)==0 ? 1 : 0);
			}
		}
		return super.takeFieldEvent();
	}
	public void resetFromQuery()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber caseless=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber high=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.vals.free();
		for (i.setValue(1);i.compareTo(this.qfc.fields.records())<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			while (true) {
				high.setValue(this.qfc.getLimit(this.vals.value,this.vals.ops,caseless,high.like()));
				if (this.vals.value.boolValue() || !this.vals.value.clip().boolValue() && !(this.vals.ops.equals(Query.CONTAINS) || this.vals.ops.equals(Query.BEGINS))) {
					if (this.vals.value.stringAt(1).equals("^")) {
						this.vals.value.setValue(this.vals.value.stringAt(2,this.vals.value.len()));
					}
					this.vals.field.setValue(this.qfc.fields.title);
					this.vals.add();
				}
				if (!high.boolValue()) break;
			}
		}
		return;
	}
	public ClarionNumber type()
	{
		return Clarion.newNumber(Constants.QBELISTBASED);
	}
	public void updateFields()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.qfc.reset();
		for (i.setValue(1);i.compareTo(this.vals.records())<=0;i.increment(1)) {
			this.vals.get(i);
			{
				ClarionString case_1=this.vals.ops;
				boolean case_1_break=false;
				if (case_1.equals(">=")) {
					this.qfc.setLimit(this.qfc.getName(this.vals.field.like()),Clarion.newString(ClarionString.staticConcat(">=",this.vals.value)));
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals("<=")) {
					this.qfc.setLimit(this.qfc.getName(this.vals.field.like()),null,Clarion.newString(ClarionString.staticConcat("<=",this.vals.value)));
					case_1_break=true;
				}
				if (!case_1_break) {
					this.qfc.setLimit(this.qfc.getName(this.vals.field.like()),null,null,Abquery.makeOperator(this.vals.ops.like(),this.vals.value.like()));
				}
			}
		}
	}
	public void updateControl(ClarionString fieldName)
	{
		Clarion.getControl(this.valueEIP.feq).setProperty(Prop.SCREENTEXT,CExpression.evaluate(this.qfc.getName(fieldName.like()).toString()));
	}
}
