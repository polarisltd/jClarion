package org.jclarion.clarion.swing;

import java.util.Random;

import javax.swing.JLabel;

import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Color;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Font;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Paper;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CWin;

public class ImageTest extends SwingTC
{

	public ImageTest(String name) {
		super(name);
	}

	public void testSimple()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,100,100);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(20,20,40,40);
		ic.setText("test-image.jpg");		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.setTimer(50);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        assertNotNull(((JLabel)cc(ic).getComponent()).getIcon());
		
        cw.close();
	}

	public void testSystem()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,100,100);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(20,20,40,40);
		ic.setText(Icon.APPLICATION);		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.setTimer(50);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        assertNotNull(((JLabel)cc(ic).getComponent()).getIcon());
		
        cw.close();
	}
	
	public void testImageNotFound()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,100,100);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(20,20,40,40);
		ic.setText("test-image-404.jpg");		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.setTimer(50);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        assertNull(((JLabel)cc(ic).getComponent()).getIcon());
		
        cw.close();
	}

	public void testCF()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,100,100);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(20,20,40,40);
		ic.setText("resource:/resources/patrick.png");		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.setTimer(50);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        assertNotNull(((JLabel)cc(ic).getComponent()).getIcon());
		
        cw.close();
	}
	
	public void testCF404()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,100,100);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(20,20,40,40);
		ic.setText("resource:/resources/patrick-404.png");		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.setTimer(50);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        assertNull(((JLabel)cc(ic).getComponent()).getIcon());
		
        cw.close();
	}
	
	public void testPrintPreview()
	{
		ClarionReport cr = new ClarionReport();
		//cr.setLandscape();
		cr.setText("Test Report");
		cr.setThous();
		cr.setPaper(Paper.A4,null,null);
		cr.setAt(1000,1000,6500,8000);
		cr.setFont("Serif",14,null,null,null);
		
		
		ReportDetail rd = new ReportDetail();
		rd.setAt(0,0,6500,1000);
		cr.add(rd);
	
		rd.add( (new StringControl()).setLeft(0).setText("Left").setAt(0,0,2000,null));
		rd.add( (new StringControl()).setRight(0).setText("Right").setAt(0,200,2000,null));
		rd.add( (new StringControl()).setCenter(0).setText("Center").setAt(0,400,2000,null));
		rd.add( (new StringControl()).setDecimal(240).setText("Decimal.12").setAt(0,600,2000,null));
		rd.add( (new ImageControl()).setText("test-image.jpg").setAt(3000,0,1000,1000));
		Random r = new Random();
		for (int scan=0;scan<10;scan++) {
			rd.add( (new LineControl()).setLineWidth(50).setColor(Color.RED,null,null).setAt(4100,0,r.nextInt(800),r.nextInt(800)));
		}
		rd.add( (new BoxControl()).setLineWidth(150).setRound().setFillColor(Color.BLUE).setColor(Color.GREEN,null,Color.YELLOW).setAt(5000,0,1000,300));
		rd.add( (new StringControl()).setCenter(0).setText("Back").setColor(null,null,Color.YELLOW).setFont(null,20,Color.OLIVE,Font.BOLD,null).setAt(5000,500,1000,null));
		rd.add( (new StringControl()).setCenter(0).setText("Front").setTransparent().setAt(5200,600,800,null));
				
		SimpleComboQueue scq  = new SimpleComboQueue();
		cr.setPreview(scq);
		
		cr.open();
		rd.print();
		rd.print();
		rd.print();
		rd.print();
		cr.endPage();
		
		assertEquals(1,scq.records());
		
		
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,300,300);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(0,0,300,300);
		scq.get(1);
		ic.setText(scq.item);		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.setTimer(500);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        assertNotNull(((JLabel)cc(ic).getComponent()).getIcon());
		
        cw.close();
		
	
		cr.close();
	}
}
