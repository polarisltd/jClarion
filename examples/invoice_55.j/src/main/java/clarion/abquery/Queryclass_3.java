package clarion.abquery;

import clarion.Sectorqueue;
import clarion.aberror.Errorclass;
import clarion.abpopup.Popupclass;
import clarion.abquery.Abquery;
import clarion.abquery.Fieldqueue;
import clarion.abquery.Popupqueue;
import clarion.abquery.Queryvisual_4;
import clarion.abquery.W;
import clarion.abquery.equates.Mconstants;
import clarion.abquery.equates.Mfeq;
import clarion.abquery.equates.Mquery;
import clarion.abutil.Iniclass;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Queryclass_3
{
	public Errorclass errors=null;
	public Fieldqueue fields=null;
	public ClarionString family=null;
	public Iniclass inimgr=null;
	public Popupqueue popuplist=null;
	public ClarionNumber qksupport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString qkicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionString qkmenuicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionNumber qksubmenupos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString qkcurrentquery=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionWindow parentwindow=null;
	public ClarionWindow window=null;
	public Queryvisual_3 win=null; // Queryvisual_4 -> Queryvisual_3
	public Queryclass_3()
	{
		errors=null;
		fields=null;
		family=null;
		inimgr=null;
		popuplist=null;
		qksupport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		qkicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		qkmenuicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		qksubmenupos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		qkcurrentquery=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		parentwindow=null;
		window=null;
		win=null;
	}

	public void additem(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		additem(p0,p1,p2,Clarion.newNumber(1));
	}
	public void additem(ClarionString p0,ClarionString p1)
	{
		additem(p0,p1,(ClarionString)null);
	}
	public void additem(ClarionString fieldname,ClarionString title,ClarionString picture,ClarionNumber forceeditpicture)
	{
		CRun._assert(!(this.fields==null));
		this.fields.clear();
		this.fields.title.setValue(title);
		this.fields.name.setValue(fieldname.upper());
		this.fields.picture.setValue(picture.clip());
		if (this.fields.picture.stringAt(1).equals("@")) {
			this.fields.picture.setValue(this.fields.picture.stringAt(2,this.fields.picture.len()));
		}
		if (this.fields.picture.stringAt(1).equals("s")) {
			this.fields.picture.setStringAt(1,"S");
		}
		if (!this.fields.picture.boolValue()) {
			this.fields.picture.setValue("S255");
		}
		this.fields.forceeditpicture.setValue(forceeditpicture);
		this.fields.add();
	}
	public ClarionNumber ask()
	{
		return ask(Clarion.newNumber(1));
	}
	public ClarionNumber ask(ClarionNumber uselast)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString ev=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		W w=new W();
		try {
			if (this.win==null) {
				this.reset();
				final int loop_1=this.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
					this.fields.get(i);
					ev.setValue(CExpression.evaluate(this.fields.name.toString()).clip());
					if (ev.boolValue()) {
						this.setlimit(this.fields.name.like(),null,null,ev.like());
					}
				}
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				if (this.qkcurrentquery.boolValue()) {
					return Clarion.newNumber(1);
				}
				else {
					this.parentwindow=(ClarionWindow)CMemory.resolveAddress(ClarionSystem.getInstance().getProperty(Prop.TARGET).intValue());
					w.open();
					this.window=w;
					w.setProperty(Prop.WALLPAPER,ClarionString.staticConcat("~",this.parentwindow.getProperty(Prop.WALLPAPER)));
					w.setProperty(Prop.TILED,this.parentwindow.getProperty(Prop.TILED));
					w.setProperty(Prop.FONT,this.parentwindow.getProperty(Prop.FONT));
					final int loop_2=Mfeq.LASTCONTROL;for (i.setValue(Mfeq.FIRSTCONTROL);i.compareTo(loop_2)<=0;i.increment(1)) {
						Clarion.getControl(i).setProperty(Prop.FONTNAME,this.parentwindow.getProperty(Prop.FONTNAME));
					}
					if (!uselast.boolValue()) {
						this.reset();
					}
					return (this.win.run().equals(Constants.REQUESTCANCELLED) ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.NOTIFY)).getNumber();
				}
			}
		} finally {
			w.close();
		}
	}
	public void findname(ClarionString fieldname)
	{
		this.fields.name.setValue(fieldname);
		this.fields.get(this.fields.ORDER().ascend(this.fields.name));
		CRun._assert(!(CError.errorCode()!=0));
	}
	public ClarionString getname(ClarionString title)
	{
		this.fields.title.setValue(title);
		this.fields.get(this.fields.ORDER().ascend(this.fields.title));
		CRun._assert(!(CError.errorCode()!=0));
		return this.fields.name.like();
	}
	public ClarionString getfilter()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString filter=Clarion.newString(5000).setEncoding(ClarionString.CSTRING);
		ClarionString sy=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionString value=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionString picture=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionNumber caseless=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber high=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		final int loop_1=this.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.fields.get(i);
			while (true) {
				picture.setValue(this.fields.picture);
				high.setValue(this.getlimit(value,sy,caseless,high.like(),picture));
				if (value.boolValue() || sy.boolValue()) {
					getfilter_pictureandcase(sy,picture,caseless,value);
					getfilter_caseless(caseless,value,filter);
					{
						ClarionString case_1=sy;
						boolean case_1_break=false;
						if (case_1.equals(Mquery.CONTAINS)) {
							filter.setValue(filter.concat("INSTRING(",this.quote(value.like()),",",this.fields.name.clip(),",1,1) <> 0"));
							case_1_break=true;
						}
						if (!case_1_break && case_1.equals(Mquery.BEGINS)) {
							filter.setValue(filter.concat("SUB(",this.fields.name.clip(),",1,",value.len(),") = ",this.quote(value.like())));
							case_1_break=true;
						}
						if (!case_1_break) {
							filter.setValue(filter.concat("(",this.fields.name.clip()," ",Abquery.makeoperator(sy.like(),Clarion.newString(""))," ",picture.equals("") || !picture.stringAt(1).equals("S") ? value : this.quote(value.like()),")"));
						}
					}
				}
				if (!high.boolValue()) break;
			}
		}
		return filter.like();
	}
	public void getfilter_pictureandcase(ClarionString sy,ClarionString picture,ClarionNumber caseless,ClarionString value)
	{
		if ((sy.equals(Mquery.CONTAINS) || sy.equals(Mquery.BEGINS)) && picture.boolValue() && !picture.stringAt(1).equals("S")) {
			this.fields.name.setValue(ClarionString.staticConcat("FORMAT(",this.fields.name,",@",picture,")"));
			caseless.setValue(Constants.TRUE);
		}
		if (sy.equals("<>") && !value.boolValue() && !picture.stringAt(1).equals("S")) {
			value.setValue(0);
		}
	}
	public void getfilter_caseless(ClarionNumber caseless,ClarionString value,ClarionString filter)
	{
		if (caseless.boolValue()) {
			value.setValue(value.upper());
			if (value.stringAt(1).equals("^")) {
				value.setValue(value.stringAt(2,value.len()));
			}
			if (!(this.fields.name.inString("UPPER(",1,1)!=0)) {
				this.fields.name.setValue(ClarionString.staticConcat("UPPER(",this.fields.name,")"));
			}
		}
		if (filter.boolValue()) {
			filter.setValue(filter.concat(" AND "));
		}
	}
	public ClarionNumber getlimit(ClarionString p0,ClarionString p1,ClarionNumber p2)
	{
		return getlimit(p0,p1,p2,Clarion.newNumber(0));
	}
	public ClarionNumber getlimit(ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionNumber high)
	{
		ClarionString dummy=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.fields.forceeditpicture.setValue(Constants.FALSE);
		this.fields.put();
		rval.setValue(this.getlimit(value,operator,caseless,high.like(),dummy));
		return rval.like();
	}
	public void getlimit(ClarionString fieldname,ClarionString value,ClarionString operator,ClarionNumber caseless)
	{
		this.findname(fieldname.like());
		this.fields.forceeditpicture.setValue(Constants.FALSE);
		this.fields.put();
		this.getlimit(value,operator,caseless);
	}
	public void getlimit(ClarionString fieldname,ClarionString low,ClarionString high,ClarionString eq)
	{
		this.findname(fieldname.like());
		low.setValue(this.fields.low.get()==null ? Clarion.newString("") : this.fields.low.get());
		high.setValue(this.fields.high.get()==null ? Clarion.newString("") : this.fields.high.get());
		eq.setValue(this.fields.middle.get()==null ? Clarion.newString("") : this.fields.middle.get());
	}
	public ClarionNumber getlimit(ClarionString p0,ClarionString p1,ClarionNumber p2,ClarionString p4)
	{
		return getlimit(p0,p1,p2,Clarion.newNumber(0),p4);
	}
	public ClarionNumber getlimit(ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionNumber high,ClarionString picture)
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber iss=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		caseless.setValue(0);
		operator.setValue("");
		iss.setValue(this.fields.picture.stringAt(1).equals("S") ? Clarion.newNumber(1) : Clarion.newNumber(0));
		if (!(this.fields.low.get()==null) && !high.boolValue()) {
			if (!(this.fields.high.get()==null)) {
				rval.setValue(Level.NOTIFY);
			}
			operator.setValue(">");
			value.setValue(this.fields.low.get());
			getlimit_parsebound(operator,value,caseless,iss,picture);
			getlimit_makeunformatted(picture,value,caseless);
			return rval.like();
		}
		if (!(this.fields.high.get()==null)) {
			CRun._assert(high.boolValue() || this.fields.low.get()==null);
			operator.setValue("<");
			value.setValue(this.fields.high.get());
			getlimit_parsebound(operator,value,caseless,iss,picture);
			getlimit_makeunformatted(picture,value,caseless);
			return rval.like();
		}
		value.setValue(this.fields.middle.get()==null ? Clarion.newString("") : this.fields.middle.get());
		getlimit_parsebound(operator,value,caseless,iss,picture);
		if (value.stringAt(1).equals("*")) {
			operator.setValue(Mquery.CONTAINS);
			value.setValue(value.stringAt(2,value.len()));
		}
		else if (value.stringAt(value.len()).equals("*")) {
			operator.setValue(Mquery.BEGINS);
			value.setValue(value.stringAt(1,value.len()-1));
		}
		if (value.stringAt(1).equals("^")) {
			caseless.setValue(1);
			value.setValue(value.stringAt(2,value.len()).upper());
		}
		if (picture.boolValue()) {
			if (!this.fields.forceeditpicture.boolValue() && !(operator.equals(Mquery.CONTAINS) || operator.equals(Mquery.BEGINS))) {
				getlimit_makeunformatted(picture,value,caseless);
			}
		}
		return rval.like();
	}
	public void getlimit_makeunformatted(ClarionString picture,ClarionString value,ClarionNumber caseless)
	{
		if (!picture.boolValue()) {
			return;
		}
		if (picture.stringAt(1).equals("S")) {
			return;
		}
		value.setValue(value.equals("") ? Clarion.newString("") : value.deformat(picture.toString()));
		caseless.setValue(Constants.FALSE);
		picture.clear();
	}
	public void getlimit_parsebound(ClarionString operator,ClarionString value,ClarionNumber caseless,ClarionNumber iss,ClarionString picture)
	{
		if (!(this.fields.middle.get()==null)) {
			operator.setValue(operator.concat("="));
		}
		Abquery.makeoperator(operator.like(),value.like(),operator,value);
		if (value.stringAt(1).equals("^")) {
			caseless.setValue(1);
			value.setValue(value.stringAt(2,value.len()).upper());
		}
		if (this.fields.name.inString("UPPER(",1,1)!=0) {
			caseless.setValue(1);
			value.setValue(value.upper());
		}
		if (this.fields.forceeditpicture.boolValue() && !iss.boolValue()) {
			caseless.setValue(Constants.FALSE);
		}
		if (this.fields.forceeditpicture.boolValue() && !iss.boolValue()) {
			picture.clear();
		}
	}
	public void getlimit(ClarionString fieldname,ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionString picture)
	{
		this.findname(fieldname.like());
		this.getlimit(value,operator,caseless,picture);
	}
	public void init()
	{
		init((Queryvisual_3)null);  // %%%%% Queryvisual_4 -> Queryvisual_3
	}
	public void init(Queryvisual_3 q) // %%%%% Queryvisual_4 -> Queryvisual_3
	{
		this.fields=new Fieldqueue();
		if (!(q==null)) {
			this.win=q;
		}
	}
	public void init(Queryvisual_3 q,Iniclass inimgr,ClarionString family,Errorclass e) // Queryvisual_4 -> Queryvisual_3 %%%%%%
	{
		this.win=q;
		this.fields=new Fieldqueue();
		this.inimgr=inimgr;
		this.win.errors=e;
		this.errors=e;
		this.family=Clarion.newString(family.clip().len());
		this.family.setValue(family);
		this.popuplist=new Popupqueue();
	}
	public void kill()
	{
		//this.fields;
		//this.family;
		//this.popuplist;
	}
	public ClarionString quote(ClarionString value)
	{
		ClarionString rv=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber rvp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		rv.setStringAt(1,"'");
		rvp.setValue(2);
		final int loop_2=value.len();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
			for (int loop_1=1+(value.stringAt(i).equals("'") ? 1 : 0);loop_1>0;loop_1--) {
				rv.setStringAt(rvp,value.stringAt(i));
				rvp.increment(1);
			}
		}
		rv.setStringAt(rvp,rvp.add(1),"'\u0000");
		return rv.like();
	}
	public void reset()
	{
		reset((ClarionString)null);
	}
	public void reset(ClarionString fieldname)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (fieldname==null) {
			final int loop_1=this.fields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.fields.get(i);
				this.reset(this.fields.name.like());
			}
		}
		else {
			this.setlimit(fieldname.like(),Clarion.newString(""),Clarion.newString(""),Clarion.newString(""));
		}
	}
	public void setlimit(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		setlimit(p0,p1,p2,(ClarionString)null);
	}
	public void setlimit(ClarionString p0,ClarionString p1)
	{
		setlimit(p0,p1,(ClarionString)null);
	}
	public void setlimit(ClarionString p0)
	{
		setlimit(p0,(ClarionString)null);
	}
	public void setlimit(ClarionString fieldname,ClarionString low,ClarionString high,ClarionString eq)
	{
		ClarionNumber isvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		isvalue.setValue(3);
		this.findname(fieldname.like());
		if (low==null || low.equals("")) {
			this.fields.low.set(null);
			isvalue.decrement(1);
		}
		else {
			this.fields.querystring.setValue(low);
			this.fields.low.set(this.fields.querystring);
		}
		if (high==null || high.equals("")) {
			this.fields.high.set(null);
			isvalue.decrement(1);
		}
		else {
			this.fields.querystring.setValue(high);
			this.fields.high.set(this.fields.querystring);
		}
		if (eq==null || eq.equals("")) {
			this.fields.middle.set(null);
			isvalue.decrement(1);
		}
		else {
			this.fields.querystring.setValue(eq);
			this.fields.middle.set(this.fields.querystring);
		}
		if (!isvalue.boolValue()) {
			this.fields.querystring.clear();
		}
		this.fields.put();
	}
	public void setquickpopup(Popupclass popup,ClarionNumber querycontrol)
	{
		Sectorqueue qq=null;
		ClarionNumber sm=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString pid=Clarion.newString(100);
		ClarionNumber sbmenu=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		qq=new Sectorqueue();
		if (this.popuplist.records()!=0) {
			sm.setValue(1);
			while (!!(this.popuplist.records()!=0)) {
				this.popuplist.get(sm);
				popup.deleteitem(this.popuplist.popupid.like());
				this.popuplist.delete();
			}
			sbmenu.setValue(Constants.TRUE);
		}
		else {
			sbmenu.setValue(Constants.FALSE);
		}
		this.popuplist.free();
		this.getqueries(qq);
		qq.sort(qq.ORDER().ascend(qq.item));
		if (qq.records()!=0) {
			pid.setValue(Mconstants.DEFAULTQKQUERYNAME);
			if (!sbmenu.boolValue()) {
				if (popup.getitems().boolValue()) {
					popup.additem(Clarion.newString("-"),Clarion.newString("Separator1"),popup.getitems().getString(),Clarion.newNumber(1));
				}
				popup.addsubmenu(Clarion.newString(Mconstants.DEFAULTQKQUERYNAME),Clarion.newString(""),Clarion.newString(""));
				pid.setValue(Mconstants.DEFAULTQKQUERYNAME);
				popup.seticon(pid.like(),this.qkmenuicon.like());
				sbmenu.setValue(Constants.TRUE);
			}
		}
		else {
			if (sbmenu.boolValue()) {
				pid.setValue(popup.additem(Clarion.newString("Empty       "),Clarion.newString("tsQBEEmpty"),Clarion.newString(Mconstants.DEFAULTQKQUERYNAME),Clarion.newNumber(2)));
				popup.setitemenable(pid.like(),Clarion.newNumber(Constants.FALSE));
				this.popuplist.popupid.setValue(pid);
				this.popuplist.queryname.setValue(pid);
				this.popuplist.add();
			}
		}
		final int loop_1=qq.records();for (sm.setValue(1);sm.compareTo(loop_1)<=0;sm.increment(1)) {
			qq.get(sm);
			pid.setValue(popup.additem(Clarion.newString(qq.item.clip().concat("  ")),qq.item.clip(),pid.like(),Clarion.newNumber(2)));
			popup.seticon(pid.like(),this.qkicon.like());
			popup.additemevent(pid.like(),Clarion.newNumber(Event.NEWSELECTION),querycontrol.like());
			this.popuplist.popupid.setValue(pid);
			this.popuplist.queryname.setValue(qq.item);
			this.popuplist.add();
		}
		if (sbmenu.boolValue()) {
			pid.setValue(popup.additem(Clarion.newString("-"),Clarion.newString("ClearSeparator  "),pid.like(),Clarion.newNumber(2)));
			this.popuplist.popupid.setValue(pid);
			this.popuplist.queryname.setValue(pid);
			this.popuplist.add();
			pid.setValue(popup.additem(Clarion.newString(Mconstants.DEFAULTCLEARNAME),Clarion.newString("tsQBEClear"),pid.like(),Clarion.newNumber(2)));
			popup.seticon(pid.like(),this.qkicon.like());
			popup.additemevent(pid.like(),Clarion.newNumber(Event.NEWSELECTION),querycontrol.like());
			this.popuplist.popupid.setValue(pid);
			this.popuplist.queryname.setValue("tsQBEClear");
			this.popuplist.add();
		}
		//qq;
		return;
	}
	public void save(ClarionString queryname)
	{
		this.inimgr.addsector(this.inimgr.getsector(this.family.like(),queryname.like(),Clarion.newString("Query")));
		this.inimgr.update(Clarion.newString("Query"),this.inimgr.getsector(this.family.like(),queryname.like(),Clarion.newString("Query")),this.fields,this.fields.name,this.fields.querystring);
	}
	public ClarionNumber take(Popupclass p)
	{
		CRun._assert(!(p==null));
		if (this.qksupport.boolValue()) {
			this.qkcurrentquery.setValue(p.getlastselection());
			this.popuplist.popupid.setValue(this.qkcurrentquery);
			this.popuplist.get(this.popuplist.ORDER().ascend(this.popuplist.popupid));
			if (CError.errorCode()!=0) {
				this.clearquery();
			}
			else {
				this.restore(this.popuplist.queryname.like());
			}
			this.save(Clarion.newString("tsMRU"));
			return Clarion.newNumber(1);
		}
		return Clarion.newNumber(0);
	}
	public void restore(ClarionString queryname)
	{
		Fieldqueue restorefields=null;
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		restorefields=new Fieldqueue();
		this.clearquery();
		restorefields.free();
		this.inimgr.fetchqueue(Clarion.newString("Query"),this.inimgr.getsector(this.family.like(),queryname.like(),Clarion.newString("Query")),restorefields,restorefields.name,restorefields.querystring);
		if (!(restorefields.records()!=0)) {
			this.clearquery();
		}
		else {
			final int loop_1=restorefields.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				restorefields.get(i);
				this.fields.name.setValue(restorefields.name.upper());
				this.fields.get(this.fields.ORDER().ascend(this.fields.name));
				if (CError.errorCode()!=0 && !restorefields.name.stringAt(1,6).equals("UPPER(")) {
					this.fields.name.setValue(ClarionString.staticConcat("UPPER(",this.fields.name,")"));
					this.fields.get(this.fields.ORDER().ascend(this.fields.name));
				}
				if (CError.errorCode()!=0 && restorefields.name.stringAt(1,6).equals("UPPER(")) {
					this.fields.name.setValue(this.fields.name.stringAt(7,this.fields.name.len()-1));
					this.fields.get(this.fields.ORDER().ascend(this.fields.name));
					if (!(CError.errorCode()!=0)) {
						if (restorefields.querystring.boolValue() && (this.fields.picture.stringAt(1).upper().equals("S") || !this.fields.picture.boolValue()) && !restorefields.querystring.stringAt(1).equals("^") && !restorefields.querystring.stringAt(2).equals("^")) {
							restorefields.querystring.setValue(ClarionString.staticConcat("^",restorefields.querystring));
						}
					}
				}
				if (CError.errorCode()!=0) {
					this.errors.setfield(restorefields.name.like());
					this.errors._throw(Clarion.newNumber(Msg.QBECOLUMNNOTSUPPORTED));
				}
				else {
					this.fields.querystring.setValue(restorefields.querystring);
					this.fields.middle.set(this.fields.querystring);
					this.fields.put();
				}
			}
			restorefields.free();
		}
		//restorefields;
	}
	public void delete(ClarionString queryname)
	{
		this.inimgr.deletesector(this.inimgr.getsector(this.family.like(),queryname.like(),Clarion.newString("Query")));
	}
	public void getqueries(Sectorqueue qq)
	{
		if (this.inimgr==null) {
			return;
		}
		qq.free();
		this.inimgr.getsectors(this.family.like(),null,Clarion.newString("Query"),qq);
		qq.sort(qq.ORDER().ascend(qq.item));
		qq.item.setValue("tsMRU");
		qq.get(qq.ORDER().ascend(qq.item));
		if (!(CError.error().length()!=0)) {
			qq.delete();
		}
	}
	public void clearquery()
	{
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		final int loop_1=this.fields.records();for (j.setValue(1);j.compareTo(loop_1)<=0;j.increment(1)) {
			this.fields.get(j);
			this.fields.querystring.clear();
			this.fields.low.set(null);
			this.fields.middle.set(null);
			this.fields.high.set(null);
			this.fields.put();
		}
	}
}
