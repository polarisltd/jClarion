package clarion.abfile;

import clarion.Dbcolumnqueue;
import clarion.Idbchangeaudit;
import clarion.Logfilequeue;
import clarion.aberror.Errorclass;
import clarion.abfile.Abfile;
import clarion.abfile.Dblogfilemanager;
import clarion.abutil.Bufferedpairsclass;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CFile;

@SuppressWarnings("all")
public class Dbauditmanager
{
	public ClarionString action=Clarion.newString(20);
	public Dbcolumnqueue columninfo=null;
	public Logfilequeue logfiles=null;
	public Dblogfilemanager lfm=null;
	public Errorclass errors=null;

	private static class _Idbchangeaudit_Impl extends Idbchangeaudit
	{
		private Dbauditmanager _owner;
		public _Idbchangeaudit_Impl(Dbauditmanager _owner)
		{
			this._owner=_owner;
		}
		public void changefield(ClarionObject left,ClarionObject right,ClarionString fieldname,ClarionString filename)
		{
			_owner.onfieldchange(left,right,fieldname.like(),filename.like());
		}
		public void onchange(ClarionString filename,ClarionFile file)
		{
			_owner.onchange(filename.like(),file);
		}
		public void beforechange(ClarionString filename,Bufferedpairsclass bfp)
		{
			_owner.beforechange(filename.like(),bfp);
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
		columninfo=null;
		logfiles=null;
		lfm=null;
		errors=null;
	}

