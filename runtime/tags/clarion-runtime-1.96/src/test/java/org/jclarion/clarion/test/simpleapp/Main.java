package org.jclarion.clarion.test.simpleapp;

import java.util.Random;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Constants;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.SimpleComboQueue;

public class Main {
	public static ClarionString name_2 = new ClarionString("Test Application");
	
	public static void main(String args[])
	{
		login();
	}

	public static void login()
	{
		ClarionString acc=new ClarionString();
		ClarionString password = new ClarionString();
		Window_56 login = new Window_56(acc,password);
		login.open();
		while (CWin.getInstance().accept()) {
			if (CWin.accepted()==login._login) {
				if (acc.equals("admin") && password.equals("boss")) {
					mainMenu("Administrator",CDate.today());
					continue;
				}
				if (acc.equals("report") && password.equals("")) {
					report();
					continue;
				}
				if (acc.equals("staff") && password.equals("")) {
					mainMenu("Staff",CDate.date(5,18,1979));
					continue;
				}
				CWin.disable(login._login);
				CWin.select(login._accCode);
			}
			if (CWin.event()==Event.TIMER) {
				CWin.enable(login._login);
			}
			CWin.getInstance().consumeAccept();
		}
		login.close();
	}
	
	public static void mainMenu(String name,int date)
	{
		Random r = new Random();
		Window_59 m = new Window_59(new ClarionString("Main Menu - "+name),new ClarionNumber(date));
		m.open();
		CWin.alert(Constants.UPKEY);
		CWin.alert(Constants.DOWNKEY);
		while (CWin.getInstance().accept()) {
			if (CWin.event()==Event.ACCEPTED) {
				name_2.setValue( m.getControl(CWin.field()).getProperty(Prop.TEXT) );
				if (CWin.field()==m._miner) {
					 for (int scan=0;scan<100;scan++) {
						 int nc = CWin.createControl(0,Create.STRING,null);
						 CWin.getControl(nc).setProperty(Prop.TEXT,"@n3");
						 CWin.getControl(nc).setProperty(Prop.USE,scan);
						 CWin.setPosition(nc,
								 r.nextInt(m.getProperty(Prop.WIDTH).intValue()),
								 r.nextInt(m.getProperty(Prop.HEIGHT).intValue()),
								 null,null);
						 CWin.unhide(nc);
					 }
				}
			}
			if (CWin.event()==Event.ALERTKEY) {
				if (CWin.keyCode()==Constants.UPKEY || CWin.keyCode()==Constants.DOWNKEY) {
					int c = CWin.focus();
					while (true) {
						if (CWin.keyCode()==Constants.UPKEY) {
							c=c-1;
						} else {
							c=c+1;
						}
						AbstractControl p = m.getControl(c);
						if (p==null) break;
						if (p instanceof ButtonControl && !p.isProperty(Prop.DISABLE)) {
							CWin.select(p.getUseID());
							break;
						}
					}
				}
			}
			CWin.getInstance().consumeAccept();
		}
		m.close();
	}
	
	public static void report()
	{
		SimpleComboQueue q = new SimpleComboQueue();
		
		ClarionReport cr = new ClarionReport();
		cr.setPreview(q);
		cr.setFont("Serif",12,null,null,null);
		cr.setThous();
		cr.setAt(0,0,6000,6000);
		ReportDetail cd = new ReportDetail();
		cd.setAt(0,0,6000,1000);
		cd.add((new StringControl()).setText("This is a report"));
		cr.add(cd);
		
		cr.open();
		cd.print();
		cd.print();
		cd.print();
		cr.endPage();
		
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,200,200);
		cw.setText("test");
		cw.setId("preview.win");
		
		ImageControl ic = new ImageControl();
		ic.setAt(0,0,200,180);
		ic.setId("preview.img");
		q.get(1);
		cw.add(ic);
		
		cw.open();
		while (CWin.getInstance().accept()) {
			if (CWin.event()==Event.OPENWINDOW) {
				ic.setText(q.item);				
			}
			CWin.getInstance().consumeAccept();
		}
		cw.close();
		cr.close();
	}
}
