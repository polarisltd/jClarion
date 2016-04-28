package clarion;

import clarion.Abpopup;
import clarion.Iniclass;
import clarion.Popupitemqueue;
import clarion.Translatorclass;
import clarion.W;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.State;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Popupclass
{
	public ClarionNumber clearKeycode;
	public ClarionString lastSelection;
	public ClarionNumber lastNumberSelection;
	public Popupitemqueue popupItems;
	public Translatorclass translator;
	public Iniclass iNIMgr;
	public ClarionNumber inToolbox;
	public ClarionNumber myThread;
	public ClarionWindow parentWindow;
	public ClarionWindow thisWindow;
	public Popupclass()
	{
		clearKeycode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lastSelection=Clarion.newString(Constants.MAXMENUITEMLEN).setEncoding(ClarionString.CSTRING);
		lastNumberSelection=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		popupItems=null;
		translator=null;
		iNIMgr=null;
		inToolbox=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		myThread=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		parentWindow=null;
		thisWindow=null;
	}

	public ClarionString addItem(ClarionString menuText)
	{
		return this.addItem(menuText.like(),Abpopup.getUniqueName(this,(menuText.equals("-") ? Clarion.newString("Separator") : menuText).getString()));
	}
	public ClarionString addItem(ClarionString menuText,ClarionString itemName)
	{
		return this.addItem(menuText.like(),itemName.like(),Clarion.newString(""),Clarion.newNumber(0));
	}
	public ClarionString addItem(ClarionString menuText,ClarionString name,ClarionString nameToFollow,ClarionNumber level)
	{
		return this.setItem(this.locateName(nameToFollow.like()),level.like(),name.like(),menuText.like());
	}
	public ClarionString addItemEvent(ClarionString p0,ClarionNumber p1)
	{
		return addItemEvent(p0,p1,Clarion.newNumber(0));
	}
	public ClarionString addItemEvent(ClarionString name,ClarionNumber eventNo,ClarionNumber controlID)
	{
		ClarionString rVal=Clarion.newString(Constants.MAXMENUITEMLEN);
		rVal.setValue(this.locateName(name.like()).equals(0) ? this.addItem(name.like()) : name);
		this.popupItems.mimicMode.setValue(Constants.FALSE);
		this.popupItems.controlID.setValue(controlID);
		this.popupItems.event.setValue(eventNo);
		this.popupItems.onToolbox.setValue(Constants.TRUE);
		this.popupItems.put();
		CRun._assert(!(CError.errorCode()!=0));
		return rVal.like();
	}
	public ClarionString addItemMimic(ClarionString p0,ClarionNumber p1)
	{
		return addItemMimic(p0,p1,(ClarionString)null);
	}
	public ClarionString addItemMimic(ClarionString name,ClarionNumber buttonID,ClarionString txt)
	{
		ClarionString rVal=Clarion.newString(Constants.MAXMENUITEMLEN);
		rVal.setValue(this.addItemEvent(name.like(),Clarion.newNumber(Event.ACCEPTED),buttonID.like()));
		this.popupItems.text.setValue(txt);
		this.popupItems.mimicMode.setValue(Constants.TRUE);
		this.popupItems.onToolbox.setValue(Constants.TRUE);
		this.popupItems.put();
		CRun._assert(!(CError.errorCode()!=0));
		return rVal.like();
	}
	public void addMenu(ClarionString p0)
	{
		addMenu(p0,Clarion.newNumber(0));
	}
	public void addMenu(ClarionString mText,ClarionNumber atPosition)
	{
		ClarionNumber cDepth=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		ClarionString cItem=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber commit=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		CRun._assert(mText.boolValue());
		if (atPosition.boolValue()) {
			atPosition.decrement(1);
			this.popupItems.get(atPosition);
			cDepth.setValue(CError.errorCode()==0 ? this.popupItems.depth : Clarion.newNumber(1));
		}
		else {
			this.popupItems.free();
		}
		commit.setValue(Constants.FALSE);
		for (i.setValue(1);i.compareTo(mText.len())<=0;i.increment(1)) {
			{
				int case_1=mText.stringAt(i).val();
				boolean case_1_break=false;
				if (case_1==Clarion.newString("|").val()) {
					addMenu_AddItem(cItem,atPosition,cDepth,commit);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Clarion.newString("{").val()) {
					addMenu_AddItem(cItem,atPosition,cDepth,commit);
					cDepth.increment(1);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Clarion.newString("}").val()) {
					addMenu_AddItem(cItem,atPosition,cDepth,commit);
					cDepth.decrement(1);
					CRun._assert(cDepth.compareTo(0)>0);
					case_1_break=true;
				}
				if (!case_1_break) {
					cItem.setValue(cItem.concat(mText.stringAt(i)));
					commit.setValue(Constants.TRUE);
				}
			}
		}
		if (commit.boolValue()) {
			addMenu_AddItem(cItem,atPosition,cDepth,commit);
		}
	}
	public void addMenu_AddItem(ClarionString cItem,ClarionNumber atPosition,ClarionNumber cDepth,ClarionNumber commit)
	{
		if (cItem.boolValue()) {
			this.setItem(atPosition.like(),cDepth.like(),cItem.like(),cItem.like());
			atPosition.increment(1);
			cItem.clear();
		}
		commit.setValue(Constants.FALSE);
		return;
	}
	public void deleteMenu(ClarionString mText)
	{
		ClarionNumber cDepth=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		ClarionString cItem=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		ClarionString refText=null;
		ClarionNumber cDeleteSep=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		refText=mText;
		if (mText.len()>3) {
			if (mText.stringAt(1,3).equals("|-|")) {
				refText=mText.stringAt(4,mText.len());
				cDeleteSep.setValue(Constants.TRUE);
			}
		}
		for (i.setValue(1);i.compareTo(refText.len())<=0;i.increment(1)) {
			if (refText.stringAt(i).equals("{")) {
				deleteMenu_DeleteItem(cItem,cDepth,cDeleteSep);
				break;
			}
			else {
				cItem.setValue(cItem.concat(refText.stringAt(i)));
				if (i.equals(refText.len())) {
					deleteMenu_DeleteItem(cItem,cDepth,cDeleteSep);
				}
			}
		}
	}
	public void deleteMenu_DeleteItem(ClarionString cItem,ClarionNumber cDepth,ClarionNumber cDeleteSep)
	{
		ClarionNumber ii=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber startDelete=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber totalRec=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (cItem.stringAt(1).equals("\u0000")) {
			return;
		}
		startDelete.setValue(Constants.FALSE);
		for (ii.setValue(1);ii.compareTo(this.popupItems.records())<=0;ii.increment(1)) {
			this.popupItems.get(ii);
			if (this.popupItems.text.clip().equals(cItem.clip()) && !startDelete.boolValue()) {
				cDepth.setValue(this.popupItems.depth);
				startDelete.setValue(Constants.TRUE);
				this.popupItems.text.setValue("TOBEDELETED");
				this.popupItems.name.setValue("TOBEDELETED");
				this.popupItems.put();
				if (cDeleteSep.boolValue()) {
					cDeleteSep.setValue(Constants.FALSE);
					if (ii.compareTo(1)>0) {
						this.popupItems.get(ii.subtract(1));
						if (this.popupItems.text.equals("-")) {
							this.popupItems.text.setValue("TOBEDELETED");
							this.popupItems.name.setValue("TOBEDELETED");
							this.popupItems.put();
						}
					}
				}
				continue;
			}
			if (startDelete.boolValue()) {
				if (cDepth.compareTo(this.popupItems.depth)<0) {
					this.popupItems.text.setValue("TOBEDELETED");
					this.popupItems.name.setValue("TOBEDELETED");
					this.popupItems.put();
				}
				else {
					break;
				}
			}
		}
		totalRec.setValue(this.popupItems.records());
		for (ii.setValue(totalRec);ii.compareTo(1)>=0;ii.increment(-1)) {
			this.popupItems.get(ii);
			if (this.popupItems.text.equals("TOBEDELETED") && this.popupItems.name.equals("TOBEDELETED")) {
				this.popupItems.delete();
			}
		}
	}
	public void addSubMenu(ClarionString mText,ClarionString nameToFollow)
	{
		this.addMenu(mText.like(),this.locateName(nameToFollow.like()).add(1).getNumber());
	}
	public void addSubMenu(ClarionString menuHeading,ClarionString menuText,ClarionString nameToFollow)
	{
		this.addSubMenu(Clarion.newString(menuHeading.clip().concat("{",menuText.clip(),"}")),nameToFollow.like());
	}
	public ClarionString ask(ClarionNumber p0)
	{
		return ask(p0,Clarion.newNumber(0));
	}
	public ClarionString ask()
	{
		return ask(Clarion.newNumber(0));
	}
	public ClarionString ask(ClarionNumber xPos,ClarionNumber yPos)
	{
		this.lastNumberSelection.setValue(this.executePopup(this.getMenuText(),xPos.like(),yPos.like()));
		if (this.lastNumberSelection.equals(0)) {
			this.lastSelection.setValue("");
			return Clarion.newString("");
		}
		this.lastSelection.setValue(this.getName(this.lastNumberSelection.like()));
		if (this.lastSelection.boolValue() && this.locateName(this.lastSelection.like()).boolValue()) {
			if (this.popupItems.event.boolValue() || this.popupItems.mimicMode.boolValue()) {
				if (this.clearKeycode.boolValue()) {
					CWin.setKeyCode(0);
				}
				CWin.post((this.popupItems.mimicMode.equals(1) ? Clarion.newNumber(Event.ACCEPTED) : this.popupItems.event).intValue(),this.popupItems.controlID.intValue(),this.myThread.intValue());
			}
		}
		return this.lastSelection.like();
	}
	public void askToolbox(ClarionString n)
	{
		W w=new W();
		ClarionNumber xp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yd=Clarion.newNumber(0).setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber nv=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		try {
			w.open(this.parentWindow);
			w.setClonedProperty(Prop.TEXT,n);
			this.thisWindow=w;
			for (c.setValue(1);c.compareTo(this.popupItems.records())<=0;c.increment(1)) {
				this.popupItems.get(c);
				if (!this.popupItems.onToolbox.boolValue()) {
					continue;
				}
				nv.increment(1);
				CWin.setTarget(this.parentWindow);
				this.checkMimics();
				CWin.setTarget(w);
				CWin.createControl(nv.intValue(),Create.BUTTON,null,null);
				if (this.popupItems.icon.boolValue()) {
					Clarion.getControl(nv).setProperty(Prop.ICON,ClarionString.staticConcat("~",this.popupItems.icon));
					Clarion.getControl(nv).setProperty(Prop.TOOLTIP,Abpopup.removeAmpersand(this.popupItems.text.like()));
				}
				else {
					Clarion.getControl(nv).setClonedProperty(Prop.TEXT,this.popupItems.text);
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
			while (Clarion.getWindowTarget().accept()) {
				if (!this.ask().boolValue()) {
					break;
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			w.close();
			this.inToolbox.setValue(0);
		} finally {
			w.close();
		}
	}
	public void checkMimics()
	{
		if (this.popupItems.mimicMode.boolValue()) {
			if (Clarion.getControl(this.popupItems.controlID).getProperty(Prop.TEXT).boolValue() && (this.popupItems.text.stringAt(1).equals("!") || !this.popupItems.text.boolValue())) {
				this.popupItems.text.setValue(Clarion.getControl(this.popupItems.controlID).getProperty(Prop.TEXT));
			}
			if (this.popupItems.text.stringAt(1).equals("!")) {
				this.popupItems.text.setValue(this.popupItems.text.stringAt(2,this.popupItems.text.len()));
			}
			if (!this.popupItems.disabled.boolValue()) {
				this.popupItems.disabled.setValue(Clarion.getControl(this.popupItems.controlID).getProperty(Prop.DISABLE).intValue()==1 ?State.ON:State.OFF);
			}
			if (!this.popupItems.icon.boolValue()) {
				this.popupItems.icon.setValue(Clarion.getControl(this.popupItems.controlID).getProperty(Prop.ICON));
			}
		}
	}
	public void deleteItem(ClarionString name)
	{
		if (this.locateName(name.like()).boolValue()) {
			this.popupItems.delete();
		}
	}
	public ClarionNumber executePopup(ClarionString menuText,ClarionNumber xPos,ClarionNumber yPos)
	{
		if (!this.inToolbox.boolValue()) {
			if (xPos.equals(0)) {
				xPos.setValue(Constants._NOPOS);
			}
			if (yPos.equals(0)) {
				yPos.setValue(Constants._NOPOS);
			}
			return Clarion.newNumber(CWin.popup(menuText.toString(),xPos.intValue(),yPos.intValue()));
		}
		while (Clarion.getWindowTarget().accept()) {
			{
				int case_1=CWin.event();
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1==Event.CLOSEWINDOW) {
					case_1_match=true;
				}
				if (case_1_match || case_1==Event.CLOSEDOWN) {
					return Clarion.newNumber(0);
					// UNREACHABLE! :case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Event.ACCEPTED) {
					if (CWin.accepted()!=0) {
						return Clarion.newNumber(CWin.accepted());
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Event.TIMER) {
					this.resetToolbox();
					case_1_break=true;
				}
			}
			Clarion.getWindowTarget().consumeAccept();
		}
		return Clarion.newNumber();
	}
	public ClarionNumber getItemChecked(ClarionString name)
	{
		if (this.locateName(name.like()).boolValue()) {
			return Clarion.newNumber(this.popupItems.check.equals(State.ON) ? 1 : 0);
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionNumber getItemEnabled(ClarionString name)
	{
		if (this.locateName(name.like()).boolValue()) {
			return Clarion.newNumber(this.popupItems.disabled.equals(State.OFF) ? 1 : 0);
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionNumber getItems()
	{
		return getItems(Clarion.newNumber(0));
	}
	public ClarionNumber getItems(ClarionNumber pOnlyItems)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber lItems=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber oldDepth=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		if (!pOnlyItems.boolValue()) {
			return Clarion.newNumber(this.popupItems.records());
		}
		lItems.setValue(0);
		for (c.setValue(1);c.compareTo(this.popupItems.records())<=0;c.increment(1)) {
			this.popupItems.get(c);
			if (this.popupItems.text.equals("-")) {
				continue;
			}
			if (this.popupItems.depth.compareTo(oldDepth)<=0) {
				lItems.increment(1);
			}
			oldDepth.setValue(this.popupItems.depth);
		}
		return lItems.like();
	}
	public ClarionString getLastSelection()
	{
		return this.lastSelection.like();
	}
	public ClarionNumber getLastNumberSelection()
	{
		return this.lastNumberSelection.like();
	}
	public ClarionString getMenuText()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString menuText=Clarion.newString(Constants.MAXMENUSTRLEN).setEncoding(ClarionString.CSTRING);
		ClarionNumber oldDepth=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber newStyle=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		for (c.setValue(1);c.compareTo(this.popupItems.records())<=0;c.increment(1)) {
			this.popupItems.get(c);
			this.checkMimics();
			if (this.popupItems.icon.boolValue()) {
				newStyle.setValue(1);
				break;
			}
		}
		for (c.setValue(1);c.compareTo(this.popupItems.records())<=0;c.increment(1)) {
			this.popupItems.get(c);
			if (this.popupItems.depth.equals(oldDepth)) {
				menuText.setValue(menuText.concat("|"));
			}
			else if (this.popupItems.depth.compareTo(oldDepth)>0) {
				menuText.setValue(menuText.concat("{"));
			}
			else {
				menuText.setValue(menuText.concat("}"));
			}
			oldDepth.setValue(this.popupItems.depth);
			this.checkMimics();
			if (this.popupItems.disabled.equals(State.ON)) {
				menuText.setValue(menuText.concat("~"));
			}
			if (!this.popupItems.check.equals(State.NONE)) {
				menuText.setValue(menuText.concat(this.popupItems.check.equals(State.ON) ? Clarion.newString("+") : Clarion.newString("-")));
			}
			getMenuText_ExtendedItems(newStyle,menuText);
			if (!(this.translator==null)) {
				this.popupItems.text.setValue(this.translator.translateString(this.popupItems.text.like()));
			}
			menuText.setValue(menuText.concat(this.popupItems.text));
		}
		return menuText.like();
	}
	public void getMenuText_ExtendedItems(ClarionNumber newStyle,ClarionString menuText)
	{
		if (newStyle.boolValue() && !this.popupItems.text.equals("-")) {
			menuText.setValue(menuText.concat("["));
			if (this.popupItems.icon.boolValue()) {
				menuText.setValue(menuText.concat(Prop.ICON,"(~",this.popupItems.icon,")"));
			}
			menuText.setValue(menuText.concat("]"));
		}
	}
	public ClarionString getName(ClarionNumber positional)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber pd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber posCnt=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (positional.boolValue()) {
			for (c.setValue(1);c.compareTo(this.popupItems.records())<=0;c.increment(1)) {
				this.popupItems.get(c);
				if (this.inToolbox.boolValue()) {
					if (!this.popupItems.onToolbox.boolValue()) {
						continue;
					}
				}
				else if (this.popupItems.text.equals("-")) {
					continue;
				}
				if (c.compareTo(this.popupItems.records())<0) {
					pd.setValue(this.popupItems.depth);
					this.popupItems.get(c.add(1));
					if (pd.compareTo(this.popupItems.depth)<0) {
						continue;
					}
					this.popupItems.get(c);
				}
				posCnt.increment(1);
				if (posCnt.equals(positional)) {
					return this.popupItems.name.like();
				}
			}
		}
		return Clarion.newString("");
	}
	public void init()
	{
		this.popupItems=new Popupitemqueue();
		this.clearKeycode.setValue(1);
		this.myThread.setValue(CRun.getThreadID());
		this.lastNumberSelection.setValue(0);
	}
	public void init(Iniclass iNIMgr)
	{
		this.iNIMgr=iNIMgr;
		this.init();
	}
	public void kill()
	{
		//this.popupItems;
	}
	public ClarionNumber locateName(ClarionString name)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.popupItems.records())<=0;i.increment(1)) {
			this.popupItems.get(i);
			if (this.popupItems.name.equals(name)) {
				return i.like();
			}
		}
		return Clarion.newNumber(0);
	}
	public void restore(ClarionString menuDescription)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString itemStr=Clarion.newString("ItemXXX");
		if (!(this.iNIMgr==null) && menuDescription.boolValue()) {
			this.popupItems.free();
			for (c.setValue(1);c.compareTo(this.iNIMgr.tryFetch(menuDescription.like(),Clarion.newString("Items")))<=0;c.increment(1)) {
				itemStr.setStringAt(5,7,c.getString().format("@N03"));
				this.popupItems.name.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(1)));
				this.popupItems.text.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(2)));
				this.popupItems.depth.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(3)));
				this.popupItems.controlID.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(4)));
				this.popupItems.event.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(5)));
				this.popupItems.mimicMode.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(6)));
				this.popupItems.check.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(7)));
				this.popupItems.disabled.setValue(this.iNIMgr.fetchField(menuDescription.like(),itemStr.like(),Clarion.newNumber(8)));
				this.popupItems.add();
				CRun._assert(!(CError.errorCode()!=0));
			}
		}
	}
	public void resetToolbox()
	{
		ClarionNumber xp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber yd=Clarion.newNumber(0).setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber nv=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (this.thisWindow==null) {
			return;
		}
		for (c.setValue(1);c.compareTo(this.popupItems.records())<=0;c.increment(1)) {
			this.popupItems.get(c);
			if (!this.popupItems.onToolbox.boolValue()) {
				continue;
			}
			nv.increment(1);
			CWin.setTarget(this.parentWindow);
			this.checkMimics();
			CWin.setTarget(this.thisWindow);
			if (!Clarion.getControl(nv).getProperty(Prop.TYPE).boolValue()) {
				CWin.createControl(nv.intValue(),Create.BUTTON,null,null);
			}
			if (this.popupItems.icon.boolValue()) {
				Clarion.getControl(nv).setProperty(Prop.ICON,ClarionString.staticConcat("~",this.popupItems.icon));
				Clarion.getControl(nv).setProperty(Prop.TOOLTIP,Abpopup.removeAmpersand(this.popupItems.text.like()));
			}
			else {
				Clarion.getControl(nv).setClonedProperty(Prop.TEXT,this.popupItems.text);
			}
			Clarion.getControl(nv).setProperty(Prop.DISABLE,this.popupItems.disabled.equals(State.ON) ? 1 : 0);
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
	public void save(ClarionString menuDescription)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString itemStr=Clarion.newString("ItemXXX");
		if (!(this.iNIMgr==null) && this.popupItems.records()!=0 && menuDescription.len()!=0) {
			this.iNIMgr.update(menuDescription.like(),Clarion.newString("Items"),Clarion.newString(String.valueOf(this.popupItems.records())));
			for (c.setValue(1);c.compareTo(this.popupItems.records())<=0;c.increment(1)) {
				this.popupItems.get(c);
				CRun._assert(!(CError.errorCode()!=0));
				itemStr.setStringAt(5,7,c.getString().format("@N03"));
				this.iNIMgr.update(menuDescription.like(),itemStr.like(),Clarion.newString(this.popupItems.name.concat(",",this.popupItems.text,",",this.popupItems.depth,",",this.popupItems.controlID,",",this.popupItems.event,",",this.popupItems.mimicMode,",",this.popupItems.check,",",this.popupItems.disabled)));
			}
		}
	}
	public ClarionString setItem(ClarionNumber addAfter,ClarionNumber level,ClarionString baseName,ClarionString menuText)
	{
		ClarionString newName=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (addAfter.equals(0)) {
			addAfter.setValue(this.popupItems.records());
		}
		if (level.equals(0)) {
			this.popupItems.get(addAfter);
			level.setValue(CError.errorCode()==0 ? this.popupItems.depth : Clarion.newNumber(1));
		}
		newName.setValue(Abpopup.getUniqueName(this,baseName.like()));
		this.popupItems.clear();
		this.popupItems.name.setValue(newName);
		l.setValue(menuText.clip().len());
		i.setValue(1);
		if (!menuText.equals("-")) {
			while (i.compareTo(l)<=0) {
				{
					int case_1=menuText.stringAt(i).val();
					boolean case_1_break=false;
					if (case_1==Clarion.newString("~").val()) {
						this.popupItems.disabled.setValue(State.ON);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Clarion.newString("+").val()) {
						this.popupItems.check.setValue(State.ON);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Clarion.newString("-").val()) {
						this.popupItems.check.setValue(State.OFF);
						case_1_break=true;
					}
					if (!case_1_break) {
						break;
					}
				}
				i.increment(1);
			}
		}
		this.popupItems.text.setValue(i.compareTo(l)>0 ? Clarion.newString("") : menuText.stringAt(i,l));
		this.popupItems.depth.setValue(level);
		this.popupItems.add(addAfter.add(1));
		CRun._assert(!(CError.errorCode()!=0));
		return newName.like();
	}
	public void setItemCheck(ClarionString name,ClarionNumber checkState)
	{
		if (this.locateName(name.like()).boolValue() && !this.popupItems.text.equals("-")) {
			this.popupItems.check.setValue(checkState.equals(0) ? Clarion.newNumber(State.OFF) : Clarion.newNumber(State.ON));
			this.popupItems.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public void setItemEnable(ClarionString name,ClarionNumber enableState)
	{
		if (this.locateName(name.like()).boolValue() && !this.popupItems.text.equals("-")) {
			this.popupItems.disabled.setValue(enableState.equals(0) ? Clarion.newNumber(State.ON) : Clarion.newNumber(State.OFF));
			this.popupItems.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public void setLevel(ClarionString name,ClarionNumber lvl)
	{
		if (this.locateName(name.like()).boolValue()) {
			this.popupItems.depth.setValue(lvl);
			this.popupItems.put();
		}
	}
	public void setIcon(ClarionString name,ClarionString txt)
	{
		if (this.locateName(name.like()).boolValue()) {
			this.popupItems.icon.setValue(txt);
			this.popupItems.put();
		}
	}
	public void setText(ClarionString name,ClarionString txt)
	{
		if (this.locateName(name.like()).boolValue()) {
			this.popupItems.text.setValue(txt);
			this.popupItems.put();
		}
	}
	public void setToolbox(ClarionString name,ClarionNumber show)
	{
		if (this.locateName(name.like()).boolValue()) {
			this.popupItems.onToolbox.setValue(show);
			this.popupItems.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public void setTranslator(Translatorclass t)
	{
		this.translator=t;
		CRun._assert(!(this.translator==null));
	}
	public void toolbox(ClarionString name)
	{
		this.inToolbox.setValue(1);
		this.parentWindow=(ClarionWindow)CMemory.resolveAddress(ClarionSystem.getInstance().getProperty(Prop.TARGET).intValue());
		{
			final int _f0=CMemory.address(this);
			final ClarionString _f1=name;
			CRun.start(new Runnable() { public void run() { Abpopup.popToolbox(Clarion.newString(String.valueOf(_f0)),_f1); } } );
		}
	}
	public void viewMenu()
	{
	}
}
