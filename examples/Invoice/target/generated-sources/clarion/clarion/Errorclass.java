package clarion;

import clarion.Aberror;
import clarion.Errorblock;
import clarion.Errorentry;
import clarion.Errorhistorylist;
import clarion.Errorloginterface;
import clarion.Histhandlerclass;
import clarion.Msgboxclass;
import clarion.Pnq;
import clarion.Standarderrorlogclass;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Icon;
import clarion.equates.Level;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Errorclass extends org.jclarion.clarion.AbstractThreaded
{
	public ClarionString defaultCategory;
	public RefVariable<Errorentry> errors;
	public RefVariable<Errorloginterface> errorLog;
	public ClarionString fieldName;
	public ClarionString filename;
	public ClarionString keyName;
	public RefVariable<Errorhistorylist> history;
	public ClarionString messageText;
	public RefVariable<Pnq> procNames;
	public ClarionString saveError;
	public ClarionNumber saveErrorCode;
	public ClarionString saveFileError;
	public ClarionString saveFileErrorCode;
	public ClarionNumber silent;
	public RefVariable<Standarderrorlogclass> stdErrorLog;
	public ClarionNumber logErrors;
	public ClarionNumber historyThreshold;
	public ClarionNumber historyViewLevel;
	public ClarionNumber historyResetOnView;
	public Errorclass()
	{
		defaultCategory=Clarion.newString().setEncoding(ClarionString.ASTRING);
		errors=new RefVariable<Errorentry>(null);
		errorLog=new RefVariable<Errorloginterface>(null);
		fieldName=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
		filename=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
		keyName=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
		history=new RefVariable<Errorhistorylist>(null);
		messageText=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
		procNames=new RefVariable<Pnq>(null);
		saveError=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		saveErrorCode=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		saveFileError=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		saveFileErrorCode=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		silent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		stdErrorLog=new RefVariable<Standarderrorlogclass>(null);
		logErrors=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		historyThreshold=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		historyViewLevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		historyResetOnView=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		construct();
	}
	public void initThread() {
		super.initThread();
		defaultCategory.setThread();
		errors.setThread();
		errorLog.setThread();
		fieldName.setThread();
		filename.setThread();
		keyName.setThread();
		history.setThread();
		messageText.setThread();
		procNames.setThread();
		saveError.setThread();
		saveErrorCode.setThread();
		saveFileError.setThread();
		saveFileErrorCode.setThread();
		silent.setThread();
		stdErrorLog.setThread();
		logErrors.setThread();
		historyThreshold.setThread();
		historyViewLevel.setThread();
		historyResetOnView.setThread();
		CRun.addInitThreadHook(new Runnable() { public void run() { construct(); } });
	}
	protected void lock(Errorclass base,Thread thread)
	{
		super.lock(base,thread);
		this.defaultCategory=(ClarionString)this.defaultCategory.getLockedObject(thread);
		this.errors=(RefVariable<Errorentry>)this.errors.getLockedObject(thread);
		this.errorLog=(RefVariable<Errorloginterface>)this.errorLog.getLockedObject(thread);
		this.fieldName=(ClarionString)this.fieldName.getLockedObject(thread);
		this.filename=(ClarionString)this.filename.getLockedObject(thread);
		this.keyName=(ClarionString)this.keyName.getLockedObject(thread);
		this.history=(RefVariable<Errorhistorylist>)this.history.getLockedObject(thread);
		this.messageText=(ClarionString)this.messageText.getLockedObject(thread);
		this.procNames=(RefVariable<Pnq>)this.procNames.getLockedObject(thread);
		this.saveError=(ClarionString)this.saveError.getLockedObject(thread);
		this.saveErrorCode=(ClarionNumber)this.saveErrorCode.getLockedObject(thread);
		this.saveFileError=(ClarionString)this.saveFileError.getLockedObject(thread);
		this.saveFileErrorCode=(ClarionString)this.saveFileErrorCode.getLockedObject(thread);
		this.silent=(ClarionNumber)this.silent.getLockedObject(thread);
		this.stdErrorLog=(RefVariable<Standarderrorlogclass>)this.stdErrorLog.getLockedObject(thread);
		this.logErrors=(ClarionNumber)this.logErrors.getLockedObject(thread);
		this.historyThreshold=(ClarionNumber)this.historyThreshold.getLockedObject(thread);
		this.historyViewLevel=(ClarionNumber)this.historyViewLevel.getLockedObject(thread);
		this.historyResetOnView=(ClarionNumber)this.historyResetOnView.getLockedObject(thread);
	}
	public Object getLockedObject(Thread thread)
	{
		Errorclass result=new Errorclass();
		result.lock(this,thread);
		return result;
	}

	public void construct()
	{
		this.saveErrorCode.setValue(Constants.NOERROR);
		this.saveError.setValue("");
		this.saveFileErrorCode.setValue(Constants.NOERROR);
		this.saveFileError.setValue("");
		this.stdErrorLog.set(null);
		this.init();
	}
	public void destruct()
	{
		this.kill();
	}
	public void addErrors(Errorblock errsIn)
	{
		ClarionNumber follow=Clarion.newNumber(3).setEncoding(ClarionNumber.USHORT);
		ClarionNumber sLen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString errs=null;
		errs=(ClarionString)CMemory.castTo(errsIn,ClarionString.class);
		for (int loop_1=errsIn.number.intValue();loop_1>0;loop_1--) {
			this.errors.get().id.setValue(errs.stringAt(follow).val()+256*errs.stringAt(follow.add(1)).val());
			follow.increment(2);
			this.errors.get().fatality.setValue(errs.stringAt(follow).val());
			follow.increment(1);
			sLen.setValue(errs.stringAt(follow).val());
			follow.increment(1);
			this.errors.get().title.set(errs.stringAt(follow,follow.add(sLen).subtract(1)));
			follow.increment(sLen);
			sLen.setValue(errs.stringAt(follow).val());
			follow.increment(1);
			this.errors.get().message.set(errs.stringAt(follow,follow.add(sLen).subtract(1)));
			follow.increment(sLen);
			this.errors.get().category.setValue("");
			this.errors.get().add();
		}
	}
	public void addHistory()
	{
		this.history.get().add();
	}
	public ClarionString getCategory()
	{
		return getCategory(Clarion.newNumber(-1));
	}
	public ClarionString getCategory(ClarionNumber id)
	{
		ClarionString rVal=Clarion.newString().setEncoding(ClarionString.ASTRING);
		if (id.equals(-1)) {
			rVal.setValue(this.defaultCategory);
		}
		else {
			rVal.setValue(Aberror.setId(this,id.like(),Clarion.newNumber(this.errors.get().records())).equals(Level.BENIGN) && !this.errors.get().category.equals("") ? this.errors.get().category : this.defaultCategory);
		}
		return rVal.like();
	}
	public ClarionString getError()
	{
		return getError(Clarion.newNumber(Constants.ERRCLARION));
	}
	public ClarionString getError(ClarionNumber errType)
	{
		{
			ClarionNumber case_1=errType;
			boolean case_1_break=false;
			if (case_1.equals(Constants.ERRCLARION)) {
				return this.saveError.like();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.ERRFILE)) {
				return this.saveFileError.like();
				// UNREACHABLE! :case_1_break=true;
			}
		}
		return Clarion.newString("");
	}
	public ClarionNumber getErrorcode()
	{
		return getErrorcode(Clarion.newNumber(Constants.ERRCLARION));
	}
	public ClarionNumber getErrorcode(ClarionNumber errType)
	{
		{
			ClarionNumber case_1=errType;
			boolean case_1_break=false;
			if (case_1.equals(Constants.ERRCLARION)) {
				return this.saveErrorCode.like();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.ERRFILE)) {
				return this.saveFileErrorCode.getNumber();
				// UNREACHABLE! :case_1_break=true;
			}
		}
		return Clarion.newNumber(Constants.NOERROR);
	}
	public ClarionString getProcedureName()
	{
		if (!(this.procNames.get().records()!=0)) {
			return Clarion.newString("");
		}
		this.procNames.get().get(this.procNames.get().records());
		while (!this.procNames.get().thread.equals(CRun.getThreadID())) {
			if (CError.errorCode()!=0) {
				return Clarion.newString("");
			}
			this.procNames.get().get(this.procNames.get().getPointer()-1);
		}
		return this.procNames.get().name.like();
	}
	public ClarionNumber historyMsg(ClarionString caption,ClarionNumber icon,ClarionNumber buttons,ClarionNumber defaultButton)
	{
		Msgboxclass msgBox=new Msgboxclass();
		Histhandlerclass hist=new Histhandlerclass();
		msgBox.init(Aberror.window,this,caption.like(),icon.like(),buttons.like(),defaultButton.like());
		hist.init(Aberror.window,this,this.history.get());
		msgBox.historyHandler=hist.windowcomponent();
		msgBox.run();
		return msgBox.msgRVal.like();
	}
	public void init()
	{
		if (this.stdErrorLog.get()==null) {
			this.stdErrorLog.set(new Standarderrorlogclass());
			this.setCategory(Clarion.newNumber(-1),Clarion.newString("ABC"));
			this.errors.set(null);
			this.procNames.set(null);
			this.history.set(null);
			this.historyThreshold.setValue(0);
			this.historyViewLevel.setValue(Level.FATAL);
			this.historyResetOnView.setValue(Constants.FALSE);
			this.setErrorLog(this.stdErrorLog.get().errorloginterface());
		}
	}
	public void kill()
	{
		//this.errors.get();
		this.errors.set(null);
		//this.history.get();
		this.history.set(null);
		//this.procNames.get();
		this.procNames.set(null);
		this.stdErrorLog.get().destruct();
		this.stdErrorLog.set(null);
	}
	public ClarionNumber message(ClarionNumber id,ClarionNumber buttons,ClarionNumber _default)
	{
		if (this.silent.boolValue()) {
			return _default.like();
		}
		this.setId(id.like());
		return this.messageBox(Clarion.newNumber(Level.BENIGN),this.subsString(),this.errors.get().title.get().like(),Clarion.newString(Icon.QUESTION),buttons.like(),_default.like(),Clarion.newNumber(0));
	}
	public ClarionNumber msg(ClarionString p0,ClarionString p1,ClarionString p2,ClarionNumber p3,ClarionNumber p4)
	{
		return msg(p0,p1,p2,p3,p4,Clarion.newNumber(0));
	}
	public ClarionNumber msg(ClarionString p0,ClarionString p1,ClarionString p2,ClarionNumber p3)
	{
		return msg(p0,p1,p2,p3,Clarion.newNumber(0));
	}
	public ClarionNumber msg(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		return msg(p0,p1,p2,Clarion.newNumber(Button.OK));
	}
	public ClarionNumber msg(ClarionString p0,ClarionString p1)
	{
		return msg(p0,p1,(ClarionString)null);
	}
	public ClarionNumber msg(ClarionString p0)
	{
		return msg(p0,(ClarionString)null);
	}
	public ClarionNumber msg(ClarionString txt,ClarionString caption,ClarionString icon,ClarionNumber buttons,ClarionNumber defaultButton,ClarionNumber style)
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		rVal.setValue(defaultButton);
		if (this.logErrors.boolValue()) {
			CRun._assert(this.errorLog.get().open().equals(Level.BENIGN),ClarionString.staticConcat("Unable to Open error log; ",CError.error()));
			CRun._assert(this.errorLog.get().take(Clarion.newString(Clarion.newString(String.valueOf(CDate.today())).format("@D17").concat("@",Clarion.newString(String.valueOf(CDate.clock())).format("@T8")," --> ",txt))).equals(Level.BENIGN),ClarionString.staticConcat("Unable to update error log; ",CError.error()));
			CRun._assert(this.errorLog.get().close().equals(Level.BENIGN),ClarionString.staticConcat("Unable to close error log; ",CError.error()));
		}
		if (this.historyThreshold.boolValue()) {
			if (this.historyThreshold.compareTo(0)>0) {
				while (Clarion.newNumber(this.history.get().records()).compareTo(this.historyThreshold)>=0) {
					this.history.get().get(1);
					this.history.get().delete();
				}
			}
			this.history.get().txt.setValue(txt);
			this.history.get().id.setValue(this.errors.get().id);
			this.history.get().category.setValue(this.getCategory(this.errors.get().id.like()));
			this.addHistory();
		}
		if (!this.silent.boolValue()) {
			if (this.historyThreshold.boolValue()) {
				if (this.errors.get().fatality.equals(this.historyViewLevel)) {
					rVal.setValue(this.historyMsg(caption.like(),icon.getNumber(),buttons.like(),defaultButton.like()));
					if (this.historyResetOnView.boolValue()) {
						this.resetHistory();
					}
				}
			}
			else {
				rVal.setValue(this.messageBox(this.errors.get().fatality.like(),txt.like(),caption.like(),icon.like(),buttons.like(),defaultButton.like(),style.like()));
			}
		}
		return rVal.like();
	}
	public ClarionNumber messageBox(ClarionNumber p0,ClarionString p1,ClarionString p2,ClarionNumber p4,ClarionNumber p5,ClarionNumber p6)
	{
		return messageBox(p0,p1,p2,(ClarionString)null,p4,p5,p6);
	}
	public ClarionNumber messageBox(ClarionNumber p0,ClarionString p1,ClarionNumber p4,ClarionNumber p5,ClarionNumber p6)
	{
		return messageBox(p0,p1,(ClarionString)null,p4,p5,p6);
	}
	public ClarionNumber messageBox(ClarionString p1,ClarionNumber p4,ClarionNumber p5,ClarionNumber p6)
	{
		return messageBox(Clarion.newNumber(Level.BENIGN),p1,p4,p5,p6);
	}
	public ClarionNumber messageBox(ClarionNumber level,ClarionString txt,ClarionString caption,ClarionString icon,ClarionNumber buttons,ClarionNumber defaultButton,ClarionNumber style)
	{
		return Clarion.newNumber(CWin.message(txt,caption,icon.toString(),buttons.intValue(),defaultButton.intValue(),style.intValue()));
	}
	public void removeErrors(Errorblock errsIn)
	{
		ClarionString errs=null;
		ClarionNumber p=Clarion.newNumber(3).setEncoding(ClarionNumber.USHORT);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		errs=(ClarionString)CMemory.castTo(errsIn,ClarionString.class);
		for (int loop_1=errsIn.number.intValue();loop_1>0;loop_1--) {
			l.setValue(errs.stringAt(p).val()+256*errs.stringAt(p.add(1)).val());
			p.increment(3);
			p.increment(errs.stringAt(p).val()+1);
			p.increment(errs.stringAt(p).val()+1);
			this.setId(l.like());
			this.errors.get().delete();
		}
	}
	public void resetHistory()
	{
		this.history.get().free();
	}
	public void setCategory(ClarionString p1)
	{
		setCategory(Clarion.newNumber(-1),p1);
	}
	public void setCategory(ClarionNumber id,ClarionString category)
	{
		if (id.equals(-1)) {
			this.defaultCategory.setValue(category);
		}
		else {
			this.setId(id.like());
			this.errors.get().category.setValue(category);
			this.errors.get().put();
		}
	}
	public void setErrorLog(Errorloginterface errLog)
	{
		this.errorLog.set(errLog);
		if (this.errors.get()==null) {
			this.errors.set(new Errorentry());
		}
		this.addErrors((Errorblock)Aberror.defaultErrors.castTo(Errorblock.class));
		if (this.procNames.get()==null) {
			this.procNames.set(new Pnq());
		}
		if (this.history.get()==null) {
			this.history.set(new Errorhistorylist());
		}
	}
	public void setErrors()
	{
		this.saveErrorCode.setValue(CError.errorCode());
		this.saveError.setValue(Clarion.newString(CError.error()).clip());
		this.saveFileErrorCode.setValue(Clarion.newString(CError.fileErrorCode()).clip());
		this.saveFileError.setValue(Clarion.newString(CError.fileError()).clip());
	}
	public void setFatality(ClarionNumber id,ClarionNumber level)
	{
		this.setId(id.like());
		this.errors.get().fatality.setValue(level);
		this.errors.get().put();
	}
	public void setField(ClarionString name)
	{
		this.fieldName.setValue(name.clip());
	}
	public void setFile(ClarionString name)
	{
		this.filename.setValue(name.clip());
	}
	public void setKey(ClarionString name)
	{
		this.keyName.setValue(name.clip());
	}
	public void setId(ClarionNumber id)
	{
		CRun._assert(!Aberror.setId(this,id.like(),Clarion.newNumber(this.errors.get().records())).boolValue(),"Identifier not found.");
	}
	public void setProcedureName()
	{
		setProcedureName((ClarionString)null);
	}
	public void setProcedureName(ClarionString s)
	{
		if (s==null) {
			if (this.getProcedureName().boolValue()) {
				this.procNames.get().delete();
			}
		}
		else {
			this.procNames.get().name.setValue(s.clip());
			this.procNames.get().thread.setValue(CRun.getThreadID());
			this.procNames.get().add();
		}
	}
	public ClarionString subsString()
	{
		ClarionString buildString=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionNumber errorPos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		buildString.setValue(this.errors.get().message.get());
		Aberror.replace(Clarion.newString("%File"),this.filename.like(),buildString);
		Aberror.replace(Clarion.newString("%Key"),this.keyName.like(),buildString);
		Aberror.replace(Clarion.newString("%ErrorCode"),this.saveErrorCode.getString(),buildString);
		if (this.saveErrorCode.equals(90) || this.saveErrorCode.equals(100)) {
			Aberror.replace(Clarion.newString("%ErrorText"),Clarion.newString(this.saveFileError.concat(" (",this.saveFileErrorCode,")")),buildString);
		}
		else {
			Aberror.replace(Clarion.newString("%ErrorText"),Clarion.newString(this.saveError.concat(" (",this.saveErrorCode,")")),buildString);
		}
		Aberror.replace(Clarion.newString("%Error"),this.saveError.like(),buildString);
		Aberror.replace(Clarion.newString("%FileErrorCode"),this.saveFileErrorCode.like(),buildString);
		Aberror.replace(Clarion.newString("%FileError"),this.saveFileError.like(),buildString);
		Aberror.replace(Clarion.newString("%Message"),this.messageText.like(),buildString);
		Aberror.replace(Clarion.newString("%Field"),this.fieldName.like(),buildString);
		Aberror.replace(Clarion.newString("%Procedure"),this.getProcedureName(),buildString);
		Aberror.replace(Clarion.newString("%Category"),this.errors.get().category.like(),buildString);
		if (buildString.inString("%Previous",1,1)!=0) {
			errorPos.setValue(this.errors.get().getPointer());
			if (Aberror.setId(this,this.errors.get().id.like(),errorPos.subtract(1).getNumber()).boolValue()) {
				Aberror.replace(Clarion.newString("%Previous"),Clarion.newString(""),buildString);
			}
			else {
				Aberror.replace(Clarion.newString("%Previous"),this.errors.get().message.get().like(),buildString);
			}
			this.errors.get().get(errorPos);
		}
		return buildString.like();
	}
	public ClarionNumber takeBenign()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeError(ClarionNumber id)
	{
		this.setId(id.like());
		{
			ClarionNumber case_1=this.errors.get().fatality;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Level.BENIGN)) {
				return this.takeBenign();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.USER)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Level.CANCEL)) {
				return this.takeUser();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.PROGRAM)) {
				return this.takeProgram();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.FATAL)) {
				return this.takeFatal();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.NOTIFY)) {
				this.takeNotify();
				return Clarion.newNumber(Level.NOTIFY);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return this.takeOther();
			}
		}
		return Clarion.newNumber();
	}
	public ClarionNumber takeFatal()
	{
		this.msg(Clarion.newString(this.subsString().concat("  Press OK to end this application")),this.errors.get().title.get().like(),Clarion.newString(Icon.EXCLAMATION),Clarion.newNumber(Button.OK),Clarion.newNumber(Button.OK),Clarion.newNumber(0));
		CRun.halt(0,this.errors.get().title.get().toString());
		return Clarion.newNumber(Level.FATAL);
	}
	public void takeNotify()
	{
		this.msg(this.subsString(),this.errors.get().title.get().like(),Clarion.newString(Icon.EXCLAMATION),Clarion.newNumber(Button.OK),Clarion.newNumber(Button.OK),Clarion.newNumber(0));
	}
	public ClarionNumber takeOther()
	{
		return this.takeProgram();
	}
	public ClarionNumber takeProgram()
	{
		return this.takeFatal();
	}
	public ClarionNumber takeUser()
	{
		if (this.msg(this.subsString(),this.errors.get().title.get().like(),Clarion.newString(Icon.QUESTION),Clarion.newNumber(Button.YES+Button.NO),Clarion.newNumber(Button.YES),Clarion.newNumber(0)).equals(Button.YES)) {
			return Clarion.newNumber(Level.BENIGN);
		}
		else {
			return Clarion.newNumber(Level.CANCEL);
		}
	}
	public ClarionNumber _throw(ClarionNumber id)
	{
		this.setErrors();
		return this.takeError(id.like());
	}
	public ClarionNumber throwFile(ClarionNumber id,ClarionString file)
	{
		this.setFile(file.like());
		return this._throw(id.like());
	}
	public ClarionNumber throwMessage(ClarionNumber id,ClarionString message)
	{
		this.messageText.setValue(message);
		return this._throw(id.like());
	}
	public void viewHistory()
	{
		this.historyMsg(Clarion.newString("Errors History"),Clarion.newNumber(0),Clarion.newNumber(Button.OK+Button.HELP),Clarion.newNumber(Button.OK));
	}
}
