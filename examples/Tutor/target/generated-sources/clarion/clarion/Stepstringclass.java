package clarion;

import clarion.Abbrowse;
import clarion.Stepclass;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;

public class Stepstringclass extends Stepclass
{
	public ClarionNumber lookupMode;
	public ClarionString ref;
	public ClarionString root;
	public ClarionString sortChars;
	public ClarionNumber testLen;
	public Stepstringclass()
	{
		lookupMode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ref=null;
		root=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		sortChars=null;
		testLen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber getPercentile(ClarionObject value)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString match=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		if (this.root.len()!=0) {
			match.setValue(value.getString().sub(this.root.len()+1,this.testLen.add(1).intValue()));
		}
		else {
			match.setValue(value);
		}
		if (!((this.controls.intValue() & Scrollsort.CASESENSITIVE)!=0)) {
			match.setValue(match.upper());
		}
		for (i.setValue(0);i.compareTo(99)<=0;i.increment(1)) {
			if (this.ref.stringAt(i.multiply(this.testLen).add(1),i.add(1).multiply(this.testLen)).compareTo(match)>0) {
				break;
			}
		}
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			i.setValue(Clarion.newNumber(100).subtract(i));
		}
		return (i.equals(0) ? Clarion.newNumber(1) : i).getNumber();
	}
	public ClarionString getValue(ClarionNumber p)
	{
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			p.setValue(Clarion.newNumber(100).subtract(p));
		}
		if (p.equals(0)) {
			p.setValue(1);
		}
		return Clarion.newString(this.root.concat(this.ref.stringAt(p.subtract(1).multiply(this.testLen).add(1),p.multiply(this.testLen))));
	}
	public ClarionNumber hash(ClarionString value)
	{
		ClarionNumber base=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber result=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber digit=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		base.setValue(this.sortChars.len());
		if (!((this.controls.intValue() & Scrollsort.CASESENSITIVE)!=0)) {
			value.setValue(value.upper());
		}
		for (i.setValue(1);i.compareTo(4)<=0;i.increment(1)) {
			digit.setValue(this.sortChars.inString(value.stringAt(i).toString()));
			if (digit.boolValue()) {
				digit.decrement(1);
			}
			result.setValue(result.multiply(base).add(digit));
		}
		return result.like();
	}
	public void init(ClarionNumber controls,ClarionNumber mode)
	{
		ClarionString validChars=Clarion.newString(255);
		ClarionNumber chars=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		this.lookupMode.setValue(mode);
		super.init(controls.like());
		{
			ClarionNumber case_1=mode;
			boolean case_1_break=false;
			if (case_1.equals(Scrollby.NAME)) {
				this.ref=Abbrowse.scrollName;
				this.testLen.setValue(3);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Scrollby.ALPHA)) {
				this.ref=Abbrowse.scrollAlpha;
				this.testLen.setValue(2);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Scrollby.RUNTIME)) {
				this.ref=Clarion.newString(400);
				this.testLen.setValue(4);
				chars.setValue(0);
				for (i.setValue(1);i.compareTo(255)<=0;i.increment(1)) {
					if ((controls.intValue() & Scrollsort.ALLOWALT)!=0 && Abbrowse.overrideCharacters.inString(ClarionString.chr(i.intValue()).toString())!=0 || (controls.intValue() & Scrollsort.ALLOWNUMERIC)!=0 && ClarionString.chr(i.intValue()).compareTo("0")>=0 && ClarionString.chr(i.intValue()).compareTo("9")<=0 || (controls.intValue() & Scrollsort.ALLOWALPHA)!=0 && ClarionString.chr(i.intValue()).isAlpha() && ((controls.intValue() & Scrollsort.CASESENSITIVE)!=0 || ClarionString.chr(i.intValue()).isUpper())) {
						chars.increment(1);
						validChars.setStringAt(chars,ClarionString.chr(i.intValue()));
					}
				}
				this.sortChars=Clarion.newString(chars.add(1)).setEncoding(ClarionString.CSTRING);
				this.sortChars.setValue(validChars.stringAt(1,chars));
				case_1_break=true;
			}
		}
	}
	public void kill()
	{
		if (this.lookupMode.equals(Scrollby.RUNTIME)) {
			//this.ref;
		}
		//this.sortChars;
	}
	public void setLimit(ClarionObject l,ClarionObject h)
	{
		ClarionNumber minLen=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber common=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString lowValue=Clarion.newString(4);
		ClarionString highValue=Clarion.newString(4);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber delta=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lowVal=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString low=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		ClarionString high=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		low.setValue(l.getString().clip());
		high.setValue(h.getString().clip());
		if (high.len()<low.len()) {
			minLen.setValue(high.len());
		}
		else {
			minLen.setValue(low.len());
		}
		for (common.setValue(1);common.compareTo(minLen)<=0;common.increment(1)) {
			if (!low.stringAt(common).equals(high.stringAt(common))) break;
		}
		this.root.setValue(common.compareTo(1)>0 ? low.stringAt(1,common.subtract(1)) : Clarion.newString(""));
		lowValue.setValue(low.stringAt(common,low.len()));
		for (i.setValue(Clarion.newNumber(2+low.len()).subtract(common));i.compareTo(4)<=0;i.increment(1)) {
			lowValue.setStringAt(i,this.sortChars.stringAt(1));
		}
		highValue.setValue(high.stringAt(common,high.len()));
		for (i.setValue(Clarion.newNumber(2+high.len()).subtract(common));i.compareTo(4)<=0;i.increment(1)) {
			highValue.setStringAt(i,this.sortChars.stringAt(this.sortChars.len()));
		}
		lowVal.setValue(this.hash(lowValue.like()));
		delta.setValue(this.hash(highValue.like()).subtract(lowVal).divide(100));
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			for (i.setValue(99);i.compareTo(0)>=0;i.increment(-1)) {
				this.ref.setStringAt(Clarion.newNumber(1).add(i.multiply(4)),Clarion.newNumber(4).add(i.multiply(4)),this.unhash(lowVal.like()));
				lowVal.increment(delta);
			}
		}
		else {
			for (i.setValue(0);i.compareTo(99)<=0;i.increment(1)) {
				this.ref.setStringAt(Clarion.newNumber(1).add(i.multiply(4)),Clarion.newNumber(4).add(i.multiply(4)),this.unhash(lowVal.like()));
				lowVal.increment(delta);
			}
		}
	}
	public ClarionNumber setLimitNeeded()
	{
		return Clarion.newNumber(this.lookupMode.equals(Scrollby.RUNTIME) ? 1 : 0);
	}
	public ClarionString unhash(ClarionNumber l)
	{
		ClarionString retVal=Clarion.newString(4);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber base=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		base.setValue(this.sortChars.len());
		CRun._assert(base.boolValue());
		for (i.setValue(4);i.compareTo(1)>=0;i.increment(-1)) {
			retVal.setStringAt(i,this.sortChars.stringAt(l.modulus(base).add(1)));
			l.setValue(l.divide(base));
		}
		return retVal.like();
	}
}
