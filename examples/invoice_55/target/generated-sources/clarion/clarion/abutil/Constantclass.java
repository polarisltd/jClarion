package clarion.abutil;

import clarion.abutil.Constdescriptorlist;
import clarion.equates.Constants;
import clarion.equates.Consttype;
import clarion.equates.Level;
import clarion.equates.Term;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Constantclass
{
	public ClarionNumber charpnt=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber items=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber recordpnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber sourcesize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString str=null;
	public ClarionNumber termination=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString terminatorvalue=Clarion.newString(33).setEncoding(ClarionString.CSTRING);
	public Constdescriptorlist descriptor=null;
	public Constantclass()
	{
		charpnt=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		items=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		recordpnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		sourcesize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		str=null;
		termination=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		terminatorvalue=Clarion.newString(33).setEncoding(ClarionString.CSTRING);
		descriptor=null;
	}

	public void additem(ClarionNumber itemtype,ClarionObject dest)
	{
		this.descriptor.clear();
		this.descriptor.itemtype.setValue(itemtype);
		this.descriptor.destination.setReferenceValue(dest);
		this.descriptor.add();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public ClarionNumber getbyte()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rval.setValue(this.str.stringAt(this.charpnt).val());
		this.charpnt.increment(1);
		return rval.like();
	}
	public ClarionNumber getshort()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		rval.setValue(this.getushort());
		return rval.like();
	}
	public ClarionNumber getushort()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		rval.setValue(this.getbyte());
		return rval.add(ClarionNumber.shift(this.getbyte().intValue(),8)).getNumber();
	}
	public ClarionNumber getlong()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		rval.setValue(this.getushort());
		return rval.add(ClarionNumber.shift(this.getshort().intValue(),16)).getNumber();
	}
	public ClarionString getpstring()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString rval=Clarion.newString(256);
		final ClarionNumber loop_1=this.getbyte();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			rval.setStringAt(i,ClarionString.chr(this.getbyte().intValue()));
		}
		return rval.sub(1,i.subtract(1).intValue());
	}
	public ClarionString getcstring()
	{
		ClarionNumber b=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber cnt=Clarion.newNumber(0).setEncoding(ClarionNumber.USHORT);
		ClarionString rval=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
		while (true) {
			b.setValue(this.getbyte());
			if (!b.boolValue()) {
				break;
			}
			else {
				cnt.increment(1);
				rval.setStringAt(cnt,ClarionString.chr(b.intValue()));
			}
		}
		return rval.sub(1,cnt.intValue());
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
		this.terminatorvalue.clear();
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
		this.recordpnt.setValue(1);
		this.charpnt.setValue(1);
		if (!(this.str==null)) {
			{
				ClarionNumber case_1=this.termination;
				boolean case_1_break=false;
				if (case_1.equals(Term.BYTE)) {
					this.items.setValue(this.getbyte());
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Term.USHORT)) {
					this.items.setValue(this.getushort());
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
		this.sourcesize.setValue(this.str.len());
		this.reset();
	}
	public ClarionNumber next()
	{
		CRun._assert(!this.termination.equals(Term.FIELDVALUE) || this.terminatorvalue.boolValue());
		{
			ClarionNumber case_1=this.termination;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Term.BYTE)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Term.USHORT)) {
				if (this.recordpnt.compareTo(this.items)>0) {
					return Clarion.newNumber(Level.NOTIFY);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Term.ENDGROUP)) {
				if (this.charpnt.compareTo(this.sourcesize)>0) {
					return Clarion.newNumber(Level.NOTIFY);
				}
				case_1_break=true;
			}
		}
		this.descriptor.get(1);
		while (!(CError.errorCode()!=0)) {
			{
				ClarionNumber case_2=this.descriptor.itemtype;
				boolean case_2_break=false;
				if (case_2.equals(Consttype.CSTRING)) {
					this.descriptor.destination.setValue(this.getcstring());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.PSTRING)) {
					this.descriptor.destination.setValue(this.getpstring());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.BYTE)) {
					this.descriptor.destination.setValue(this.getbyte());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.SHORT)) {
					this.descriptor.destination.setValue(this.getshort());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.USHORT)) {
					this.descriptor.destination.setValue(this.getushort());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Consttype.LONG)) {
					this.descriptor.destination.setValue(this.getlong());
					case_2_break=true;
				}
				if (!case_2_break) {
					CRun._assert(Constants.FALSE!=0);
				}
			}
			if (this.descriptor.getPointer()==1 && this.termination.equals(Term.FIELDVALUE) && this.descriptor.destination.equals(this.terminatorvalue)) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			this.descriptor.get(this.descriptor.getPointer()+1);
		}
		this.recordpnt.increment(1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public void next(ClarionQueue q)
	{
		this.reset();
		while (this.next().equals(Level.BENIGN)) {
			q.add();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public void next(ClarionFile f)
	{
		this.reset();
		while (this.next().equals(Level.BENIGN)) {
			f.add();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
}
