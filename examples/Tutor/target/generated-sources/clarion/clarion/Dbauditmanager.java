package clarion;

import clarion.Abfile;
import clarion.Bufferedpairsclass;
import clarion.Criticalprocedure;
import clarion.Dbcolumnqueue;
import clarion.Dblogfilemanager;
import clarion.Errorclass;
import clarion.Idbchangeaudit;
import clarion.Logfilequeue;
import clarion.Threadedaction;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.concurrent.ICriticalSection;

public class Dbauditmanager
{
	public Threadedaction actions;
	public Dbcolumnqueue columnInfo;
	public Logfilequeue logFiles;
	public Dblogfilemanager lfm;
	public Errorclass errors;
	public ICriticalSection crit;
	public ClarionNumber inited;

	private static class _Idbchangeaudit_Impl extends Idbchangeaudit
	{
		private Dbauditmanager _owner;
		public _Idbchangeaudit_Impl(Dbauditmanager _owner)
		{
			this._owner=_owner;
		}
		public void changeField(ClarionObject left,ClarionObject right,ClarionString fieldName,ClarionString filename)
		{
			_owner.onFieldChange(left,right,fieldName.like(),filename.like());
		}
		public void onChange(ClarionString filename,ClarionFile file)
		{
			_owner.onChange(filename.like(),file);
		}
		public void beforeChange(ClarionString filename,Bufferedpairsclass bfp)
		{
			_owner.beforeChange(filename.like(),bfp);
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
		actions=null;
		columnInfo=null;
		logFiles=null;
		lfm=null;
		errors=null;
		crit=null;
		inited=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		construct();
	}

