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
package org.jclarion.clarion;

import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.SwingUtilities;

import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.crash.Crash;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.AWTBlocker;



public class ClarionEvent {

    private static Logger log = Logger.getLogger(ClarionEvent.class.getName());
    
    private int                     event;
    private int                     field;
    private boolean                 window;
    private Boolean                 consumeResult;
    private Thread                  clarionThread;
    
    private StackTraceElement[]     creatingThread;
    private AbstractControl         creatingField;

    public static  ClarionEvent test(int event, int field, boolean window) 
    {
        return new ClarionEvent(event,field,window);
    }

    protected ClarionEvent(int event, int field, boolean window) 
    {
        this.event = event;
        this.field=field;
        this.window = window;
    }
    
    public ClarionEvent(int event, AbstractControl field, boolean window) 
    {
        this.event = event;
        if (field!=null) {
            this.field = field.getUseID();
        }
        this.window = window;
        if (CWinImpl.log.isLoggable(Level.FINE)) {
            creatingField=field;
            creatingThread=Thread.currentThread().getStackTrace();
        }
    }
    
    public void setClarionThread(Thread clarionThread)
    {
        this.clarionThread=clarionThread;
    }

    public Thread getClarionThread()
    {
    	return clarionThread;
    }
    

    public int getEvent() {
        return event;
    }

    public int getField() {
        return field;
    }

    public boolean isWindowEvent() {
        return window;
    }
    
    public String toString() {
        return toString(false);
    }

    public String toString(boolean dumpStack) {
        StringBuilder sb = new StringBuilder();
        sb.append("Event[Event:");
        String es = CWin.eventString(event);
        if (es!=null) {
            sb.append(es);
        } else {
            sb.append(event);
        }
        if (creatingField!=null) {
            sb.append(" field:");
            sb.append(creatingField.getId());
        } else {
            if (field!=0) {
                sb.append(" Field:");
                sb.append(field);
            }
        }
        sb.append(" W:");
        sb.append(window);

        sb.append(" C:");
        sb.append(consumeResult);
        
        sb.append("]");
        
        if (dumpStack && creatingThread!=null) {
            int until=5;
            if (until>creatingThread.length) until=creatingThread.length;
            for (int scan=2;scan<until;scan++) {
                sb.append("\n   ");
                sb.append(creatingThread[scan].toString());
            }
        }
        
        return sb.toString();
   }

    public String debugString() {
        
        
        return "Event[Event:" + event + " Field:" + field + " Window:" + window
                + " Consume:" + consumeResult + "]";
    }

    public Boolean getConsumeResultNoWait() {
        synchronized (this) {
            return consumeResult;
        }
    }

    private Runnable runOnConsumedResult = null;

    public Boolean runOnConsumedResult(Runnable run) {
        synchronized (this) {
            if (consumeResult != null) return consumeResult;
            runOnConsumedResult = run;
        }
        return null;
    }

    public boolean getConsumeResult() {

        synchronized (this) {
            while (consumeResult != null) return consumeResult;
        }
        
        if (SwingUtilities.isEventDispatchThread() && clarionThread!=null) {
            
            AWTBlocker blocker = AWTBlocker.getInstance(clarionThread);
            
            try {
                blocker.setBlockState(true);
                return doGetConsumeResult();
            } finally {
                blocker.setBlockState(false);
            }
        }
        
        return doGetConsumeResult();
    }        
        
    private boolean doGetConsumeResult()
    {
        long start = System.currentTimeMillis();
        
        long warn = start+5000;
        long end  = start+15000;
        
        synchronized (this) {
            while (consumeResult == null) {
                
                long now = System.currentTimeMillis(); 
                
                if (now>=end) {
                    consume(true);
                    Crash.getInstance().log("Task is taking a long time");
                    Crash.getInstance().logAllThreads();
                    Crash.getInstance().threadCrash();
                    return true;
                }
                
                if (now>=warn) {
                    log.warning("Task is taking a long time");
                    CWin.getInstance().debugStack();
                    for (Entry<Thread, StackTraceElement[]> e : Thread.getAllStackTraces().entrySet() ) {
                        System.out.println(e.getKey());
                        for (StackTraceElement line : e.getValue()) {
                            System.out.println(" "+line.toString());
                        }
                    }
                }
                
                try {
                    wait(5000);
                } catch (InterruptedException ex) {
                }
            }
            return consumeResult;
        }
    }

    public void consume(boolean isConsumed) {
        Runnable doRun;
        synchronized (this) {
            if (consumeResult!=null) return;
            consumeResult = isConsumed;
            doRun = runOnConsumedResult;
            notifyAll();
        }
        if (doRun != null) {
            doRun.run();
        }
    }
}
    
    

