package org.jclarion.clarion.swing;

import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.util.Random;

import javax.swing.JLabel;

import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Color;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Font;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Paper;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ClarionIconData;
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

	public void testCopy()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,100,100);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(20,20,70,70);
		ic.setText("test-image.jpg");		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();

        waitForEventQueueToCatchup();
        
        getRobot().mousePress(cc(ic).getComponent(),0,0,InputEvent.BUTTON3_MASK);
        getRobot().mouseRelease(InputEvent.BUTTON3_MASK);
        waitForEventQueueToCatchup();
        getRobot().mousePress(cc(ic).getComponent(),10,10);
        getRobot().mouseRelease();
        waitForEventQueueToCatchup();
        
        getRobot().key(KeyEvent.VK_ESCAPE);

        assertTrue(cw.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.close();
	}
	
	public void testDrag()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setAt(10,10,100,100);
		cw.setText("Image Test");
		
		ImageControl ic = new ImageControl();
		ic.setAt(20,20,70,70);
		ic.setText("test-image.jpg");		
		cw.add(ic);
		
		cw.open();
		
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.setTimer(5);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);

        drag(ic,10,20,35,60);

        assertTrue(cw.accept());
        assertEquals(Event.SIZED,CWin.event());
        cw.consumeAccept();
        
        assertEquals(1,ic.getProperty(Prop.CLIP).intValue());
        assertEquals(9,ic.getProperty(Prop.CLIENTX).intValue());
        assertEquals(21,ic.getProperty(Prop.CLIENTY).intValue());
        assertEquals(25,ic.getProperty(Prop.CLIENTWIDTH).intValue());
        assertEquals(45,ic.getProperty(Prop.CLIENTHEIGHT).intValue());

        cw.close();
	}
	
	
	private void drag(ImageControl ic, int x1, int y1, int x2, int y2) {
		ic=cc(ic);
		try {
		getRobot().mousePress(ic.getComponent(),x1,y1);
		for (int scan=0;scan<=10;scan++) {
			Thread.sleep(50);
			getRobot().mouseMove(ic.getComponent(),(x2-x1)*scan/10+x1,(y2-y1)*scan/10+y1);
		}			
		getRobot().mouseRelease();
		} catch (InterruptedException ex) { }
		waitForEventQueueToCatchup();
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
        
        assertNull(((ClarionIconData)((JLabel)cc(ic).getComponent()).getIcon()).getImage());
		
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
        
        assertNull(((ClarionIconData)((JLabel)cc(ic).getComponent()).getIcon()).getImage());
		
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
	
	
	public void testSVG()
	{
		ClarionReport cr = new ClarionReport();
		//cr.setLandscape();
		cr.setText("Test Report");
		cr.setThous();
		cr.setPaper(Paper.A4,null,null);
		cr.setAt(1000,1000,6500,8000);
		cr.setFont("Serif",14,null,null,null);
		
		
		ReportDetail rd = new ReportDetail();
		rd.setAt(0,0,6500,1100);
		cr.add(rd);
	
		rd.add( (new ImageControl()).setText("resource:/resources/butterfly.svgz").setAt(3000,0,2000,1000));
		rd.add( (new BoxControl()).setAt(3000,0,2000,1000).setColor(Color.BLACK,null,null));

		SimpleComboQueue scq  = new SimpleComboQueue();
		cr.setPreview(scq);
		
		cr.open();
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

	public void testSVG2()
	{
		ClarionReport cr = new ClarionReport();
		//cr.setLandscape();
		cr.setText("Test Report");
		cr.setThous();
		cr.setPaper(Paper.A4,null,null);
		cr.setAt(0,0,8270,11690);
		cr.setFont("Serif",14,null,null,null);
		
		ReportDetail rd = new ReportDetail();
		rd.setAt(0,0,8270,11690);
		cr.add(rd);
	
		rd.add( (new ImageControl()).setText("resource:/resources/test.svgz").setAt(0,0,8270,11690));

		SimpleComboQueue scq  = new SimpleComboQueue();
		cr.setPreview(scq);
		
		cr.open();
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
