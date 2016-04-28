package clarion.abreport;

import clarion.abreport.Printpreviewclass_2;
import clarion.abreport.equates.Mconstants;
import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Pagemanagerclass
{
	public Printpreviewclass_2 pp=null;
	public ClarionDecimal aspectratio=Clarion.newDecimal(8,4);
	public ClarionNumber imagefeq=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber borderfeq=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber imagewidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber imageheight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber xpos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber ypos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber height=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionString filename=null;
	public ClarionNumber centreonx=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber centreony=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Pagemanagerclass neighbour=null;
	public ClarionNumber pageno=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber zoomstate=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public Pagemanagerclass()
	{
		pp=null;
		aspectratio=Clarion.newDecimal(8,4);
		imagefeq=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		borderfeq=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		imagewidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		imageheight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		xpos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ypos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		width=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		height=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		filename=null;
		centreonx=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		centreony=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		neighbour=null;
		pageno=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		zoomstate=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	}

	public ClarionNumber coordcontained(ClarionNumber x,ClarionNumber y)
	{
		if (this.zoomstate.equals(Mconstants.NOZOOM)) {
			if (CRun.inRange(x.subtract(Clarion.getControl(this.imagefeq).getProperty(Prop.XPOS)),Clarion.newNumber(0),Clarion.getControl(this.imagefeq).getProperty(Prop.WIDTH)) && CRun.inRange(y.subtract(Clarion.getControl(this.imagefeq).getProperty(Prop.YPOS)),Clarion.newNumber(0),Clarion.getControl(this.imagefeq).getProperty(Prop.HEIGHT))) {
				return this.pageno.like();
			}
		}
		else {
			if (CRun.inRange(x,Clarion.newNumber(0),Clarion.getControl(this.imagefeq).getProperty(Prop.WIDTH)) && CRun.inRange(y,Clarion.newNumber(0),Clarion.getControl(this.imagefeq).getProperty(Prop.HEIGHT))) {
				return this.pageno.like();
			}
		}
		if (!(this.neighbour==null)) {
			return this.neighbour.coordcontained(x.like(),y.like());
		}
		return Clarion.newNumber(0);
	}
	public void delete()
	{
		if (!(this.neighbour==null)) {
			this.neighbour.delete();
		}
		this.delete(this.pageno.like());
	}
	public void delete(ClarionNumber pageno)
	{
		if (this.pageno.equals(pageno)) {
			CWin.removeControl(this.imagefeq.intValue());
			CWin.removeControl(this.borderfeq.intValue());
			this.zoomstate.setValue(Mconstants.NOZOOM);
		}
		else if (!(this.neighbour==null)) {
			this.neighbour.delete(pageno.like());
		}
	}
	public void draw(ClarionNumber p0)
	{
		draw(p0,Clarion.newNumber(Mconstants.NOZOOM));
	}
	public void draw(ClarionNumber pageno,ClarionNumber zoomfactor)
	{
		ClarionDecimal zoommodifier=Clarion.newDecimal(8,4);
		ClarionNumber twidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber theight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber winwidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber winheight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (this.pageno.equals(pageno)) {
			if (!Clarion.getControl(this.borderfeq).getProperty(Prop.TYPE).equals(Create.BOX)) {
				CWin.createControl(this.borderfeq.intValue(),Create.BOX,null,null);
				CWin.createControl(this.imagefeq.intValue(),Create.IMAGE,null,null);
				Clarion.getControl(this.borderfeq).setProperty(Prop.COLOR,Color.BLACK);
				Clarion.getControl(this.borderfeq).setProperty(Prop.FILL,Color.WHITE);
				Clarion.getControl(this.imagefeq).setProperty(Prop.CURSOR,Cursor.ZOOM);
				Clarion.getControl(this.imagefeq).setProperty(Prop.COLOR,Color.WHITE);
				Clarion.getControl(this.imagefeq).setProperty(Prop.ALRT,250,Constants.MOUSELEFT);
				Clarion.getControl(this.imagefeq).setClonedProperty(Prop.TEXT,this.filename);
			}
			if (zoomfactor.equals(Mconstants.NOZOOM)) {
				Clarion.getControl(this.imagefeq).setClonedProperty(Prop.MAXWIDTH,this.width);
				Clarion.getControl(this.imagefeq).setClonedProperty(Prop.MAXHEIGHT,this.height);
				Clarion.getControl(this.imagefeq).setProperty(Prop.VSCROLL,Constants.FALSE);
				Clarion.getControl(this.imagefeq).setProperty(Prop.HSCROLL,Constants.FALSE);
				if (!this.pp.inpagelist(this.pageno.like()).boolValue()) {
					Clarion.getControl(this.borderfeq).setProperty(Prop.FILL,Color.GRAY);
					Clarion.getControl(this.imagefeq).setProperty(Prop.TEXT,"");
				}
				else {
					Clarion.getControl(this.borderfeq).setProperty(Prop.FILL,Color.WHITE);
					Clarion.getControl(this.imagefeq).setClonedProperty(Prop.TEXT,this.filename);
				}
				CWin.setPosition(this.borderfeq.intValue(),this.xpos.intValue(),this.ypos.intValue(),this.width.intValue(),this.height.intValue());
				CWin.setPosition(this.imagefeq.intValue(),this.xpos.intValue(),this.ypos.intValue(),this.width.intValue(),this.height.intValue());
				CWin.unhide(this.borderfeq.intValue());
				CWin.unhide(this.imagefeq.intValue());
			}
			else {
				winwidth.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTWIDTH));
				winheight.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTHEIGHT));
				zoommodifier.setValue(zoomfactor.equals(Mconstants.PAGEWIDTH) ? winwidth.divide(this.imagewidth) : zoomfactor.divide(100));
				twidth.setValue(this.imagewidth.multiply(zoommodifier));
				theight.setValue(this.imageheight.multiply(zoommodifier));
				CWin.unhide(this.imagefeq.intValue());
				Clarion.getControl(this.imagefeq).setClonedProperty(Prop.MAXWIDTH,twidth);
				Clarion.getControl(this.imagefeq).setClonedProperty(Prop.MAXHEIGHT,theight);
				CWin.setPosition(this.imagefeq.intValue(),0,0,(twidth.compareTo(winwidth)<=0 ? twidth : winwidth).intValue(),(theight.compareTo(winheight)<=0 ? theight : winheight).intValue());
				CWin.setPosition(this.borderfeq.intValue(),0,0,(twidth.compareTo(winwidth)<=0 ? twidth : winwidth).intValue(),(theight.compareTo(winheight)<=0 ? theight : winheight).intValue());
				Clarion.getControl(this.imagefeq).setProperty(Prop.HSCROLL,twidth.compareTo(winwidth)>0 ? 1 : 0);
				Clarion.getControl(this.imagefeq).setProperty(Prop.VSCROLL,theight.compareTo(winheight)>0 ? 1 : 0);
				Clarion.getControl(this.borderfeq).setProperty(Prop.HIDE,theight.compareTo(winheight)>0 && twidth.compareTo(winwidth)>0 ? 1 : 0);
				if (CWin.event()!=Event.SIZED) {
					if (Clarion.getControl(this.imagefeq).getProperty(Prop.VSCROLL).boolValue()) {
						Clarion.getControl(this.imagefeq).setProperty(Prop.VSCROLLPOS,Clarion.newNumber(255).multiply(this.centreony.divide(100)));
					}
					if (Clarion.getControl(this.imagefeq).getProperty(Prop.HSCROLL).boolValue()) {
						Clarion.getControl(this.imagefeq).setProperty(Prop.HSCROLLPOS,Clarion.newNumber(255).multiply(this.centreonx.divide(100)));
					}
				}
			}
			this.centreonx.setValue(0);
			this.centreony.setValue(0);
			this.zoomstate.setValue(zoomfactor);
		}
		else if (!(this.neighbour==null)) {
			this.neighbour.draw(pageno.like(),zoomfactor.like());
		}
	}
	public ClarionNumber exists(ClarionNumber pageno)
	{
		if (this.pageno.equals(pageno)) {
			return Clarion.newNumber(Constants.TRUE);
		}
		else if (!(this.neighbour==null)) {
			return this.neighbour.exists(pageno.like());
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionString getprop(ClarionNumber pageno,ClarionNumber prop)
	{
		if (this.pageno.equals(pageno)) {
			return Clarion.getControl(this.imagefeq).getProperty(prop).getString();
		}
		else if (!(this.neighbour==null)) {
			return this.neighbour.getprop(pageno.like(),prop.like());
		}
		return Clarion.newString(String.valueOf(0));
	}
	public void highlight(ClarionNumber pageno)
	{
		if (Clarion.getControl(this.borderfeq).getProperty(Prop.TYPE).equals(Create.BOX)) {
			Clarion.getControl(this.borderfeq).setProperty(Prop.COLOR,this.pageno.equals(pageno) ? Clarion.newNumber(Color.RED) : Clarion.newNumber(Color.BLACK));
		}
		if (!(this.neighbour==null)) {
			this.neighbour.highlight(pageno.like());
		}
	}
	public void init(Printpreviewclass_2 p,ClarionNumber pageno,ClarionNumber pbasefeq,ClarionString fname)
	{
		this.pp=p;
		this.filename=Clarion.newString(fname.clip().len());
		this.filename.setValue(fname);
		this.borderfeq.setValue(pbasefeq);
		this.imagefeq.setValue(pbasefeq.add(1));
		this.pageno.setValue(pageno);
		CWin.createControl(Mconstants.TEMPIMAGE,Create.IMAGE,null,null);
		Clarion.getControl(Mconstants.TEMPIMAGE).setClonedProperty(Prop.TEXT,this.filename);
		this.imagewidth.setValue(Clarion.getControl(Mconstants.TEMPIMAGE).getProperty(Prop.MAXWIDTH));
		this.imageheight.setValue(Clarion.getControl(Mconstants.TEMPIMAGE).getProperty(Prop.MAXHEIGHT));
		CWin.removeControl(Mconstants.TEMPIMAGE);
		this.aspectratio.setValue(this.imageheight.divide(this.imagewidth));
	}
	public void init(Printpreviewclass_2 p,ClarionNumber pageno,ClarionNumber pbasefeq,ClarionString fname,ClarionNumber x,ClarionNumber y,ClarionNumber wid,ClarionNumber hgt)
	{
		this.init(p,pageno.like(),pbasefeq.like(),fname);
		this.setposition(this.pageno.like(),x.like(),y.like(),wid.like(),hgt.like());
	}
	public void kill()
	{
		if (!(this.neighbour==null)) {
			this.neighbour.kill();
			//this.neighbour;
		}
		CWin.removeControl(this.imagefeq.intValue());
		CWin.removeControl(this.borderfeq.intValue());
		//this.filename;
	}
	public void setcentre(ClarionNumber pageno,ClarionNumber x,ClarionNumber y)
	{
		this.centreonx.setValue(this.pageno.equals(pageno) ? x : Clarion.newNumber(0));
		this.centreony.setValue(this.pageno.equals(pageno) ? y : Clarion.newNumber(0));
		if (!(this.neighbour==null)) {
			this.neighbour.setcentre(pageno.like(),x.like(),y.like());
		}
	}
	public void setposition(ClarionNumber pageno,ClarionNumber x,ClarionNumber y,ClarionNumber w,ClarionNumber h)
	{
		if (this.pageno.equals(pageno)) {
			this.xpos.setValue(x);
			this.ypos.setValue(y);
			if (h.divide(w).compareTo(this.aspectratio)<0) {
				w.setValue(h.divide(this.aspectratio));
			}
			else {
				h.setValue(w.multiply(this.aspectratio));
			}
			this.width.setValue(w);
			this.height.setValue(h);
			if (Clarion.getControl(this.borderfeq).getProperty(Prop.TYPE).equals(Create.BOX)) {
				CWin.setPosition(this.borderfeq.intValue(),x.intValue(),y.intValue(),w.intValue(),h.intValue());
			}
			if (Clarion.getControl(this.imagefeq).getProperty(Prop.TYPE).equals(Create.IMAGE)) {
				CWin.setPosition(this.imagefeq.intValue(),x.intValue(),y.intValue(),w.intValue(),h.intValue());
			}
		}
		else if (!(this.neighbour==null)) {
			this.neighbour.setposition(pageno.like(),x.like(),y.like(),w.like(),h.like());
		}
	}
}
