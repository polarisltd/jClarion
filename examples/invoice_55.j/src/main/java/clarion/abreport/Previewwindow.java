package clarion.abreport;

import clarion.abreport.Printpreviewclass_2;
import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Icon;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ComboControl;
import org.jclarion.clarion.control.ItemControl;
import org.jclarion.clarion.control.MenuControl;
import org.jclarion.clarion.control.MenubarControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SeparatorControl;
import org.jclarion.clarion.control.SpinControl;
import org.jclarion.clarion.control.ToolbarControl;

@SuppressWarnings("all")
public class Previewwindow extends ClarionWindow
{
	public int _filemenu=0;
	public int _pagestoprint=0;
	public int _print=0;
	public int _exit=0;
	public int _viewmenu=0;
	public int _next=0;
	public int _previous=0;
	public int _jump=0;
	public int _changedisplay=0;
	public int _zoommenu=0;
	public int _tbarprint=0;
	public int _tbarexit=0;
	public int _tbarzoom=0;
	public int _pageprompt=0;
	public int _currentpage=0;
	public int _acrossprompt=0;
	public int _pagesacross=0;
	public int _downprompt=0;
	public int _pagesdown=0;
	public int _zoomprompt=0;
	public int _zoomlist=0;
	public Previewwindow(Printpreviewclass_2 self)
	{
		this.setText("Report Preview").setAt(null,null,291,120).setFont("MS Sans Serif",10,null,null,null).setColor(Color.GRAY,null,null).setCenter().setImmediate().setIcon(Icon.PRINT).setAlrt(Constants.MOUSERIGHTUP).setAlrt(Constants.PGUPKEY).setAlrt(Constants.PGDNKEY).setStatus(-1,90,70).setGray().setMax().setResize();
		this.setId("printpreviewclass_2.display.previewwindow");
		MenubarControl _C1=new MenubarControl();
		this.add(_C1);
		MenuControl _C2=new MenuControl();
		_C2.setText("&File");
		this._filemenu=this.register(_C2,"printpreviewclass_2.display.previewwindow.filemenu");
		_C1.add(_C2);
		ItemControl _C3=new ItemControl();
		_C3.setText("Pa&ges to Print...").setMsg("Select which pages to print");
		this._pagestoprint=this.register(_C3,"printpreviewclass_2.display.previewwindow.pagestoprint");
		_C2.add(_C3);
		SeparatorControl _C4=new SeparatorControl();
		_C2.add(_C4);
		ItemControl _C5=new ItemControl();
		_C5.setText("&Print").setMsg("Print the report");
		this._print=this.register(_C5,"printpreviewclass_2.display.previewwindow.print");
		_C2.add(_C5);
		SeparatorControl _C6=new SeparatorControl();
		_C2.add(_C6);
		ItemControl _C7=new ItemControl();
		_C7.setText("E&xit").setMsg("Exit without printing the report");
		this._exit=this.register(_C7,"printpreviewclass_2.display.previewwindow.exit");
		_C2.add(_C7);
		MenuControl _C8=new MenuControl();
		_C8.setText("&View").setDisabled();
		this._viewmenu=this.register(_C8,"printpreviewclass_2.display.previewwindow.viewmenu");
		_C1.add(_C8);
		ItemControl _C9=new ItemControl();
		_C9.setText("&Next Page(s)").setMsg("View the next page or pages of the report");
		this._next=this.register(_C9,"printpreviewclass_2.display.previewwindow.next");
		_C8.add(_C9);
		ItemControl _C10=new ItemControl();
		_C10.setText("&Previous Page(s)").setDisabled().setMsg("View the next page or pages of the report");
		this._previous=this.register(_C10,"printpreviewclass_2.display.previewwindow.previous");
		_C8.add(_C10);
		SeparatorControl _C11=new SeparatorControl();
		_C8.add(_C11);
		ItemControl _C12=new ItemControl();
		_C12.setText("&Jump to a page").setMsg("Jump to a specific page of the report");
		this._jump=this.register(_C12,"printpreviewclass_2.display.previewwindow.jump");
		_C8.add(_C12);
		SeparatorControl _C13=new SeparatorControl();
		_C8.add(_C13);
		ItemControl _C14=new ItemControl();
		_C14.setText("&Change Display").setMsg("Change the number of pages displayed");
		this._changedisplay=this.register(_C14,"printpreviewclass_2.display.previewwindow.changedisplay");
		_C8.add(_C14);
		MenuControl _C15=new MenuControl();
		_C15.setText("&Zoom");
		this._zoommenu=this.register(_C15,"printpreviewclass_2.display.previewwindow.zoommenu");
		_C1.add(_C15);
		ToolbarControl _C16=new ToolbarControl();
		_C16.setAt(0,0,291,21);
		this.add(_C16);
		ButtonControl _C17=new ButtonControl();
		_C17.setIcon(Icon.PRINT).setAt(4,4,14,14).setTip("Print this report");
		this._tbarprint=this.register(_C17,"printpreviewclass_2.display.previewwindow.tbarprint");
		_C16.add(_C17);
		ButtonControl _C18=new ButtonControl();
		_C18.setIcon(Icon.NOPRINT).setAt(20,4,14,14).setTip("Exit without printing the report");
		this._tbarexit=this.register(_C18,"printpreviewclass_2.display.previewwindow.tbarexit");
		_C16.add(_C18);
		ButtonControl _C19=new ButtonControl();
		_C19.setIcon(Icon.ZOOM).setAt(36,4,14,14).setTip("Zoom in on a page of the report");
		this._tbarzoom=this.register(_C19,"printpreviewclass_2.display.previewwindow.tbarzoom");
		_C16.add(_C19);
		PromptControl _C20=new PromptControl();
		_C20.setText("&Page:").setAt(52,8,20,9).setRight(null);
		this._pageprompt=this.register(_C20,"printpreviewclass_2.display.previewwindow.pageprompt");
		_C16.add(_C20);
		SpinControl _C21=new SpinControl();
		_C21.setRange(1,10).setStep(1).setPicture("@n4").setAt(76,8,28,9);
		this._currentpage=this.register(_C21.use(self.currentpage),"printpreviewclass_2.display.previewwindow.currentpage");
		_C16.add(_C21);
		PromptControl _C22=new PromptControl();
		_C22.setText("&Across:").setAt(108,8,24,9).setRight(null);
		this._acrossprompt=this.register(_C22,"printpreviewclass_2.display.previewwindow.acrossprompt");
		_C16.add(_C22);
		SpinControl _C23=new SpinControl();
		_C23.setVScroll().setRange(1,10).setStep(1).setPicture("@N2").setAt(136,8,24,9).setMsg("Select the number of thumbnails in a row");
		this._pagesacross=this.register(_C23.use(self.pagesacross),"printpreviewclass_2.display.previewwindow.pagesacross");
		_C16.add(_C23);
		PromptControl _C24=new PromptControl();
		_C24.setText("&Down:").setAt(164,8,20,9).setRight(null);
		this._downprompt=this.register(_C24,"printpreviewclass_2.display.previewwindow.downprompt");
		_C16.add(_C24);
		SpinControl _C25=new SpinControl();
		_C25.setRange(1,10).setStep(1).setPicture("@n2").setAt(188,8,24,9).setMsg("Select the number of thumbnails in a column");
		this._pagesdown=this.register(_C25.use(self.pagesdown),"printpreviewclass_2.display.previewwindow.pagesdown");
		_C16.add(_C25);
		PromptControl _C26=new PromptControl();
		_C26.setText("Z&oom:").setAt(216,8,20,9).setHidden().setRight(null);
		this._zoomprompt=this.register(_C26,"printpreviewclass_2.display.previewwindow.zoomprompt");
		_C16.add(_C26);
		ComboControl _C27=new ComboControl();
		_C27.setDrop(10).setFrom("").setPicture("@S16").setAt(240,8,48,9).setHidden().setMsg("Set zoom to standard or user defined value");
		this._zoomlist=this.register(_C27.use(self.zoomlist),"printpreviewclass_2.display.previewwindow.zoomlist");
		_C16.add(_C27);
	}
}