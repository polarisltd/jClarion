package clarion;

import clarion.Abfile;
import clarion.Bufferedpairsclass;
import clarion.Dbcolumnqueue;
import clarion.Dblogfilemanager;
import clarion.Errorclass;
import clarion.Idbchangeaudit;
import clarion.Logfilequeue;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CFile;

public class Dbauditmanager
{
	public ClarionString action;
	public Dbcolumnqueue columnInfo;
	public Logfilequeue logFiles;
	public Dblogfilemanager lfm;
	public Errorclass errors;

	private static class _Idbchangeaudit_Impl extends Idbchangeaudit
	{
		private Dbauditmanager _owner;
		public _Idbchangeaudit_Impl(Dbauditmanager _owner)
		{
			this._owner=_owner;
		}
		public void changeField(ClarionObject left,ClarionObject right,ClarionString fieldName,ClarionString fileName)
		{
			_owner.onFieldChange(left,right,fieldName.like(),fileName.like());
		}
		public void onChange(ClarionString fileName,ClarionFile file)
		{
			_owner.onChange(fileName.like(),file);
		}
		public void beforeChange(ClarionString fileName,Bufferedpairsclass bfp)
		{
			_owner.beforeChange(fileName.like(),bfp);
		}
	}
	private Idbchangeaudit _Idbchangeaudit_inst;
	public Idbchangeaudit idbchangeaudit()
	{
		if (_Idbchangeaudit_inst==null) _Idbchangeaudit_inst=new _Idbchangeaudit_Impl(this);
		return _Idbchangeaudit_inst;
	}
	public Dbauditmanager()
	{
		action=Clarion.newString(20);
		columnInfo=null;
		logFiles=null;
		lfm=null;
		errors=null;
	}

