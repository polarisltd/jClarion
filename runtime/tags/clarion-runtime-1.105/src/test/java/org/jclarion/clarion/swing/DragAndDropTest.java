package org.jclarion.clarion.swing;

import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;


public class DragAndDropTest extends SwingTC 
{
	public DragAndDropTest(String name) {
		super(name);
	}

	public void testSimple()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setText("Test");
		cw.setAt(10,10,100,150);
		
		EntryControl e1 = new EntryControl();
		e1.setAt(5,5,80,10);
		e1.setPicture("@s20");
		e1.setDropID("list","e");
		e1.setDragID("e");
		
		EntryControl e2 = new EntryControl();
		e2.setAt(5,35,80,10);
		e2.setPicture("@s20");
		e2.setDropID("list","e");
		e2.setDragID("e");
		
		cw.add(e1);
		cw.add(e2);
		
		ListControl lc = new ListControl();
		lc.setAt(5,50,80,70);
		ClarionQueue cq = new ClarionQueue();
		ClarionString b = new ClarionString(40);
		cq.addVariable("a",b);
		for (int scan=0;scan<20;scan++) {
			b.setValue("Line #"+scan);
			cq.add();
		}
		lc.setFrom(cq);
		lc.setDragID("list");
		
		cw.add(lc);
		
		cw.open();

		assertTrue(cw.accept());
		assertEquals(Event.OPENWINDOW,CWin.event());
		cw.consumeAccept();
		
		assertTrue(cw.accept());
		assertEquals(Event.SELECTED,CWin.event());
		cw.consumeAccept();
		
		cw.setTimer(1);
		assertTrue(cw.accept());
		assertEquals(Event.TIMER,CWin.event());
		cw.consumeAccept();
		cw.setTimer(0);
		
		dragDrop(e1,e2);

		ClarionNumber thread= new ClarionNumber();
		ClarionNumber control= new ClarionNumber();
		
		assertTrue(cw.accept());
		assertEquals(Event.DRAG,CWin.event());
		assertEquals(e1.getUseID(),CWin.field());
		assertEquals("e",CWin.getDragID(thread,control).toString());
		assertEquals(CRun.getThreadID(),thread.intValue());
		assertEquals(e2.getUseID(),control.intValue());
		cw.consumeAccept();
		cw.setTimer(0);
		
		thread.clear();
		control.clear();
		assertTrue(cw.accept());
		assertEquals(Event.DROP,CWin.event());
		assertEquals(e2.getUseID(),CWin.field());
		assertEquals("e",CWin.getDropID(thread,control).toString());
		assertEquals(CRun.getThreadID(),thread.intValue());
		assertEquals(e1.getUseID(),control.intValue());
		cw.consumeAccept();
		cw.setTimer(0);
		
		cw.setTimer(1);
		assertTrue(cw.accept());
		assertEquals(Event.TIMER,CWin.event());
		cw.consumeAccept();
		cw.setTimer(0);
		
		dragDrop(e2,lc);
				
		assertTrue(cw.accept());
		assertEquals(Event.SELECTED,CWin.event());
		cw.consumeAccept();

		// does not work because drag/drop does not match
		cw.setTimer(1);
		assertTrue(cw.accept());
		assertEquals(Event.TIMER,CWin.event());
		cw.consumeAccept();
		cw.setTimer(0);
						
			
		dragDrop(lc,e2);
		
		assertTrue(cw.accept());
		assertEquals(Event.SELECTED,CWin.event());
		cw.consumeAccept();

		assertTrue(cw.accept());
		assertEquals(Event.DRAG,CWin.event());
		assertEquals(lc.getUseID(),CWin.field());
		assertEquals("list",CWin.getDragID(null,null).toString());
		CWin.setDropID("hey hey hey");
		cw.consumeAccept();
		cw.setTimer(0);
		
		thread.clear();
		control.clear();
		assertTrue(cw.accept());
		assertEquals(Event.DROP,CWin.event());
		assertEquals(e2.getUseID(),CWin.field());
		assertEquals("hey hey hey",CWin.getDropID(null,null).toString());
		cw.consumeAccept();
		cw.setTimer(0);
		
		cw.setTimer(1);
		assertTrue(cw.accept());
		assertEquals(Event.TIMER,CWin.event());
		cw.consumeAccept();
		cw.setTimer(0);
		
		cw.close();
	}

	private void dragDrop(AbstractControl e1, AbstractControl e2) {
		e1=cc(e1);
		e2=cc(e2);
		try {
		getRobot().mousePress(e1.getComponent());
		for (int scan=0;scan<10;scan++) {
			Thread.sleep(50);
			getRobot().mouseMove(e1.getComponent(),scan*2+10,10);
		}			
		for (int scan=0;scan<10;scan++) {
			Thread.sleep(50);
			getRobot().mouseMove(e2.getComponent(),scan*2+10,10);
		}			
		getRobot().mouseRelease();
		} catch (InterruptedException ex) { }
		waitForEventQueueToCatchup();
	}

}
