package org.jclarion.clarion.swing.gui;

import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionPrinter;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.KeyedClarionEvent;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.ComboControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.ItemControl;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.MenuControl;
import org.jclarion.clarion.control.MenubarControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.SpinControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.control.TextControl;
import org.jclarion.clarion.control.ToolbarControl;
import org.jclarion.clarion.control.TreeMenuControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.OpenMonitor;
import org.jclarion.clarion.swing.dnd.DragEvent;
import org.jclarion.clarion.swing.dnd.DropEvent;
import org.jclarion.clarion.swing.notify.EventNotifier;

public class RemoteTypes 
{
	public static final int CWIN 	= 512;
	public static final int PRINTER = 513;
	public static final int WINDOW  = 514;
	public static final int APP     = 515;
	public static final int FILE    = 516;
	public static final int NOTIFIER= 517;
	
	public static final int SEM_EVENT 		 = 1;
	public static final int SEM_OPEN_MONITOR = 2;
	public static final int SEM_KEY_EVENT	 = 3;
	public static final int SEM_DRAG_EVENT	 = 4;
	public static final int SEM_DROP_EVENT	 = 5;

	private static RemoteTypes instance=new RemoteTypes();
	
	public static RemoteTypes getInstance()
	{
		return instance;
	}
	
	public RemoteWidget manufactureWidget(int type)
	{
		switch(type) {
			case NOTIFIER:
				return EventNotifier.getInstance();
			case FILE:
				return FileServer.getInstance();
			case CWIN:
				return CWin.getInstance();
			case PRINTER:
				return ClarionPrinter.getInstance();
			case WINDOW:
				return new ClarionWindow();
			case APP:
				return new ClarionApplication();
			case Create.SSTRING:
			case Create.STRING:
				return new StringControl();
			case Create.IMAGE:
				return new ImageControl();
			case Create.LINE:
				return new LineControl();
			case Create.BOX:
				return new BoxControl();
			case Create.ENTRY:
				return new EntryControl();
			case Create.BUTTON:
				return new ButtonControl();
			case Create.PROMPT:
				return new PromptControl();
			case Create.OPTION:
				return new OptionControl();
			case Create.CHECK:
				return new CheckControl();
			case Create.GROUP:
				return new GroupControl();
			case Create.LIST:
				return new ListControl();
			case Create.COMBO:
				return new ComboControl();
			case Create.SPIN:
				return new SpinControl();
			case Create.TEXT:
				return new TextControl();
			case Create.MENU:
				return new MenuControl();
			case Create.ITEM:
				return new ItemControl();
			case Create.RADIO:
				return new RadioControl();
			case Create.MENUBAR:
				return new MenubarControl();
			case Create.APPLICATION:
				return new ClarionApplication();
			case Create.WINDOW:
				return new ClarionWindow();
			case Create.PROGRESS:
				return new ProgressControl();
			case Create.SHEET:
				return new SheetControl();
			case Create.TAB:
				return new TabControl();
			case Create.PANEL:
				return new PanelControl();
			case Create.TREEMENU:
				return new TreeMenuControl();
			case Create.TOOLBAR:
				return new ToolbarControl();
			case Create.REPORT:
			case Create.HEADER:
			case Create.FOOTER:
			case Create.BREAK:
			case Create.FORM:
			case Create.DETAIL:
			case Create.OLE:
			case Create.DROPLIST:
			case Create.DROPCOMBO:
			case Create.SUBLIST:
			case Create.REGION:
			case Create.ELLIPSE:
			case Create.CUSTOM:
		}
		return null;
	}

	public RemoteSemaphore manufactureSemaphore(int sType) {
		switch(sType) {
			case SEM_EVENT:
				return new ClarionEvent();
			case SEM_KEY_EVENT:
				return new KeyedClarionEvent();
			case SEM_DRAG_EVENT:
				return new DragEvent();
			case SEM_DROP_EVENT:
				return new DropEvent();
			case SEM_OPEN_MONITOR:
				return new OpenMonitor();
		}
		return null;
	}
}
