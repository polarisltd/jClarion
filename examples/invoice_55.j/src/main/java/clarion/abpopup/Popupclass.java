package clarion.abpopup;

import clarion.abpopup.Abpopup;
import clarion.abpopup.Popupitemqueue;
import clarion.abpopup.W;
import clarion.abpopup.equates.Mstate;
import clarion.abutil.Iniclass;
import clarion.abutil.Translatorclass;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Popupclass
{
	public ClarionNumber clearkeycode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString lastselection=Clarion.newString(Constants.MAXMENUITEMLEN).setEncoding(ClarionString.CSTRING);
	public Popupitemqueue popupitems=null;
	public Translatorclass translator=null;
	public Iniclass inimgr=null;
	public ClarionNumber intoolbox=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber mythread=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionWindow parentwindow=null;
	public ClarionWindow thiswindow=null;
	public Popupclass()
	{
		clearkeycode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lastselection=Clarion.newString(Constants.MAXMENUITEMLEN).setEncoding(ClarionString.CSTRING);
		popupitems=null;
		translator=null;
		inimgr=null;
		intoolbox=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		mythread=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		parentwindow=null;
		thiswindow=null;
	}

	public ClarionString additem(ClarionString menutext)
	{
		return this.additem(menutext.like(),Abpopup.getuniquename(this,(menutext.equals("-") ? Clarion.newString("Separator") : menutext).getString()));
	}
	public ClarionString additem(ClarionString menutext,ClarionString itemname)
	{
		return this.additem(menutext.like(),itemname.like(),Clarion.newString(""),Clarion.newNumber(0));
	}
	public ClarionString additem(ClarionString menutext,ClarionString name,ClarionString nametofollow,ClarionNumber level)
	{
		return this.setitem(this.locatename(nametofollow.like()),level.like(),name.like(),menutext.like());
	}
	public ClarionString additemevent(ClarionString p0,ClarionNumber p1)
	{
		return additemevent(p0,p1,Clarion.newNumber(0));
	}
	public ClarionString additemevent(ClarionString name,ClarionNumber eventno,ClarionNumber controlid)
	{
		ClarionString rval=Clarion.newString(Constants.MAXMENUITEMLEN);
		rval.setValue(this.locatename(name.like()).equals(0) ? this.additem(name.like()) : name);
		this.popupitems.mimicmode.setValue(Constants.FALSE);
		this.popupitems.controlid.setValue(controlid);
		this.popupitems.event.setValue(eventno);
		this.popupitems.ontoolbox.setValue(Constants.TRUE);
		this.popupitems.put();
		CRun._assert(!(CError.errorCode()!=0));
		return rval.like();
	}
	public ClarionString additemmimic(ClarionString p0,ClarionNumber p1)
	{
		return additemmimic(p0,p1,(ClarionString)null);
	}
	public ClarionString additemmimic(ClarionString name,ClarionNumber buttonid,ClarionString txt)
	{
		ClarionString rval=Clarion.newString(Constants.MAXMENUITEMLEN);
		rval.setValue(this.additemevent(name.like(),Clarion.newNumber(Event.ACCEPTED),buttonid.like()));
		this.popupitems.text.setValue(txt);
		this.popupitems.mimicmode.setValue(Constants.TRUE);
		this.popupitems.ontoolbox.setValue(Constants.TRUE);
		this.popupitems.put();
		CRun._assert(!(CError.errorCode()!=0));
		return rval.like();
	}
	public void addmenu(ClarionString p0)
	{
		addmenu(p0,Clarion.newNumber(0));
	}
	public void addmenu(ClarionString mtext,ClarionNumber atposition)
	{
		ClarionNumber cdepth=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		ClarionString citem=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		CRun._assert(mtext.boolValue());
		if (atposition.boolValue()) {
			atposition.decrement(1);
			this.popupitems.get(atposition);
			cdepth.setValue(CError.errorCode()==0 ? this.popupitems.depth : Clarion.newNumber(1));
		}
		else {
			this.popupitems.free();
		}
		final int loop_1=mtext.len();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			{
				ClarionString case_1=mtext.stringAt(i);
				boolean case_1_break=false;
				if (case_1.equals("|")) {
					addmenu_additem(citem,atposition,cdepth);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals("{")) {
					addmenu_additem(citem,atposition,cdepth);
					cdepth.increment(1);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals("}")) {
					addmenu_additem(citem,atposition,cdepth);
					cdepth.decrement(1);
					CRun._assert(cdepth.compareTo(0)>0);
					case_1_break=true;
				}
				if (!case_1_break) {
					citem.setValue(citem.concat(mtext.stringAt(i)));
					if (i.equals(mtext.len())) {
						addmenu_additem(citem,atposition,cdepth);
					}
				}
			}
		}
	}
	public void addmenu_additem(ClarionString citem,ClarionNumber atposition,ClarionNumber cdepth)
	{
		if (citem.boolValue()) {
			this.setitem(atposition.like(),cdepth.like(),citem.like(),citem.like());
			atposition.increment(1);
			citem.clear();
		}
	}
	public void addsubmenu(ClarionString mtext,ClarionString nametofollow)
	{
		this.addmenu(mtext.like(),this.locatename(nametofollow.like()).add(1).getNumber());
	}
	public void addsubmenu(ClarionString menuheading,ClarionString menutext,ClarionString nametofollow)
	{
		this.addsubmenu(Clarion.newString(menuheading.clip().concat("{",menutext.clip(),"}")),nametofollow.like());
	}
	public ClarionString ask(ClarionNumber p0)
	{
		return ask(p0,Clarion.newNumber(0));
	}
	public ClarionString ask()
	{
		return ask(Clarion.newNumber(0));
	}
	public ClarionString ask(ClarionNumber xpos,ClarionNumber ypos)
	{
		this.lastselection.setValue(this.getname(this.executepopup(this.getmenutext(),xpos.like(),ypos.like())));
		if (this.lastselection.boolValue() && this.locatename(this.lastselection.like()).boolValue()) {
			if (this.popupitems.event.boolValue() || this.popupitems.mimicmode.boolValue()) {
				if (this.clearkeycode.boolValue()) {
					CWin.setKeyCode(0);
				}
				CWin.post((this.popupitems.mimicmode.equals(1) ? Clarion.newNumber(Event.ACCEPTED) : this.popupitems.event).intValue(),this.popupitems.controlid.intValue(),this.mythread.intValue());
			}
		}
		return this.lastselection.like();
	}
	public void asktoolbox(ClarionString n)
	{
		W w=new W();
		ClarionNumber xp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yd=Clarion.newNumber(0).setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber nv=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		try {
			w.open(this.parentwindow);
			w.setClonedProperty(Prop.TEXT,n);
			this.thiswindow=w;
			final int loop_1=this.popupitems.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
				this.popupitems.get(c);
				if (!this.popupitems.ontoolbox.boolValue()) {
					continue;
				}
				nv.increment(1);
				CWin.setTarget(this.parentwindow);
				this.checkmimics();
				CWin.setTarget(w);
				CWin.createControl(nv.intValue(),Create.BUTTON,null,null);
				if (this.popupitems.icon.boolValue()) {
					Clarion.getControl(nv).setProperty(Prop.ICON,ClarionString.staticConcat("~",this.popupitems.icon));
					Clarion.getControl(nv).setClonedProperty(Prop.TOOLTIP,this.popupitems.text);
				}
				else {
					Clarion.getControl(nv).setClonedProperty(Prop.TEXT,this.popupitems.text);
				}
				CWin.setPosition(nv.intValue(),xp.intValue(),yp.intValue(),null,null);
				xp.increment(Clarion.getControl(nv).getProperty(Prop.WIDTH));
				if (Clarion.getControl(nv).getProperty(Prop.HEIGHT).compareTo(yd)>0) {
					yd.setValue(Clarion.getControl(nv).getProperty(Prop.HEIGHT));
				}
			}
			CWin.unhide(1,nv.intValue());
			w.setClonedProperty(Prop.WIDTH,xp);
			w.setProperty(Prop.HEIGHT,yp.add(yd));
			while (this.ask().boolValue()) {
			}
		} finally {
			w.close();
		}
	}
	public void checkmimics()
	{
		if (this.popupitems.mimicmode.boolValue()) {
			if (Clarion.getControl(this.popupitems.controlid).getProperty(Prop.TEXT).boolValue() && (this.popupitems.text.stringAt(1).equals("!") || !this.popupitems.text.boolValue())) {
				this.popupitems.text.setValue(Clarion.getControl(this.popupitems.controlid).getProperty(Prop.TEXT));
			}
			if (this.popupitems.text.stringAt(1).equals("!")) {
				this.popupitems.text.setValue(this.popupitems.text.stringAt(2,this.popupitems.text.len()));
			}
			if (!this.popupitems.disabled.boolValue()) {
				this.popupitems.disabled.setValue(Clarion.getControl(this.popupitems.controlid).getProperty(Prop.DISABLE).intValue()==1 ?Mstate.ON:Mstate.OFF);
			}
			if (!this.popupitems.icon.boolValue()) {
				this.popupitems.icon.setValue(Clarion.getControl(this.popupitems.controlid).getProperty(Prop.ICON));
			}
		}
	}
	public void deleteitem(ClarionString name)
	{
		if (this.locatename(name.like()).boolValue()) {
			this.popupitems.delete();
		}
	}
	public ClarionNumber executepopup(ClarionString menutext,ClarionNumber xpos,ClarionNumber ypos)
	{
		if (this.intoolbox.boolValue()) {
			while (Clarion.getWindowTarget().accept()) {
				if (CWin.accepted()!=0) {
					return Clarion.newNumber(CWin.accepted());
				}
				if (CWin.event()==Event.TIMER) {
					this.resettoolbox();
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			this.intoolbox.setValue(0);
			return Clarion.newNumber(0);
		}
		else {
			if (xpos.boolValue() && ypos.boolValue()) {
				return Clarion.newNumber(CWin.popup(menutext.toString(),xpos.intValue(),ypos.intValue()));
			}
			else if (xpos.boolValue()) {
				return Clarion.newNumber(CWin.popup(menutext.toString(),xpos.intValue(),null));
			}
			else if (ypos.boolValue()) {
				return Clarion.newNumber(CWin.popup(menutext.toString(),null,ypos.intValue()));
			}
			else {
				return Clarion.newNumber(CWin.popup(menutext.toString()));
			}
		}
	}
	public ClarionNumber getitemchecked(ClarionString name)
	{
		if (this.locatename(name.like()).boolValue()) {
			return Clarion.newNumber(this.popupitems.check.equals(Mstate.ON) ? 1 : 0);
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionNumber getitemenabled(ClarionString name)
	{
		if (this.locatename(name.like()).boolValue()) {
			return Clarion.newNumber(this.popupitems.disabled.equals(Mstate.OFF) ? 1 : 0);
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionNumber getitems()
	{
		return Clarion.newNumber(this.popupitems.records());
	}
	public ClarionString getlastselection()
	{
		return this.lastselection.like();
	}
	public ClarionString getmenutext()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString menutext=Clarion.newString(Constants.MAXMENUSTRLEN).setEncoding(ClarionString.CSTRING);
		ClarionNumber olddepth=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		ClarionNumber newstyle=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		final int loop_1=this.popupitems.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
			this.popupitems.get(c);
			this.checkmimics();
			if (this.popupitems.icon.boolValue()) {
				newstyle.setValue(1);
				break;
			}
		}
		final int loop_2=this.popupitems.records();for (c.setValue(1);c.compareTo(loop_2)<=0;c.increment(1)) {
			this.popupitems.get(c);
			if (this.popupitems.depth.equals(olddepth)) {
				menutext.setValue(menutext.concat("|"));
			}
			else if (this.popupitems.depth.compareTo(olddepth)>0) {
				menutext.setValue(menutext.concat("{"));
			}
			else {
				menutext.setValue(menutext.concat("}"));
			}
			olddepth.setValue(this.popupitems.depth);
			this.checkmimics();
			if (this.popupitems.disabled.equals(Mstate.ON)) {
				menutext.setValue(menutext.concat("~"));
			}
			if (!this.popupitems.check.equals(Mstate.NONE)) {
				menutext.setValue(menutext.concat(this.popupitems.check.equals(Mstate.ON) ? Clarion.newString("+") : Clarion.newString("-")));
			}
			getmenutext_extendeditems(newstyle,menutext);
			if (!(this.translator==null)) {
				this.popupitems.text.setValue(this.translator.translatestring(this.popupitems.text.like()));
			}
			menutext.setValue(menutext.concat(this.popupitems.text));
		}
		return menutext.like();
	}
	public void getmenutext_extendeditems(ClarionNumber newstyle,ClarionString menutext)
	{
		if (newstyle.boolValue() && !this.popupitems.text.equals("-")) {
			menutext.setValue(menutext.concat("["));
			if (this.popupitems.icon.boolValue()) {
				menutext.setValue(menutext.concat(Prop.ICON,"(~",this.popupitems.icon,")"));
			}
			menutext.setValue(menutext.concat("]"));
		}
	}
	public ClarionString getname(ClarionNumber positional)
	{
		ClarionString rval=Clarion.newString(Constants.MAXMENUITEMLEN).setEncoding(ClarionString.CSTRING);
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber pd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber poscnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (positional.boolValue()) {
			final int loop_1=this.popupitems.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
				this.popupitems.get(c);
				if (!this.popupitems.text.equals("-")) {
					if (c.compareTo(this.popupitems.records())<0) {
						this.popupitems.get(c.add(1));
						pd.setValue(this.popupitems.depth);
						this.popupitems.get(c);
						if (pd.compareTo(this.popupitems.depth)>0) {
							continue;
						}
					}
					poscnt.increment(1);
					if (poscnt.equals(positional)) {
						rval.setValue(this.popupitems.name);
						break;
					}
				}
			}
		}
		return rval.like();
	}
	public void init()
	{
		this.popupitems=new Popupitemqueue();
		this.clearkeycode.setValue(1);
		this.mythread.setValue(CRun.getThreadID());
	}
	public void init(Iniclass inimgr)
	{
		this.inimgr=inimgr;
		this.init();
	}
	public void kill()
	{
		//this.popupitems;
	}
	public ClarionNumber locatename(ClarionString name)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		final int loop_1=this.popupitems.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.popupitems.get(i);
			if (this.popupitems.name.equals(name)) {
				return i.like();
			}
		}
		return Clarion.newNumber(0);
	}
	public void restore(ClarionString menudescription)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString itemstr=Clarion.newString("ItemXXX");
		if (!(this.inimgr==null) && menudescription.boolValue()) {
			this.popupitems.free();
			final ClarionString loop_1=this.inimgr.tryfetch(menudescription.like(),Clarion.newString("Items"));for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
				itemstr.setValue(itemstr.stringAt(1,4).concat(c.getString().format("@N03")));
				this.popupitems.name.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(1)));
				this.popupitems.text.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(2)));
				this.popupitems.depth.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(3)));
				this.popupitems.controlid.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(4)));
				this.popupitems.event.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(5)));
				this.popupitems.mimicmode.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(6)));
				this.popupitems.check.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(7)));
				this.popupitems.disabled.setValue(this.inimgr.fetchfield(menudescription.like(),itemstr.like(),Clarion.newNumber(8)));
				this.popupitems.add();
				CRun._assert(!(CError.errorCode()!=0));
			}
		}
	}
	public void resettoolbox()
	{
		ClarionNumber xp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yd=Clarion.newNumber(0).setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber nv=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (this.thiswindow==null) {
			return;
		}
		final int loop_1=this.popupitems.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
			this.popupitems.get(c);
			if (!this.popupitems.ontoolbox.boolValue()) {
				continue;
			}
			nv.increment(1);
			CWin.setTarget(this.parentwindow);
			this.checkmimics();
			CWin.setTarget(this.thiswindow);
			if (!Clarion.getControl(nv).getProperty(Prop.TYPE).boolValue()) {
				CWin.createControl(nv.intValue(),Create.BUTTON,null,null);
			}
			if (this.popupitems.icon.boolValue()) {
				Clarion.getControl(nv).setProperty(Prop.ICON,ClarionString.staticConcat("~",this.popupitems.icon));
				Clarion.getControl(nv).setProperty(Prop.TOOLTIP,Abpopup.removeampersand(this.popupitems.text.like()));
			}
			else {
				Clarion.getControl(nv).setClonedProperty(Prop.TEXT,this.popupitems.text);
			}
			Clarion.getControl(nv).setProperty(Prop.DISABLE,this.popupitems.disabled.equals(Mstate.ON) ? 1 : 0);
			CWin.setPosition(nv.intValue(),xp.intValue(),yp.intValue(),null,null);
			CWin.unhide(nv.intValue());
			xp.increment(Clarion.getControl(nv).getProperty(Prop.WIDTH));
			if (Clarion.getControl(nv).getProperty(Prop.HEIGHT).compareTo(yd)>0) {
				yd.setValue(Clarion.getControl(nv).getProperty(Prop.HEIGHT));
			}
		}
		nv.increment(1);
		while (!!Clarion.getControl(nv).getProperty(Prop.FEQ).boolValue()) {
			CWin.removeControl(nv.intValue());
			nv.increment(1);
		}
		Clarion.getControl(0).setClonedProperty(Prop.WIDTH,xp);
		Clarion.getControl(0).setProperty(Prop.HEIGHT,yp.add(yd));
	}
	public void save(ClarionString menudescription)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString itemstr=Clarion.newString("ItemXXX");
		if (!(this.inimgr==null) && this.popupitems.records()!=0 && menudescription.len()!=0) {
			this.inimgr.update(menudescription.like(),Clarion.newString("Items"),Clarion.newString(String.valueOf(this.popupitems.records())));
			final int loop_1=this.popupitems.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
				this.popupitems.get(c);
				CRun._assert(!(CError.errorCode()!=0));
				itemstr.setValue(itemstr.stringAt(1,4).concat(c.getString().format("@N03")));
				this.inimgr.update(menudescription.like(),itemstr.like(),Clarion.newString(this.popupitems.name.concat(",",this.popupitems.text,",",this.popupitems.depth,",",this.popupitems.controlid,",",this.popupitems.event,",",this.popupitems.mimicmode,",",this.popupitems.check,",",this.popupitems.disabled)));
			}
		}
	}
	public ClarionString setitem(ClarionNumber addafter,ClarionNumber level,ClarionString basename,ClarionString menutext)
	{
		ClarionString newname=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		if (addafter.equals(0)) {
			addafter.setValue(this.popupitems.records());
		}
		if (level.equals(0)) {
			this.popupitems.get(addafter);
			level.setValue(CError.errorCode()==0 ? this.popupitems.depth : Clarion.newNumber(1));
		}
		newname.setValue(Abpopup.getuniquename(this,basename.like()));
		this.popupitems.clear();
		this.popupitems.name.setValue(newname);
		if (!menutext.equals("-")) {
			while (true) {
				{
					int execute_1=Clarion.newString("~+-").inString(menutext.stringAt(1).toString());
					if (execute_1==1) {
						this.popupitems.disabled.setValue(Mstate.ON);
					}
					if (execute_1==2) {
						this.popupitems.check.setValue(Mstate.ON);
					}
					if (execute_1==3) {
						this.popupitems.check.setValue(Mstate.OFF);
					}
					if (execute_1<1 || execute_1>3) {
						break;
					}
				}
				menutext.setValue(menutext.stringAt(2,menutext.len()));
			}
		}
		this.popupitems.text.setValue(menutext);
		this.popupitems.depth.setValue(level);
		this.popupitems.add(addafter.add(1));
		CRun._assert(!(CError.errorCode()!=0));
		return newname.like();
	}
	public void setitemcheck(ClarionString name,ClarionNumber checkstate)
	{
		if (this.locatename(name.like()).boolValue() && !this.popupitems.text.equals("-")) {
			this.popupitems.check.setValue(checkstate.equals(0) ? Clarion.newNumber(Mstate.OFF) : Clarion.newNumber(Mstate.ON));
			this.popupitems.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public void setitemenable(ClarionString name,ClarionNumber enablestate)
	{
		if (this.locatename(name.like()).boolValue() && !this.popupitems.text.equals("-")) {
			this.popupitems.disabled.setValue(enablestate.equals(0) ? Clarion.newNumber(Mstate.ON) : Clarion.newNumber(Mstate.OFF));
			this.popupitems.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public void setlevel(ClarionString name,ClarionNumber lvl)
	{
		if (this.locatename(name.like()).boolValue()) {
			this.popupitems.depth.setValue(lvl);
			this.popupitems.put();
		}
	}
	public void seticon(ClarionString name,ClarionString txt)
	{
		if (this.locatename(name.like()).boolValue()) {
			this.popupitems.icon.setValue(txt);
			this.popupitems.put();
		}
	}
	public void settext(ClarionString name,ClarionString txt)
	{
		if (this.locatename(name.like()).boolValue()) {
			this.popupitems.text.setValue(txt);
			this.popupitems.put();
		}
	}
	public void settoolbox(ClarionString name,ClarionNumber show)
	{
		if (this.locatename(name.like()).boolValue()) {
			this.popupitems.ontoolbox.setValue(show);
			this.popupitems.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public void settranslator(Translatorclass t)
	{
		this.translator=t;
		CRun._assert(!(this.translator==null));
	}
	public void toolbox(ClarionString name)
	{
		this.intoolbox.setValue(1);
		this.parentwindow=(ClarionWindow)CMemory.resolveAddress(ClarionSystem.getInstance().getProperty(Prop.TARGET).intValue());
		{
		final int _f0=CMemory.address(this);
		final ClarionString _f1=name;
		CRun.start(new Runnable() { public void run() { Abpopup.poptoolbox(Clarion.newString(String.valueOf(_f0)),_f1); } } ).getId();
		}
	}
	public void viewmenu()
	{
	}
}
