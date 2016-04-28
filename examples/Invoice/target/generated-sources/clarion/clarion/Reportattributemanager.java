package clarion;

import clarion.Hiddencontrolsqueue;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Repgen;
import clarion.equates.Targetattr;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;

public class Reportattributemanager
{
	public ClarionReport r;
	public Hiddencontrolsqueue hcq;
	public Reportattributemanager()
	{
		r=null;
		hcq=null;
		construct();
	}

	public void construct()
	{
		this.hcq=new Hiddencontrolsqueue();
	}
	public void destruct()
	{
		this.hcq.free();
		//this.hcq;
	}
	public void init(ClarionReport pReport)
	{
		this.r=pReport;
	}
	public void set(ClarionNumber p0,ClarionString p1,ClarionString p2)
	{
		set(p0,p1,p2,(ClarionString)null);
	}
	public void set(ClarionNumber pReportControl,ClarionString pReportGeneratorType,ClarionString pAttribute,ClarionString pAttributeValue)
	{
		ClarionNumber lStartPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lEndPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lAttrPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lNextAttr=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lAttrExists=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber lReadPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lWritePos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lReadLen=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString lAttribute=Clarion.newString(Constants.MAXATTRIBUTESIZE+1).setEncoding(ClarionString.CSTRING);
		ClarionString lEnd=Clarion.newString(Constants.MAXATTRIBUTESIZE+1).setEncoding(ClarionString.CSTRING);
		if (pAttribute.equals(Targetattr.HIDE) && pReportGeneratorType.equals(Repgen.ALL)) {
			this.hcq.control.setValue(pReportControl);
			this.hcq.add();
		}
		lAttribute.setValue(this.r.getControl(pReportControl).getProperty(Prop.EXTEND));
		lStartPos.setValue(lAttribute.inString(pReportGeneratorType.toString(),1,1));
		if (!lStartPos.boolValue()) {
			if (pAttribute.boolValue()) {
				if (lAttribute.boolValue()) {
					lAttribute.setValue(lAttribute.concat(Constants.WRITERSEPERATOR));
				}
				lAttribute.setValue(lAttribute.concat(pReportGeneratorType,Constants.ATTRIBUTELISTSTART,pAttribute));
				if (!(pAttributeValue==null)) {
					lAttribute.setValue(lAttribute.concat(Constants.ATTRIBUTETYPESEPERATOR,pAttributeValue));
				}
				lAttribute.setValue(lAttribute.concat(Constants.ATTRIBUTELISTEND));
			}
		}
		else {
			lEndPos.setValue(lAttribute.inString(Constants.ATTRIBUTELISTEND,1,lStartPos.intValue()));
			if (lEndPos.equals(0)) {
				lAttribute.setValue(lAttribute.concat(Constants.ATTRIBUTELISTEND));
				lEndPos.setValue(lAttribute.len());
			}
			lAttrPos.setValue(lAttribute.inString(pAttribute.toString(),1,lStartPos.intValue()));
			if (lAttrPos.boolValue() && lAttrPos.compareTo(lEndPos)<0) {
				lAttrExists.setValue(Constants.TRUE);
				lNextAttr.setValue(lAttribute.inString(Constants.ATTRIBUTESEPERATOR,1,lAttrPos.intValue()));
				if (lNextAttr.boolValue() && lNextAttr.compareTo(lEndPos)<0) {
					lEndPos.setValue(lNextAttr);
				}
			}
			else {
				lAttrExists.setValue(Constants.FALSE);
			}
			lEnd.setValue(lAttribute.sub(lEndPos.intValue(),Clarion.newNumber(lAttribute.len()).subtract(lEndPos).add(1).intValue()));
			if (lAttrExists.boolValue()) {
				lAttribute.setValue(lAttribute.sub(1,lAttrPos.subtract(1).intValue()).concat(pAttribute));
			}
			else {
				lAttribute.setValue(lAttribute.sub(1,lEndPos.subtract(1).intValue()).concat(Constants.ATTRIBUTESEPERATOR,pAttribute));
			}
			if (!(pAttributeValue==null)) {
				lAttribute.setValue(lAttribute.concat(Constants.ATTRIBUTETYPESEPERATOR));
				if (pAttributeValue.inString(Constants.ATTRIBUTESEPERATOR,1,1)!=0) {
					lReadLen.setValue(pAttributeValue.clip().len());
					lReadPos.setValue(1);
					lWritePos.setValue(lAttribute.len()+1);
					lAttribute.setStringAt(lWritePos,Constants.QUOTECHAR);
					lWritePos.increment(1);
					while (lReadPos.compareTo(lReadLen)<=0) {
						if (pAttributeValue.stringAt(lReadPos).val()==Clarion.newString(Constants.QUOTECHAR).val()) {
							lAttribute.setStringAt(lWritePos,Constants.QUOTECHAR);
							lWritePos.increment(1);
						}
						lAttribute.setStringAt(lWritePos,pAttributeValue.stringAt(lReadPos));
						lReadPos.increment(1);
						lWritePos.increment(1);
					}
					lAttribute.setStringAt(lWritePos.add(1),Constants.QUOTECHAR);
					lAttribute.setStringAt(lWritePos.add(2),ClarionString.chr(0));
				}
				else {
					lAttribute.setValue(lAttribute.concat(pAttributeValue));
				}
			}
			lAttribute.setValue(lAttribute.concat(lEnd));
		}
		this.r.getControl(pReportControl).setClonedProperty(Prop.EXTEND,lAttribute);
	}
	public void setHideControls()
	{
		ClarionNumber lIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lWidth=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lHeight=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionReal lCoordinateMeasure=Clarion.newReal();
		ClarionNumber lNeedToChangeMeasure=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lCoordinateMeasure.setValue(0);
		lNeedToChangeMeasure.setValue(Constants.FALSE);
		if (this.r.getProperty(Prop.THOUS).boolValue()) {
			lCoordinateMeasure.setValue(1);
		}
		else if (this.r.getProperty(Prop.MM).boolValue()) {
			lCoordinateMeasure.setValue(40);
		}
		else if (this.r.getProperty(Prop.POINTS).boolValue()) {
			lCoordinateMeasure.setValue("13.89");
		}
		else {
			lNeedToChangeMeasure.setValue(Constants.TRUE);
			lCoordinateMeasure.setValue(1);
		}
		if (lNeedToChangeMeasure.boolValue()) {
			this.r.setProperty(Prop.THOUS,Constants.TRUE);
		}
		for (lIndex.setValue(1);lIndex.compareTo(this.hcq.records())<=0;lIndex.increment(1)) {
			this.hcq.get(lIndex);
			if (CError.errorCode()!=0) {
				break;
			}
			lWidth.setValue(this.r.getControl(this.hcq.control).getProperty(Prop.WIDTH));
			lHeight.setValue(this.r.getControl(this.hcq.control).getProperty(Prop.HEIGHT));
			lWidth.setValue(lWidth.multiply(lCoordinateMeasure));
			lHeight.setValue(lHeight.multiply(lCoordinateMeasure));
			this.set(this.hcq.control.like(),Clarion.newString(Repgen.ALL),Clarion.newString(Targetattr.HIDEWIDTH),lWidth.getString());
			this.set(this.hcq.control.like(),Clarion.newString(Repgen.ALL),Clarion.newString(Targetattr.HIDEHEIGHT),lHeight.getString());
			this.r.getControl(this.hcq.control).setProperty(Prop.WIDTH,0);
			this.r.getControl(this.hcq.control).setProperty(Prop.HEIGHT,0);
		}
		if (lNeedToChangeMeasure.boolValue()) {
			this.r.setProperty(Prop.THOUS,Constants.FALSE);
		}
	}
	public ClarionString extract(ClarionString pReportGeneratorType,ClarionString pAttribute,ClarionString pControlExtendAttribute)
	{
		ClarionString lAttribute=Clarion.newString(Constants.MAXATTRIBUTESIZE+1).setEncoding(ClarionString.CSTRING);
		ClarionNumber lStartPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lEndPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lAttrPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lAttrEnd=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lNextAttr=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lValStart=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lValLen=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lAttribute.setValue(pControlExtendAttribute);
		lStartPos.setValue(lAttribute.inString(pReportGeneratorType.toString(),1,1));
		if (!lStartPos.boolValue()) {
			return Clarion.newString("");
		}
		else {
			lEndPos.setValue(lAttribute.inString(Constants.ATTRIBUTELISTEND,1,lStartPos.intValue()));
			if (lEndPos.equals(0)) {
				return Clarion.newString("");
			}
			lAttrPos.setValue(lAttribute.inString(pAttribute.toString(),1,lStartPos.intValue()));
			if (lAttrPos.boolValue() && lAttrPos.compareTo(lEndPos)<0) {
				lAttrEnd.setValue(lAttribute.inString(Constants.ATTRIBUTESEPERATOR,1,lAttrPos.intValue()));
				if (!lAttrEnd.boolValue() || lAttrEnd.compareTo(lEndPos)>0) {
					lAttrEnd.setValue(lEndPos);
				}
				lValStart.setValue(lAttrPos.add(pAttribute.len()).add(1));
				lValLen.setValue(lAttrEnd.subtract(lValStart));
				return lAttribute.sub(lValStart.intValue(),lValLen.intValue());
			}
			else {
				return Clarion.newString("");
			}
		}
	}
	public ClarionNumber isValid(ClarionString pReportGeneratorType,ClarionString pControlExtendAttribute)
	{
		ClarionString lAttribute=Clarion.newString(Constants.MAXATTRIBUTESIZE+1).setEncoding(ClarionString.CSTRING);
		ClarionNumber lStartPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lEndPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lAttrPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lAttribute.setValue(pControlExtendAttribute);
		lStartPos.setValue(lAttribute.inString(pReportGeneratorType.toString(),1,1));
		if (!lStartPos.boolValue()) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			lEndPos.setValue(lAttribute.inString(Constants.ATTRIBUTELISTEND,1,lStartPos.intValue()));
			if (lEndPos.equals(0)) {
				return Clarion.newNumber(Constants.FALSE);
			}
			return Clarion.newNumber(Constants.TRUE);
		}
	}
	public ClarionNumber isValid(ClarionString pReportGeneratorType,ClarionString pAttribute,ClarionString pControlExtendAttribute)
	{
		ClarionString lAttribute=Clarion.newString(Constants.MAXATTRIBUTESIZE+1).setEncoding(ClarionString.CSTRING);
		ClarionNumber lStartPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lEndPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lAttrPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lAttribute.setValue(pControlExtendAttribute);
		lStartPos.setValue(lAttribute.inString(pReportGeneratorType.toString(),1,1));
		if (!lStartPos.boolValue()) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			lEndPos.setValue(lAttribute.inString(Constants.ATTRIBUTELISTEND,1,lStartPos.intValue()));
			if (lEndPos.equals(0)) {
				return Clarion.newNumber(Constants.FALSE);
			}
			lAttrPos.setValue(lAttribute.inString(pAttribute.toString(),1,lStartPos.intValue()));
			if (lAttrPos.boolValue()) {
				return Clarion.newNumber(Constants.TRUE);
			}
			else {
				return Clarion.newNumber(Constants.FALSE);
			}
		}
	}
}
