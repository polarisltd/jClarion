package clarion.abfile;

import clarion.Main;
import clarion.abfile.Filemanager;
import clarion.abfile.Filemapping;
import clarion.abfile.Filesmanager;
import clarion.abfile.Keyfieldqueue;
import clarion.abfile.Statusq;
import clarion.equates.As;
import clarion.equates.Constants;
import clarion.equates.Driverop;
import clarion.equates.File;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;

@SuppressWarnings("all")
public class Abfile
{
	public static Filemapping filemapping;
	public static ClarionNumber epoc;
	public static Statusq statusq;
	public static Filesmanager filesmanager;
	public static ClarionString szdbtextlog;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		Main.__register_destruct(new Runnable() { public void run() { __static_destruct(); } });
		__static_init();
	}

	public static void __static_init() {
		filemapping=new Filemapping();
		epoc=Clarion.newNumber(1).setEncoding(ClarionNumber.LONG);
		statusq=new Statusq();
		filesmanager=new Filesmanager();
		szdbtextlog=Clarion.newString(File.MAXFILEPATH+1).setEncoding(ClarionString.CSTRING);
	}

	public static void __static_destruct() {
		Abfile.filesmanager.destruct();
	}


	public static ClarionString getfieldvalue(ClarionString fmtag,ClarionString fldtag)
	{
		Filemanager fm=null;
		ClarionAny fld=Clarion.newAny();
		fm=Abfile.getfilemanager(fmtag.like());
		fld.setReferenceValue(Abfile.getfilefield(fmtag.like(),fldtag.like()));
		return (fm==null || fld.getValue()==null ? Clarion.newString("") : fld.getString().format(fm.getfieldpicture(fldtag.like()).toString())).getString();
	}
	public static ClarionObject getfilefield(ClarionString fmtag,ClarionString fldtag)
	{
		Filemanager fm=null;
		ClarionAny rval=Clarion.newAny();
		fm=Abfile.getfilemanager(fmtag.like());
		if (fm==null) {
			rval.setReferenceValue(null);
		}
		else {
			rval.setReferenceValue(fm.getfield(fldtag.like()));
		}
		return rval;
	}
	public static Filemanager getfilemanager(ClarionString tag)
	{
		Filemanager rval=null;
		rval=(Filemanager)CMemory.resolveAddress(CMemory.tied(tag.toString(),As.ADDRFILEMANAGER));
		return rval;
	}
	public static void setfilemanager(Filemanager fm,ClarionString tag)
	{
		CMemory.tie(tag.toString(),As.ADDRFILEMANAGER,CMemory.address(fm));
	}
	public static void concatgetcomponents(Keyfieldqueue fields,ClarionString into,ClarionNumber howmany)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		into.setValue("");
		final ClarionNumber loop_1=howmany.like();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			fields.get(i);
			if (CError.errorCode()!=0) {
				break;
			}
			into.setValue(into.concat(fields.field,"|"));
		}
	}
	public static ClarionString dupstring(ClarionString st)
	{
		ClarionNumber sizeis=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionString ns=null;
		sizeis.setValue(st.clip().len());
		ns=Clarion.newString(sizeis.equals(0) ? Clarion.newNumber(1) : sizeis);
		ns.setValue(st);
		return ns;
	}
	public static ClarionString casedvalue(ClarionString fieldname,ClarionObject field,ClarionObject fieldvalue)
	{
		ClarionString tvalue=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionString value=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber j=Clarion.newNumber(2).setEncoding(ClarionNumber.UNSIGNED);
		if ((field.getValue()) instanceof ClarionString) {
			tvalue.setValue(fieldvalue);
			value.setStringAt(1,"'");
			final int loop_1=tvalue.len();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				value.setStringAt(j,tvalue.stringAt(i));
				j.increment(1);
				if (tvalue.stringAt(i).equals("'")) {
					value.setStringAt(j,tvalue.stringAt(i));
					j.increment(1);
				}
			}
			value.setStringAt(j,j.add(1),"'\u0000");
			return (fieldname.inString("UPPER(",1,1)!=0 ? Clarion.newString(ClarionString.staticConcat("UPPER(",value,")")) : value).getString();
		}
		else {
			return fieldvalue.getString();
		}
	}
	public static ClarionNumber localaction(ClarionNumber mode)
	{
		return Clarion.newNumber(mode.equals(Ri.RESTRICT) || mode.equals(Ri.CASCADE) || mode.equals(Ri.CLEAR) ? 1 : 0);
	}
	public static void cleanup(Filemanager self)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (self.cleanedup.boolValue()) {
			return;
		}
		self.cleanedup.setValue(Constants.TRUE);
		Abfile.filesmanager.removefilemapping(self);
		//self.info;
		if (!(self.keys==null)) {
			final int loop_2=self.keys.records();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
				self.keys.get(i);
				final int loop_1=self.keys.fields.get().records();for (j.setValue(1);j.compareTo(loop_1)<=0;j.increment(1)) {
					self.keys.fields.get().get(j);
					//self.keys.fields.get().fieldname.get();
					self.keys.fields.get().field.setReferenceValue(null);
				}
				//self.keys.fields.get();
			}
			//self.keys;
		}
		if (!(self.buffers==null)) {
			final int loop_3=self.buffers.records();for (i.setValue(1);i.compareTo(loop_3)<=0;i.increment(1)) {
				self.buffers.get(i);
				//self.buffers.buffer.get();
			}
			//self.buffers;
		}
		final int loop_4=self.saved.records();for (i.setValue(1);i.compareTo(loop_4)<=0;i.increment(1)) {
			self.saved.get(i);
			self.file.freeState(self.saved.state.intValue());
		}
		//self.saved;
		if (!(self.fields==null)) {
			final int loop_5=self.fields.records();for (i.setValue(1);i.compareTo(loop_5)<=0;i.increment(1)) {
				self.fields.get(i);
				self.fields.fld.setReferenceValue(null);
			}
			//self.fields;
		}
		self.filename.setReferenceValue(null);
	}
	public static ClarionNumber opcodecanbedone(ClarionNumber opcode)
	{
		{
			ClarionNumber case_1=opcode;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Driverop.DESTROY)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Driverop.CLOSE)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Driverop.GETNULLS)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Driverop.SETNULLS)) {
				return Clarion.newNumber(Constants.TRUE);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return Clarion.newNumber(Constants.FALSE);
			}
		}
		return Clarion.newNumber();
	}
}
