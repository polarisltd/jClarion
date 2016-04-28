package clarion;

import clarion.AppFrame;
import clarion.Main;
import clarion.Thiswindow;
import clarion.Toolbarclass;
import clarion.Tutor002;
import clarion.Tutor003;
import clarion.Tutor004;
import clarion.Tutor005;
import clarion.Tutor006;
import clarion.Tutor007;
import clarion.Tutor008;
import clarion.Tutor009;
import clarion.Tutor010;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Tutor001
{

	public static void main()
	{
		AppFrame appFrame=new AppFrame();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow thisWindow=new Thiswindow(toolbar,appFrame);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			appFrame.close();
		}
	}
	public static void main_MenuEditMenu()
	{
	}
	public static void main_MenuBrowseMenu(AppFrame appFrame)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==appFrame._browseCUSTOMER) {
				{
					CRun.start(new Runnable() { public void run() { Tutor002.browseCUSTOMER(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._browseORDERS) {
				{
					CRun.start(new Runnable() { public void run() { Tutor006.browseORDERS(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._browseStates) {
				{
					CRun.start(new Runnable() { public void run() { Tutor009.browseStates(); } } );
				}
				case_1_break=true;
			}
		}
	}
	public static void main_MenuWindowMenu()
	{
	}
	public static void main_MenuMenubar()
	{
	}
	public static void main_MenuReportCUSTOMER(AppFrame appFrame)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==appFrame._reportCUSTOMERByCUSKEYCUSTNUMBER) {
				{
					CRun.start(new Runnable() { public void run() { Tutor003.reportCUSTOMERByCUSKEYCUSTNUMBER(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._reportCUSTOMERByCUSKEYCOMPANY) {
				{
					CRun.start(new Runnable() { public void run() { Tutor004.reportCUSTOMERByCUSKEYCOMPANY(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._reportCUSTOMERByCUSKEYZIPCODE) {
				{
					CRun.start(new Runnable() { public void run() { Tutor005.reportCUSTOMERByCUSKEYZIPCODE(); } } );
				}
				case_1_break=true;
			}
		}
	}
	public static void main_MenuReportMenu(AppFrame appFrame)
	{
		{
			int case_1=CWin.accepted();
			if (case_1==appFrame._reportStatesBySTAKeyState) {
				{
					CRun.start(new Runnable() { public void run() { Tutor010.reportStatesBySTAKeyState(); } } );
				}
			}
		}
	}
	public static void main_MenuHelpMenu()
	{
	}
	public static void main_MenuFileMenu()
	{
	}
	public static void main_MenuReportORDERS(AppFrame appFrame)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==appFrame._reportORDERSByORDKEYORDERNUMBER) {
				{
					CRun.start(new Runnable() { public void run() { Tutor007.reportORDERSByORDKEYORDERNUMBER(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._reportORDERSByORDKEYCUSTNUMBER) {
				{
					CRun.start(new Runnable() { public void run() { Tutor008.reportORDERSByORDKEYCUSTNUMBER(); } } );
				}
				case_1_break=true;
			}
		}
	}
	public static void main_DefineListboxStyle()
	{
	}
}
