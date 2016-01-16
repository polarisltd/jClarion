package org.jclarion.clarion.ide.windowdesigner;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.ComboControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.control.ReportBreak;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportForm;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.SpinControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.control.TextControl;

public class ControlType {
	public Class<? extends PropertyObject> clazz;
	public boolean hasKids;
	private String name;
	private boolean serializeText;
	private boolean serializeAsPicture;
	private boolean serializeSpecial;
	
	private static Map<String,ControlType> controls=new HashMap<String,ControlType>();
	private static Map<Class<? extends PropertyObject>,ControlType> controlsClass=new HashMap<Class<? extends PropertyObject>,ControlType>();
	static {
		construct("window",ClarionWindow.class).setKids().serializeText();
		construct("report",ClarionReport.class).setKids().serializeText();
		construct("detail",ReportDetail.class).setKids();
		construct("footer",ReportFooter.class).setKids();
		construct("header",ReportHeader.class).setKids();
		construct("break",ReportBreak.class).setKids();
		construct("form",ReportForm.class).setKids();
		construct("sheet",SheetControl.class).setKids();
		construct("tab",TabControl.class).setKids().serializeText();
		construct("panel",PanelControl.class);
		
		(new ControlType("string",StringControl.class) {

			@Override
			public boolean isSerializeAsPicture(PropertyObject po) {
				return ((AbstractControl)po).getUseObject()!=null;
			}
			
		}).serializeText();
		construct("button",ButtonControl.class).serializeText();
		construct("radio",RadioControl.class).serializeText();
		construct("option",OptionControl.class).setKids().serializeText();
		construct("check",CheckControl.class).serializeText();
		construct("list",ListControl.class);
		construct("entry",EntryControl.class).serializeText().serializeAsPicture();
		construct("text",TextControl.class).serializeText().serializeAsPicture();
		construct("combo",ComboControl.class);
		construct("group",GroupControl.class).setKids().serializeText();
		construct("line",LineControl.class);
		construct("box",BoxControl.class);
		construct("image",ImageControl.class).serializeText().serializeSpecial();
		construct("spin",SpinControl.class);
		construct("progress",ProgressControl.class);
		construct("prompt",PromptControl.class).serializeText();
	}
	
	public static ControlType construct(String name,Class<? extends PropertyObject> clazz)
	{
		return new ControlType(name,clazz);
	}
	
	public static ControlType get(String name)
	{
		return controls.get(name.toLowerCase());
	}

	public static ControlType get(Class<? extends PropertyObject> clazz)
	{
		return controlsClass.get(clazz);
	}
	
	public ControlType(String name,Class<? extends PropertyObject> clazz) {
		this.name=name;
		this.clazz=clazz;
		controls.put(name.toLowerCase(), this);
		controlsClass.put(clazz,this);
	}
	
	public ControlType serializeText()
	{
		serializeText=true;
		return this;
	}
	
	

	public ControlType serializeSpecial()
	{
		serializeSpecial=true;
		return this;
	}

	public ControlType serializeAsPicture()
	{
		serializeAsPicture=true;
		return this;
	}
	
	public ControlType setKids()
	{
		hasKids=true;
		return this;
	}
	
	public String getName()
	{
		return name;
	}

	public Class<? extends PropertyObject> getClazz() {
		return clazz;
	}

	public boolean isHasKids() {
		return hasKids;
	}
	
	public boolean isSerializeText() {
		return serializeText;
	}

	public boolean isSerializeSpecial() {
		return serializeSpecial;
	}
	
	public boolean isSerializeAsPicture(PropertyObject po) {
		return serializeAsPicture;
	}
	

}
