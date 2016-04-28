package clarion;

import clarion.Abresize;
import clarion.Controlqueue;
import clarion.Positiongroup;
import clarion.Resizequeue;
import clarion.Windowpositiongroup;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Resize;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Windowresizeclass
{
	public ClarionNumber appstrategy;
	public ClarionNumber autoTransparent;
	public Windowpositiongroup origWin;
	public Controlqueue controlQueue;
	public ClarionNumber deferMoves;
	public Positiongroup previousWin;
	public ClarionNumber resizeCalled;
	public Resizequeue resizeList;
	public Windowresizeclass()
	{
		appstrategy=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		autoTransparent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		origWin=new Windowpositiongroup();
		controlQueue=null;
		deferMoves=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		previousWin=new Positiongroup();
		resizeCalled=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		resizeList=null;
	}

	public ClarionNumber getParentControl(ClarionNumber controlID)
	{
		this.controlQueue.id.setValue(controlID);
		this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
		CRun._assert(!(CError.errorCode()!=0));
		return this.controlQueue.parentID.like();
	}
	public ClarionNumber getPositionStrategy(ClarionNumber p0)
	{
		return getPositionStrategy(p0,(ClarionNumber)null);
	}
	public ClarionNumber getPositionStrategy(ClarionNumber controlType,ClarionNumber appstrategy)
	{
		ClarionNumber appStrat=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rVal=Clarion.newNumber(Resize.REPOSITION).setEncoding(ClarionNumber.USHORT);
		appStrat.setValue(Clarion.newBool(appstrategy==null).equals(Constants.TRUE) ? this.appstrategy : appstrategy);
		{
			ClarionNumber case_1=appStrat;
			boolean case_1_break=false;
			if (case_1.equals(Appstrategy.NORESIZE)) {
				rVal.setValue(Resize.LOCKXPOS+Resize.LOCKYPOS);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SPREAD)) {
				if (controlType.equals(Create.BUTTON)) {
					rVal.setValue(Resize.FIXNEARESTX+Resize.FIXNEARESTY);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SURFACE)) {
				{
					ClarionNumber case_2=controlType;
					boolean case_2_break=false;
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2.equals(Create.BUTTON)) {
						rVal.setValue(Resize.FIXNEARESTX+Resize.FIXNEARESTY);
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2.equals(Create.ENTRY)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.COMBO)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.SPIN)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.DROPCOMBO)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.PROMPT)) {
						rVal.setValue(Resize.FIXTOP);
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2.equals(Create.LIST)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.SHEET)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.PANEL)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.IMAGE)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.OPTION)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.GROUP)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.REGION)) {
						rVal.setValue(Resize.FIXLEFT+Resize.FIXTOP);
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
		}
		return rVal.like();
	}
	public ClarionNumber getResizeStrategy(ClarionNumber p0)
	{
		return getResizeStrategy(p0,(ClarionNumber)null);
	}
	public ClarionNumber getResizeStrategy(ClarionNumber controlType,ClarionNumber appstrategy)
	{
		ClarionNumber appStrat=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rVal=Clarion.newNumber(Resize.RESIZE).setEncoding(ClarionNumber.USHORT);
		appStrat.setValue(Clarion.newBool(appstrategy==null).equals(Constants.TRUE) ? this.appstrategy : appstrategy);
		{
			ClarionNumber case_1=appStrat;
			boolean case_1_break=false;
			if (case_1.equals(Appstrategy.NORESIZE)) {
				rVal.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SPREAD)) {
				{
					ClarionNumber case_2=this.controlQueue.type;
					boolean case_2_break=false;
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2.equals(Create.BUTTON)) {
						rVal.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2.equals(Create.RADIO)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.CHECK)) {
						rVal.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2.equals(Create.ENTRY)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.COMBO)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.SPIN)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.DROPCOMBO)) {
						rVal.setValue(Resize.LOCKHEIGHT);
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SURFACE)) {
				{
					ClarionNumber case_3=this.controlQueue.type;
					boolean case_3_break=false;
					boolean case_3_match=false;
					case_3_match=false;
					if (case_3.equals(Create.BUTTON)) {
						rVal.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
						case_3_break=true;
					}
					case_3_match=false;
					if (!case_3_break && case_3.equals(Create.RADIO)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.CHECK)) {
						rVal.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
						case_3_break=true;
					}
					case_3_match=false;
					if (!case_3_break && case_3.equals(Create.ENTRY)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.COMBO)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.SPIN)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.DROPCOMBO)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.PROMPT)) {
						rVal.setValue(Resize.LOCKHEIGHT);
						case_3_break=true;
					}
					case_3_match=false;
					if (!case_3_break && case_3.equals(Create.LIST)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.SHEET)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.PANEL)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.IMAGE)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.OPTION)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.GROUP)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.REGION)) {
						rVal.setValue(Resize.CONSTANTRIGHT+Resize.CONSTANTBOTTOM);
						case_3_break=true;
					}
				}
				case_1_break=true;
			}
		}
		return rVal.like();
	}
	public ClarionNumber getOrigPos(ClarionNumber ctrlId,Positiongroup pg)
	{
		this.controlQueue.id.setValue(ctrlId);
		this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		pg.setValue(this.controlQueue.pos.getString());
		return Clarion.newNumber(Constants.TRUE);
	}
	public ClarionNumber getCurrentPos(ClarionNumber ctrlId,Positiongroup pg)
	{
		this.controlQueue.id.setValue(ctrlId);
		this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		Abresize.getSizeInfo(ctrlId.like(),pg);
		return Clarion.newNumber(Constants.TRUE);
	}
	public void init(ClarionNumber p0,ClarionNumber p1)
	{
		init(p0,p1,Clarion.newNumber(Constants.FALSE));
	}
	public void init(ClarionNumber p0)
	{
		init(p0,Clarion.newNumber(Constants.FALSE));
	}
	public void init()
	{
		init(Clarion.newNumber(Appstrategy.RESIZE));
	}
	public void init(ClarionNumber appstrategy,ClarionNumber setWindowMinSize,ClarionNumber setWindowMaxSize)
	{
		this.controlQueue=new Controlqueue();
		this.resizeList=new Resizequeue();
		this.appstrategy.setValue(appstrategy);
		CWin.register(Event.SIZED,new Runnable() { public void run() {takeResize(); } },CMemory.address(this));
		Clarion.getControl(0).setProperty(Prop.IMM,Constants.TRUE);
		this.reset();
		if (appstrategy.equals(Appstrategy.SURFACE)) {
			this.setParentDefaults();
		}
		if (setWindowMinSize.boolValue()) {
			Clarion.getControl(0).setClonedProperty(Prop.MINWIDTH,this.origWin.width);
			Clarion.getControl(0).setClonedProperty(Prop.MINHEIGHT,this.origWin.height);
		}
		if (setWindowMaxSize.boolValue()) {
			Clarion.getControl(0).setClonedProperty(Prop.MAXWIDTH,this.origWin.width);
			Clarion.getControl(0).setClonedProperty(Prop.MAXHEIGHT,this.origWin.height);
		}
		this.deferMoves.setValue(Constants.TRUE);
	}
	public void kill()
	{
		CWin.unregister(Event.SIZED,new Runnable() { public void run() {takeResize(); } },CMemory.address(this));
		//this.controlQueue;
		//this.resizeList;
	}
	public void removeControl(ClarionNumber control)
	{
		ClarionNumber delPrnt=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		this.controlQueue.id.setValue(control);
		this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
		if (!(CError.errorCode()!=0)) {
			delPrnt.setValue(this.controlQueue.parentID);
			this.controlQueue.delete();
			if (!(CError.errorCode()!=0)) {
				this.controlQueue.get(1);
				while (!(CError.errorCode()!=0)) {
					if (this.controlQueue.parentID.equals(control)) {
						this.controlQueue.parentID.setValue(delPrnt);
						this.controlQueue.put();
					}
					this.controlQueue.get(this.controlQueue.getPointer()+1);
				}
			}
		}
	}
	public void reset()
	{
		ClarionNumber fieldCounter=Clarion.newNumber(0).setEncoding(ClarionNumber.SIGNED);
		Abresize.getSizeInfo(Clarion.newNumber(0),this.origWin);
		this.origWin.maximized.setValue(Clarion.getControl(0).getProperty(Prop.MAXIMIZE));
		this.origWin.iconized.setValue(Clarion.getControl(0).getProperty(Prop.ICONIZE));
		this.previousWin.setValue(this.origWin.getString());
		while (true) {
			fieldCounter.setValue(Clarion.getControl(0).getProperty(Prop.NEXTFIELD,fieldCounter));
			if (!fieldCounter.boolValue()) {
				break;
			}
			this.controlQueue.id.setValue(fieldCounter);
			this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
			if (CError.errorCode()!=0) {
				this.controlQueue.type.setValue(Clarion.getControl(fieldCounter).getProperty(Prop.TYPE));
				this.controlQueue.hasChildren.setValue(Constants.FALSE);
				if (!Clarion.getControl(fieldCounter).getProperty(Prop.INTOOLBAR).boolValue() && CRun.inRange(this.controlQueue.type,Clarion.newNumber(1),Clarion.newNumber(Create.TOOLBAR-1)) && !CRun.inlist(this.controlQueue.type.toString(),new ClarionString[] {Clarion.newString(String.valueOf(Create.MENU)),Clarion.newString(String.valueOf(Create.ITEM)),Clarion.newString(String.valueOf(Create.TAB))}).boolValue()) {
					this.controlQueue.id.setValue(fieldCounter);
					Abresize.getSizeInfo(fieldCounter.like(),this.controlQueue.pos);
					if (this.controlQueue.type.equals(Create.LIST) && Clarion.getControl(this.controlQueue.id).getProperty(Prop.DROP).boolValue()) {
						this.controlQueue.type.setValue(Create.ENTRY);
					}
					this.controlQueue.positionalStrategy.setValue(this.getPositionStrategy(this.controlQueue.type.like()));
					this.controlQueue.resizeStrategy.setValue(this.getResizeStrategy(this.controlQueue.type.like()));
					this.controlQueue.parentID.setValue(0);
					this.controlQueue.add(this.controlQueue.ORDER().ascend(this.controlQueue.id));
					CRun._assert(!(CError.errorCode()!=0));
				}
			}
			else {
				Abresize.getSizeInfo(fieldCounter.like(),this.controlQueue.pos);
				this.controlQueue.put(this.controlQueue.ORDER().ascend(this.controlQueue.id));
				CRun._assert(!(CError.errorCode()!=0));
			}
		}
		this.resizeCalled.setValue(Constants.FALSE);
	}
	public ClarionNumber resize()
	{
		return this.resize(Clarion.newNumber(0));
	}
	public ClarionNumber resize(ClarionNumber control)
	{
		Positiongroup currentSize=new Positiongroup();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber saveDefer=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		Positiongroup winPos=new Positiongroup();
		Positiongroup winCurrentPos=new Positiongroup();
		this.resizeList.free();
		Abresize.getSizeInfo(control.like(),currentSize);
		if (CWin.getLastField()!=0 && !(currentSize.width.equals(this.previousWin.width) && currentSize.height.equals(this.previousWin.height))) {
			if (this.deferMoves.boolValue()) {
				saveDefer.setValue(ClarionSystem.getInstance().getProperty(Prop.DEFERMOVE));
				ClarionSystem.getInstance().setProperty(Prop.DEFERMOVE,this.controlQueue.records());
			}
			if (currentSize.width.equals(this.origWin.width) && currentSize.height.equals(this.origWin.height)) {
				Abresize.restoreControls(this);
			}
			else {
				if (control.equals(0)) {
					winPos.setValue(this.origWin.getString());
					winPos.xPos.setValue(0);
					winPos.yPos.setValue(0);
					winCurrentPos.setValue(currentSize.getString());
					winCurrentPos.xPos.setValue(0);
					winCurrentPos.yPos.setValue(0);
				}
				else {
					this.getOrigPos(control.like(),winPos);
					this.getCurrentPos(control.like(),winCurrentPos);
				}
				this.resizeChildren(control.like(),winPos,winCurrentPos);
				if (!this.deferMoves.boolValue()) {
					Abresize.setPriorities(this,currentSize);
					if (this.previousWin.width.power(2).add(this.previousWin.height.power(2)).compareTo(currentSize.width.power(2).add(currentSize.height.power(2)))>0) {
						this.resizeList.sort(this.resizeList.ORDER().ascend(this.resizeList.priority));
					}
					else {
						this.resizeList.sort(this.resizeList.ORDER().descend(this.resizeList.priority));
					}
				}
				for (i.setValue(1);i.compareTo(this.resizeList.records())<=0;i.increment(1)) {
					this.resizeList.get(i);
					if (!this.resizeList.before.getString().equals(this.resizeList.after.getString())) {
						Abresize.setSize(this.resizeList.controlID.like(),this.resizeList.after);
					}
				}
			}
			if (this.deferMoves.boolValue()) {
				ClarionSystem.getInstance().setProperty(Prop.DEFERMOVE,saveDefer.compareTo(0)<0 ? saveDefer : Clarion.newNumber(0));
			}
			this.resizeCalled.setValue(Constants.TRUE);
			this.previousWin.setValue(currentSize.getString());
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void resizeChildren(ClarionNumber parentID,Positiongroup parentOrigPos,Positiongroup parentCurrentPos)
	{
		ClarionNumber fieldCounter=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		Resizequeue resizeList=null;
		Positiongroup pOrigPos=new Positiongroup();
		Positiongroup pNewPos=new Positiongroup();
		resizeList=this.resizeList;
		for (fieldCounter.setValue(1);fieldCounter.compareTo(this.controlQueue.records())<=0;fieldCounter.increment(1)) {
			this.controlQueue.get(fieldCounter);
			CRun._assert(!(CError.errorCode()!=0));
			if (this.controlQueue.parentID.equals(parentID)) {
				resizeList.clear();
				resizeList.controlID.setValue(this.controlQueue.id);
				resizeList.type.setValue(this.controlQueue.type);
				Abresize.getSizeInfo(this.controlQueue.id.like(),resizeList.before);
				this.setPosition(resizeList.controlID.like(),parentOrigPos,parentCurrentPos,this.controlQueue.pos,resizeList.after);
				pOrigPos.setValue(this.controlQueue.pos.getString());
				pNewPos.setValue(resizeList.after.getString());
				resizeList.add();
				CRun._assert(!(CError.errorCode()!=0));
				if (!resizeList.before.getString().equals(resizeList.after.getString()) && this.controlQueue.hasChildren.boolValue()) {
					this.resizeChildren(this.controlQueue.id.like(),pOrigPos,pNewPos);
				}
			}
		}
	}
	public void restoreWindow()
	{
		Clarion.getControl(0).setClonedProperty(Prop.MAXIMIZE,this.origWin.maximized);
		Clarion.getControl(0).setClonedProperty(Prop.ICONIZE,this.origWin.iconized);
		CWin.setPosition(0,null,null,this.origWin.width.intValue(),this.origWin.height.intValue());
		Abresize.restoreControls(this);
	}
	public void setParentControl(ClarionNumber p0)
	{
		setParentControl(p0,Clarion.newNumber(0));
	}
	public void setParentControl(ClarionNumber controlID,ClarionNumber parentID)
	{
		if (!controlID.equals(parentID)) {
			this.controlQueue.id.setValue(controlID);
			this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
			if (!(CError.errorCode()!=0)) {
				this.controlQueue.parentID.setValue(parentID);
				this.controlQueue.put();
				CRun._assert(!(CError.errorCode()!=0));
			}
			if (parentID.boolValue()) {
				this.controlQueue.id.setValue(parentID);
				this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
				CRun._assert(!(CError.errorCode()!=0));
				if (!this.controlQueue.hasChildren.boolValue()) {
					this.controlQueue.hasChildren.setValue(Constants.TRUE);
					this.controlQueue.put();
					CRun._assert(!(CError.errorCode()!=0));
				}
			}
		}
	}
	public void setParentDefaults()
	{
		ClarionNumber iPnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		Positiongroup iSize=new Positiongroup();
		ClarionNumber pPnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber thisControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		CRun._assert(this.resizeCalled.equals(Constants.FALSE));
		for (iPnt.setValue(1);iPnt.compareTo(this.controlQueue.records())<=0;iPnt.increment(1)) {
			this.controlQueue.get(iPnt);
			CRun._assert(!(CError.errorCode()!=0));
			CRun._assert(!this.controlQueue.type.equals(Create.TAB));
			thisControl.setValue(this.controlQueue.id);
			if (!Clarion.getControl(thisControl).getProperty(Prop.PARENT).equals(0)) {
				while (Clarion.getControl(Clarion.getControl(thisControl).getProperty(Prop.PARENT)).getProperty(Prop.TYPE).equals(Create.TAB)) {
					thisControl.setValue(Clarion.getControl(thisControl).getProperty(Prop.PARENT));
				}
				this.setParentControl(thisControl.like(),Clarion.getControl(thisControl).getProperty(Prop.PARENT).getNumber());
			}
			else {
				iSize.setValue(this.controlQueue.pos.getString());
				for (pPnt.setValue(1);pPnt.compareTo(this.controlQueue.records())<=0;pPnt.increment(1)) {
					this.controlQueue.get(pPnt);
					CRun._assert(!(CError.errorCode()!=0));
					if (!this.controlQueue.id.equals(thisControl) && CRun.inRange(this.controlQueue.pos.xPos,iSize.xPos,iSize.xPos.add(iSize.width).subtract(1)) && CRun.inRange(this.controlQueue.pos.yPos,iSize.yPos,iSize.yPos.add(iSize.height).subtract(1))) {
						this.setParentControl(this.controlQueue.id.like(),thisControl.like());
					}
				}
			}
		}
	}
	public void setPosition(ClarionNumber controlID,Positiongroup parentOrigPos,Positiongroup parentCurrentPos,Positiongroup origPos,Positiongroup newPos)
	{
		ClarionNumber constBottom=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber constRight=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber constBottomCnt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber constRightCnt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber delta=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber heightLocked=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber origLogicalX=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber origLogicalY=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber widthLocked=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber xPositional=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionDecimal xScale=Clarion.newDecimal(6,4);
		ClarionNumber yPositional=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionDecimal yScale=Clarion.newDecimal(6,4);
		xScale.setValue(parentCurrentPos.width.divide(parentOrigPos.width));
		yScale.setValue(parentCurrentPos.height.divide(parentOrigPos.height));
		CRun._assert(this.controlQueue.id.equals(controlID));
		widthLocked.setValue((this.controlQueue.resizeStrategy.intValue() & Resize.LOCKWIDTH)!=0 ? 1 : 0);
		heightLocked.setValue((this.controlQueue.resizeStrategy.intValue() & Resize.LOCKHEIGHT)!=0 ? 1 : 0);
		constRight.setValue((this.controlQueue.resizeStrategy.intValue() & Resize.CONSTANTRIGHT)!=0 ? 1 : 0);
		constBottom.setValue((this.controlQueue.resizeStrategy.intValue() & Resize.CONSTANTBOTTOM)!=0 ? 1 : 0);
		constRightCnt.setValue((this.controlQueue.resizeStrategy.intValue() & Resize.CONSTANTRIGHTCENTER)!=0 ? 1 : 0);
		constBottomCnt.setValue((this.controlQueue.resizeStrategy.intValue() & Resize.CONSTANTBOTTOMCENTER)!=0 ? 1 : 0);
		xPositional.setValue(this.controlQueue.positionalStrategy.intValue() & 0xff);
		yPositional.setValue(this.controlQueue.positionalStrategy.intValue() & 0xff00);
		origLogicalX.setValue(origPos.xPos.subtract(parentOrigPos.xPos));
		origLogicalY.setValue(origPos.yPos.subtract(parentOrigPos.yPos));
		if (!constRight.boolValue() && !constRightCnt.boolValue()) {
			newPos.width.setValue(widthLocked.equals(Constants.TRUE) ? origPos.width : origPos.width.multiply(xScale));
		}
		if (!constBottom.boolValue() && !constBottomCnt.boolValue()) {
			newPos.height.setValue(heightLocked.equals(Constants.TRUE) ? origPos.height : origPos.height.multiply(yScale));
		}
		if (xPositional.equals(Resize.FIXNEARESTX)) {
			xPositional.setValue(origLogicalX.compareTo(parentOrigPos.width.subtract(origLogicalX).subtract(origPos.width))<0 ? Clarion.newNumber(Resize.FIXLEFT) : Clarion.newNumber(Resize.FIXRIGHT));
		}
		if (yPositional.equals(Resize.FIXNEARESTY)) {
			yPositional.setValue(origLogicalY.compareTo(parentOrigPos.height.subtract(origLogicalY).subtract(origPos.height))<0 ? Clarion.newNumber(Resize.FIXTOP) : Clarion.newNumber(Resize.FIXBOTTOM));
		}
		{
			ClarionNumber case_1=xPositional;
			boolean case_1_break=false;
			if (case_1.equals(Resize.LOCKXPOS)) {
				newPos.xPos.setValue(origPos.xPos);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXRIGHT)) {
				delta.setValue(parentOrigPos.width.subtract(origLogicalX));
				newPos.xPos.setValue(parentCurrentPos.xPos.add(parentCurrentPos.width.subtract(widthLocked.equals(Constants.TRUE) ? delta : delta.multiply(xScale))));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXLEFT)) {
				newPos.xPos.setValue(parentCurrentPos.xPos.add(origLogicalX));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXXCENTER)) {
				delta.setValue(origLogicalX.subtract(parentOrigPos.width.divide(2)));
				newPos.xPos.setValue(parentCurrentPos.xPos.add(parentCurrentPos.width.divide(2).add(widthLocked.equals(Constants.TRUE) ? delta : delta.multiply(xScale))));
				case_1_break=true;
			}
			if (!case_1_break) {
				newPos.xPos.setValue(parentCurrentPos.xPos.add(origLogicalX).multiply(xScale));
			}
		}
		{
			ClarionNumber case_2=yPositional;
			boolean case_2_break=false;
			if (case_2.equals(Resize.LOCKYPOS)) {
				newPos.yPos.setValue(origPos.yPos);
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Resize.FIXBOTTOM)) {
				delta.setValue(parentOrigPos.height.subtract(origLogicalY));
				newPos.yPos.setValue(parentCurrentPos.yPos.add(parentCurrentPos.height.subtract(heightLocked.equals(Constants.TRUE) ? delta : delta.multiply(yScale))));
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Resize.FIXTOP)) {
				newPos.yPos.setValue(parentCurrentPos.yPos.add(origLogicalY));
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Resize.FIXYCENTER)) {
				delta.setValue(origLogicalY.subtract(parentOrigPos.height.divide(2)));
				newPos.yPos.setValue(parentCurrentPos.yPos.add(parentCurrentPos.height.divide(2).add(heightLocked.equals(Constants.TRUE) ? delta : delta.multiply(yScale))));
				case_2_break=true;
			}
			if (!case_2_break) {
				newPos.yPos.setValue(parentCurrentPos.yPos.add(origLogicalY).multiply(yScale));
			}
		}
		if (constRight.boolValue()) {
			newPos.width.setValue(parentCurrentPos.xPos.add(parentCurrentPos.width).subtract(parentOrigPos.width.subtract(origLogicalX).subtract(origPos.width)).subtract(newPos.xPos));
		}
		else if (constRightCnt.boolValue()) {
			newPos.width.setValue(origPos.width.add(parentCurrentPos.xPos.add(parentCurrentPos.width).subtract(parentOrigPos.width.subtract(origLogicalX)).subtract(newPos.xPos).divide(2)));
		}
		if (constBottom.boolValue()) {
			newPos.height.setValue(parentCurrentPos.yPos.add(parentCurrentPos.height).subtract(parentOrigPos.height.subtract(origLogicalY).subtract(origPos.height)).subtract(newPos.yPos));
		}
		else if (constBottomCnt.boolValue()) {
			newPos.height.setValue(origPos.height.add(parentCurrentPos.yPos.add(parentCurrentPos.height).subtract(parentOrigPos.height.subtract(origLogicalY)).subtract(newPos.yPos).divide(2)));
		}
	}
	public void setStrategy(ClarionNumber srcCtrl,ClarionNumber destCtrl)
	{
		ClarionNumber posStrat=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber resStrat=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.controlQueue.id.setValue(srcCtrl);
		this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
		if (!(CError.errorCode()!=0)) {
			posStrat.setValue(this.controlQueue.positionalStrategy);
			resStrat.setValue(this.controlQueue.resizeStrategy);
			this.setStrategy(destCtrl.like(),posStrat.like(),resStrat.like());
		}
	}
	public void setStrategy(ClarionNumber controlID,ClarionNumber positionalStrategy,ClarionNumber resizeStrategy)
	{
		ClarionNumber fieldCounter=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (!controlID.boolValue()) {
			for (fieldCounter.setValue(1);fieldCounter.compareTo(this.controlQueue.records())<=0;fieldCounter.increment(1)) {
				this.controlQueue.get(fieldCounter);
				CRun._assert(!(CError.errorCode()!=0));
				setStrategy_AddStrategy(positionalStrategy,resizeStrategy);
			}
		}
		else {
			this.controlQueue.id.setValue(controlID);
			this.controlQueue.get(this.controlQueue.ORDER().ascend(this.controlQueue.id));
			if (CError.errorCode()!=0) {
				CRun._assert(!Clarion.getControl(controlID).getProperty(Prop.INTOOLBAR).boolValue());
				CRun._assert(CRun.inRange(Clarion.getControl(controlID).getProperty(Prop.TYPE),Clarion.newNumber(1),Clarion.newNumber(Create.TOOLBAR-1)));
				CRun._assert(!this.controlQueue.type.equals(Create.MENU));
				CRun._assert(!this.controlQueue.type.equals(Create.ITEM));
				this.controlQueue.id.setValue(controlID);
				this.controlQueue.type.setValue(Clarion.getControl(controlID).getProperty(Prop.TYPE));
				this.controlQueue.hasChildren.setValue(Constants.FALSE);
				Abresize.getSizeInfo(controlID.like(),this.controlQueue.pos);
				this.controlQueue.add(this.controlQueue.ORDER().ascend(this.controlQueue.id));
				CRun._assert(!(CError.errorCode()!=0));
			}
			setStrategy_AddStrategy(positionalStrategy,resizeStrategy);
		}
	}
	public void setStrategy_AddStrategy(ClarionNumber positionalStrategy,ClarionNumber resizeStrategy)
	{
		this.controlQueue.positionalStrategy.setValue(positionalStrategy);
		this.controlQueue.resizeStrategy.setValue(resizeStrategy);
		this.controlQueue.put();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public ClarionNumber takeResize()
	{
		return this.resize();
	}
}
