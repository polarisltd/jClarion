package clarion.abresize;

import clarion.Controlqueue;
import clarion.Positiongroup;
import clarion.Resizequeue;
import clarion.Windowpositiongroup;
import clarion.abresize.Abresize;
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

@SuppressWarnings("all")
public class Windowresizeclass
{
	public ClarionNumber appstrategy=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber autotransparent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Windowpositiongroup origwin=new Windowpositiongroup();
	public Controlqueue controlqueue=null;
	public ClarionNumber defermoves=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Positiongroup previouswin=new Positiongroup();
	public ClarionNumber resizecalled=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
	public Resizequeue resizelist=null;
	public Windowresizeclass()
	{
		appstrategy=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		autotransparent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		origwin=new Windowpositiongroup();
		controlqueue=null;
		defermoves=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		previouswin=new Positiongroup();
		resizecalled=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		resizelist=null;
	}

	public ClarionNumber getparentcontrol(ClarionNumber controlid)
	{
		this.controlqueue.id.setValue(controlid);
		this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
		CRun._assert(!(CError.errorCode()!=0));
		return this.controlqueue.parentid.like();
	}
	public ClarionNumber getpositionstrategy(ClarionNumber p0)
	{
		return getpositionstrategy(p0,(ClarionNumber)null);
	}
	public ClarionNumber getpositionstrategy(ClarionNumber controltype,ClarionNumber appstrategy)
	{
		ClarionNumber appstrat=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rval=Clarion.newNumber(Resize.REPOSITION).setEncoding(ClarionNumber.USHORT);
		appstrat.setValue(Clarion.newBool(appstrategy==null).equals(Constants.TRUE) ? this.appstrategy : appstrategy);
		{
			ClarionNumber case_1=appstrat;
			boolean case_1_break=false;
			if (case_1.equals(Appstrategy.NORESIZE)) {
				rval.setValue(Resize.LOCKXPOS+Resize.LOCKYPOS);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SPREAD)) {
				if (controltype.equals(Create.BUTTON)) {
					rval.setValue(Resize.FIXNEARESTX+Resize.FIXNEARESTY);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SURFACE)) {
				{
					ClarionNumber case_2=controltype;
					boolean case_2_break=false;
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2.equals(Create.BUTTON)) {
						rval.setValue(Resize.FIXNEARESTX+Resize.FIXNEARESTY);
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
						rval.setValue(Resize.FIXTOP);
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
						rval.setValue(Resize.FIXLEFT+Resize.FIXTOP);
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
		}
		return rval.like();
	}
	public ClarionNumber getresizestrategy(ClarionNumber p0)
	{
		return getresizestrategy(p0,(ClarionNumber)null);
	}
	public ClarionNumber getresizestrategy(ClarionNumber controltype,ClarionNumber appstrategy)
	{
		ClarionNumber appstrat=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rval=Clarion.newNumber(Resize.RESIZE).setEncoding(ClarionNumber.USHORT);
		appstrat.setValue(Clarion.newBool(appstrategy==null).equals(Constants.TRUE) ? this.appstrategy : appstrategy);
		{
			ClarionNumber case_1=appstrat;
			boolean case_1_break=false;
			if (case_1.equals(Appstrategy.NORESIZE)) {
				rval.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SPREAD)) {
				{
					ClarionNumber case_2=this.controlqueue.type;
					boolean case_2_break=false;
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2.equals(Create.BUTTON)) {
						rval.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2.equals(Create.RADIO)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Create.CHECK)) {
						rval.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
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
						rval.setValue(Resize.LOCKHEIGHT);
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Appstrategy.SURFACE)) {
				{
					ClarionNumber case_3=this.controlqueue.type;
					boolean case_3_break=false;
					boolean case_3_match=false;
					case_3_match=false;
					if (case_3.equals(Create.BUTTON)) {
						rval.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
						case_3_break=true;
					}
					case_3_match=false;
					if (!case_3_break && case_3.equals(Create.RADIO)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Create.CHECK)) {
						rval.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
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
						rval.setValue(Resize.LOCKHEIGHT);
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
						rval.setValue(Resize.CONSTANTRIGHT+Resize.CONSTANTBOTTOM);
						case_3_break=true;
					}
				}
				case_1_break=true;
			}
		}
		return rval.like();
	}
	public ClarionNumber getorigpos(ClarionNumber ctrlid,Positiongroup pg)
	{
		this.controlqueue.id.setValue(ctrlid);
		this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		pg.setValue(this.controlqueue.pos.getString());
		return Clarion.newNumber(Constants.TRUE);
	}
	public ClarionNumber getcurrentpos(ClarionNumber ctrlid,Positiongroup pg)
	{
		this.controlqueue.id.setValue(ctrlid);
		this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		Abresize.getsizeinfo(ctrlid.like(),pg);
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
	public void init(ClarionNumber appstrategy,ClarionNumber setwindowminsize,ClarionNumber setwindowmaxsize)
	{
		this.controlqueue=new Controlqueue();
		this.resizelist=new Resizequeue();
		this.appstrategy.setValue(appstrategy);
		CWin.register(Event.SIZED,new Runnable() { public void run() {takeresize(); } },CMemory.address(this));
		Clarion.getControl(0).setProperty(Prop.IMM,Constants.TRUE);
		this.reset();
		if (appstrategy.equals(Appstrategy.SURFACE)) {
			this.setparentdefaults();
		}
		if (setwindowminsize.boolValue()) {
			Clarion.getControl(0).setClonedProperty(Prop.MINWIDTH,this.origwin.width);
			Clarion.getControl(0).setClonedProperty(Prop.MINHEIGHT,this.origwin.height);
		}
		if (setwindowmaxsize.boolValue()) {
			Clarion.getControl(0).setClonedProperty(Prop.MAXWIDTH,this.origwin.width);
			Clarion.getControl(0).setClonedProperty(Prop.MAXHEIGHT,this.origwin.height);
		}
		this.defermoves.setValue(Constants.TRUE);
	}
	public void kill()
	{
		CWin.unregister(Event.SIZED,new Runnable() { public void run() {takeresize(); } },CMemory.address(this));
		//this.controlqueue;
		//this.resizelist;
	}
	public void removecontrol(ClarionNumber control)
	{
		ClarionNumber delprnt=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		this.controlqueue.id.setValue(control);
		this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
		if (!(CError.errorCode()!=0)) {
			delprnt.setValue(this.controlqueue.parentid);
			this.controlqueue.delete();
			if (!(CError.errorCode()!=0)) {
				this.controlqueue.get(1);
				while (!(CError.errorCode()!=0)) {
					if (this.controlqueue.parentid.equals(control)) {
						this.controlqueue.parentid.setValue(delprnt);
						this.controlqueue.put();
					}
					this.controlqueue.get(this.controlqueue.getPointer()+1);
				}
			}
		}
	}
	public void reset()
	{
		ClarionNumber fieldcounter=Clarion.newNumber(0).setEncoding(ClarionNumber.SIGNED);
		Abresize.getsizeinfo(Clarion.newNumber(0),this.origwin);
		this.origwin.maximized.setValue(Clarion.getControl(0).getProperty(Prop.MAXIMIZE));
		this.origwin.iconized.setValue(Clarion.getControl(0).getProperty(Prop.ICONIZE));
		this.previouswin.setValue(this.origwin.getString());
		while (true) {
			fieldcounter.setValue(Clarion.getControl(0).getProperty(Prop.NEXTFIELD,fieldcounter));
			if (!fieldcounter.boolValue()) {
				break;
			}
			this.controlqueue.id.setValue(fieldcounter);
			this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
			if (CError.errorCode()!=0) {
				this.controlqueue.type.setValue(Clarion.getControl(fieldcounter).getProperty(Prop.TYPE));
				this.controlqueue.haschildren.setValue(Constants.FALSE);
				if (!Clarion.getControl(fieldcounter).getProperty(Prop.INTOOLBAR).boolValue() && CRun.inRange(this.controlqueue.type,Clarion.newNumber(1),Clarion.newNumber(Create.TOOLBAR-1)) && !CRun.inlist(this.controlqueue.type.toString(),new ClarionString[] {Clarion.newString(String.valueOf(Create.MENU)),Clarion.newString(String.valueOf(Create.ITEM)),Clarion.newString(String.valueOf(Create.TAB))}).boolValue()) {
					this.controlqueue.id.setValue(fieldcounter);
					Abresize.getsizeinfo(fieldcounter.like(),this.controlqueue.pos);
					if (this.controlqueue.type.equals(Create.LIST) && Clarion.getControl(this.controlqueue.id).getProperty(Prop.DROP).boolValue()) {
						this.controlqueue.type.setValue(Create.ENTRY);
					}
					this.controlqueue.positionalstrategy.setValue(this.getpositionstrategy(this.controlqueue.type.like()));
					this.controlqueue.resizestrategy.setValue(this.getresizestrategy(this.controlqueue.type.like()));
					this.controlqueue.parentid.setValue(0);
					this.controlqueue.add(this.controlqueue.ORDER().ascend(this.controlqueue.id));
					CRun._assert(!(CError.errorCode()!=0));
				}
			}
			else {
				Abresize.getsizeinfo(fieldcounter.like(),this.controlqueue.pos);
				this.controlqueue.put(this.controlqueue.ORDER().ascend(this.controlqueue.id));
				CRun._assert(!(CError.errorCode()!=0));
			}
		}
		this.resizecalled.setValue(Constants.FALSE);
	}
	public ClarionNumber resize()
	{
		return this.resize(Clarion.newNumber(0));
	}
	public ClarionNumber resize(ClarionNumber control)
	{
		Positiongroup currentsize=new Positiongroup();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber savedefer=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		Positiongroup winpos=new Positiongroup();
		Positiongroup wincurrentpos=new Positiongroup();
		this.resizelist.free();
		Abresize.getsizeinfo(control.like(),currentsize);
		if (CWin.getLastField()!=0 && !(currentsize.width.equals(this.previouswin.width) && currentsize.height.equals(this.previouswin.height))) {
			if (this.defermoves.boolValue()) {
				savedefer.setValue(ClarionSystem.getInstance().getProperty(Prop.DEFERMOVE));
				ClarionSystem.getInstance().setProperty(Prop.DEFERMOVE,this.controlqueue.records());
			}
			if (currentsize.width.equals(this.origwin.width) && currentsize.height.equals(this.origwin.height)) {
				Abresize.restorecontrols(this);
			}
			else {
				if (control.equals(0)) {
					winpos.setValue(this.origwin.getString());
					winpos.xpos.setValue(0);
					winpos.ypos.setValue(0);
					wincurrentpos.setValue(currentsize.getString());
					wincurrentpos.xpos.setValue(0);
					wincurrentpos.ypos.setValue(0);
				}
				else {
					this.getorigpos(control.like(),winpos);
					this.getcurrentpos(control.like(),wincurrentpos);
				}
				this.resizechildren(control.like(),winpos,wincurrentpos);
				if (!this.defermoves.boolValue()) {
					Abresize.setpriorities(this,currentsize);
					if (this.previouswin.width.power(2).add(this.previouswin.height.power(2)).compareTo(currentsize.width.power(2).add(currentsize.height.power(2)))>0) {
						this.resizelist.sort(this.resizelist.ORDER().ascend(this.resizelist.priority));
					}
					else {
						this.resizelist.sort(this.resizelist.ORDER().descend(this.resizelist.priority));
					}
				}
				final int loop_1=this.resizelist.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
					this.resizelist.get(i);
					if (!this.resizelist.before.getString().equals(this.resizelist.after.getString())) {
						Abresize.setsize(this.resizelist.controlid.like(),this.resizelist.after);
					}
				}
			}
			if (this.defermoves.boolValue()) {
				ClarionSystem.getInstance().setProperty(Prop.DEFERMOVE,savedefer.compareTo(0)<0 ? savedefer : Clarion.newNumber(0));
			}
			this.resizecalled.setValue(Constants.TRUE);
			this.previouswin.setValue(currentsize.getString());
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void resizechildren(ClarionNumber parentid,Positiongroup parentorigpos,Positiongroup parentcurrentpos)
	{
		ClarionNumber fieldcounter=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		Resizequeue resizelist=null;
		Positiongroup porigpos=new Positiongroup();
		Positiongroup pnewpos=new Positiongroup();
		resizelist=this.resizelist;
		final int loop_1=this.controlqueue.records();for (fieldcounter.setValue(1);fieldcounter.compareTo(loop_1)<=0;fieldcounter.increment(1)) {
			this.controlqueue.get(fieldcounter);
			CRun._assert(!(CError.errorCode()!=0));
			if (this.controlqueue.parentid.equals(parentid)) {
				resizelist.clear();
				resizelist.controlid.setValue(this.controlqueue.id);
				resizelist.type.setValue(this.controlqueue.type);
				Abresize.getsizeinfo(this.controlqueue.id.like(),resizelist.before);
				this.setposition(resizelist.controlid.like(),parentorigpos,parentcurrentpos,this.controlqueue.pos,resizelist.after);
				porigpos.setValue(this.controlqueue.pos.getString());
				pnewpos.setValue(resizelist.after.getString());
				resizelist.add();
				CRun._assert(!(CError.errorCode()!=0));
				if (!resizelist.before.getString().equals(resizelist.after.getString()) && this.controlqueue.haschildren.boolValue()) {
					this.resizechildren(this.controlqueue.id.like(),porigpos,pnewpos);
				}
			}
		}
	}
	public void restorewindow()
	{
		Clarion.getControl(0).setClonedProperty(Prop.MAXIMIZE,this.origwin.maximized);
		Clarion.getControl(0).setClonedProperty(Prop.ICONIZE,this.origwin.iconized);
		CWin.setPosition(0,null,null,this.origwin.width.intValue(),this.origwin.height.intValue());
		Abresize.restorecontrols(this);
	}
	public void setparentcontrol(ClarionNumber p0)
	{
		setparentcontrol(p0,Clarion.newNumber(0));
	}
	public void setparentcontrol(ClarionNumber controlid,ClarionNumber parentid)
	{
		if (!controlid.equals(parentid)) {
			this.controlqueue.id.setValue(controlid);
			this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
			if (!(CError.errorCode()!=0)) {
				this.controlqueue.parentid.setValue(parentid);
				this.controlqueue.put();
				CRun._assert(!(CError.errorCode()!=0));
			}
			if (parentid.boolValue()) {
				this.controlqueue.id.setValue(parentid);
				this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
				CRun._assert(!(CError.errorCode()!=0));
				if (!this.controlqueue.haschildren.boolValue()) {
					this.controlqueue.haschildren.setValue(Constants.TRUE);
					this.controlqueue.put();
					CRun._assert(!(CError.errorCode()!=0));
				}
			}
		}
	}
	public void setparentdefaults()
	{
		ClarionNumber ipnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		Positiongroup isize=new Positiongroup();
		ClarionNumber ppnt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber thiscontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		CRun._assert(this.resizecalled.equals(Constants.FALSE));
		final int loop_2=this.controlqueue.records();for (ipnt.setValue(1);ipnt.compareTo(loop_2)<=0;ipnt.increment(1)) {
			this.controlqueue.get(ipnt);
			CRun._assert(!(CError.errorCode()!=0));
			CRun._assert(!this.controlqueue.type.equals(Create.TAB));
			thiscontrol.setValue(this.controlqueue.id);
			if (!Clarion.getControl(thiscontrol).getProperty(Prop.PARENT).equals(0)) {
				while (Clarion.getControl(Clarion.getControl(thiscontrol).getProperty(Prop.PARENT)).getProperty(Prop.TYPE).equals(Create.TAB)) {
					thiscontrol.setValue(Clarion.getControl(thiscontrol).getProperty(Prop.PARENT));
				}
				this.setparentcontrol(thiscontrol.like(),Clarion.getControl(thiscontrol).getProperty(Prop.PARENT).getNumber());
			}
			else {
				isize.setValue(this.controlqueue.pos.getString());
				final int loop_1=this.controlqueue.records();for (ppnt.setValue(1);ppnt.compareTo(loop_1)<=0;ppnt.increment(1)) {
					this.controlqueue.get(ppnt);
					CRun._assert(!(CError.errorCode()!=0));
					if (!this.controlqueue.id.equals(thiscontrol) && CRun.inRange(this.controlqueue.pos.xpos,isize.xpos,isize.xpos.add(isize.width).subtract(1)) && CRun.inRange(this.controlqueue.pos.ypos,isize.ypos,isize.ypos.add(isize.height).subtract(1))) {
						this.setparentcontrol(this.controlqueue.id.like(),thiscontrol.like());
					}
				}
			}
		}
	}
	public void setposition(ClarionNumber controlid,Positiongroup parentorigpos,Positiongroup parentcurrentpos,Positiongroup origpos,Positiongroup newpos)
	{
		ClarionNumber constbottom=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber constright=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber constbottomcnt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber constrightcnt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber delta=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber heightlocked=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber origlogicalx=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber origlogicaly=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber widthlocked=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber xpositional=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionDecimal xscale=Clarion.newDecimal(6,4);
		ClarionNumber ypositional=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionDecimal yscale=Clarion.newDecimal(6,4);
		xscale.setValue(parentcurrentpos.width.divide(parentorigpos.width));
		yscale.setValue(parentcurrentpos.height.divide(parentorigpos.height));
		CRun._assert(this.controlqueue.id.equals(controlid));
		widthlocked.setValue((this.controlqueue.resizestrategy.intValue() & Resize.LOCKWIDTH)!=0 ? 1 : 0);
		heightlocked.setValue((this.controlqueue.resizestrategy.intValue() & Resize.LOCKHEIGHT)!=0 ? 1 : 0);
		constright.setValue((this.controlqueue.resizestrategy.intValue() & Resize.CONSTANTRIGHT)!=0 ? 1 : 0);
		constbottom.setValue((this.controlqueue.resizestrategy.intValue() & Resize.CONSTANTBOTTOM)!=0 ? 1 : 0);
		constrightcnt.setValue((this.controlqueue.resizestrategy.intValue() & Resize.CONSTANTRIGHTCENTER)!=0 ? 1 : 0);
		constbottomcnt.setValue((this.controlqueue.resizestrategy.intValue() & Resize.CONSTANTBOTTOMCENTER)!=0 ? 1 : 0);
		xpositional.setValue(this.controlqueue.positionalstrategy.intValue() & 0xff);
		ypositional.setValue(this.controlqueue.positionalstrategy.intValue() & 0xff00);
		origlogicalx.setValue(origpos.xpos.subtract(parentorigpos.xpos));
		origlogicaly.setValue(origpos.ypos.subtract(parentorigpos.ypos));
		if (!constright.boolValue() && !constrightcnt.boolValue()) {
			newpos.width.setValue(widthlocked.equals(Constants.TRUE) ? origpos.width : origpos.width.multiply(xscale));
		}
		if (!constbottom.boolValue() && !constbottomcnt.boolValue()) {
			newpos.height.setValue(heightlocked.equals(Constants.TRUE) ? origpos.height : origpos.height.multiply(yscale));
		}
		if (xpositional.equals(Resize.FIXNEARESTX)) {
			xpositional.setValue(origlogicalx.compareTo(parentorigpos.width.subtract(origlogicalx).subtract(origpos.width))<0 ? Clarion.newNumber(Resize.FIXLEFT) : Clarion.newNumber(Resize.FIXRIGHT));
		}
		if (ypositional.equals(Resize.FIXNEARESTY)) {
			ypositional.setValue(origlogicaly.compareTo(parentorigpos.height.subtract(origlogicaly).subtract(origpos.height))<0 ? Clarion.newNumber(Resize.FIXTOP) : Clarion.newNumber(Resize.FIXBOTTOM));
		}
		{
			ClarionNumber case_1=xpositional;
			boolean case_1_break=false;
			if (case_1.equals(Resize.LOCKXPOS)) {
				newpos.xpos.setValue(origpos.xpos);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXRIGHT)) {
				delta.setValue(parentorigpos.width.subtract(origlogicalx));
				newpos.xpos.setValue(parentcurrentpos.xpos.add(parentcurrentpos.width.subtract(widthlocked.equals(Constants.TRUE) ? delta : delta.multiply(xscale))));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXLEFT)) {
				newpos.xpos.setValue(parentcurrentpos.xpos.add(origlogicalx));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXXCENTER)) {
				delta.setValue(origlogicalx.subtract(parentorigpos.width.divide(2)));
				newpos.xpos.setValue(parentcurrentpos.xpos.add(parentcurrentpos.width.divide(2).add(widthlocked.equals(Constants.TRUE) ? delta : delta.multiply(xscale))));
				case_1_break=true;
			}
			if (!case_1_break) {
				newpos.xpos.setValue(parentcurrentpos.xpos.add(origlogicalx).multiply(xscale));
			}
		}
		{
			ClarionNumber case_2=ypositional;
			boolean case_2_break=false;
			if (case_2.equals(Resize.LOCKYPOS)) {
				newpos.ypos.setValue(origpos.ypos);
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Resize.FIXBOTTOM)) {
				delta.setValue(parentorigpos.height.subtract(origlogicaly));
				newpos.ypos.setValue(parentcurrentpos.ypos.add(parentcurrentpos.height.subtract(heightlocked.equals(Constants.TRUE) ? delta : delta.multiply(yscale))));
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Resize.FIXTOP)) {
				newpos.ypos.setValue(parentcurrentpos.ypos.add(origlogicaly));
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Resize.FIXYCENTER)) {
				delta.setValue(origlogicaly.subtract(parentorigpos.height.divide(2)));
				newpos.ypos.setValue(parentcurrentpos.ypos.add(parentcurrentpos.height.divide(2).add(heightlocked.equals(Constants.TRUE) ? delta : delta.multiply(yscale))));
				case_2_break=true;
			}
			if (!case_2_break) {
				newpos.ypos.setValue(parentcurrentpos.ypos.add(origlogicaly).multiply(yscale));
			}
		}
		if (constright.boolValue()) {
			newpos.width.setValue(parentcurrentpos.xpos.add(parentcurrentpos.width).subtract(parentorigpos.width.subtract(origlogicalx).subtract(origpos.width)).subtract(newpos.xpos));
		}
		else if (constrightcnt.boolValue()) {
			newpos.width.setValue(origpos.width.add(parentcurrentpos.xpos.add(parentcurrentpos.width).subtract(parentorigpos.width.subtract(origlogicalx)).subtract(newpos.xpos).divide(2)));
		}
		if (constbottom.boolValue()) {
			newpos.height.setValue(parentcurrentpos.ypos.add(parentcurrentpos.height).subtract(parentorigpos.height.subtract(origlogicaly).subtract(origpos.height)).subtract(newpos.ypos));
		}
		else if (constbottomcnt.boolValue()) {
			newpos.height.setValue(origpos.height.add(parentcurrentpos.ypos.add(parentcurrentpos.height).subtract(parentorigpos.height.subtract(origlogicaly)).subtract(newpos.ypos).divide(2)));
		}
	}
	public void setstrategy(ClarionNumber srcctrl,ClarionNumber destctrl)
	{
		ClarionNumber posstrat=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber resstrat=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.controlqueue.id.setValue(srcctrl);
		this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
		if (!(CError.errorCode()!=0)) {
			posstrat.setValue(this.controlqueue.positionalstrategy);
			resstrat.setValue(this.controlqueue.resizestrategy);
			this.setstrategy(destctrl.like(),posstrat.like(),resstrat.like());
		}
	}
	public void setstrategy(ClarionNumber controlid,ClarionNumber positionalstrategy,ClarionNumber resizestrategy)
	{
		ClarionNumber fieldcounter=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (!controlid.boolValue()) {
			final int loop_1=this.controlqueue.records();for (fieldcounter.setValue(1);fieldcounter.compareTo(loop_1)<=0;fieldcounter.increment(1)) {
				this.controlqueue.get(fieldcounter);
				CRun._assert(!(CError.errorCode()!=0));
				setstrategy_addstrategy(positionalstrategy,resizestrategy);
			}
		}
		else {
			this.controlqueue.id.setValue(controlid);
			this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
			if (CError.errorCode()!=0) {
				CRun._assert(!Clarion.getControl(controlid).getProperty(Prop.INTOOLBAR).boolValue());
				CRun._assert(CRun.inRange(Clarion.getControl(controlid).getProperty(Prop.TYPE),Clarion.newNumber(1),Clarion.newNumber(Create.TOOLBAR-1)));
				CRun._assert(!this.controlqueue.type.equals(Create.MENU));
				CRun._assert(!this.controlqueue.type.equals(Create.ITEM));
				this.controlqueue.id.setValue(controlid);
				this.controlqueue.type.setValue(Clarion.getControl(controlid).getProperty(Prop.TYPE));
				this.controlqueue.haschildren.setValue(Constants.FALSE);
				Abresize.getsizeinfo(controlid.like(),this.controlqueue.pos);
				this.controlqueue.add(this.controlqueue.ORDER().ascend(this.controlqueue.id));
				CRun._assert(!(CError.errorCode()!=0));
			}
			setstrategy_addstrategy(positionalstrategy,resizestrategy);
		}
	}
	public void setstrategy_addstrategy(ClarionNumber positionalstrategy,ClarionNumber resizestrategy)
	{
		this.controlqueue.positionalstrategy.setValue(positionalstrategy);
		this.controlqueue.resizestrategy.setValue(resizestrategy);
		this.controlqueue.put();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public ClarionNumber takeresize()
	{
		return this.resize();
	}
}
