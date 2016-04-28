package clarion;

import clarion.Abquery;
import clarion.Errorclass;
import clarion.Fieldqueue;
import clarion.Iniclass;
import clarion.Popupclass;
import clarion.Popupqueue;
import clarion.Queryvisual;
import clarion.Sectorqueue;
import clarion.W_1;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Feq;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Query;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;

public class Queryclass
{
	public Errorclass errors;
	public Fieldqueue fields;
	public ClarionString family;
	public Iniclass iNIMgr;
	public Popupqueue popupList;
	public ClarionNumber qkSupport;
	public ClarionString qkIcon;
	public ClarionString qkMenuIcon;
	public ClarionNumber qkSubMenuPos;
	public ClarionString qkCurrentQuery;
	public ClarionWindow parentWindow;
	public ClarionWindow window;
	public Queryvisual win;
	public Queryclass()
	{
		errors=null;
		fields=null;
		family=null;
		iNIMgr=null;
		popupList=null;
		qkSupport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		qkIcon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		qkMenuIcon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		qkSubMenuPos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		qkCurrentQuery=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		parentWindow=null;
		window=null;
		win=null;
	}

	public void addItem(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		addItem(p0,p1,p2,Clarion.newNumber(1));
	}
	public void addItem(ClarionString p0,ClarionString p1)
	{
		addItem(p0,p1,(ClarionString)null);
	}
	public void addItem(ClarionString fieldName,ClarionString title,ClarionString picture,ClarionNumber forceEditPicture)
	{
		CRun._assert(!(this.fields==null));
		this.fields.clear();
		this.fields.title.setValue(title);
		this.fields.name.setValue(fieldName.upper());
		this.fields.picture.setValue(picture.clip());
		if (this.fields.picture.stringAt(1).equals("@")) {
			this.fields.picture.setValue(this.fields.picture.stringAt(2,this.fields.picture.len()));
		}
		if (this.fields.picture.stringAt(1).equals("s")) {
			this.fields.picture.setStringAt(1,"S");
		}
		if (this.fields.picture.stringAt(1).equals("n")) {
			this.fields.picture.setStringAt(1,"N");
		}
		if (!this.fields.picture.boolValue()) {
			this.fields.picture.setValue("S255");
		}
		this.fields.forceEditPicture.setValue(forceEditPicture);
		this.fields.add();
	}
	public ClarionNumber ask()
	{
		return ask(Clarion.newNumber(1));
	}
	public ClarionNumber ask(ClarionNumber useLast)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString ev=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		W_1 w=new W_1();
		try {
			if (this.win==null) {
				this.reset();
				for (i.setValue(1);i.compareTo(this.fields.records())<=0;i.increment(1)) {
					this.fields.get(i);
					ev.setValue(CExpression.evaluate(this.fields.name.toString()).clip());
					if (ev.boolValue()) {
						this.setLimit(this.fields.name.like(),null,null,ev.like());
					}
				}
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				if (this.qkCurrentQuery.boolValue()) {
					return Clarion.newNumber(1);
				}
				else {
					this.parentWindow=(ClarionWindow)CMemory.resolveAddress(ClarionSystem.getInstance().getProperty(Prop.TARGET).intValue());
					w.open();
					this.window=w;
					w.setProperty(Prop.WALLPAPER,ClarionString.staticConcat("~",this.parentWindow.getProperty(Prop.WALLPAPER)));
					w.setProperty(Prop.TILED,this.parentWindow.getProperty(Prop.TILED));
					w.setProperty(Prop.FONT,this.parentWindow.getProperty(Prop.FONT));
					for (i.setValue(Feq.FIRSTCONTROL);i.compareTo(Feq.LASTCONTROL)<=0;i.increment(1)) {
						Clarion.getControl(i).setProperty(Prop.FONTNAME,this.parentWindow.getProperty(Prop.FONTNAME));
					}
					if (!useLast.boolValue()) {
						this.reset();
					}
					return (this.win.run().equals(Constants.REQUESTCANCELLED) ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.NOTIFY)).getNumber();
				}
			}
		} finally {
			w.close();
		}
	}
	public void findName(ClarionString fieldName)
	{
		this.fields.name.setValue(fieldName);
		this.fields.get(this.fields.ORDER().ascend(this.fields.name));
		CRun._assert(!(CError.errorCode()!=0));
	}
	public ClarionString getName(ClarionString title)
	{
		this.fields.title.setValue(title);
		this.fields.get(this.fields.ORDER().ascend(this.fields.title));
		CRun._assert(!(CError.errorCode()!=0));
		return this.fields.name.like();
	}
	public ClarionString getFilter()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString filter=Clarion.newString(5000).setEncoding(ClarionString.CSTRING);
		ClarionString sy=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionString value=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionString picture=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionNumber caseless=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber high=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		for (i.setValue(1);i.compareTo(this.fields.records())<=0;i.increment(1)) {
			this.fields.get(i);
			while (true) {
				picture.setValue(this.fields.picture);
				high.setValue(this.getLimit(value,sy,caseless,high.like(),picture));
				if (value.boolValue() || sy.boolValue()) {
					getFilter_PictureAndCase(sy,picture,caseless,value);
					getFilter_CaseLess(caseless,value);
					{
						ClarionString case_1=sy;
						boolean case_1_break=false;
						if (case_1.equals(Query.CONTAINS)) {
							if (value.boolValue()) {
								getFilter_AppendAnd(filter);
								filter.setValue(filter.concat("INSTRING(",this.quote(value.like()),",",this.fields.name.clip(),",1,1) <> 0"));
							}
							case_1_break=true;
						}
						if (!case_1_break && case_1.equals(Query.BEGINS)) {
							if (value.boolValue()) {
								getFilter_AppendAnd(filter);
								if (picture.stringAt(1).equals("N")) {
									filter.setValue(filter.concat("SUB(LEFT(",this.fields.name.clip(),"),1,",value.len(),") = ",this.quote(value.like())));
								}
								else {
									filter.setValue(filter.concat("SUB(",this.fields.name.clip(),",1,",value.len(),") = ",this.quote(value.like())));
								}
							}
							case_1_break=true;
						}
						if (!case_1_break) {
							getFilter_AppendAnd(filter);
							filter.setValue(filter.concat("(",this.fields.name.clip()," ",Abquery.makeOperator(sy.like(),Clarion.newString(""))," ",picture.equals("") || !picture.stringAt(1).equals("S") ? !picture.stringAt(1).equals("N") && !value.boolValue() ? Clarion.newString("0") : value : this.quote(value.like()),")"));
						}
					}
				}
				if (!high.boolValue()) break;
			}
		}
		return filter.like();
	}
	public void getFilter_PictureAndCase(ClarionString sy,ClarionString picture,ClarionNumber caseless,ClarionString value)
	{
		if ((sy.equals(Query.CONTAINS) || sy.equals(Query.BEGINS)) && picture.boolValue() && !picture.stringAt(1).equals("S")) {
			this.fields.name.setValue(ClarionString.staticConcat("FORMAT(",this.fields.name,",@",picture,")"));
			caseless.setValue(Constants.TRUE);
		}
		if (sy.equals("<>") && !value.boolValue() && !picture.stringAt(1).equals("S")) {
			value.setValue(0);
		}
		if (picture.boolValue() && (picture.stringAt(1).equals("N") || picture.stringAt(1).upper().equals("E") || picture.stringAt(1).upper().equals("T") || picture.stringAt(1).upper().equals("D") && !picture.stringAt(1,2).upper().equals("D4") && !picture.stringAt(1,2).upper().equals("D17") && !picture.stringAt(1,2).upper().equals("D18"))) {
			caseless.setValue(Constants.FALSE);
			value.setValue(value.upper());
		}
	}
	public void getFilter_CaseLess(ClarionNumber caseless,ClarionString value)
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
		else {
			if (this.fields.name.inString("UPPER(",1,1)!=0 && this.fields.name.stringAt(this.fields.name.clip().len()).equals(")")) {
				this.fields.name.setValue(this.fields.name.stringAt(7,this.fields.name.clip().len()-1));
			}
		}
	}
	public void getFilter_AppendAnd(ClarionString filter)
	{
		if (filter.boolValue()) {
			filter.setValue(filter.concat(" AND "));
		}
	}
	public ClarionNumber getLimit(ClarionString p0,ClarionString p1,ClarionNumber p2)
	{
		return getLimit(p0,p1,p2,Clarion.newNumber(0));
	}
	public ClarionNumber getLimit(ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionNumber high)
	{
		ClarionString dummy=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.fields.forceEditPicture.setValue(Constants.FALSE);
		this.fields.put();
		rVal.setValue(this.getLimit(value,operator,caseless,high.like(),dummy));
		return rVal.like();
	}
	public void getLimit(ClarionString fieldName,ClarionString value,ClarionString operator,ClarionNumber caseless)
	{
		this.findName(fieldName.like());
		this.fields.forceEditPicture.setValue(Constants.FALSE);
		this.fields.put();
		this.getLimit(value,operator,caseless);
	}
	public void getLimit(ClarionString fieldName,ClarionString low,ClarionString high,ClarionString eq)
	{
		this.findName(fieldName.like());
		low.setValue(this.fields.low);
		high.setValue(this.fields.high);
		eq.setValue(this.fields.middle);
	}
	public ClarionNumber getLimit(ClarionString p0,ClarionString p1,ClarionNumber p2,ClarionString p4)
	{
		return getLimit(p0,p1,p2,Clarion.newNumber(0),p4);
	}
	public ClarionNumber getLimit(ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionNumber high,ClarionString picture)
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber isS=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber length=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		caseless.setValue(0);
		operator.setValue("");
		length.setValue(value.len());
		isS.setValue(this.fields.picture.stringAt(1).upper().equals("S") ? Clarion.newNumber(1) : Clarion.newNumber(0));
		rVal.setValue(Level.BENIGN);
		if (this.fields.low.boolValue() && !high.boolValue()) {
			if (this.win.type().equals(Constants.QBEFORMBASED)) {
				rVal.setValue(Level.NOTIFY);
				if (this.fields.middle.boolValue()) {
					this.fields.high.setValue("");
					this.fields.low.setValue("");
				}
				else {
					this.fields.middle.setValue(this.fields.low);
					this.fields.high.setValue("");
					this.fields.low.setValue("");
				}
				this.fields.put();
				return rVal.like();
			}
			if (this.fields.high.boolValue()) {
				rVal.setValue(Level.NOTIFY);
			}
			operator.setValue(">");
			value.setValue(this.fields.low);
			length.setValue(value.len());
			getLimit_ParseBound(operator,value,caseless,length,isS,picture);
			getLimit_MakeUnformatted(picture,value,caseless);
			return rVal.like();
		}
		if (this.fields.high.boolValue()) {
			CRun._assert(high.boolValue() || !this.fields.low.boolValue());
			operator.setValue("<");
			value.setValue(this.fields.high);
			length.setValue(value.len());
			getLimit_ParseBound(operator,value,caseless,length,isS,picture);
			getLimit_MakeUnformatted(picture,value,caseless);
			return rVal.like();
		}
		value.setValue(this.fields.middle);
		length.setValue(value.len());
		if (!length.boolValue()) {
			return rVal.like();
		}
		getLimit_ParseBound(operator,value,caseless,length,isS,picture);
		{
			ClarionNumber case_1=this.win.type();
			boolean case_1_break=false;
			if (case_1.equals(Constants.QBEFORMBASED)) {
				if (value.stringAt(1).equals("*")) {
					operator.setValue(Query.CONTAINS);
					value.setValue(length.equals(1) ? Clarion.newString("") : value.stringAt(2,length));
				}
				else if (!length.equals(0) && value.stringAt(length).equals("*")) {
					operator.setValue(Query.BEGINS);
					value.setValue(value.stringAt(1,length.subtract(1)));
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.QBELISTBASED)) {
				if (value.stringAt(1).equals("*")) {
					operator.setValue(Query.CONTAINS);
					value.setValue(value.stringAt(2,length));
				}
				else if (value.stringAt(length).equals("*")) {
					operator.setValue(Query.BEGINS);
					value.setValue(value.stringAt(1,length.subtract(1)));
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				CRun._assert(Constants.FALSE!=0);
			}
		}
		if (value.stringAt(1).equals("^")) {
			caseless.setValue(1);
			{
				ClarionNumber case_2=this.win.type();
				boolean case_2_break=false;
				if (case_2.equals(Constants.QBEFORMBASED)) {
					value.setValue(length.equals(1) ? Clarion.newString("") : value.stringAt(2,length).upper());
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Constants.QBELISTBASED)) {
					value.setValue(value.stringAt(2,length).upper());
					case_2_break=true;
				}
				if (!case_2_break) {
					CRun._assert(Constants.FALSE!=0);
				}
			}
		}
		if (picture.boolValue()) {
			if (!this.fields.forceEditPicture.boolValue()) {
				if (!(operator.equals(Query.CONTAINS) || operator.equals(Query.BEGINS))) {
					getLimit_MakeUnformatted(picture,value,caseless);
				}
			}
		}
		return rVal.like();
	}
	public void getLimit_MakeUnformatted(ClarionString picture,ClarionString value,ClarionNumber caseless)
	{
		if (!picture.boolValue()) {
			return;
		}
		if (picture.stringAt(1).equals("S") || picture.stringAt(1).equals("s")) {
			return;
		}
		if ((picture.stringAt(1).equals("N") || picture.stringAt(1).equals("n")) && value.left().clip().isNumeric()) {
			return;
		}
		value.setValue(value.equals("") ? Clarion.newString("") : value.deformat(picture.toString()));
		caseless.setValue(Constants.FALSE);
		picture.clear();
	}
	public void getLimit_ParseBound(ClarionString operator,ClarionString value,ClarionNumber caseless,ClarionNumber length,ClarionNumber isS,ClarionString picture)
	{
		if (this.fields.middle.boolValue()) {
			operator.setValue(operator.concat("="));
		}
		Abquery.makeOperator(operator.like(),value.like(),operator,value);
		if (value.stringAt(1).equals("^")) {
			caseless.setValue(1);
			{
				ClarionNumber case_1=this.win.type();
				boolean case_1_break=false;
				if (case_1.equals(Constants.QBEFORMBASED)) {
					value.setValue(length.compareTo(1)<=0 ? Clarion.newString("") : value.stringAt(2,length).upper());
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.QBELISTBASED)) {
					value.setValue(value.stringAt(2,length).upper());
					case_1_break=true;
				}
				if (!case_1_break) {
					CRun._assert(Constants.FALSE!=0);
				}
			}
		}
		if (this.fields.name.inString("UPPER(",1,1)!=0) {
			caseless.setValue(1);
			value.setValue(value.upper());
		}
		if (this.fields.forceEditPicture.boolValue() && !isS.boolValue()) {
			caseless.setValue(Constants.FALSE);
		}
		if (this.fields.forceEditPicture.boolValue() && !isS.boolValue()) {
			picture.clear();
		}
	}
	public void getLimit(ClarionString fieldName,ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionString picture)
	{
		this.findName(fieldName.like());
		this.getLimit(value,operator,caseless,picture);
	}
	public void init()
	{
		init((Queryvisual)null);
	}
	public void init(Queryvisual q)
	{
		this.fields=new Fieldqueue();
		if (!(q==null)) {
			this.win=q;
		}
	}
	public void init(Queryvisual q,Iniclass iNIMgr,ClarionString family,Errorclass e)
	{
		this.win=q;
		this.fields=new Fieldqueue();
		this.iNIMgr=iNIMgr;
		this.win.errors=e;
		this.errors=e;
		this.family=Clarion.newString(family.clip().len());
		this.family.setValue(family);
		this.popupList=new Popupqueue();
	}
	public void kill()
	{
		//this.fields;
		//this.family;
		//this.popupList;
	}
	public ClarionString quote(ClarionString value)
	{
		ClarionString rv=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber rvp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		rv.setStringAt(1,"'");
		rvp.setValue(2);
		for (i.setValue(1);i.compareTo(value.len())<=0;i.increment(1)) {
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
	public void reset(ClarionString fieldName)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (fieldName==null) {
			for (i.setValue(1);i.compareTo(this.fields.records())<=0;i.increment(1)) {
				this.fields.get(i);
				this.reset(this.fields.name.like());
			}
		}
		else {
			this.setLimit(fieldName.like(),Clarion.newString(""),Clarion.newString(""),Clarion.newString(""));
		}
	}
	public void setLimit(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		setLimit(p0,p1,p2,(ClarionString)null);
	}
	public void setLimit(ClarionString p0,ClarionString p1)
	{
		setLimit(p0,p1,(ClarionString)null);
	}
	public void setLimit(ClarionString p0)
	{
		setLimit(p0,(ClarionString)null);
	}
	public void setLimit(ClarionString fieldName,ClarionString low,ClarionString high,ClarionString eq)
	{
		this.findName(fieldName.like());
		if (!(low==null)) {
			this.fields.low.setValue(low);
		}
		if (!(high==null)) {
			this.fields.high.setValue(high);
		}
		if (!(eq==null)) {
			this.fields.middle.setValue(eq);
		}
		this.fields.put();
	}
	public void setQuickPopup(Popupclass popup,ClarionNumber queryControl)
	{
		Sectorqueue qq=null;
		ClarionNumber sm=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString pID=Clarion.newString(100);
		ClarionNumber sbMenu=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		qq=new Sectorqueue();
		if (this.popupList.records()!=0) {
			sm.setValue(1);
			while (!!(this.popupList.records()!=0)) {
				this.popupList.get(sm);
				popup.deleteItem(this.popupList.popupID.like());
				this.popupList.delete();
			}
			sbMenu.setValue(Constants.TRUE);
		}
		else {
			sbMenu.setValue(Constants.FALSE);
		}
		this.popupList.free();
		this.getQueries(qq);
		qq.sort(qq.ORDER().ascend(qq.item));
		if (qq.records()!=0) {
			pID.setValue(Constants.DEFAULTQKQUERYNAME);
			if (!sbMenu.boolValue()) {
				if (popup.getItems().boolValue()) {
					popup.addItem(Clarion.newString("-"),Clarion.newString("Separator1"),popup.getItems().getString(),Clarion.newNumber(1));
				}
				popup.addSubMenu(Clarion.newString(Constants.DEFAULTQKQUERYNAME),Clarion.newString(""),Clarion.newString(""));
				pID.setValue(Constants.DEFAULTQKQUERYNAME);
				popup.setIcon(pID.like(),this.qkMenuIcon.like());
				sbMenu.setValue(Constants.TRUE);
			}
		}
		else {
			if (sbMenu.boolValue()) {
				pID.setValue(popup.addItem(Clarion.newString("Empty       "),Clarion.newString("tsQBEEmpty"),Clarion.newString(Constants.DEFAULTQKQUERYNAME),Clarion.newNumber(2)));
				popup.setItemEnable(pID.like(),Clarion.newNumber(Constants.FALSE));
				this.popupList.popupID.setValue(pID);
				this.popupList.queryName.setValue(pID);
				this.popupList.add();
			}
		}
		for (sm.setValue(1);sm.compareTo(qq.records())<=0;sm.increment(1)) {
			qq.get(sm);
			pID.setValue(popup.addItem(Clarion.newString(qq.item.clip().concat("  ")),qq.item.clip(),pID.like(),Clarion.newNumber(2)));
			popup.setIcon(pID.like(),this.qkIcon.like());
			popup.addItemEvent(pID.like(),Clarion.newNumber(Event.NEWSELECTION),queryControl.like());
			this.popupList.popupID.setValue(pID);
			this.popupList.queryName.setValue(qq.item);
			this.popupList.add();
		}
		if (sbMenu.boolValue()) {
			pID.setValue(popup.addItem(Clarion.newString("-"),Clarion.newString("ClearSeparator  "),pID.like(),Clarion.newNumber(2)));
			this.popupList.popupID.setValue(pID);
			this.popupList.queryName.setValue(pID);
			this.popupList.add();
			pID.setValue(popup.addItem(Clarion.newString(Constants.DEFAULTCLEARNAME),Clarion.newString("tsQBEClear"),pID.like(),Clarion.newNumber(2)));
			popup.setIcon(pID.like(),this.qkIcon.like());
			popup.addItemEvent(pID.like(),Clarion.newNumber(Event.NEWSELECTION),queryControl.like());
			this.popupList.popupID.setValue(pID);
			this.popupList.queryName.setValue("tsQBEClear");
			this.popupList.add();
		}
		//qq;
		return;
	}
	public void save(ClarionString queryName)
	{
		this.iNIMgr.addSector(this.iNIMgr.getSector(this.family.like(),queryName.like(),Clarion.newString("Query")));
		this.iNIMgr.updateQueue(Clarion.newString("Query"),this.iNIMgr.getSector(this.family.like(),queryName.like(),Clarion.newString("Query")),this.fields,this.fields.name,this.fields.middle,this.fields.low,this.fields.high);
	}
	public ClarionNumber take(Popupclass p)
	{
		CRun._assert(!(p==null));
		if (this.qkSupport.boolValue()) {
			this.qkCurrentQuery.setValue(p.getLastSelection());
			this.popupList.popupID.setValue(this.qkCurrentQuery);
			this.popupList.get(this.popupList.ORDER().ascend(this.popupList.popupID));
			if (CError.errorCode()!=0) {
				this.clearQuery();
			}
			else {
				this.restore(this.popupList.queryName.like());
			}
			this.save(Clarion.newString("tsMRU"));
			return Clarion.newNumber(1);
		}
		return Clarion.newNumber(0);
	}
	public void restore(ClarionString queryName)
	{
		Fieldqueue restoreFields=null;
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		restoreFields=new Fieldqueue();
		this.clearQuery();
		restoreFields.free();
		this.iNIMgr.fetchQueue(Clarion.newString("Query"),this.iNIMgr.getSector(this.family.like(),queryName.like(),Clarion.newString("Query")),restoreFields,restoreFields.name,restoreFields.middle,restoreFields.low,restoreFields.high);
		if (!(restoreFields.records()!=0)) {
			this.clearQuery();
		}
		else {
			for (i.setValue(1);i.compareTo(restoreFields.records())<=0;i.increment(1)) {
				restoreFields.get(i);
				this.fields.name.setValue(restoreFields.name.upper());
				this.fields.get(this.fields.ORDER().ascend(this.fields.name));
				if (CError.errorCode()!=0 && !restoreFields.name.stringAt(1,6).equals("UPPER(")) {
					this.fields.name.setValue(ClarionString.staticConcat("UPPER(",this.fields.name,")"));
					this.fields.get(this.fields.ORDER().ascend(this.fields.name));
				}
				if (CError.errorCode()!=0 && restoreFields.name.stringAt(1,6).equals("UPPER(")) {
					this.fields.name.setValue(this.fields.name.stringAt(7,this.fields.name.len()-1));
					this.fields.get(this.fields.ORDER().ascend(this.fields.name));
					if (!(CError.errorCode()!=0)) {
						if (restoreFields.middle.boolValue() && (this.fields.picture.stringAt(1).upper().equals("S") || !this.fields.picture.boolValue()) && !restoreFields.middle.stringAt(1).equals("^") && !restoreFields.middle.stringAt(2).equals("^")) {
							restoreFields.middle.setValue(ClarionString.staticConcat("^",restoreFields.middle));
						}
						if (restoreFields.low.boolValue() && (this.fields.picture.stringAt(1).upper().equals("S") || !this.fields.picture.boolValue()) && !restoreFields.low.stringAt(1).equals("^") && !restoreFields.low.stringAt(2).equals("^")) {
							restoreFields.low.setValue(ClarionString.staticConcat("^",restoreFields.low));
						}
						if (restoreFields.high.boolValue() && (this.fields.picture.stringAt(1).upper().equals("S") || !this.fields.picture.boolValue()) && !restoreFields.high.stringAt(1).equals("^") && !restoreFields.high.stringAt(2).equals("^")) {
							restoreFields.high.setValue(ClarionString.staticConcat("^",restoreFields.high));
						}
					}
				}
				if (CError.errorCode()!=0) {
					this.errors.setField(restoreFields.name.like());
					this.errors._throw(Clarion.newNumber(Msg.QBECOLUMNNOTSUPPORTED));
				}
				else {
					this.fields.middle.setValue(restoreFields.middle);
					this.fields.low.setValue(restoreFields.low);
					this.fields.high.setValue(restoreFields.high);
					if (this.fields.middle.stringAt(1).equals("^")) {
						this.fields.middle.setValue(this.fields.middle.stringAt(2,this.fields.middle.len()).upper());
					}
					if (this.fields.low.stringAt(1).equals("^")) {
						this.fields.low.setValue(this.fields.low.stringAt(2,this.fields.low.len()).upper());
					}
					if (this.fields.high.stringAt(1).equals("^")) {
						this.fields.high.setValue(this.fields.high.stringAt(2,this.fields.high.len()).upper());
					}
					if (this.win.type().equals(Constants.QBEFORMBASED)) {
						if (this.fields.middle.boolValue()) {
							this.fields.high.setValue("");
							this.fields.low.setValue("");
						}
						else {
							this.fields.middle.setValue(this.fields.low);
							this.fields.high.setValue("");
							this.fields.low.setValue("");
						}
					}
					this.fields.put();
				}
			}
			restoreFields.free();
		}
		//restoreFields;
	}
	public void delete(ClarionString queryName)
	{
		this.iNIMgr.deleteSector(this.iNIMgr.getSector(this.family.like(),queryName.like(),Clarion.newString("Query")));
	}
	public void getQueries(Sectorqueue qq)
	{
		if (this.iNIMgr==null) {
			return;
		}
		qq.free();
		this.iNIMgr.getSectors(this.family.like(),null,Clarion.newString("Query"),qq);
		qq.sort(qq.ORDER().ascend(qq.item));
		qq.item.setValue("tsMRU");
		qq.get(qq.ORDER().ascend(qq.item));
		if (!(CError.error().length()!=0)) {
			qq.delete();
		}
	}
	public void clearQuery()
	{
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		for (j.setValue(1);j.compareTo(this.fields.records())<=0;j.increment(1)) {
			this.fields.get(j);
			this.fields.low.clear();
			this.fields.middle.clear();
			this.fields.high.clear();
			this.fields.put();
		}
	}
}
