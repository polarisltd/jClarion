/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */

package org.jclarion.clarion.swing;

import java.awt.event.KeyEvent;

import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class ButtonTest extends SwingTC {
    
    public ButtonTest(String name) {
        super(name);
    }
    
    public void testLabelOverlayBug()
    {
    	ClarionWindow w1 = new ClarionWindow();
    	w1.setText("Hot Keys");
    	w1.setAt(30,30,150,150);

    	
    	ButtonControl b1 = new ButtonControl();
    	b1.setAt(5,30,100,20);
    	b1.setFlat();
    	w1.add(b1);
    	
    	StringControl sc = new StringControl();
    	sc.setAt(10,30,80,20);
    	sc.setText("Hello World");
    	w1.add(sc);

    	w1.open();

    	w1.accept();
        assertEquals(Event.OPENWINDOW,CWin.event());
        w1.consumeAccept();

        w1.accept();
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w1.consumeAccept();
        
        getRobot().mousePress(cc(b1).getComponent(),50,20);
        getRobot().mouseRelease();

        w1.accept();
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w1.consumeAccept();
    	
    	w1.close();
    }
    
    
    public void testHotKeysBug()
    {
    	ClarionWindow w1 = new ClarionWindow();
    	w1.setText("Hot Keys");
    	w1.setAt(30,30,150,150);

    	EntryControl ec = new EntryControl();
    	ec.setAt(5,5,100,20);
    	ec.setText("@s20");
    	w1.add(ec);
    	
    	ButtonControl b1 = new ButtonControl();
    	b1.setAt(5,30,100,20);
    	b1.setText("&Underlined");
    	w1.add(b1);

    	ButtonControl b2 = new ButtonControl();
    	b2.setAt(5,55,100,20);
    	b2.setText("F6 Hot Key");
    	b2.setKey(Constants.F6KEY);
    	w1.add(b2);

    	ButtonControl b3 = new ButtonControl();
    	b3.setAt(5,80,100,20);
    	b3.setText("&this one");
    	w1.add(b3);

    	ButtonControl b4 = new ButtonControl();
    	b4.setAt(5,105,100,20);
    	b4.setText("F5 Hot Key");
    	b4.setKey(Constants.F5KEY);
    	w1.add(b4);
    	
    	w1.open();
    	
        w1.accept();
        assertEquals(Event.OPENWINDOW,CWin.event());
        w1.consumeAccept();

        w1.accept();
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(ec.getUseID(),CWin.field());
        w1.consumeAccept();
        
        waitForEventQueueToCatchup();
        getRobot().key(KeyEvent.VK_U);
        getRobot().key(KeyEvent.VK_U,KeyEvent.ALT_MASK);
 
        a(w1,ec,Event.ACCEPTED);
        assertEquals("u",ec.getUseObject().toString().trim());

        a(w1,b1,Event.SELECTED);
        a(w1,b1,Event.ACCEPTED);

        getRobot().key(KeyEvent.VK_T);

        a(w1,b3,Event.SELECTED);
        a(w1,b3,Event.ACCEPTED);
        
        getRobot().key(KeyEvent.VK_U);
        
        a(w1,b1,Event.SELECTED);
        a(w1,b1,Event.ACCEPTED);
        
        getRobot().key(KeyEvent.VK_U);

        a(w1,b1,Event.ACCEPTED);        
        
        getRobot().key(KeyEvent.VK_T,KeyEvent.ALT_MASK);

        a(w1,b3,Event.SELECTED);
        a(w1,b3,Event.ACCEPTED);
        
        getRobot().key(KeyEvent.VK_F6);

        a(w1,b2,Event.SELECTED);
        a(w1,b2,Event.ACCEPTED);
        
        getRobot().key(KeyEvent.VK_F5);
        
        a(w1,b4,Event.SELECTED);
        a(w1,b4,Event.ACCEPTED);

        getRobot().key(KeyEvent.VK_TAB);

        a(w1,ec,Event.SELECTED);

        getRobot().key(KeyEvent.VK_F6);

        a(w1,b2,Event.SELECTED);
        a(w1,b2,Event.ACCEPTED);
        
        w1.setTimer(10);
        assertTrue(w1.accept());
        assertEquals(Event.TIMER,CWin.event());
        w1.consumeAccept();
        w1.setTimer(0);

        w1.close();
    }
    
    
    private void a(ClarionWindow w1, AbstractControl ec, int ev) {
    	assertTrue(w1.accept());
    	assertEquals(ev,CWin.event());
    	assertEquals(ec.getUseID(),CWin.field());
    	w1.consumeAccept();
	}


	public class Window_174 extends ClarionWindow
    {
        public int _group5=0;
        public int _group2=0;
        public int _a4Receipt=0;
        public int _docReceipt=0;
        public int _group8=0;
        public int _emailReceipt=0;
        public int _group5E=0;
        public int _group1_2=0;
        public int _noPrint=0;
        public int _exit=0;
        public int _group1=0;
        public int _group1_2E=0;
        public int _group5_3=0;
        public Window_174()
        {
            this.setText("Invoice Print Menu").setAt(null,null,137,132).setFont("MS Sans Serif",12,null,Font.REGULAR,null).setCenter().setSystem().setGray().setDouble().setMDI();
            this.setId("posfinish.window");
            GroupControl _C1=new GroupControl();
            _C1.setText("Group 6").setAt(4,75,129,24).setBoxed().setBevel(-1,null,null);
            this._group5=this.register(_C1,"posfinish.window.group5");
            this.add(_C1);
            GroupControl _C2=new GroupControl();
            _C2.setText("Group 2").setAt(4,4,129,40).setDisabled().setBoxed().setBevel(-1,null,null);
            this._group2=this.register(_C2,"posfinish.window.group2");
            this.add(_C2);
            ButtonControl _C3=new ButtonControl();
            _C3.setFlat().setText("&A4 Receipt/Invoice").setAt(14,8,109,14).setHidden();
            this._a4Receipt=this.register(_C3,"posfinish.window.a4receipt");
            this.add(_C3);
            ButtonControl _C4=new ButtonControl();
            _C4.setFlat().setText("&Docket Receipt/Invoice").setAt(14,26,109,14).setHidden();
            this._docReceipt=this.register(_C4,"posfinish.window.docreceipt");
            this.add(_C4);
            GroupControl _C5=new GroupControl();
            _C5.setText("Group 8").setAt(2,2,133,128).setBoxed().setBevel(1,null,null);
            this._group8=this.register(_C5,"posfinish.window.group8");
            this.add(_C5);
            ButtonControl _C6=new ButtonControl();
            _C6.setFlat().setText("&Email Receipt/Invoice").setAt(15,51,109,14);
            this._emailReceipt=this.register(_C6,"posfinish.window.emailreceipt");
            _C5.add(_C6);
            GroupControl _C7=new GroupControl();
            _C7.setText("Group 6").setAt(4,47,129,24).setBoxed().setBevel(-1,null,null);
            this._group5E=this.register(_C7,"posfinish.window.group5:e");
            _C5.add(_C7);
            GroupControl _C8=new GroupControl();
            _C8.setText("Group 1").setAt(4,71,129,4).setBoxed().setBevel(-1,null,null);
            this._group1_2=this.register(_C8,"posfinish.window.group1:2");
            _C5.add(_C8);
            ButtonControl _C9=new ButtonControl();
            _C9.setFlat().setText("Do &Not Print Now").setAt(15,80,109,14);
            this._noPrint=this.register(_C9,"posfinish.window.noprint");
            this.add(_C9);
            ButtonControl _C10=new ButtonControl();
            _C10.setFlat().setText("E&Xit and Suspend Sale").setAt(16,108,109,14);
            this._exit=this.register(_C10,"posfinish.window.exit");
            this.add(_C10);
            GroupControl _C11=new GroupControl();
            _C11.setText("Group 1").setAt(4,44,129,3).setBoxed().setBevel(-1,null,null);
            this._group1=this.register(_C11,"posfinish.window.group1");
            this.add(_C11);
            GroupControl _C12=new GroupControl();
            _C12.setText("Group 1").setAt(4,99,129,4).setBoxed().setBevel(-1,null,null);
            this._group1_2E=this.register(_C12,"posfinish.window.group1:2:e");
            this.add(_C12);
            GroupControl _C13=new GroupControl();
            _C13.setText("Group 6").setAt(4,103,129,24).setBoxed().setBevel(-1,null,null);
            this._group5_3=this.register(_C13,"posfinish.window.group5:3");
            this.add(_C13);
        }
    }    

    public void testButtonSelect() throws InterruptedException
    {
        final ClarionApplication app = new ClarionApplication();
        app.setAt(null,null,250,140);
        Thread t = new Thread() {
            public void run() {
                app.open();
                while (app.accept()) {
                    app.consumeAccept();
                }
                app.close();
            };
        };
        t.start();
        app.waitForActiveState(true,5000);
        
        ClarionWindow base=new ClarionWindow();
        base.setAt(10,10,100,100);
        base.setText("base");
        base.setMDI();
        base.open();
        base.accept();
        assertEquals(Event.OPENWINDOW,CWin.event());
        base.consumeAccept();

        ClarionWindow base2=new ClarionWindow();
        base2.setAt(20,20,100,100);
        base2.setText("base 2");
        base2.setMDI();
        base2.open();
        base2.accept();
        assertEquals(Event.OPENWINDOW,CWin.event());
        base2.consumeAccept();
        
        base2.close();
        
        
        Window_174 w = new Window_174();
        w.open();
        
        CWin.unhide(w._a4Receipt);
        CWin.unhide(w._docReceipt);
        
        CWin.select(w._docReceipt);

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(w._docReceipt,CWin.field());
        w.consumeAccept();

        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        
        w.close();

        base.close();
        
        app.post(Event.CLOSEWINDOW);
        t.join();
    }
    
    public void testPreferredSizing()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,100,null);
        w.add(b);
        int id = w.register(b);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertEquals(101,b.getProperty(Prop.WIDTH).intValue());
        assertTrue(b.getProperty(Prop.HEIGHT).intValue()>8);
        
        w.close();
    }

    public void testGetPosition()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(25,20,100,11);
        w.add(b);
        int id = w.register(b);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertEquals(100,b.getProperty(Prop.WIDTH).intValue());
        assertTrue(b.getProperty(Prop.HEIGHT).intValue()>8);
        
        ClarionNumber x,y,wi,he;
        x=new ClarionNumber();
        y=new ClarionNumber();
        wi=new ClarionNumber();
        he=new ClarionNumber();
        
        CWin.getPosition(b.getUseID(),x,y,wi,he);
        assertEquals(25,x.intValue());
        assertEquals(20,y.intValue());
        assertEquals(100,wi.intValue());
        assertEquals(11,he.intValue());
        
        w.close();
    }
    
    public void testStdCloseEvent()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,100,null);
        b.setStandard(Std.CLOSE);
        w.add(b);
        int id = w.register(b);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(' ');

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();
        
        assertFalse(w.accept());
    }

    public void testStdCloseEventUsingEnterKey()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,100,null);
        b.setStandard(Std.CLOSE);
        w.add(b);
        int id = w.register(b);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();
        
        assertFalse(w.accept());
    }
    

    public void testSimpleOpenAndClose()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,150,50);
        w.add(b);
        int id = w.register(b);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        Thread t = run(new Runnable() {
            @Override
            public void run() {
                getRobot().key(' ');
            } 
            
        },100);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        w.close();
        
        try {
            t.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void testResizeAndRelocate()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        final ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,150,50);
        b.setDefault();
        w.add(b);
        int id = w.register(b);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        run(new Runnable() {
            @Override
            public void run() {
                getRobot().key(' ');
            } 
            
        },100);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
      
        /**
        t.join();
        */
        
        b.setProperty(Prop.HEIGHT,30);
        waitForEventQueueToCatchup();
        
        assertEquals(30*cc(w).getFontHeight()/8,cc(b).getComponent().getHeight());

        b.setProperty(Prop.WIDTH,40);
        waitForEventQueueToCatchup();

        assertEquals(40*cc(w).getFontWidth()/4,cc(b).getComponent().getWidth());

        b.setProperty(Prop.XPOS,25);
        waitForEventQueueToCatchup();

        assertEquals(25*cc(w).getFontWidth()/4,cc(b).getComponent().getX());
        
        b.setProperty(Prop.YPOS,58); 
        waitForEventQueueToCatchup();

        assertEquals(58*cc(w).getFontHeight()/8,cc(b).getComponent().getY());

        b.setProperty(Prop.TEXT,"New Text");
        waitForEventQueueToCatchup();
        
        assertEquals("New Text",cc(b).getButton().getText());
        
        w.close();
    }

    
    public void testDefault()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        final EntryControl e2 =  new EntryControl();
        e2.setPicture("@n$11.2").setAt(20,70,150,30);
        w.add(e2);
        int id2 = w.register(e2);

        final ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,150,30);
        b.setDefault();
        w.add(b);
        int id = w.register(b);

        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    
    public void testEnterKeyOverridesDefault()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);

        final ButtonControl b1 =  new ButtonControl();
        b1.setText("All Good").setAt(20,20,150,30);
        w.add(b1);

        final ButtonControl b2 =  new ButtonControl();
        b2.setText("All Good").setAt(20,80,150,30);
        b2.setDefault();
        w.add(b2);

        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_SPACE);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b2.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
    public void testDefaultWithChanges()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        final EntryControl e2 =  new EntryControl();
        e2.setPicture("@n$11.2").setAt(20,70,150,30);
        w.add(e2);
        int id2 = w.register(e2);

        final ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,150,30);
        b.setDefault();
        w.add(b);
        int id = w.register(b);

        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key('1');
        
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id2,CWin.field());
        assertEquals("1",e2.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }


    public void testDefaultWithRejectedChanges()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        final EntryControl e2 =  new EntryControl();
        e2.setPicture("@n$11.2").setAt(20,70,150,30);
        w.add(e2);
        int id2 = w.register(e2);

        final ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,150,30);
        b.setDefault();
        w.add(b);
        w.register(b);

        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key('X');
        
        sleep(100);

        getRobot().key(KeyEvent.VK_ENTER);
        
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    public void testKeyShortCut()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        final EntryControl e2 =  new EntryControl();
        e2.setPicture("@n$11.2").setAt(20,70,150,30);
        w.add(e2);
        int id2 = w.register(e2);

        final ButtonControl b =  new ButtonControl();
        b.setText("&All Good").setAt(20,20,150,30);
        w.add(b);
        int id = w.register(b);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();
        
        getRobot().key('0');
        getRobot().key('1');
        getRobot().key('.');
        getRobot().key('2');

        sleep(100);
        
        getRobot().key('A',KeyEvent.ALT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id2,CWin.field());
        assertEquals("1.2",e2.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        CWin.select(e2.getUseID());

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();
        
        getRobot().key('X');

        sleep(100);
        
        getRobot().key('A',KeyEvent.ALT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        assertEquals("1.2",e2.getUseObject().toString());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        assertEquals(e2.getUseID(),CWin.focus());
        
        w.close();
    }
    
    public void testHotKeyShortCut()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        final EntryControl e2 =  new EntryControl();
        e2.setPicture("@n$11.2").setAt(20,70,150,30);
        w.add(e2);
        int id2 = w.register(e2);

        final ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,150,30);
        b.setKey(Constants.F6KEY);
        w.add(b);
        int id = w.register(b);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();
        
        getRobot().key('0');
        getRobot().key('1');
        getRobot().key('.');
        getRobot().key('2');

        sleep(100);
        
        getRobot().key(KeyEvent.VK_F6);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id2,CWin.field());
        assertEquals("1.2",e2.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_F6);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }    

    
    public void testHotKeyShortCutAbortOnReject()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        final EntryControl e2 =  new EntryControl();
        e2.setPicture("@n$11.2").setAt(20,70,150,30);
        w.add(e2);
        int id2 = w.register(e2);

        final ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,20,150,30);
        b.setKey(Constants.F6KEY);
        w.add(b);
        w.register(b);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();
        
        getRobot().key('X');
        getRobot().key('Y');
        getRobot().key('.');
        getRobot().key('Z');

        sleep(100);
        
        getRobot().key(KeyEvent.VK_F6);
        
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(id2,CWin.field());
        w.consumeAccept();
        
        assertEquals(id2,CWin.focus());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        w.close();
    }    

}
