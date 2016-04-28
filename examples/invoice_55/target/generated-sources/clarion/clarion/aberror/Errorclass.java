package clarion.aberror;

import clarion.Errorblock;
import clarion.Errorentry;
import clarion.Errorhistorylist;
import clarion.Errorloginterface;
import clarion.aberror.Aberror;
import clarion.aberror.Histhandlerclass;
import clarion.aberror.Msgboxclass;
import clarion.aberror.Pnq;
import clarion.aberror.Standarderrorlogclass;
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

@SuppressWarnings("all")
public class Errorclass
{
	public ClarionString defaultcategory=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public Errorentry errors=null;
	public Errorloginterface errorlog=null;
	public ClarionString fieldname=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
	public ClarionString filename=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
	public Errorhistorylist history=null;
	public ClarionString messagetext=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
	public Pnq procnames=null;
	public ClarionString saveerror=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionNumber saveerrorcode=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString savefileerror=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionString savefileerrorcode=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionNumber silent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Standarderrorlogclass stderrorlog=null;
	public ClarionNumber logerrors=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber historythreshold=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber historyviewlevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber historyresetonview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Errorclass()
	{
		defaultcategory=Clarion.newString().setEncoding(ClarionString.ASTRING);
		errors=null;
		errorlog=null;
		fieldname=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
		filename=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
		history=null;
		messagetext=Clarion.newString(Constants.MESSAGEMAXLEN).setEncoding(ClarionString.CSTRING);
		procnames=null;
		saveerror=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		saveerrorcode=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		savefileerror=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		savefileerrorcode=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		silent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		stderrorlog=null;
		logerrors=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		historythreshold=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		historyviewlevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		historyresetonview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void adderrors(Errorblock errsin)
	{
		ClarionNumber follow=Clarion.newNumber(3).setEncoding(ClarionNumber.USHORT);
		ClarionNumber slen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString errs=null;
		errs=(ClarionString)CMemory.castTo(errsin,ClarionString.class);
		for (int loop_1=errsin.number.intValue();loop_1>0;loop_1--) {
			this.errors.id.setValue(errs.stringAt(follow).val()+256*errs.stringAt(follow.add(1)).val());
			follow.increment(2);
			this.errors.fatality.setValue(errs.stringAt(follow).val());
			follow.increment(1);
			slen.setValue(errs.stringAt(follow).val());
			follow.increment(1);
			this.errors.title.set(errs.stringAt(follow,follow.add(slen).subtract(1)));
			follow.increment(slen);
			slen.setValue(errs.stringAt(follow).val());
			follow.increment(1);
			this.errors.message.set(errs.stringAt(follow,follow.add(slen).subtract(1)));
			follow.increment(slen);
			this.errors.category.setValue("");
			this.errors.add();
		}
	}
	public void addhistory()
	{
		this.history.add();
	}
	public ClarionString getcategory()
	{
		return getcategory(Clarion.newNumber(-1));
	}
	public ClarionString getcategory(ClarionNumber id)
	{
		ClarionString rval=Clarion.newString().setEncoding(ClarionString.ASTRING);
		if (id.equals(-1)) {
			rval.setValue(this.defaultcategory);
		}
		else {
			rval.setValue(Aberror.setid(this,id.like(),Clarion.newNumber(this.errors.records())).equals(Level.BENIGN) && !this.errors.category.equals("") ? this.errors.category : this.defaultcategory);
		}
		return rval.like();
	}
	public ClarionString getprocedurename()
	{
		if (!(this.procnames.records()!=0)) {
			return Clarion.newString("");
		}
		this.procnames.get(this.procnames.records());
		while (!this.procnames.thread.equals(CRun.getThreadID())) {
			if (CError.errorCode()!=0) {
				return Clarion.newString("");
			}
			this.procnames.get(this.procnames.getPointer()-1);
		}
		return this.procnames.name.like();
	}
	public ClarionNumber historymsg(ClarionString caption,ClarionNumber icon,ClarionNumber buttons,ClarionNumber defaultbutton)
	{
		Msgboxclass msgbox=new Msgboxclass();
		Histhandlerclass hist=new Histhandlerclass();
		msgbox.init(Aberror.window,this,caption.like(),icon.like(),buttons.like(),defaultbutton.like());
		hist.init(Aberror.window,this,this.history);
		msgbox.historyhandler=hist.windowcomponent();
		msgbox.run();
		return msgbox.msgrval.like();
	}
	public void init()
	{
		this.stderrorlog=new Standarderrorlogclass();
		this.setcategory(Clarion.newNumber(-1),Clarion.newString("ABC"));
		this.historythreshold.setValue(0);
		this.historyviewlevel.setValue(Level.FATAL);
		this.historyresetonview.setValue(Constants.FALSE);
		this.init(this.stderrorlog.errorloginterface());
	}
	public void init(Errorloginterface errlog)
	{
		this.errorlog=errlog;
		this.errors=new Errorentry();
		this.adderrors((Errorblock)Aberror.defaulterrors.castTo(Errorblock.class));
		this.procnames=new Pnq();
		if (this.history==null) {
			this.history=new Errorhistorylist();
		}
	}
	public void kill()
	{
		//this.errors;
		//this.history;
		//this.procnames;
		this.stderrorlog.destruct();
	}
	public ClarionNumber message(ClarionNumber id,ClarionNumber buttons,ClarionNumber _default)
	{
		if (this.silent.boolValue()) {
			return _default.like();
		}
		this.setid(id.like());
		return this.messagebox(Clarion.newNumber(Level.BENIGN),this.subsstring(),this.errors.title.get().like(),Clarion.newString(Icon.QUESTION),buttons.like(),_default.like(),Clarion.newNumber(0));
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
	public ClarionNumber msg(ClarionString txt,ClarionString caption,ClarionString icon,ClarionNumber buttons,ClarionNumber defaultbutton,ClarionNumber style)
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		rval.setValue(defaultbutton);
		if (this.logerrors.boolValue()) {
			CRun._assert(this.errorlog.open().equals(Level.BENIGN),ClarionString.staticConcat("Unable to Open error log; ",CError.error()));
			CRun._assert(this.errorlog.take(Clarion.newString(Clarion.newString(String.valueOf(CDate.today())).format("@D17").concat("@",Clarion.newString(String.valueOf(CDate.clock())).format("@T8")," --> ",txt))).equals(Level.BENIGN),ClarionString.staticConcat("Unable to update error log; ",CError.error()));
			CRun._assert(this.errorlog.close().equals(Level.BENIGN),ClarionString.staticConcat("Unable to close error log; ",CError.error()));
		}
		if (this.historythreshold.boolValue()) {
			if (this.historythreshold.compareTo(0)>0) {
				while (Clarion.newNumber(this.history.records()).compareTo(this.historythreshold)>=0) {
					this.history.get(1);
					this.history.delete();
				}
			}
			this.history.txt.setValue(txt);
			this.history.id.setValue(this.errors.id);
			this.history.category.setValue(this.getcategory(this.errors.id.like()));
			this.addhistory();
		}
		if (!this.silent.boolValue()) {
			if (this.historythreshold.boolValue()) {
				if (this.errors.fatality.equals(this.historyviewlevel)) {
					rval.setValue(this.historymsg(caption.like(),icon.getNumber(),buttons.like(),defaultbutton.like()));
					if (this.historyresetonview.boolValue()) {
						this.resethistory();
					}
				}
			}
			else {
				rval.setValue(this.messagebox(this.errors.fatality.like(),txt.like(),caption.like(),icon.like(),buttons.like(),defaultbutton.like(),style.like()));
			}
		}
		return rval.like();
	}
	public ClarionNumber messagebox(ClarionNumber p0,ClarionString p1,ClarionString p2,ClarionNumber p4,ClarionNumber p5,ClarionNumber p6)
	{
		return messagebox(p0,p1,p2,(ClarionString)null,p4,p5,p6);
	}
	public ClarionNumber messagebox(ClarionNumber p0,ClarionString p1,ClarionNumber p4,ClarionNumber p5,ClarionNumber p6)
	{
		return messagebox(p0,p1,(ClarionString)null,p4,p5,p6);
	}
	public ClarionNumber messagebox(ClarionString p1,ClarionNumber p4,ClarionNumber p5,ClarionNumber p6)
	{
		return messagebox(Clarion.newNumber(Level.BENIGN),p1,p4,p5,p6);
	}
	public ClarionNumber messagebox(ClarionNumber level,ClarionString txt,ClarionString caption,ClarionString icon,ClarionNumber buttons,ClarionNumber defaultbutton,ClarionNumber style)
	{
		return Clarion.newNumber(CWin.message(txt,caption,icon.toString(),buttons.intValue(),defaultbutton.intValue(),style.intValue()));
	}
	public void removeerrors(Errorblock errsin)
	{
		ClarionString errs=null;
		ClarionNumber p=Clarion.newNumber(3).setEncoding(ClarionNumber.USHORT);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		errs=(ClarionString)CMemory.castTo(errsin,ClarionString.class);
		for (int loop_1=errsin.number.intValue();loop_1>0;loop_1--) {
			l.setValue(errs.stringAt(p).val()+256*errs.stringAt(p.add(1)).val());
			p.increment(3);
			p.increment(errs.stringAt(p).val()+1);
			p.increment(errs.stringAt(p).val()+1);
			this.setid(l.like());
			this.errors.delete();
		}
	}
	public void resethistory()
	{
		this.history.free();
	}
	public void setcategory(ClarionString p1)
	{
		setcategory(Clarion.newNumber(-1),p1);
	}
	public void setcategory(ClarionNumber id,ClarionString category)
	{
		if (id.equals(-1)) {
			this.defaultcategory.setValue(category);
		}
		else {
			this.setid(id.like());
			this.errors.category.setValue(category);
			this.errors.put();
		}
	}
	public void seterrors()
	{
		this.saveerrorcode.setValue(CError.errorCode());
		this.saveerror.setValue(Clarion.newString(CError.error()).clip());
		this.savefileerrorcode.setValue(Clarion.newString(CError.fileErrorCode()).clip());
		this.savefileerror.setValue(Clarion.newString(CError.fileError()).clip());
	}
	public void setfatality(ClarionNumber id,ClarionNumber level)
	{
		this.setid(id.like());
		this.errors.fatality.setValue(level);
		this.errors.put();
	}
	public void setfield(ClarionString name)
	{
		this.fieldname.setValue(name.clip());
	}
	public void setfile(ClarionString name)
	{
		this.filename.setValue(name.clip());
	}
	public void setid(ClarionNumber id)
	{
		CRun._assert(!Aberror.setid(this,id.like(),Clarion.newNumber(this.errors.records())).boolValue(),"Identifier not found.");
	}
	public void setprocedurename()
	{
		setprocedurename((ClarionString)null);
	}
	public void setprocedurename(ClarionString s)
	{
		if (s==null) {
			if (this.getprocedurename().boolValue()) {
				this.procnames.delete();
			}
		}
		else {
			this.procnames.name.setValue(s.clip());
			this.procnames.thread.setValue(CRun.getThreadID());
			this.procnames.add();
		}
	}
	public ClarionString subsstring()
	{
		ClarionString buildstring=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionNumber errorpos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		buildstring.setValue(this.errors.message.get());
		Aberror.replace(Clarion.newString("%File"),this.filename.like(),buildstring);
		Aberror.replace(Clarion.newString("%ErrorCode"),this.saveerrorcode.getString(),buildstring);
		if (this.saveerrorcode.equals(90)) {
			Aberror.replace(Clarion.newString("%ErrorText"),Clarion.newString(this.savefileerror.concat(" (",this.savefileerrorcode,")")),buildstring);
		}
		else {
			Aberror.replace(Clarion.newString("%ErrorText"),Clarion.newString(this.saveerror.concat(" (",this.saveerrorcode,")")),buildstring);
		}
		Aberror.replace(Clarion.newString("%Error"),this.saveerror.like(),buildstring);
		Aberror.replace(Clarion.newString("%FileErrorCode"),this.savefileerrorcode.like(),buildstring);
		Aberror.replace(Clarion.newString("%FileError"),this.savefileerror.like(),buildstring);
		Aberror.replace(Clarion.newString("%Message"),this.messagetext.like(),buildstring);
		Aberror.replace(Clarion.newString("%Field"),this.fieldname.like(),buildstring);
		Aberror.replace(Clarion.newString("%Procedure"),this.getprocedurename(),buildstring);
		Aberror.replace(Clarion.newString("%Category"),this.errors.category.like(),buildstring);
		if (buildstring.inString("%Previous",1,1)!=0) {
			errorpos.setValue(this.errors.getPointer());
			if (Aberror.setid(this,this.errors.id.like(),errorpos.subtract(1).getNumber()).boolValue()) {
				Aberror.replace(Clarion.newString("%Previous"),Clarion.newString(""),buildstring);
			}
			else {
				Aberror.replace(Clarion.newString("%Previous"),this.errors.message.get().like(),buildstring);
			}
			this.errors.get(errorpos);
		}
		return buildstring.like();
	}
	public ClarionNumber takebenign()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeerror(ClarionNumber id)
	{
		this.setid(id.like());
		{
			ClarionNumber case_1=this.errors.fatality;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Level.BENIGN)) {
				return this.takebenign();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.USER)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Level.CANCEL)) {
				return this.takeuser();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.PROGRAM)) {
				return this.takeprogram();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.FATAL)) {
				return this.takefatal();
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Level.NOTIFY)) {
				this.takenotify();
				return Clarion.newNumber(Level.NOTIFY);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return this.takeother();
			}
		}
		return Clarion.newNumber();
	}
	public ClarionNumber takefatal()
	{
		this.msg(Clarion.newString(this.subsstring().concat("  Press OK to end this application")),this.errors.title.get().like(),Clarion.newString(Icon.EXCLAMATION),Clarion.newNumber(Button.OK),Clarion.newNumber(Button.OK),Clarion.newNumber(0));
		CRun.halt(0,this.errors.title.get().toString());
		return Clarion.newNumber(Level.FATAL);
	}
	public void takenotify()
	{
		this.msg(this.subsstring(),this.errors.title.get().like(),Clarion.newString(Icon.EXCLAMATION),Clarion.newNumber(Button.OK),Clarion.newNumber(Button.OK),Clarion.newNumber(0));
	}
	public ClarionNumber takeother()
	{
		return this.takeprogram();
	}
	public ClarionNumber takeprogram()
	{
		return this.takefatal();
	}
	public ClarionNumber takeuser()
	{
		if (this.msg(this.subsstring(),this.errors.title.get().like(),Clarion.newString(Icon.QUESTION),Clarion.newNumber(Button.YES+Button.NO),Clarion.newNumber(Button.YES),Clarion.newNumber(0)).equals(Button.YES)) {
			return Clarion.newNumber(Level.BENIGN);
		}
		else {
			return Clarion.newNumber(Level.CANCEL);
		}
	}
	public ClarionNumber _throw(ClarionNumber id)
	{
		this.seterrors();
		return this.takeerror(id.like());
	}
	public ClarionNumber throwfile(ClarionNumber id,ClarionString file)
	{
		this.setfile(file.like());
		return this._throw(id.like());
	}
	public ClarionNumber throwmessage(ClarionNumber id,ClarionString message)
	{
		this.messagetext.setValue(message);
		return this._throw(id.like());
	}
	public void viewhistory()
	{
		this.historymsg(Clarion.newString("Errors History"),Clarion.newNumber(0),Clarion.newNumber(Button.OK+Button.HELP),Clarion.newNumber(Button.OK));
	}
}
