package clarion;

import clarion.Printpreviewclass;
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

public class Pagemanagerclass
{
	public Printpreviewclass pp;
	public ClarionDecimal aspectRatio;
	public ClarionNumber imageFeq;
	public ClarionNumber borderFeq;
	public ClarionNumber imageWidth;
	public ClarionNumber imageHeight;
	public ClarionNumber xPos;
	public ClarionNumber yPos;
	public ClarionNumber width;
	public ClarionNumber height;
	public ClarionString filename;
	public ClarionNumber centreOnX;
	public ClarionNumber centreOnY;
	public Pagemanagerclass neighbour;
	public ClarionNumber pageNo;
	public ClarionNumber zoomState;
	public Pagemanagerclass()
	{
		pp=null;
		aspectRatio=Clarion.newDecimal(8,4);
		imageFeq=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		borderFeq=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		imageWidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		imageHeight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		xPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		yPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		width=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		height=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		filename=null;
		centreOnX=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		centreOnY=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		neighbour=null;
		pageNo=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		zoomState=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	}

	public ClarionNumber coordContained(ClarionNumber x,ClarionNumber y)
	{
		if (this.zoomState.equals(Constants.NOZOOM)) {
			if (CRun.inRange(x.subtract(Clarion.getControl(this.imageFeq).getProperty(Prop.XPOS)),Clarion.newNumber(0),Clarion.getControl(this.imageFeq).getProperty(Prop.WIDTH)) && CRun.inRange(y.subtract(Clarion.getControl(this.imageFeq).getProperty(Prop.YPOS)),Clarion.newNumber(0),Clarion.getControl(this.imageFeq).getProperty(Prop.HEIGHT))) {
				return this.pageNo.like();
			}
		}
		else {
			if (CRun.inRange(x,Clarion.newNumber(0),Clarion.getControl(this.imageFeq).getProperty(Prop.WIDTH)) && CRun.inRange(y,Clarion.newNumber(0),Clarion.getControl(this.imageFeq).getProperty(Prop.HEIGHT))) {
				return this.pageNo.like();
			}
		}
		if (!(this.neighbour==null)) {
			return this.neighbour.coordContained(x.like(),y.like());
		}
		return Clarion.newNumber(0);
	}
	public void delete()
	{
		if (!(this.neighbour==null)) {
			this.neighbour.delete();
		}
		this.delete(this.pageNo.like());
	}
	public void delete(ClarionNumber pageNo)
	{
		if (this.pageNo.equals(pageNo)) {
			CWin.removeControl(this.imageFeq.intValue());
			CWin.removeControl(this.borderFeq.intValue());
			this.zoomState.setValue(Constants.NOZOOM);
		}
		else if (!(this.neighbour==null)) {
			this.neighbour.delete(pageNo.like());
		}
	}
	public void draw(ClarionNumber p0)
	{
		draw(p0,Clarion.newNumber(Constants.NOZOOM));
	}
	public void draw(ClarionNumber pageNo,ClarionNumber zoomFactor)
	{
		ClarionDecimal zoomModifier=Clarion.newDecimal(8,4);
		ClarionNumber tWidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber tHeight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber winWidth=tWidth.like();
		ClarionNumber winHeight=tHeight.like();
		if (this.pageNo.equals(pageNo)) {
			if (!Clarion.getControl(this.borderFeq).getProperty(Prop.TYPE).equals(Create.BOX)) {
				CWin.createControl(this.borderFeq.intValue(),Create.BOX,null,null);
				CWin.createControl(this.imageFeq.intValue(),Create.IMAGE,null,null);
				Clarion.getControl(this.borderFeq).setProperty(Prop.COLOR,Color.BLACK);
				Clarion.getControl(this.borderFeq).setProperty(Prop.FILL,Color.WHITE);
				Clarion.getControl(this.imageFeq).setProperty(Prop.CURSOR,Cursor.ZOOM);
				Clarion.getControl(this.imageFeq).setProperty(Prop.COLOR,Color.WHITE);
				Clarion.getControl(this.imageFeq).setProperty(Prop.ALRT,250,Constants.MOUSELEFT);
				Clarion.getControl(this.imageFeq).setClonedProperty(Prop.TEXT,this.filename);
			}
			if (zoomFactor.equals(Constants.NOZOOM)) {
				Clarion.getControl(this.imageFeq).setClonedProperty(Prop.MAXWIDTH,this.width);
				Clarion.getControl(this.imageFeq).setClonedProperty(Prop.MAXHEIGHT,this.height);
				Clarion.getControl(this.imageFeq).setProperty(Prop.VSCROLL,Constants.FALSE);
				Clarion.getControl(this.imageFeq).setProperty(Prop.HSCROLL,Constants.FALSE);
				if (!this.pp.inPageList(this.pageNo.like()).boolValue()) {
					Clarion.getControl(this.borderFeq).setProperty(Prop.FILL,Color.GRAY);
					Clarion.getControl(this.imageFeq).setProperty(Prop.TEXT,"");
				}
				else {
					Clarion.getControl(this.borderFeq).setProperty(Prop.FILL,Color.WHITE);
					Clarion.getControl(this.imageFeq).setClonedProperty(Prop.TEXT,this.filename);
				}
				CWin.setPosition(this.borderFeq.intValue(),this.xPos.intValue(),this.yPos.intValue(),this.width.intValue(),this.height.intValue());
				CWin.setPosition(this.imageFeq.intValue(),this.xPos.intValue(),this.yPos.intValue(),this.width.intValue(),this.height.intValue());
				CWin.unhide(this.borderFeq.intValue());
				CWin.unhide(this.imageFeq.intValue());
			}
			else {
				winWidth.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTWIDTH));
				winHeight.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTHEIGHT));
				zoomModifier.setValue(zoomFactor.equals(Constants.PAGEWIDTH) ? winWidth.divide(this.imageWidth) : zoomFactor.divide(100));
				tWidth.setValue(this.imageWidth.multiply(zoomModifier));
				tHeight.setValue(this.imageHeight.multiply(zoomModifier));
				CWin.unhide(this.imageFeq.intValue());
				Clarion.getControl(this.imageFeq).setClonedProperty(Prop.MAXWIDTH,tWidth);
				Clarion.getControl(this.imageFeq).setClonedProperty(Prop.MAXHEIGHT,tHeight);
				CWin.setPosition(this.imageFeq.intValue(),0,0,(tWidth.compareTo(winWidth)<=0 ? tWidth : winWidth).intValue(),(tHeight.compareTo(winHeight)<=0 ? tHeight : winHeight).intValue());
				CWin.setPosition(this.borderFeq.intValue(),0,0,(tWidth.compareTo(winWidth)<=0 ? tWidth : winWidth).intValue(),(tHeight.compareTo(winHeight)<=0 ? tHeight : winHeight).intValue());
				Clarion.getControl(this.imageFeq).setProperty(Prop.HSCROLL,tWidth.compareTo(winWidth)>0 ? 1 : 0);
				Clarion.getControl(this.imageFeq).setProperty(Prop.VSCROLL,tHeight.compareTo(winHeight)>0 ? 1 : 0);
				Clarion.getControl(this.borderFeq).setProperty(Prop.HIDE,tHeight.compareTo(winHeight)>0 && tWidth.compareTo(winWidth)>0 ? 1 : 0);
				if (CWin.event()!=Event.SIZED) {
					if (Clarion.getControl(this.imageFeq).getProperty(Prop.VSCROLL).boolValue()) {
						Clarion.getControl(this.imageFeq).setProperty(Prop.VSCROLLPOS,Clarion.newNumber(255).multiply(this.centreOnY.divide(100)));
					}
					if (Clarion.getControl(this.imageFeq).getProperty(Prop.HSCROLL).boolValue()) {
						Clarion.getControl(this.imageFeq).setProperty(Prop.HSCROLLPOS,Clarion.newNumber(255).multiply(this.centreOnX.divide(100)));
					}
				}
			}
			this.centreOnX.setValue(0);
			this.centreOnY.setValue(0);
			this.zoomState.setValue(zoomFactor);
		}
		else if (!(this.neighbour==null)) {
			this.neighbour.draw(pageNo.like(),zoomFactor.like());
		}
	}
	public ClarionNumber exists(ClarionNumber pageNo)
	{
		if (this.pageNo.equals(pageNo)) {
			return Clarion.newNumber(Constants.TRUE);
		}
		else if (!(this.neighbour==null)) {
			return this.neighbour.exists(pageNo.like());
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionString getProp(ClarionNumber pageNo,ClarionNumber prop)
	{
		if (this.pageNo.equals(pageNo)) {
			return Clarion.getControl(this.imageFeq).getProperty(prop).getString();
		}
		else if (!(this.neighbour==null)) {
			return this.neighbour.getProp(pageNo.like(),prop.like());
		}
		return Clarion.newString(String.valueOf(0));
	}
	public void highLight(ClarionNumber pageNo)
	{
		if (Clarion.getControl(this.borderFeq).getProperty(Prop.TYPE).equals(Create.BOX)) {
			Clarion.getControl(this.borderFeq).setProperty(Prop.COLOR,this.pageNo.equals(pageNo) ? Clarion.newNumber(Color.RED) : Clarion.newNumber(Color.BLACK));
		}
		if (!(this.neighbour==null)) {
			this.neighbour.highLight(pageNo.like());
		}
	}
	public void init(Printpreviewclass p,ClarionNumber pageNo,ClarionNumber pBaseFeq,ClarionString fname)
	{
		this.pp=p;
		this.filename=Clarion.newString(fname.clip().len());
		this.filename.setValue(fname);
		this.borderFeq.setValue(pBaseFeq);
		this.imageFeq.setValue(pBaseFeq.add(1));
		this.pageNo.setValue(pageNo);
		CWin.createControl(Constants.TEMPIMAGE,Create.IMAGE,null,null);
		Clarion.getControl(Constants.TEMPIMAGE).setClonedProperty(Prop.TEXT,this.filename);
		this.imageWidth.setValue(Clarion.getControl(Constants.TEMPIMAGE).getProperty(Prop.MAXWIDTH));
		this.imageHeight.setValue(Clarion.getControl(Constants.TEMPIMAGE).getProperty(Prop.MAXHEIGHT));
		CWin.removeControl(Constants.TEMPIMAGE);
		this.aspectRatio.setValue(this.imageHeight.divide(this.imageWidth));
	}
	public void init(Printpreviewclass p,ClarionNumber pageNo,ClarionNumber pBaseFeq,ClarionString fname,ClarionNumber x,ClarionNumber y,ClarionNumber wid,ClarionNumber hgt)
	{
		this.init(p,pageNo.like(),pBaseFeq.like(),fname);
		this.setPosition(this.pageNo.like(),x.like(),y.like(),wid.like(),hgt.like());
	}
	public void kill()
	{
		if (!(this.neighbour==null)) {
			this.neighbour.kill();
			//this.neighbour;
		}
		CWin.removeControl(this.imageFeq.intValue());
		CWin.removeControl(this.borderFeq.intValue());
		//this.filename;
	}
	public void setCentre(ClarionNumber pageNo,ClarionNumber x,ClarionNumber y)
	{
		this.centreOnX.setValue(this.pageNo.equals(pageNo) ? x : Clarion.newNumber(0));
		this.centreOnY.setValue(this.pageNo.equals(pageNo) ? y : Clarion.newNumber(0));
		if (!(this.neighbour==null)) {
			this.neighbour.setCentre(pageNo.like(),x.like(),y.like());
		}
	}
	public void setPosition(ClarionNumber pageNo,ClarionNumber x,ClarionNumber y,ClarionNumber w,ClarionNumber h)
	{
		if (this.pageNo.equals(pageNo)) {
			this.xPos.setValue(x);
			this.yPos.setValue(y);
			if (h.divide(w).compareTo(this.aspectRatio)<0) {
				w.setValue(h.divide(this.aspectRatio));
			}
			else {
				h.setValue(w.multiply(this.aspectRatio));
			}
			this.width.setValue(w);
			this.height.setValue(h);
			if (Clarion.getControl(this.borderFeq).getProperty(Prop.TYPE).equals(Create.BOX)) {
				CWin.setPosition(this.borderFeq.intValue(),x.intValue(),y.intValue(),w.intValue(),h.intValue());
			}
			if (Clarion.getControl(this.imageFeq).getProperty(Prop.TYPE).equals(Create.IMAGE)) {
				CWin.setPosition(this.imageFeq.intValue(),x.intValue(),y.intValue(),w.intValue(),h.intValue());
			}
		}
		else if (!(this.neighbour==null)) {
			this.neighbour.setPosition(pageNo.like(),x.like(),y.like(),w.like(),h.like());
		}
	}
}
