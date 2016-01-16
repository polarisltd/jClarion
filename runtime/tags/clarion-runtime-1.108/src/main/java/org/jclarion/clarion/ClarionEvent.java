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
import org.jclarion.clarion.swing.AWTController;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.RemoteSemaphore;
import org.jclarion.clarion.swing.gui.RemoteTypes;



public class ClarionEvent implements AWTController, RemoteSemaphore
{
    private static Logger log = Logger.getLogger(ClarionEvent.class.getName());
    
    private int                     event;
    private int                     field;
    private boolean                 window;
    private int						seqID;
    private Boolean                 consumeResult;
    private Thread                  clarionThread;
    private Object[]				data;
    
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
        creatingField=field;
        if (CWinImpl.log.isLoggable(Level.FINE)) {
            creatingThread=Thread.currentThread().getStackTrace();
        }
    }
    
    public ClarionEvent() {
	}

    public void setSeqID(int id)
    {
    	this.seqID=id;
    }
    
    public int getSeqID()
    {
    	return seqID;
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
    
    public AbstractControl creatingField()
    {
    	return creatingField;
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
        
        if (SwingUtilities.isEventDispatchThread()) {
            AWTBlocker blocker = AWTBlocker.getInstance();
            blocker.setController(this);
        }
        return doGetConsumeResult();
    }        
    
    private Runnable runWhileWaiting=null;
    
    
	@Override
	public boolean runTask(Runnable r) {
    	synchronized(this) {
            if (consumeResult != null) return false;
            while (runWhileWaiting!=null) {
            	try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
            	continue;
            }
            runWhileWaiting=r;
            notifyAll();
    	}

    	synchronized(this) {
    		while (runWhileWaiting==r) {
            	try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}    			
    		}
    	}
    	return true;
    }
        
    private boolean doGetConsumeResult()
    {
        long start = System.currentTimeMillis();
        
        long warn = start+5000;
        long end  = start+15000;
        
        while (true) {
        	Runnable r=null;
        	synchronized (this) {
        		r=runWhileWaiting;
        	}
        	if (r!=null) {
        		try {
        			r.run();
        		} catch (Exception ex) { 
        			ex.printStackTrace();
        		}
            	synchronized (this) {
            		if (r==runWhileWaiting) {
            			runWhileWaiting=null;
            			notifyAll();
            			continue;
            		}
            	}
        	}
        	synchronized (this) {
        		if (runWhileWaiting!=null) continue;
            	if (consumeResult!=null) return consumeResult; 
                
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
        }
    }
    
    public void cancel()
    {
    	consume(true);
    }

    public void consume(boolean isConsumed) {
        Runnable doRun;
        synchronized (this) {
            if (consumeResult!=null) return;
            consumeResult = isConsumed;
            doRun = runOnConsumedResult;
            notifyAll();
        }
        
        if (remote!=null) {
        	remote.send(this,isConsumed);
        	remote.dispose(this);
        }
        
        if (doRun != null) {
            doRun.run();
        }
    }

    private int id;
    private GUIModel remote;
    
	@Override
	public int getID() {
		return id;
	}

	@Override
	public Object[] getMetaData() {
		if (data==null) {
			return new Object[] { this.event,this.field,this.creatingField,this.window,this.seqID };
		} else {
			return new Object[] { this.event,this.field,this.creatingField,this.window,this.seqID,this.data };
		}
	}

	@Override
	public void setMetaData(Object[] o) {
		event=(Integer)o[0];
		field=(Integer)o[1];
		creatingField=(AbstractControl)o[2];
		window=(Boolean)o[3];
		seqID=(Integer)o[4];
		if (o.length>5) {
			data=(Object[])o[5];
		}
	}
	
	@Override
	public int getType() {
		return RemoteTypes.SEM_EVENT;
	}

	@Override
	public void notify(Object result) 
	{
		consume((Boolean)result);
	}

	@Override
	public void setID(int id) {
		this.id=id;
	}

	@Override
	public void setID(int id,GUIModel remote) {
		this.id=id;
		this.remote=remote;
	}
	
	private boolean networkSemaphore=false;

	public void setNetworkSemaphore(boolean aSet)
	{
		networkSemaphore=aSet;
	}
	
	@Override
	public boolean isNetworkSemaphore() {
		return networkSemaphore;
	}

	public void setAdditionalData(Object... data) {
		this.data=data;
	}
	
	public Object[] getAdditionalData()
	{
		return data;
	}
}
    
    