	public void additem(ClarionString filename,ClarionString fieldname,ClarionObject field,ClarionString fieldheader,ClarionString fieldpicture)
	{
		if (!this.setfm(filename.like()).boolValue()) {
			return;
		}
		this.columninfo.filename.setValue(filename);
		this.columninfo.fieldname.setValue(fieldname);
		this.columninfo.get(this.columninfo.ORDER().ascend(this.columninfo.filename).ascend(this.columninfo.fieldname));
		if (CError.errorCode()!=0) {
			this.columninfo.clear();
			this.columninfo.filename.setValue(filename);
			this.columninfo.fieldname.setValue(fieldname);
			this.columninfo.field.setReferenceValue(field);
			this.columninfo.fieldheader.setValue(fieldheader);
			this.columninfo.fieldpicture.setValue(fieldpicture);
			this.columninfo.length.setValue(field.getString().format(fieldpicture.toString()).len());
			if (Clarion.newNumber(this.columninfo.fieldheader.clip().len()).compareTo(this.columninfo.length)>0) {
				this.columninfo.length.setValue(this.columninfo.fieldheader.clip().len());
			}
			this.columninfo.add();
		}
	}
	public void addlogfile(ClarionString filename,ClarionString logfilename)
	{
		this.logfiles.filename.setValue(filename);
		this.logfiles.logfilename.setValue(logfilename);
		this.logfiles.get(this.logfiles.ORDER().ascend(this.logfiles.filename));
		if (CError.errorCode()!=0) {
			this.logfiles.clear();
			this.logfiles.filename.setValue(filename);
			this.logfiles.logfilename.setValue(logfilename);
			this.logfiles.add();
			this.additem(filename.like(),Clarion.newString("Action"),this.action,Clarion.newString("Action"),Clarion.newString("@s20"));
		}
	}
	public void appendlog(ClarionString filename)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString headerpic=Clarion.newString().setEncoding(ClarionString.ASTRING);
		if (!this.setfm(filename.like()).boolValue()) {
			return;
		}
		this.openlogfile(filename.like());
		this.lfm.buffer.clear();
		this.lfm.buffer.setValue(ClarionString.staticConcat("|",Clarion.newString(String.valueOf(CDate.today())).format("@D17"),"|",Clarion.newString(String.valueOf(CDate.clock())).format("@T7"),"|"));
		this.columninfo.sort(this.columninfo.ORDER().ascend(this.columninfo.filename));
		final int loop_1=this.columninfo.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.columninfo.get(i);
			if (this.columninfo.filename.compareTo(filename)<0) {
				continue;
			}
			if (this.columninfo.filename.compareTo(filename)>0) {
				break;
			}
			headerpic.setValue(ClarionString.staticConcat("@s",this.columninfo.length));
			this.lfm.buffer.setValue(this.lfm.buffer.getString().clip().concat(this.columninfo.field.getString().format(this.columninfo.fieldpicture.toString()).format(headerpic.toString()),"|"));
		}
		this.lfm.insert();
	}
	public void beforechange(ClarionString filename,Bufferedpairsclass bfp)
	{
		this.action.setValue("Before Change");
		bfp.assignlefttobuffer();
		bfp.assignrighttoleft();
		this.appendlog(filename.like());
		bfp.assignbuffertoleft();
	}
	public void createheader(ClarionString filename,Dblogfilemanager lfm)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber lheader=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString savebuffer=Clarion.newString().setEncoding(ClarionString.ASTRING);
		lfm.create.setValue(Constants.TRUE);
		lfm.buffer.clear();
		lfm.buffer.setValue(ClarionString.staticConcat("| Date",Clarion.newString(" ").all(Clarion.newString(String.valueOf(CDate.today())).format("@D17").len()-5),"| Time",Clarion.newString(" ").all(Clarion.newString(String.valueOf(CDate.clock())).format("@T7").len()-5),"|"));
		this.columninfo.sort(this.columninfo.ORDER().ascend(this.columninfo.filename));
		final int loop_1=this.columninfo.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.columninfo.get(i);
			if (this.columninfo.filename.compareTo(filename)<0) {
				continue;
			}
			if (this.columninfo.filename.compareTo(filename)>0) {
				break;
			}
			lheader.setValue(this.columninfo.fieldheader.clip().len());
			if (lheader.compareTo(this.columninfo.length)<0) {
				lfm.buffer.setValue(lfm.buffer.getString().clip().concat(this.columninfo.fieldheader,Clarion.newString(" ").all(this.columninfo.length.subtract(lheader).intValue()),"|"));
			}
			else {
				lfm.buffer.setValue(lfm.buffer.getString().clip().concat(this.columninfo.fieldheader,"|"));
			}
		}
		savebuffer.setValue(lfm.buffer.getString());
		lfm.buffer.setValue(Clarion.newString("-").all(savebuffer.clip().len()));
		lfm.insert();
		lfm.buffer.setValue(savebuffer);
		lfm.insert();
		lfm.buffer.setValue(Clarion.newString("-").all(savebuffer.clip().len()));
		lfm.insert();
	}
	public void init(Errorclass errorhandler)
	{
		this.errors=errorhandler;
		this.columninfo=new Dbcolumnqueue();
		this.logfiles=new Logfilequeue();
		this.lfm=new Dblogfilemanager();
	}
	public void kill()
	{
		while (!(this.columninfo.records()<1)) {
			this.columninfo.get(1);
			this.columninfo.field.setReferenceValue(null);
			this.columninfo.delete();
		}
		this.columninfo.free();
		//this.columninfo;
		this.logfiles.free();
		//this.logfiles;
		if (this.lfm.opened.boolValue()) {
			this.lfm.close();
			this.lfm.kill();
		}
		this.lfm.destruct();
	}
	public ClarionNumber setfm(ClarionString filename)
	{
		this.logfiles.filename.setValue(filename);
		this.logfiles.get(this.logfiles.ORDER().ascend(this.logfiles.filename));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
	}
	public void onchange(ClarionString filename,ClarionFile file)
	{
		this.action.setValue("After Change");
		this.appendlog(filename.like());
	}
	public void ondelete(ClarionString filename,ClarionFile file)
	{
		this.action.setValue("On Delete");
		this.appendlog(filename.like());
	}
	public void onfieldchange(ClarionObject left,ClarionObject right,ClarionString fieldname,ClarionString filename)
	{
	}
	public void oninsert(ClarionString filename,ClarionFile file)
	{
		this.action.setValue("On Insert");
		this.appendlog(filename.like());
	}
	public void openlogfile(ClarionString filename)
	{
		ClarionNumber createheader=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.logfiles.filename.setValue(filename);
		this.logfiles.get(this.logfiles.ORDER().ascend(this.logfiles.filename));
		if (!(CError.errorCode()!=0)) {
			if (this.lfm.opened.boolValue()) {
				this.lfm.close();
				this.lfm.kill();
				this.lfm.opened.setValue(Constants.FALSE);
			}
			Abfile.szdbtextlog.setValue(this.logfiles.logfilename.clip());
			this.lfm.init(this.errors,this.logfiles.logfilename.like());
			createheader.setValue(CFile.isFile(Abfile.szdbtextlog.toString()));
			if (this.lfm.open().boolValue()) {
			}
			else {
				if (!createheader.boolValue()) {
					this.createheader(filename.like(),this.lfm);
				}
			}
		}
		this.lfm.opened.setValue(Constants.TRUE);
	}
}