	public void syncAction()
	{
		this.syncAction(Clarion.newNumber(CRun.getThreadID()));
	}
	public void syncAction(ClarionNumber id)
	{
		this.actions.id.setValue(id);
		this.actions.get(this.actions.ORDER().ascend(this.actions.id));
		if (CError.errorCode()!=0) {
			this.actions.action.setValue("");
			this.actions.add(this.actions.ORDER().ascend(this.actions.id));
		}
	}
	public void setAction(ClarionString action)
	{
		this.setAction(Clarion.newNumber(CRun.getThreadID()),action.like());
	}
	public void setAction(ClarionNumber id,ClarionString action)
	{
		this.syncAction(id.like());
		this.actions.action.setValue(action);
		this.actions.put(this.actions.ORDER().ascend(this.actions.id));
	}
	public ClarionString getAction(ClarionNumber id)
	{
		this.syncAction(id.like());
		return this.actions.action.like();
	}
	public ClarionString getAction()
	{
		return this.getAction(Clarion.newNumber(CRun.getThreadID()));
	}
	public void addItem(ClarionString filename,ClarionString fieldName,ClarionObject field,ClarionString fieldHeader,ClarionString fieldPicture)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			if (!this.setFM(filename.like()).boolValue()) {
				return;
			}
			this.syncAction();
			this.columnInfo.filename.setValue(filename);
			this.columnInfo.fieldName.setValue(fieldName);
			this.columnInfo.get(this.columnInfo.ORDER().ascend(this.columnInfo.filename).ascend(this.columnInfo.fieldName));
			if (CError.errorCode()!=0) {
				this.columnInfo.clear();
				this.columnInfo.filename.setValue(filename);
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
		} finally {
			cp.destruct();
		}
	}
	public void addLogFile(ClarionString filename,ClarionString logFileName)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.syncAction();
			this.logFiles.filename.setValue(filename);
			this.logFiles.logFileName.setValue(logFileName);
			this.logFiles.get(this.logFiles.ORDER().ascend(this.logFiles.filename));
			if (CError.errorCode()!=0) {
				this.logFiles.clear();
				this.logFiles.filename.setValue(filename);
				this.logFiles.logFileName.setValue(logFileName);
				this.logFiles.add();
				this.addItem(filename.like(),Clarion.newString("Action"),this.actions.action,Clarion.newString("Action"),Clarion.newString("@s20"));
			}
		} finally {
			cp.destruct();
		}
	}
	public void appendLog(ClarionString filename)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString headerPic=Clarion.newString().setEncoding(ClarionString.ASTRING);
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			if (!this.setFM(filename.like()).boolValue()) {
				return;
			}
			this.syncAction();
			this.openLogFile(filename.like());
			this.lfm.buffer.clear();
			this.lfm.buffer.setValue(ClarionString.staticConcat("|",Clarion.newString(String.valueOf(CDate.today())).format("@D17"),"|",Clarion.newString(String.valueOf(CDate.clock())).format("@T7"),"|"));
			this.columnInfo.sort(this.columnInfo.ORDER().ascend(this.columnInfo.filename));
			for (i.setValue(1);i.compareTo(this.columnInfo.records())<=0;i.increment(1)) {
				this.columnInfo.get(i);
				if (this.columnInfo.filename.compareTo(filename)<0) {
					continue;
				}
				if (this.columnInfo.filename.compareTo(filename)>0) {
					break;
				}
				headerPic.setValue(ClarionString.staticConcat("@s",this.columnInfo.length));
				this.lfm.buffer.setValue(this.lfm.buffer.getString().clip().concat(this.columnInfo.field.getString().format(this.columnInfo.fieldPicture.toString()).format(headerPic.toString()),"|"));
			}
			this.lfm.insert();
			this.closeLogFile(filename.like());
		} finally {
			cp.destruct();
		}
	}
	public void beforeChange(ClarionString filename,Bufferedpairsclass bfp)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.setAction(Clarion.newString("Before Change"));
			bfp.assignLeftToBuffer();
			bfp.assignRightToLeft();
			this.appendLog(filename.like());
			bfp.assignBufferToLeft();
		} finally {
			cp.destruct();
		}
	}
	public void createHeader(ClarionString filename,Dblogfilemanager lfm)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber lHeader=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString saveBuffer=Clarion.newString().setEncoding(ClarionString.ASTRING);
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.syncAction();
			lfm.create.setValue(Constants.TRUE);
			lfm.buffer.clear();
			lfm.buffer.setValue(ClarionString.staticConcat("| Date",Clarion.newString(" ").all(Clarion.newString(String.valueOf(CDate.today())).format("@D17").len()-5),"| Time",Clarion.newString(" ").all(Clarion.newString(String.valueOf(CDate.clock())).format("@T7").len()-5),"|"));
			this.columnInfo.sort(this.columnInfo.ORDER().ascend(this.columnInfo.filename));
			for (i.setValue(1);i.compareTo(this.columnInfo.records())<=0;i.increment(1)) {
				this.columnInfo.get(i);
				if (this.columnInfo.filename.compareTo(filename)<0) {
					continue;
				}
				if (this.columnInfo.filename.compareTo(filename)>0) {
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
		} finally {
			cp.destruct();
		}
	}
	public void init(Errorclass errorHandler)
	{
		this.crit=new ICriticalSection();
		this.errors=errorHandler;
		this.columnInfo=new Dbcolumnqueue();
		this.logFiles=new Logfilequeue();
		this.lfm=new Dblogfilemanager();
		this.lfm.cleanedUp.setValue(Constants.TRUE);
		this.actions=new Threadedaction();
		this.inited.setValue(Constants.TRUE);
	}
	public void kill()
	{
		if (this.inited.boolValue()) {
			this.inited.setValue(Constants.FALSE);
			//this.actions;
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
			}
			this.lfm.destruct();
		}
	}
	public ClarionNumber setFM(ClarionString filename)
	{
		this.logFiles.filename.setValue(filename);
		this.logFiles.get(this.logFiles.ORDER().ascend(this.logFiles.filename));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
	}
	public void onChange(ClarionString filename,ClarionFile file)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.setAction(Clarion.newString("After Change"));
			this.appendLog(filename.like());
		} finally {
			cp.destruct();
		}
	}
	public void onDelete(ClarionString filename,ClarionFile file)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.setAction(Clarion.newString("On Delete"));
			this.appendLog(filename.like());
		} finally {
			cp.destruct();
		}
	}
	public void onFieldChange(ClarionObject left,ClarionObject right,ClarionString fieldName,ClarionString filename)
	{
	}
	public void onInsert(ClarionString filename,ClarionFile file)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.setAction(Clarion.newString("On Insert"));
			this.appendLog(filename.like());
		} finally {
			cp.destruct();
		}
	}
	public void openLogFile(ClarionString filename)
	{
		ClarionNumber createHeader=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.logFiles.filename.setValue(filename);
		this.logFiles.get(this.logFiles.ORDER().ascend(this.logFiles.filename));
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
					this.createHeader(filename.like(),this.lfm);
				}
			}
		}
		this.lfm.opened.setValue(Constants.TRUE);
	}
	public void closeLogFile(ClarionString filename)
	{
		this.logFiles.filename.setValue(filename);
		this.logFiles.get(this.logFiles.ORDER().ascend(this.logFiles.filename));
		if (!(CError.errorCode()!=0)) {
			if (this.lfm.opened.boolValue()) {
				this.lfm.close();
				this.lfm.kill();
				this.lfm.opened.setValue(Constants.FALSE);
				this.logFiles.put();
			}
		}
	}
	public void construct()
	{
	}
	public void destruct()
	{
		this.kill();
	}
}
