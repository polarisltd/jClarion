package clarion.rescode;

import clarion.Controlpostype;
import clarion.Controlqueuetype;
import clarion.Main;
import clarion.equates.Create;
import clarion.equates.Prop;
import clarion.equates.Resize;
import clarion.rescode.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Windowresizetype
{
	public Controlpostype origwin=new Controlpostype();
	public Controlpostype previouswin=new Controlpostype();
	public Controlqueuetype controlqueue=null;
	public Windowresizetype()
	{
		origwin=new Controlpostype();
		previouswin=new Controlpostype();
		controlqueue=null;
	}

	public void initialize()
	{
		initialize(Clarion.newNumber(0));
	}
	public void initialize(ClarionNumber appstrategy)
	{
		ClarionNumber fieldcounter=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		this.controlqueue=new Controlqueuetype();
		CWin.getPosition(0,this.origwin.xpos,this.origwin.ypos,this.origwin.width,this.origwin.height);
		this.previouswin.setValue(this.origwin.getString());
		final int loop_1=CWin.getLastField();for (fieldcounter.setValue(CWin.getFirstField());fieldcounter.compareTo(loop_1)<=0;fieldcounter.increment(1)) {
			this.controlqueue.type.setValue(Clarion.getControl(fieldcounter).getProperty(Prop.TYPE));
			if (this.controlqueue.type.boolValue() && !(this.controlqueue.type.equals(Create.MENU) || this.controlqueue.type.equals(Create.ITEM))) {
				this.controlqueue.id.setValue(fieldcounter);
				CWin.getPosition(fieldcounter.intValue(),this.controlqueue.pos.xpos,this.controlqueue.pos.ypos,this.controlqueue.pos.width,this.controlqueue.pos.height);
				{
					ClarionNumber case_1=appstrategy;
					boolean case_1_break=false;
					if (case_1.equals(1)) {
						initialize_resizestrategy();
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(2)) {
						initialize_spreadstrategy();
						case_1_break=true;
					}
					if (!case_1_break) {
						this.controlqueue.positionalstrategy.setValue(0);
						this.controlqueue.resizestrategy.setValue(0);
					}
				}
				this.controlqueue.add();
			}
		}
		this.controlqueue.sort(this.controlqueue.ORDER().ascend(this.controlqueue.id));
	}
	public void initialize_resizestrategy()
	{
		this.controlqueue.positionalstrategy.setValue(0);
		this.controlqueue.resizestrategy.setValue(0);
	}
	public void initialize_spreadstrategy()
	{
		{
			ClarionNumber case_1=this.controlqueue.type;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Create.BUTTON)) {
				this.controlqueue.positionalstrategy.setValue(Resize.FIXNEARESTX+Resize.FIXNEARESTY);
				this.controlqueue.resizestrategy.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Create.RADIO)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Create.CHECK)) {
				this.controlqueue.positionalstrategy.setValue(0);
				this.controlqueue.resizestrategy.setValue(Resize.LOCKWIDTH+Resize.LOCKHEIGHT);
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Create.ENTRY)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Create.COMBO)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Create.SPIN)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Create.DROPCOMBO)) {
				this.controlqueue.positionalstrategy.setValue(0);
				this.controlqueue.resizestrategy.setValue(Resize.LOCKHEIGHT);
				case_1_break=true;
			}
			if (!case_1_break) {
				this.controlqueue.positionalstrategy.setValue(0);
				this.controlqueue.resizestrategy.setValue(0);
			}
		}
	}
	public void resize()
	{
		Controlpostype currentsize=new Controlpostype();
		Controlpostype newsize=new Controlpostype();
		ClarionDecimal xscale=Clarion.newDecimal(6,4);
		ClarionDecimal yscale=Clarion.newDecimal(6,4);
		ClarionNumber fieldcounter=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber delta=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber savedefermove=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber xpositional=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber ypositional=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		savedefermove.setValue(Main.system.getProperty(Prop.DEFERMOVE));
		CWin.getPosition(0,currentsize.xpos,currentsize.ypos,currentsize.width,currentsize.height);
		if (currentsize.width.equals(this.previouswin.width) && currentsize.height.equals(this.previouswin.height)) {
			return;
		}
		else {
			this.previouswin.setValue(currentsize.getString());
		}
		xscale.setValue(currentsize.width.divide(this.origwin.width));
		yscale.setValue(currentsize.height.divide(this.origwin.height));
		Main.system.setProperty(Prop.DEFERMOVE,this.controlqueue.records());
		final int loop_1=this.controlqueue.records();for (fieldcounter.setValue(1);fieldcounter.compareTo(loop_1)<=0;fieldcounter.increment(1)) {
			this.controlqueue.get(fieldcounter);
			newsize.xpos.setValue(this.controlqueue.pos.xpos.multiply(xscale));
			newsize.ypos.setValue(this.controlqueue.pos.ypos.multiply(yscale));
			if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKWIDTH)!=0) {
				newsize.width.setValue(this.controlqueue.pos.width);
			}
			else {
				newsize.width.setValue(this.controlqueue.pos.width.multiply(xscale));
			}
			if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKHEIGHT)!=0) {
				newsize.height.setValue(this.controlqueue.pos.height);
			}
			else {
				newsize.height.setValue(this.controlqueue.pos.height.multiply(yscale));
			}
			xpositional.setValue(this.controlqueue.positionalstrategy.intValue() & Mconstants.LOMASK);
			ypositional.setValue(this.controlqueue.positionalstrategy.intValue() & Mconstants.HIMASK);
			resize_derivestrategy(xpositional,ypositional);
			if (!xscale.equals(1)) {
				resize_calcxpos(xpositional,newsize,delta,currentsize,xscale);
			}
			if (!yscale.equals(1)) {
				resize_calcypos(ypositional,newsize,delta,currentsize,yscale);
			}
			if (this.controlqueue.type.equals(Create.SSTRING) && this.controlqueue.pos.width.equals(1)) {
				CWin.setPosition(this.controlqueue.id.intValue(),newsize.xpos.intValue(),newsize.ypos.intValue(),null,newsize.height.intValue());
			}
			else {
				CWin.setPosition(this.controlqueue.id.intValue(),newsize.xpos.intValue(),newsize.ypos.intValue(),newsize.width.intValue(),newsize.height.intValue());
			}
		}
		if (savedefermove.compareTo(0)<0) {
			Main.system.setClonedProperty(Prop.DEFERMOVE,savedefermove);
		}
	}
	public void resize_calcxpos(ClarionNumber xpositional,Controlpostype newsize,ClarionNumber delta,Controlpostype currentsize,ClarionDecimal xscale)
	{
		{
			ClarionNumber case_1=xpositional;
			boolean case_1_break=false;
			if (case_1.equals(Resize.LOCKXPOS)) {
				newsize.xpos.setValue(this.controlqueue.pos.xpos);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXRIGHT)) {
				delta.setValue(this.origwin.width.subtract(this.controlqueue.pos.xpos));
				if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKWIDTH)!=0) {
					newsize.xpos.setValue(currentsize.width.subtract(delta));
				}
				else {
					newsize.xpos.setValue(currentsize.width.subtract(delta.multiply(xscale)));
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXLEFT)) {
				delta.setValue(this.controlqueue.pos.xpos);
				if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKWIDTH)!=0) {
					newsize.xpos.setValue(delta);
				}
				else {
					newsize.xpos.setValue(delta.multiply(xscale));
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXXCENTRE)) {
				delta.setValue(this.controlqueue.pos.xpos.subtract(this.origwin.width.divide(2)));
				if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKWIDTH)!=0) {
					newsize.xpos.setValue(currentsize.width.divide(2).add(delta));
				}
				else {
					newsize.xpos.setValue(currentsize.width.divide(2).add(delta.multiply(xscale)));
				}
				case_1_break=true;
			}
		}
	}
	public void resize_calcypos(ClarionNumber ypositional,Controlpostype newsize,ClarionNumber delta,Controlpostype currentsize,ClarionDecimal yscale)
	{
		{
			ClarionNumber case_1=ypositional;
			boolean case_1_break=false;
			if (case_1.equals(Resize.LOCKYPOS)) {
				newsize.ypos.setValue(this.controlqueue.pos.ypos);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXBOTTOM)) {
				delta.setValue(this.origwin.height.subtract(this.controlqueue.pos.ypos));
				if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKHEIGHT)!=0) {
					newsize.ypos.setValue(currentsize.height.subtract(delta));
				}
				else {
					newsize.ypos.setValue(currentsize.height.subtract(delta.multiply(yscale)));
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXTOP)) {
				delta.setValue(this.controlqueue.pos.ypos);
				if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKHEIGHT)!=0) {
					newsize.ypos.setValue(delta);
				}
				else {
					newsize.ypos.setValue(delta.multiply(yscale));
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Resize.FIXYCENTRE)) {
				delta.setValue(this.controlqueue.pos.ypos.subtract(this.origwin.height.divide(2)));
				if ((this.controlqueue.resizestrategy.intValue() & Resize.LOCKHEIGHT)!=0) {
					newsize.ypos.setValue(currentsize.height.divide(2).add(delta));
				}
				else {
					newsize.ypos.setValue(currentsize.height.divide(2).add(delta.multiply(yscale)));
				}
				case_1_break=true;
			}
		}
	}
	public void resize_derivestrategy(ClarionNumber xpositional,ClarionNumber ypositional)
	{
		if (xpositional.equals(Resize.FIXNEARESTX)) {
			xpositional.setValue(this.controlqueue.pos.xpos.compareTo(this.origwin.width.subtract(this.controlqueue.pos.xpos).subtract(this.controlqueue.pos.width))<=0 ? Clarion.newNumber(Resize.FIXLEFT) : Clarion.newNumber(Resize.FIXRIGHT));
		}
		if (ypositional.equals(Resize.FIXNEARESTY)) {
			ypositional.setValue(this.controlqueue.pos.ypos.compareTo(this.origwin.height.subtract(this.controlqueue.pos.ypos).subtract(this.controlqueue.pos.height))<=0 ? Clarion.newNumber(Resize.FIXTOP) : Clarion.newNumber(Resize.FIXBOTTOM));
		}
	}
	public void destroy()
	{
		//this.controlqueue;
	}
	public void setcontrolstrategy(ClarionNumber p1,ClarionNumber p2)
	{
		setcontrolstrategy(Clarion.newNumber(0),p1,p2);
	}
	public void setcontrolstrategy(ClarionNumber controlid,ClarionNumber positionalstrategy,ClarionNumber resizestrategy)
	{
		ClarionNumber fieldcounter=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (!controlid.boolValue()) {
			final int loop_1=this.controlqueue.records();for (fieldcounter.setValue(1);fieldcounter.compareTo(loop_1)<=0;fieldcounter.increment(1)) {
				this.controlqueue.get(fieldcounter);
				setcontrolstrategy_setstrategy(positionalstrategy,resizestrategy);
			}
		}
		else {
			this.controlqueue.id.setValue(controlid);
			this.controlqueue.get(this.controlqueue.ORDER().ascend(this.controlqueue.id));
			if (!(CError.errorCode()!=0)) {
				setcontrolstrategy_setstrategy(positionalstrategy,resizestrategy);
			}
		}
	}
	public void setcontrolstrategy_setstrategy(ClarionNumber positionalstrategy,ClarionNumber resizestrategy)
	{
		this.controlqueue.positionalstrategy.setValue(positionalstrategy);
		this.controlqueue.resizestrategy.setValue(resizestrategy);
		this.controlqueue.put();
	}
}
