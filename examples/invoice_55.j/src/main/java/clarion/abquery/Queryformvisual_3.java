package clarion.abquery;

import clarion.abquery.Abquery;
import clarion.abquery.Queryformclass_3;
import clarion.abquery.Queryformclass_4;
import clarion.abquery.Queryvisual_3;
import clarion.abquery.equates.Mconstants;
import clarion.abquery.equates.Mfeq;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Queryformvisual_3 extends Queryvisual_3
{
	public Queryformclass_3 qfc=null; // public Queryformclass_4 qfc=null; RENAME INSTANCE FIELD TYPE %%%%%%
	public Queryformvisual_3()
	{
		qfc=null;
	}

	public ClarionNumber getbuttonfeq(ClarionNumber index)
	{
		if (!index.equals(0) && index.compareTo(this.qfc.fields.records())<=0) {
			return Clarion.newNumber(Mfeq.STARTCONTROL).add(index.multiply(3)).getNumber();
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber init()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber maxw=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber maxpw=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		Queryformclass_3 qfc=null;
		ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		qfc=this.qfc;
		CMemory.clear(this);
		this.qfc=qfc;
		this.qc=qfc;
		rval.setValue(super.init());
		if (rval.boolValue()) {
			return rval.like();
		}
		final int loop_1=this.qfc.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			control.setValue(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3).subtract(2)));
			CWin.createControl(control.intValue(),Create.PROMPT,Mfeq.CONTROLTAB,null);
			Clarion.getControl(control).setProperty(Prop.TEXT,this.qfc.fields.title.concat(":"));
			if (Clarion.getControl(control).getProperty(Prop.WIDTH).compareTo(maxpw)>0) {
				maxpw.setValue(Clarion.getControl(control).getProperty(Prop.WIDTH));
			}
			control.setValue(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3).subtract(1)));
			CWin.createControl(control.intValue(),Create.ENTRY,Mfeq.CONTROLTAB,null);
			Clarion.getControl(control).setProperty(Prop.TEXT,this.qfc.fields.forceeditpicture.intValue()==1 ?this.qfc.fields.picture:Clarion.newString("@s30"));
			Clarion.getControl(control).setProperty(Prop.ALRT,1,Constants.F7KEY);
			Clarion.getControl(control).setProperty(Prop.ALRT,1,Constants.MOUSERIGHT);
			if (Clarion.getControl(control).getProperty(Prop.WIDTH).compareTo(maxw)>0) {
				maxw.setValue(Clarion.getControl(control).getProperty(Prop.WIDTH));
			}
			control.setValue(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3)));
			CWin.createControl(control.intValue(),Create.BUTTON,Mfeq.CONTROLTAB,null);
			Clarion.getControl(control).setProperty(Prop.SKIP,1);
			this.settext(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3).subtract(1)).getNumber(),this.qfc.fields.querystring.like());
		}
		init_positions(maxpw,maxw);
		if (!(this.queries.records()!=0)) {
			this.firstfield.setValue(Mfeq.STARTCONTROL+1);
		}
		this.additem(Clarion.newNumber(Mfeq.CANCEL),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.okcontrol.setValue(Mfeq.OK);
		return rval.like();
	}
	public void init_positions(ClarionNumber maxpw,ClarionNumber maxw)
	{
		ClarionNumber lmargin=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber tmargin=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber fullwidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber fullheight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber minwidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		lmargin.setValue(Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.XPOS).add(5));
		tmargin.setValue(Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.YPOS).add(16));
		fullwidth.setValue(Clarion.newNumber(3).multiply(lmargin).add(maxpw).add(maxw).add(Mconstants.HSPACING).add(20));
		minwidth.setValue(Clarion.newDecimal("2.7").multiply(Clarion.getControl(Mfeq.CANCEL).getProperty(Prop.WIDTH)));
		if (fullwidth.compareTo(minwidth)<0) {
			fullwidth.setValue(minwidth);
		}
		final int loop_1=this.qfc.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			CWin.setPosition(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3).subtract(2)).intValue(),lmargin.intValue(),tmargin.add(i.subtract(1).multiply(Mconstants.CHEIGHT+Mconstants.VSPACING)).intValue(),maxpw.intValue(),Mconstants.CHEIGHT);
			CWin.setPosition(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3).subtract(1)).intValue(),Clarion.newNumber(2).multiply(lmargin).add(maxpw).intValue(),tmargin.add(i.subtract(1).multiply(Mconstants.CHEIGHT+Mconstants.VSPACING)).intValue(),maxw.intValue(),Mconstants.CHEIGHT);
			CWin.setPosition(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3)).intValue(),Clarion.newNumber(2).multiply(lmargin).add(Mconstants.HSPACING).add(maxpw).add(maxw).intValue(),tmargin.add(i.subtract(1).multiply(Mconstants.CHEIGHT+Mconstants.VSPACING)).intValue(),10,10);
		}
		CWin.unhide(Mfeq.STARTCONTROL+1,Mfeq.STARTCONTROL+this.qfc.fields.records()*3);
		i.setValue(this.qfc.fields.records());
		fullheight.setValue(Clarion.newNumber(Mconstants.MARGIN*2).add(i.multiply(Mconstants.CHEIGHT)).add(i.subtract(1).multiply(Mconstants.VSPACING)).add(5));
		if (fullheight.compareTo(140)<0) {
			fullheight.setValue(140);
		}
		CWin.setPosition(Mfeq.OK,fullwidth.subtract(Clarion.getControl(Mfeq.OK).getProperty(Prop.WIDTH)).subtract(Mconstants.HSPACING).subtract(Clarion.getControl(Mfeq.CANCEL).getProperty(Prop.WIDTH)).subtract(Mconstants.MARGIN).intValue(),fullheight.intValue(),null,null);
		CWin.setPosition(Mfeq.CANCEL,fullwidth.subtract(Clarion.getControl(Mfeq.CANCEL).getProperty(Prop.WIDTH)).subtract(Mconstants.MARGIN).intValue(),Clarion.getControl(Mfeq.OK).getProperty(Prop.YPOS).intValue(),null,null);
		CWin.setPosition(Mfeq.SHEETCONTROL,Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.XPOS).intValue(),Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.YPOS).intValue(),fullwidth.subtract(10).intValue(),Clarion.getControl(Mfeq.OK).getProperty(Prop.YPOS).subtract(6).intValue());
		fullheight.setValue(Clarion.getControl(Mfeq.OK).getProperty(Prop.YPOS).add(Clarion.getControl(Mfeq.OK).getProperty(Prop.HEIGHT)).add(Mconstants.VSPACING));
		CWin.setPosition(0,null,null,fullwidth.intValue(),fullheight.intValue());
	}
	public void settext(ClarionNumber control,ClarionString entrytext)
	{
		ClarionString pft=Clarion.newString(5).setEncoding(ClarionString.CSTRING);
		if (entrytext.len()!=0) {
			while (Clarion.newString("<>~=").inString(entrytext.stringAt(1).toString())!=0) {
				pft.setValue(pft.concat(entrytext.stringAt(1)));
				entrytext.setValue(entrytext.sub(2,entrytext.len()-1));
			}
		}
		Clarion.getControl(control).setProperty(Prop.SCREENTEXT,entrytext.equals("") ? Clarion.newString("") : entrytext.format((this.qfc.fields.forceeditpicture.intValue()==1 ?this.qfc.fields.picture:Clarion.newString("@s30")).toString()));
		CWin.update(control.intValue());
		Clarion.getControl(control.add(1)).setProperty(Prop.TEXT,pft.equals("") ? entrytext.equals("") ? Clarion.newString(" ") : Clarion.newString("=") : pft);
	}
	public ClarionNumber takeaccepted()
	{
		ClarionNumber a=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		{
			int case_1=CWin.accepted();
			if (case_1>=Mfeq.STARTCONTROL+1 && case_1<=Mfeq.STARTCONTROL+this.qfc.fields.records()*3) {
				a.setValue(CWin.accepted());
				if (a.subtract(Mfeq.STARTCONTROL).modulus(3).equals(0)) {
					{
						ClarionObject case_2=Clarion.getControl(a).getProperty(Prop.TEXT);
						boolean case_2_break=false;
						if (case_2.equals(" ")) {
							Clarion.getControl(a).setProperty(Prop.TEXT,"=");
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals("=")) {
							Clarion.getControl(a).setProperty(Prop.TEXT,">=");
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(">=")) {
							Clarion.getControl(a).setProperty(Prop.TEXT,"<=");
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals("<=")) {
							Clarion.getControl(a).setProperty(Prop.TEXT,"<>");
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals("<>")) {
							Clarion.getControl(a).setProperty(Prop.TEXT," ");
							case_2_break=true;
						}
					}
				}
				else if (a.subtract(Mfeq.STARTCONTROL).modulus(3).equals(2)) {
					if (Clarion.getControl(a).getProperty(Prop.TEXT).boolValue()) {
						if (!Clarion.getControl(a.add(1)).getProperty(Prop.TEXT).boolValue()) {
							Clarion.getControl(a.add(1)).setProperty(Prop.TEXT,"=");
						}
					}
					else {
						Clarion.getControl(a.add(1)).setProperty(Prop.TEXT," ");
					}
				}
			}
		}
		return super.takeaccepted();
	}
	public ClarionNumber takecompleted()
	{
		this.setresponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
		this.updatefields();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takefieldevent()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rval.setValue(super.takefieldevent());
		if (CWin.field()<Mfeq.STARTCONTROL) {
			return rval.like();
		}
		{
			int case_1=(CWin.field()-Mfeq.STARTCONTROL)%3;
			if (case_1==2) {
				if (CWin.event()==Event.ALERTKEY) {
					this.qfc.fields.get(((CWin.field()-Mfeq.STARTCONTROL)+1)/3);
					this.settext(Clarion.newNumber(CWin.field()),this.qfc.fields.forceeditpicture.intValue()==1 ?CExpression.evaluate(this.qfc.fields.name.toString()).clip().format(Clarion.getControl(CWin.field()).getProperty(Prop.TEXT).toString()):CExpression.evaluate(this.qfc.fields.name.toString()).clip().format(this.qfc.fields.picture.toString()));
					CWin.update(CWin.field());
					CWin.post(Event.ACCEPTED,CWin.field());
				}
			}
		}
		return rval.like();
	}
	public void resetfromquery()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		final int loop_1=this.qfc.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			this.settext(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3).subtract(1)).getNumber(),this.qfc.fields.querystring.like());
		}
		CWin.update();
		return;
	}
	public void updatefields()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		final int loop_1=this.qfc.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			control.setValue(Clarion.newNumber(Mfeq.STARTCONTROL).add(i.multiply(3)));
			if (Clarion.getControl(control).getProperty(Prop.SCREENTEXT).boolValue()) {
				this.qfc.fields.querystring.setValue(Abquery.makeoperator(Clarion.getControl(control).getProperty(Prop.SCREENTEXT).getString(),Clarion.getControl(control.subtract(1)).getProperty(Prop.VALUE).getString().clip()));
			}
			else {
				this.qfc.fields.querystring.clear();
			}
			this.qfc.fields.put();
		}
	}
}