	public void addItem(ClarionString fileName,ClarionString fieldName,ClarionObject field,ClarionString fieldHeader,ClarionString fieldPicture)
	{
		if (!this.setFM(fileName.like()).boolValue()) {
			return;
		}
		this.columnInfo.fileName.setValue(fileName);
		this.columnInfo.fieldName.setValue(fieldName);
		this.columnInfo.get(this.columnInfo.ORDER().ascend(this.columnInfo.fileName).ascend(this.columnInfo.fieldName));
		if (CError.errorCode()!=0) {
			this.columnInfo.clear();
			this.columnInfo.fileName.setValue(fileName);
			this.columnInfo.fieldName.setValue(fieldName);
			this.columnInfo.field.setReferenceValue(field);
			this.columnInfo.fieldHeader.setValue(fieldHeader);
			this.columnInfo.fieldPicture.setValue(fieldPicture);
			this.columnInfo.length.setValue(field.getString().format(fieldPicture.toString()).len());
			if (Clarion.newNumber(this.columnInfo.fieldHeader.clip().len()).compareTo(this.columnInfo.length)>0) {
				this.columnInfo.length.setValue(this.columnInfo.fieldHeader.clip().len());
			}
			this.columnInfo.add();
		}
	}
	public void addLogFile(ClarionString fileName,ClarionString logFileName)
	{
		this.logFiles.fileName.setValue(fileName);
		this.logFiles.logFileName.setValue(logFileName);
		this.logFiles.get(this.logFiles.ORDER().ascend(this.logFiles.fileName));
		if (CError.errorCode()!=0) {
			this.logFiles.clear();
			this.logFiles.fileName.setValue(fileName);
			this.logFiles.logFileName.setValue(logFileName);
			this.logFiles.add();
			this.addItem(fileName.like(),Clarion.newString("Action"),this.action,Clarion.newString("Action"),Clarion.newString("@s20"));
		}
	}
	public void appendLog(ClarionString fileName)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString headerPic=Clarion.newString().setEncoding(ClarionString.ASTRING);
		if (!this.setFM(fileName.like()).boolValue()) {
			return;
		}
		this.openLogFile(fileName.like());
		this.lfm.buffer.clear();
		this.lfm.buffer.setValue(ClarionString.staticConcat("|",Clarion.newString(String.valueOf(CDate.today())).format("@D17"),"|",Clarion.newString(String.valueOf(CDate.clock())).format("@T7"),"|"));
		this.columnInfo.sort(this.columnInfo.ORDER().ascend(this.columnInfo.fileName));
		for (i.setValue(1);i.compareTo(this.columnInfo.records())<=0;i.increment(1)) {
			this.columnInfo.get(i);
			if (this.columnInfo.fileName.compareTo(fileName)<0) {
				continue;
			}
			if (this.columnInfo.fileName.compareTo(fileName)>0) {
				break;
			}
			headerPic.setValue(ClarionString.staticConcat("@s",this.columnInfo.length));
			this.lfm.buffer.setValue(this.lfm.buffer.getString().clip().concat(this.columnInfo.field.getString().format(this.columnInfo.fieldPicture.toString()).format(headerPic.toString()),"|"));
		}
		this.lfm.insert();
	}
	public void beforeChange(ClarionString fileName,Bufferedpairsclass bfp)
	{
		this.action.setValue("Before Change");
		bfp.assignLeftToBuffer();
		bfp.assignRightToLeft();
		this.appendLog(fileName.like());
		bfp.assignBufferToLeft();
	}
	public void createHeader(ClarionString fileName,Dblogfilemanager lfm)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber lHeader=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString saveBuffer=Clarion.newString().setEncoding(ClarionString.ASTRING);
		lfm.create.setValue(Constants.TRUE);
		lfm.buffer.clear();
		lfm.buffer.setValue(ClarionString.staticConcat("| Date",Clarion.newString(" ").all(Clarion.newString(String.valueOf(CDate.today())).format("@D17").len()-5),"| Time",Clarion.newString(" ").all(Clarion.newString(String.valueOf(CDate.clock())).format("@T7").len()-5),"|"));
		this.columnInfo.sort(this.columnInfo.ORDER().ascend(this.columnInfo.fileName));
		for (i.setValue(1);i.compareTo(this.columnInfo.records())<=0;i.increment(1)) {
			this.columnInfo.get(i);
			if (this.columnInfo.fileName.compareTo(fileName)<0) {
				continue;
			}
			if (this.columnInfo.fileName.compareTo(fileName)>0) {
				break;
			}
			lHeader.setValue(this.columnInfo.fieldHeader.clip().len());
			if (lHeader.compareTo(this.columnInfo.length)<0) {
				lfm.buffer.setValue(lfm.buffer.getString().clip().concat(this.columnInfo.fieldHeader,Clarion.newString(" ").all(this.columnInfo.length.subtract(lHeader).intValue()),"|"));
			}
			else {
				lfm.buffer.setValue(lfm.buffer.getString().clip().concat(this.columnInfo.fieldHeader,"|"));
			}
		}
		saveBuffer.setValue(lfm.buffer.getString());
		lfm.buffer.setValue(Clarion.newString("-").all(saveBuffer.clip().len()));
		lfm.insert();
		lfm.buffer.setValue(saveBuffer);
		lfm.insert();
		lfm.buffer.setValue(Clarion.newString("-").all(saveBuffer.clip().len()));
		lfm.insert();
	}
	public void init(Errorclass errorHandler)
	{
		this.errors=errorHandler;
		this.columnInfo=new Dbcolumnqueue();
		this.logFiles=new Logfilequeue();
		this.lfm=new Dblogfilemanager();
	}
	public void kill()
	{
		while (!(this.columnInfo.records()<1)) {
			this.columnInfo.get(1);
			this.columnInfo.field.setReferenceValue(null);
			this.columnInfo.delete();
		}
		this.columnInfo.free();
		//this.columnInfo;
		this.logFiles.free();
		//this.logFiles;
		if (this.lfm.opened.boolValue()) {
			this.lfm.close();
			this.lfm.kill();
		}
		this.lfm.destruct();
	}
	public ClarionNumber setFM(ClarionString fileName)
	{
		this.logFiles.fileName.setValue(fileName);
		this.logFiles.get(this.logFiles.ORDER().ascend(this.logFiles.fileName));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
	}
	public void onChange(ClarionString fileName,ClarionFile file)
	{
		this.action.setValue("After Change");
		this.appendLog(fileName.like());
	}
	public void onDelete(ClarionString fileName,ClarionFile file)
	{
		this.action.setValue("On Delete");
		this.appendLog(fileName.like());
	}
	public void onFieldChange(ClarionObject left,ClarionObject right,ClarionString fieldName,ClarionString fileName)
	{
	}
	public void onInsert(ClarionString fileName,ClarionFile file)
	{
		this.action.setValue("On Insert");
		this.appendLog(fileName.like());
	}
	public void openLogFile(ClarionString fileName)
	{
		ClarionNumber createHeader=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.logFiles.fileName.setValue(fileName);
		this.logFiles.get(this.logFiles.ORDER().ascend(this.logFiles.fileName));
		if (!(CError.errorCode()!=0)) {
			if (this.lfm.opened.boolValue()) {
				this.lfm.close();
				this.lfm.kill();
				this.lfm.opened.setValue(Constants.FALSE);
			}
			Abfile.szDbTextLog.setValue(this.logFiles.logFileName.clip());
			this.lfm.init(this.errors,this.logFiles.logFileName.like());
			createHeader.setValue(CFile.isFile(Abfile.szDbTextLog.toString()));
			if (this.lfm.open().boolValue()) {
			}
			else {
				if (!createHeader.boolValue()) {
					this.createHeader(fileName.like(),this.lfm);
				}
			}
		}
		this.lfm.opened.setValue(Constants.TRUE);
	}
}
