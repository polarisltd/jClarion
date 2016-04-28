package clarion;

import clarion.Abquery;
import clarion.Queryformclass;
import clarion.Queryvisual;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Feq;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;

public class Queryformvisual extends Queryvisual
{
	public Queryformclass qfc;
	public Queryformvisual()
	{
		qfc=null;
	}

	public ClarionNumber getButtonFeq(ClarionNumber index)
	{
		if (!index.equals(0) && index.compareTo(this.qfc.fields.records())<=0) {
			return Clarion.newNumber(Feq.STARTCONTROL).add(index.multiply(3)).getNumber();
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber init()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber maxW=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber maxPW=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		Queryformclass qfc=null;
		ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		qfc=this.qfc;
		CMemory.clear(this);
		this.qfc=qfc;
		this.qc=qfc;
		rVal.setValue(super.init());
		if (rVal.boolValue()) {
			return rVal.like();
		}
		for (i.setValue(1);i.compareTo(this.qfc.fields.records())<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			control.setValue(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3).subtract(2)));
			CWin.createControl(control.intValue(),Create.PROMPT,Feq.CONTROLTAB,null);
			Clarion.getControl(control).setProperty(Prop.TEXT,this.qfc.fields.title.concat(":"));
			if (Clarion.getControl(control).getProperty(Prop.WIDTH).compareTo(maxPW)>0) {
				maxPW.setValue(Clarion.getControl(control).getProperty(Prop.WIDTH));
			}
			control.setValue(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3).subtract(1)));
			CWin.createControl(control.intValue(),Create.ENTRY,Feq.CONTROLTAB,null);
			Clarion.getControl(control).setProperty(Prop.TEXT,this.qfc.fields.forceEditPicture.intValue()==1 ?this.qfc.fields.picture:Clarion.newString("@s30"));
			Clarion.getControl(control).setProperty(Prop.ALRT,1,Constants.F7KEY);
			Clarion.getControl(control).setProperty(Prop.ALRT,1,Constants.MOUSERIGHT);
			if (Clarion.getControl(control).getProperty(Prop.WIDTH).compareTo(maxW)>0) {
				maxW.setValue(Clarion.getControl(control).getProperty(Prop.WIDTH));
			}
			control.setValue(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3)));
			CWin.createControl(control.intValue(),Create.BUTTON,Feq.CONTROLTAB,null);
			Clarion.getControl(control).setProperty(Prop.SKIP,1);
			this.setText(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3).subtract(1)).getNumber(),this.qfc.fields.queryString.like());
		}
		init_Positions(maxPW,maxW);
		if (!(this.queries.records()!=0)) {
			this.firstField.setValue(Feq.STARTCONTROL+1);
		}
		this.addItem(Clarion.newNumber(Feq.CANCEL),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.okControl.setValue(Feq.OK);
		return rVal.like();
	}
	public void init_Positions(ClarionNumber maxPW,ClarionNumber maxW)
	{
		ClarionNumber lMargin=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber tMargin=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber fullWidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber fullHeight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber minWidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		lMargin.setValue(Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.XPOS).add(5));
		tMargin.setValue(Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.YPOS).add(16));
		fullWidth.setValue(Clarion.newNumber(3).multiply(lMargin).add(maxPW).add(maxW).add(Constants.HSPACING).add(20));
		minWidth.setValue(Clarion.newDecimal("2.7").multiply(Clarion.getControl(Feq.CANCEL).getProperty(Prop.WIDTH)));
		if (fullWidth.compareTo(minWidth)<0) {
			fullWidth.setValue(minWidth);
		}
		for (i.setValue(1);i.compareTo(this.qfc.fields.records())<=0;i.increment(1)) {
			CWin.setPosition(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3).subtract(2)).intValue(),lMargin.intValue(),tMargin.add(i.subtract(1).multiply(Constants.CHEIGHT+Constants.VSPACING)).intValue(),maxPW.intValue(),Constants.CHEIGHT);
			CWin.setPosition(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3).subtract(1)).intValue(),Clarion.newNumber(2).multiply(lMargin).add(maxPW).intValue(),tMargin.add(i.subtract(1).multiply(Constants.CHEIGHT+Constants.VSPACING)).intValue(),maxW.intValue(),Constants.CHEIGHT);
			CWin.setPosition(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3)).intValue(),Clarion.newNumber(2).multiply(lMargin).add(Constants.HSPACING).add(maxPW).add(maxW).intValue(),tMargin.add(i.subtract(1).multiply(Constants.CHEIGHT+Constants.VSPACING)).intValue(),10,10);
		}
		CWin.unhide(Feq.STARTCONTROL+1,Feq.STARTCONTROL+this.qfc.fields.records()*3);
		i.setValue(this.qfc.fields.records());
		fullHeight.setValue(Clarion.newNumber(Constants.MARGIN*2).add(i.multiply(Constants.CHEIGHT)).add(i.subtract(1).multiply(Constants.VSPACING)).add(5));
		if (fullHeight.compareTo(140)<0) {
			fullHeight.setValue(140);
		}
		CWin.setPosition(Feq.OK,fullWidth.subtract(Clarion.getControl(Feq.OK).getProperty(Prop.WIDTH)).subtract(Constants.HSPACING).subtract(Clarion.getControl(Feq.CANCEL).getProperty(Prop.WIDTH)).subtract(Constants.MARGIN).intValue(),fullHeight.intValue(),null,null);
		CWin.setPosition(Feq.CANCEL,fullWidth.subtract(Clarion.getControl(Feq.CANCEL).getProperty(Prop.WIDTH)).subtract(Constants.MARGIN).intValue(),Clarion.getControl(Feq.OK).getProperty(Prop.YPOS).intValue(),null,null);
		CWin.setPosition(Feq.SHEETCONTROL,Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.XPOS).intValue(),Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.YPOS).intValue(),fullWidth.subtract(10).intValue(),Clarion.getControl(Feq.OK).getProperty(Prop.YPOS).subtract(6).intValue());
		fullHeight.setValue(Clarion.getControl(Feq.OK).getProperty(Prop.YPOS).add(Clarion.getControl(Feq.OK).getProperty(Prop.HEIGHT)).add(Constants.VSPACING));
		CWin.setPosition(0,null,null,fullWidth.intValue(),fullHeight.intValue());
	}
	public void setText(ClarionNumber control,ClarionString entryText)
	{
		ClarionString pft=Clarion.newString(5).setEncoding(ClarionString.CSTRING);
		if (entryText.len()!=0) {
			while (Clarion.newString("<>~=").inString(entryText.stringAt(1).toString())!=0) {
				pft.setValue(pft.concat(entryText.stringAt(1)));
				entryText.setValue(entryText.sub(2,entryText.len()-1));
			}
		}
		Clarion.getControl(control).setProperty(Prop.SCREENTEXT,entryText.equals("") ? Clarion.newString("") : entryText.format((this.qfc.fields.forceEditPicture.intValue()==1 ?this.qfc.fields.picture:Clarion.newString("@s30")).toString()));
		CWin.update(control.intValue());
		Clarion.getControl(control.add(1)).setProperty(Prop.TEXT,pft.equals("") ? entryText.equals("") ? Clarion.newString(" ") : Clarion.newString("=") : pft);
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber a=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		{
			int case_1=CWin.accepted();
			if (case_1>=Feq.STARTCONTROL+1 && case_1<=Feq.STARTCONTROL+this.qfc.fields.records()*3) {
				a.setValue(CWin.accepted());
				if (a.subtract(Feq.STARTCONTROL).modulus(3).equals(0)) {
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
				else if (a.subtract(Feq.STARTCONTROL).modulus(3).equals(2)) {
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
		return super.takeAccepted();
	}
	public ClarionNumber takeCompleted()
	{
		this.setResponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
		this.updateFields();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeFieldEvent()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rVal.setValue(super.takeFieldEvent());
		if (CWin.field()<Feq.STARTCONTROL) {
			return rVal.like();
		}
		{
			int case_1=(CWin.field()-Feq.STARTCONTROL)%3;
			if (case_1==2) {
				if (CWin.event()==Event.ALERTKEY) {
					this.qfc.fields.get(((CWin.field()-Feq.STARTCONTROL)+1)/3);
					this.setText(Clarion.newNumber(CWin.field()),this.qfc.fields.forceEditPicture.intValue()==1 ?CExpression.evaluate(this.qfc.fields.name.toString()).clip().format(Clarion.getControl(CWin.field()).getProperty(Prop.TEXT).toString()):CExpression.evaluate(this.qfc.fields.name.toString()).clip().format(this.qfc.fields.picture.toString()));
					CWin.update(CWin.field());
					CWin.post(Event.ACCEPTED,CWin.field());
				}
			}
		}
		return rVal.like();
	}
	public void resetFromQuery()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		for (i.setValue(1);i.compareTo(this.qfc.fields.records())<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			this.setText(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3).subtract(1)).getNumber(),this.qfc.fields.queryString.like());
		}
		CWin.update();
		return;
	}
	public void updateFields()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		for (i.setValue(1);i.compareTo(this.qfc.fields.records())<=0;i.increment(1)) {
			this.qfc.fields.get(i);
			control.setValue(Clarion.newNumber(Feq.STARTCONTROL).add(i.multiply(3)));
			if (Clarion.getControl(control).getProperty(Prop.SCREENTEXT).boolValue()) {
				this.qfc.fields.queryString.setValue(Abquery.makeOperator(Clarion.getControl(control).getProperty(Prop.SCREENTEXT).getString(),Clarion.getControl(control.subtract(1)).getProperty(Prop.VALUE).getString().clip()));
			}
			else {
				this.qfc.fields.queryString.clear();
			}
			this.qfc.fields.put();
		}
	}
}
