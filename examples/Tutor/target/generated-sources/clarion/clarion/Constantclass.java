package clarion;

import clarion.Constdescriptorlist;
import clarion.equates.Constants;
import clarion.equates.Consttype;
import clarion.equates.Level;
import clarion.equates.Term;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;

public class Constantclass
{
	public ClarionNumber charPnt;
	public ClarionNumber items;
	public ClarionNumber recordPnt;
	public ClarionNumber sourceSize;
	public ClarionString str;
	public ClarionNumber termination;
	public ClarionAny terminatorValue;
	public ClarionNumber terminatorField;
	public ClarionBool terminatorInclude;
	public Constdescriptorlist descriptor;
	public ClarionBool complete;
	public Constantclass()
	{
		charPnt=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		items=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		recordPnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		sourceSize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		str=null;
		termination=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		terminatorValue=Clarion.newAny();
		terminatorField=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		terminatorInclude=Clarion.newBool();
		descriptor=null;
		complete=Clarion.newBool();
	}

	public void constantClass()
	{
		this.complete.setValue(Constants.FALSE);
		this.terminatorField.setValue(1);
		this.terminatorInclude.setValue(Constants.FALSE);
	}
	public void addItem(ClarionNumber itemType,ClarionObject dest)
	{
		this.descriptor.clear();
		this.descriptor.itemType.setValue(itemType);
		this.descriptor.destination.setReferenceValue(dest);
		this.descriptor.add();
	}
	public ClarionNumber getByte()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rVal.setValue(this.str.stringAt(this.charPnt).val());
		this.charPnt.increment(1);
		return rVal.like();
	}
	public ClarionNumber getShort()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		rVal.setValue(this.getUShort());
		return rVal.like();
	}
	public ClarionNumber getUShort()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		rVal.setValue(this.getByte());
		return rVal.add(ClarionNumber.shift(this.getByte().intValue(),8)).getNumber();
	}
	public ClarionNumber getLong()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		rVal.setValue(this.getUShort());
		return rVal.add(ClarionNumber.shift(this.getShort().intValue(),16)).getNumber();
	}
	public ClarionString getPString()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString rVal=Clarion.newString(256);
		for (i.setValue(1);i.compareTo(this.getByte())<=0;i.increment(1)) {
			rVal.setStringAt(i,ClarionString.chr(this.getByte().intValue()));
		}
		return rVal.sub(1,i.subtract(1).intValue());
	}
	public ClarionString getCString()
	{
		ClarionNumber b=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber cnt=Clarion.newNumber(0).setEncoding(ClarionNumber.USHORT);
		ClarionString rVal=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
		while (true) {
			b.setValue(this.getByte());
			if (!b.boolValue()) {
				break;
			}
			else {
				cnt.increment(1);
				rVal.setStringAt(cnt,ClarionString.chr(b.intValue()));
			}
		}
		return rVal.sub(1,cnt.intValue());
	}
	public void init()
	{
		init(Clarion.newNumber(Term.USHORT));
	}
	public void init(ClarionNumber termination)
	{
		this.str=null;
		this.descriptor=new Constdescriptorlist();
		this.termination.setValue(termination);
		this.terminatorValue.clear();
		this.reset();
	}
	public void kill()
	{
		this.descriptor.get(1);
		while (!(CError.errorCode()!=0)) {
			this.descriptor.destination.setReferenceValue(null);
			this.descriptor.get(this.descriptor.getPointer()+1);
		}
		//this.descriptor;
		//this.str;
	}
	public void reset()
	{
		this.recordPnt.setValue(1);
		this.charPnt.setValue(1);
		if (!(this.str==null)) {
			{
				ClarionNumber case_1=this.termination;
				boolean case_1_break=false;
				if (case_1.equals(Term.BYTE)) {
					this.items.setValue(this.getByte());
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Term.USHORT)) {
					this.items.setValue(this.getUShort());
					case_1_break=true;
				}
			}
		}
		else {
			this.items.setValue(0);
		}
	}
	public void set(ClarionString src)
	{
		//this.str;
		this.str=Clarion.newString(src.len());
		this.str.setValue(src);
		this.sourceSize.setValue(this.str.len());
		this.reset();
	}
	public ClarionNumber next()
	{
		if (this.complete.boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		{
			ClarionNumber case_1=this.termination;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Term.BYTE)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Term.USHORT)) {
				if (this.recordPnt.compareTo(this.items)>0) {
					this.complete.setValue(Constants.TRUE);
					return Clarion.newNumber(Level.NOTIFY);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Term.ENDGROUP)) {
				if (this.charPnt.compareTo(this.sourceSize)>0) {
					this.complete.setValue(Constants.TRUE);
					return Clarion.newNumber(Level.NOTIFY);
				}
				case_1_break=true;
			}
		}
		this.descriptor.get(1);
		while (!(CError.errorCode()!=0)) {
			{
				ClarionNumber case_2=this.descriptor.itemType;
				boolean case_2_break=false;
				if (case_2.equals(Consttype.CSTRING)) {
					this.descriptor.destination.setValue(this.getCString());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.PSTRING)) {
					this.descriptor.destination.setValue(this.getPString());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.BYTE)) {
					this.descriptor.destination.setValue(this.getByte());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.SHORT)) {
					this.descriptor.destination.setValue(this.getShort());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.USHORT)) {
					this.descriptor.destination.setValue(this.getUShort());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.LONG)) {
					this.descriptor.destination.setValue(this.getLong());
					case_2_break=true;
				}
				if (!case_2_break) {
				}
			}
			if (Clarion.newNumber(this.descriptor.getPointer()).equals(this.terminatorField) && this.termination.equals(Term.FIELDVALUE) && this.descriptor.destination.equals(this.terminatorValue)) {
				this.complete.setValue(Constants.TRUE);
				if (!this.terminatorInclude.boolValue()) {
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
			this.descriptor.get(this.descriptor.getPointer()+1);
		}
		if (this.termination.equals(Term.FIELDVALUE) && this.complete.boolValue() && !this.terminatorInclude.boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		this.recordPnt.increment(1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public void next(ClarionQueue q)
	{
		this.reset();
		while (this.next().equals(Level.BENIGN)) {
			q.add();
		}
	}
	public void next(ClarionFile f)
	{
		this.reset();
		while (this.next().equals(Level.BENIGN)) {
			f.add();
		}
	}
}
