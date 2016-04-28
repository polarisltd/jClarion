package clarion;

import clarion.Filemanager;
import clarion.Filesmanager;
import clarion.Keyfieldqueue;
import clarion.equates.As;
import clarion.equates.Constants;
import clarion.equates.Driverop;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;

public class Abfile
{
	public static ClarionNumber epoc;
	public static ClarionString szDbTextLog;
	public static Filesmanager filesManager;

	public static ClarionString getFieldValue(ClarionString fMTag,ClarionString fldTag)
	{
		Filemanager fm=null;
		ClarionAny fld=Clarion.newAny();
		fm=Abfile.getFileManager(fMTag.like());
		fld.setReferenceValue(Abfile.getFileField(fMTag.like(),fldTag.like()));
		return (fm==null || fld.getValue()==null ? Clarion.newString("") : fld.getString().format(fm.getFieldPicture(fldTag.like()).toString())).getString();
	}
	public static ClarionObject getFileField(ClarionString fMTag,ClarionString fldTag)
	{
		Filemanager fm=null;
		ClarionAny rVal=Clarion.newAny();
		fm=Abfile.getFileManager(fMTag.like());
		if (fm==null) {
			rVal.setReferenceValue(null);
		}
		else {
			rVal.setReferenceValue(fm.getField(fldTag.like()));
		}
		return rVal;
	}
	public static Filemanager getFileManager(ClarionString tag)
	{
		Filemanager rVal=null;
		rVal=(Filemanager)CMemory.resolveAddress(CMemory.tied(tag.toString(),As.ADDRFILEMANAGER));
		return rVal;
	}
	public static void setFileManager(Filemanager fm,ClarionString tag)
	{
		CMemory.tie(tag.toString(),As.ADDRFILEMANAGER,CMemory.address(fm));
	}
	public static void concatGetComponents(Keyfieldqueue fields,ClarionString into,ClarionNumber howMany)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		into.setValue("");
		for (i.setValue(1);i.compareTo(howMany)<=0;i.increment(1)) {
			fields.get(i);
			if (CError.errorCode()!=0) {
				break;
			}
			into.setValue(into.concat(fields.field,"|"));
		}
	}
	public static ClarionString dupString(ClarionString st)
	{
		ClarionNumber sizeIs=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionString ns=null;
		sizeIs.setValue(st.clip().len());
		if (sizeIs.equals(0)) {
			sizeIs.setValue(1);
		}
		ns=Clarion.newString(sizeIs);
		ns.setValue(st);
		return ns;
	}
	public static ClarionString casedValue(ClarionString fieldName,ClarionObject field,ClarionObject fieldValue)
	{
		ClarionString tValue=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionString value=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber j=Clarion.newNumber(2).setEncoding(ClarionNumber.UNSIGNED);
		if ((field.getValue()) instanceof ClarionString) {
			tValue.setValue(fieldValue);
			value.setStringAt(1,"'");
			for (i.setValue(1);i.compareTo(tValue.len())<=0;i.increment(1)) {
				value.setStringAt(j,tValue.stringAt(i));
				j.increment(1);
				if (tValue.stringAt(i).equals("'")) {
					value.setStringAt(j,tValue.stringAt(i));
					j.increment(1);
				}
			}
			value.setStringAt(j,j.add(1),"'\u0000");
			return (fieldName.inString("UPPER(",1,1)!=0 ? Clarion.newString(ClarionString.staticConcat("UPPER(",value,")")) : value).getString();
		}
		else {
			return fieldValue.getString();
		}
	}
	public static ClarionNumber localAction(ClarionNumber mode)
	{
		return Clarion.newNumber(mode.equals(Ri.RESTRICT) || mode.equals(Ri.CASCADE) || mode.equals(Ri.CLEAR) ? 1 : 0);
	}
	public static void cleanUp(Filemanager self)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber k=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (self.cleanedUp.boolValue()) {
			return;
		}
		self.cleanedUp.setValue(Constants.TRUE);
		Abfile.filesManager.removeFileMapping(self);
		for (j.setValue(1);j.compareTo(self.keys.records())<=0;j.increment(1)) {
			self.keys.get(j);
			for (k.setValue(1);k.compareTo(self.keys.fields.get().records())<=0;k.increment(1)) {
				self.keys.fields.get().get(k);
				//self.keys.fields.get().fieldName.get();
				self.keys.fields.get().field.setReferenceValue(null);
			}
			//self.keys.fields.get();
		}
		//self.keys;
		if (!(self.previousBuffer==null)) {
			//self.previousBuffer;
		}
		if (!(self.buffers==null)) {
			for (i.setValue(1);i.compareTo(self.buffers.records())<=0;i.increment(1)) {
				self.buffers.get(i);
				//self.buffers.buffer.get();
			}
			//self.buffers;
		}
		for (i.setValue(1);i.compareTo(self.saved.records())<=0;i.increment(1)) {
			self.saved.get(i);
			self.file.freeState(self.saved.state.intValue());
		}
		//self.saved;
		if (!(self.fields==null)) {
			for (i.setValue(1);i.compareTo(self.fields.records())<=0;i.increment(1)) {
				self.fields.get(i);
				self.fields.fld.setReferenceValue(null);
			}
			//self.fields;
		}
		self.filename.setReferenceValue(null);
	}
	public static ClarionNumber opCodeCanBeDone(ClarionNumber opCode)
	{
		{
			ClarionNumber case_1=opCode;
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
