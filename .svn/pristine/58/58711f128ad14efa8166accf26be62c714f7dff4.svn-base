package org.jclarion.clarion.ide.model.report;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.LayoutManager;
import java.awt.Rectangle;
import java.awt.Toolkit;

import javax.swing.JComponent;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propprint;
import org.jclarion.clarion.control.ReportBreak;
import org.jclarion.clarion.control.ReportDetail;

/**
 * Layout manager positions report controls and resizes the container too
 * 
 * @author barney
 *
 */
public class ReportEditorLayout implements LayoutManager
{
	private ClarionReport report;
	private int dpi=0;

	public ReportEditorLayout(ClarionReport report)
	{
		this.report=report;		
		dpi=Toolkit.getDefaultToolkit().getScreenResolution();
	}
	
	public int getDPI()
	{
		return dpi;
	}

	@Override
	public void addLayoutComponent(String name, Component comp) 
	{
	}

	@Override
	public void removeLayoutComponent(Component comp) 
	{
	}

	@Override
	public Dimension preferredLayoutSize(Container parent) 
	{
		return null;
	}

	@Override
	public Dimension minimumLayoutSize(Container parent) 
	{
		return null;
	}
	
	private static class Rect
	{
		Integer x,y,width,height;

		public Rect()
		{
		}
		
		/*
		public Rect(Rect base)
		{
			x=base.x;
			y=base.y;
			width=base.width;
			height=base.height;			
		}
		*/
		
		public void clearNulls()
		{
			if (x==null) x=0;
			if (y==null) y=0;
			if (width==null) width=0;
			if (height==null) height=0;
		}
		
		public Rect convertToPixels(ClarionReport report)
		{
			if (x!=null) x=report.widthDialogToPixels(x);
			if (y!=null) y=report.heightDialogToPixels(y);
			if (width!=null) width=report.widthDialogToPixels(width);
			if (height!=null) height=report.heightDialogToPixels(height);
			return this;
		}

		@Override
		public String toString() {
			return "Rect [x=" + x + ", y=" + y + ", width=" + width
					+ ", height=" + height + "]";
		}
		
		
	}
	
	private Rect getRect(PropertyObject obj)
	{
		Rect r = new Rect();
		r.x=getIntProp(obj,Prop.XPOS);
		r.y=getIntProp(obj,Prop.YPOS);
		r.width=getIntProp(obj,Prop.WIDTH);
		r.height=getIntProp(obj,Prop.HEIGHT);
		return r;
	}
	
	private Integer getIntProp(PropertyObject obj, int prop) {
		ClarionObject co = obj.getRawProperty(prop,false);
		return co==null ? null : co.intValue();
	}

	@Override
	public void layoutContainer(Container parent) 
	{
		Rect reportSize = getRect(report).convertToPixels(report);
		Dimension pageSize = null;
		
		String paper = report.getProperty(Propprint.PAPER).toString();
		
		if ("PAPER:A4".equalsIgnoreCase(paper)) {
			pageSize = new Dimension( (int) (210/25.4*dpi),(int) (297/25.4*dpi)); 
		}
		if (pageSize!=null && report.isProperty(Prop.LANDSCAPE)) {
			pageSize=new Dimension(pageSize.height,pageSize.width);
		}
		if (pageSize==null) {
			pageSize=new Dimension(reportSize.x+reportSize.width,reportSize.y+reportSize.height);
		}
		
		int top=0;
		int width=0;
		for (Component c : parent.getComponents()) {
			if (!(c instanceof JComponent)) continue;
			JComponent comp = (JComponent)c;			
			PropertyObject ac = (PropertyObject)comp.getClientProperty("Clarion");			
			if (ac==null) continue;
			if (!comp.isVisible()) continue;
			
			Rect item = getSize(ac,reportSize,pageSize);
			
			item.clearNulls();
			if (comp.getClientProperty("Header")!=null) {
				Dimension d = comp.getPreferredSize();
				item.x=0;
				item.width=pageSize.width;
				item.height=Math.max(d.height,15);
			}
			
			Rectangle result = new Rectangle(item.x,top,item.width,item.height);			 
			c.setBounds(result);
			c.doLayout();
			top+=item.height;
			if (item.x+item.width>width) {
				width=item.x+item.width;
			}
		}
		parent.setSize(width,top);
	}

	private Rect getSize(PropertyObject ac, Rect reportSize, Dimension pageSize) {
		Rect r = getRect(ac).convertToPixels(report);
		if (ac instanceof ClarionReport) {
			return r;
		}
		
		boolean reportConstrained=false;
		if (ac instanceof ReportDetail) {
			reportConstrained=true;
		}
		if (ac.getParentPropertyObject() instanceof ReportBreak) {
			reportConstrained=true;
		}
		if (reportConstrained && ac.isProperty(Prop.ABSOLUTE)) {
			reportConstrained=false;
		}
		
		if (reportConstrained) {
			if (r.width==null) r.width=reportSize.width-(r.x==null ? 0 : r.x);
			r.clearNulls();
			r.x=r.x+reportSize.x;
		} else {
			if (r.width==null) r.width=pageSize.width-(r.x==null ? 0 : r.x);
		}
		return r;
	}

}
