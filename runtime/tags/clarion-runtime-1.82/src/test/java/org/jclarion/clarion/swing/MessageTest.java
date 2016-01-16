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

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Button;
import org.jclarion.clarion.constants.Constants;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.runtime.CWin;

public class MessageTest extends SwingTC
{

    public MessageTest(String name) {
        super(name);
    }
    
    private abstract class MsgBox extends Thread
    {
        Integer result=null;
    
        public void start()
        {
            super.start();
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        public void run()
        {
            result = message();
        }
        
        public Integer getResult()
        {
            try {
                this.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            return result;
        }
        
        public abstract int message();
    }

    public void testEnterKeyBug()
    {
     
        ClarionWindow win = new ClarionWindow();
        win.setAt(null,null,100,100);
        win.setCenter();
        win.setText("Example");
        
        win.open();
        CWin.alert(Constants.ENTERKEY);
        
        assertTrue(win.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        win.consumeAccept();

        win.setTimer(20);
        assertTrue(win.accept());
        assertEquals(Event.TIMER,CWin.event());
        win.consumeAccept();
        win.setTimer(0);
        
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(win.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        win.consumeAccept();

        assertTrue(win.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        win.consumeAccept();

        Thread t = new Thread() {
            public void run() {
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                getRobot().key(KeyEvent.VK_TAB);
                getRobot().key(KeyEvent.VK_SPACE);
            }
        };
        t.start();

        assertEquals(Button.CANCEL,CWin.message(Clarion.newString("Hello"),Clarion.newString("Hello"),Icon.HAND,Button.OK+Button.CANCEL,Button.OK));
        
        win.close();
    }

    public void testEnterKeyBug2()
    {
     
        ClarionWindow win = new ClarionWindow();
        win.setAt(null,null,100,100);
        win.setCenter();
        win.setText("Example");
        
        win.open();
        CWin.alert(Constants.ENTERKEY);
        
        assertTrue(win.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        win.consumeAccept();

        win.setTimer(20);
        assertTrue(win.accept());
        assertEquals(Event.TIMER,CWin.event());
        win.consumeAccept();
        win.setTimer(0);
        
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(win.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        win.consumeAccept();

        assertTrue(win.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        win.consumeAccept();

        Thread t = new Thread() {
            public void run() {
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                getRobot().key(KeyEvent.VK_TAB);
                getRobot().key(KeyEvent.VK_ENTER);
            }
        };
        t.start();

        assertEquals(Button.CANCEL,CWin.message(Clarion.newString("Hello"),Clarion.newString("Hello"),Icon.HAND,Button.OK+Button.CANCEL,Button.OK));
        
        win.close();
    }
    
    
    public void testDoubleKeyBug()
    {
     
        ClarionWindow win = new ClarionWindow();
        win.setAt(null,null,100,100);
        win.setCenter();
        win.setText("Example");
        
        win.open();
        CWin.alert(Constants.DELETEKEY);
        
        assertTrue(win.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        win.consumeAccept();

        win.setTimer(20);
        assertTrue(win.accept());
        assertEquals(Event.TIMER,CWin.event());
        win.consumeAccept();
        win.setTimer(0);
        
        getRobot().key(KeyEvent.VK_DELETE);

        assertTrue(win.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        win.consumeAccept();

        assertTrue(win.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        win.consumeAccept();

        getRobot().key(KeyEvent.VK_DELETE);

        Thread t = new Thread() {
            public void run() {
                try {
                    Thread.sleep(8000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                getRobot().key(KeyEvent.VK_SPACE);
            }
        };
        t.start();

        CWin.message(Clarion.newString("Hello"));
        
        win.close();
    }

    public void testDoubleKeyBugFast()
    {
     
        ClarionWindow win = new ClarionWindow();
        win.setAt(null,null,100,100);
        win.setCenter();
        win.setText("Example");
        
        win.open();
        CWin.alert(Constants.DELETEKEY);
                
        assertTrue(win.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        win.consumeAccept();

        win.setTimer(20);
        assertTrue(win.accept());
        assertEquals(Event.TIMER,CWin.event());
        win.consumeAccept();
        win.setTimer(0);
        
        getRobot().key(KeyEvent.VK_DELETE);
        getRobot().key(KeyEvent.VK_DELETE);

        assertTrue(win.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        win.consumeAccept();

        assertTrue(win.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        win.consumeAccept();

        Thread t = new Thread() {
            public void run() {

                try {
                    Thread.sleep(8000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                getRobot().key(KeyEvent.VK_SPACE);
            }
        };
        t.start();

        CWin.message(Clarion.newString("Hello"));
        
        win.close();
    }
    
    public void testSimpleOk()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(Clarion.newString("Hello"));
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_SPACE);
        
        assertEquals(Button.OK,mb.getResult().intValue());
    }

    public void testSimpleOkWithMnemonic()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(Clarion.newString("Hello"));
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_O);
        
        assertEquals(Button.OK,mb.getResult().intValue());
    }

    public void testSimpleOkWithAltMnemonic()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(Clarion.newString("Hello"));
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_O,KeyEvent.ALT_MASK);
        
        assertEquals(Button.OK,mb.getResult().intValue());
    }

    public void testSimpleOkWithTwoOptions()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Test Message")
                        ,Clarion.newString("Header")
                        ,null
                        ,Button.YES+Button.NO
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertEquals(Button.YES,mb.getResult().intValue());
    }

    public void testSimpleOkWithTwoOptionsOptionBViaTab()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Test Message")
                        ,Clarion.newString("Header")
                        ,Icon.APPLICATION
                        ,Button.ABORT+Button.RETRY+Button.CANCEL
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_TAB);
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertEquals(Button.RETRY,mb.getResult().intValue());
    }

    public void testSimpleOkWith3OptionsOptionCViaSTab()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Test Message")
                        ,Clarion.newString("Header")
                        ,Icon.HAND
                        ,Button.ABORT+Button.RETRY+Button.CANCEL
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertEquals(Button.CANCEL,mb.getResult().intValue());
    }

    
public void testReallyBigMessageB()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Notification Sent. Check Notification History to check delivery status")
                        ,Clarion.newString("Send SMS")
                        ,null
                        ,Button.OK
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertEquals(Button.OK,mb.getResult().intValue());
    }
    
    public void testReallyBigMessage()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Big Message")
                        ,Clarion.newString("Header")
                        ,Icon.HAND
                        ,Button.ABORT+Button.RETRY+Button.CANCEL
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertEquals(Button.CANCEL,mb.getResult().intValue());
    }

    public void testReallyBigMessage2()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really Really\n\nReally Really Really Really Really Really Really Big Message")
                        ,Clarion.newString("Header")
                        ,Icon.HAND
                        ,Button.ABORT+Button.RETRY+Button.CANCEL
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertEquals(Button.CANCEL,mb.getResult().intValue());
    }
    
    public void testSimpleOkWith3OptionsOptionBViaRArrow()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Test Message")
                        ,Clarion.newString("Header")
                        ,Icon.QUESTION
                        ,Button.ABORT+Button.RETRY+Button.CANCEL
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_RIGHT);  
        getRobot().key(KeyEvent.VK_ENTER);
            

        
        assertEquals(Button.RETRY,mb.getResult().intValue());
    }

    public void testSimpleOkWith3OptionsOptionBViaLArrow()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Test Message")
                        ,Clarion.newString("Header")
                        ,Icon.HELP
                        ,Button.ABORT+Button.RETRY+Button.CANCEL
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_LEFT);  
        getRobot().key(KeyEvent.VK_ENTER);

        assertEquals(Button.CANCEL,mb.getResult().intValue());
    }
    
    public void testSimpleOkWithTwoOptionsOptionBViaDefault()
    {
        MsgBox mb = new MsgBox() {
            @Override
            public int message() {
                return CWin.message(
                        Clarion.newString("Test Message")
                        ,Clarion.newString("Header")
                        ,Icon.EXCLAMATION
                        ,Button.YES+Button.NO
                        ,Button.NO
                );
            }
        };
        
        mb.start();
        
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertEquals(Button.NO,mb.getResult().intValue());
    }
    
}
