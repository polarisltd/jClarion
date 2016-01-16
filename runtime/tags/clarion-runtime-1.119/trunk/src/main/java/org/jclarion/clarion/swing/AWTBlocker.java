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

import java.lang.reflect.InvocationTargetException;
import java.util.LinkedList;

import javax.swing.SwingUtilities;

public class AWTBlocker implements Runnable
{
	private static AWTBlocker blocker=new AWTBlocker();
    
    public static AWTBlocker getInstance()
    {
    	return blocker;
    }

    public AWTBlocker()
    {
    }
    
    private AWTController current;
    private int modalCount=0;
    private LinkedList<RunOnlyOnce> tasks=new LinkedList<RunOnlyOnce>();
    
    public void alterModal(int count)
    {
    	AWTController abort=null;
    	
    	synchronized(this) {
    		modalCount+=count;
    		if (modalCount>0) {
    			abort=current;
    			current=null;
    		}
    	}
    	if (abort!=null) abort.cancel();
    }
    
    public void setController(AWTController newController)
    {
    	AWTController abort=null;
    	synchronized(this) {
    		if (modalCount>0) {
    			abort=newController;
    		} else {
    			current=newController;
    			notifyAll();
    		}
    	}
    	if (abort!=null) abort.cancel();
    }
    
    private class ModalTask implements Runnable
    {
    	private Runnable base;
    	
		public ModalTask(Runnable base)
    	{
    		this.base=base;
    	}

		@Override
		public void run() {
			alterModal(-1);
			base.run();
		}
    }
    
    private class RunOnlyOnce implements Runnable
    {
    	private Runnable base;
		private Object monitor;
		private boolean finished;

		public RunOnlyOnce(Runnable base,Object monitor)
    	{
    		this.base=base;
    		this.monitor=monitor;
    	}
		
		public void run()
		{
			Runnable run=null;
			synchronized(monitor) {
				run=base;
				base=null;
				monitor.notifyAll();
			}
			if (run==null) return;
			try {
				run.run();
			} finally {
				synchronized(monitor) {
					finished=true;
					monitor.notifyAll();
				}
			}			
		}
		
		public boolean isFinished()
		{
			synchronized(monitor) {
				return finished;
			}
		}
		
		public boolean isStarted()
		{
			synchronized(monitor) {
				return base==null;
			}
		}
		
		public void waitUntilFinished()
		{
			synchronized(monitor) {
				while (!finished) {
					try {
						monitor.wait();
					} catch (InterruptedException e) {
						return;
					}
				}
			}			
		}
		
		public String toString()
		{
			return base!=null ? base.toString() : "Empty";
		}
		
    }

    /**
     * Targeted to be short lived call
     * 
     * @param r
     */
    public void runAsSoonAsPossibleOnSwing(Runnable xr,boolean modal,boolean wait ) {
    	if (modal) {
    		alterModal(1);
        	try {
        		if (wait) {
        			SwingUtilities.invokeAndWait(new ModalTask(xr));
        		} else {
        			SwingUtilities.invokeLater(new ModalTask(xr));
        		}
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
        	return;
    	}
    	
    	RunOnlyOnce task=new RunOnlyOnce(xr,this);
    	synchronized(tasks) {
    		tasks.add(task);
    	}
    	Runnable r = this;
    	
    	SwingUtilities.invokeLater(r);
    	
   		while ( true ) {
   			AWTController ctl;
   			synchronized(this) {
   				if (task.isFinished()) break;
   				ctl=current; 
   			}  
   			if (ctl==null || !ctl.runTask(r)) {
       			synchronized(this) {
       				current=null;
       				if (wait) {
       					if (task.isFinished()) break;
       				} else {
       					if (task.isStarted()) break;       					
       				}
       				if (current!=ctl) {
       					continue;
       				}
       				try {
						wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
       			}    		
   			} else {
   				if (wait) {
   					task.waitUntilFinished();
   				} else {
   					break;
   				}
   			}
  		}
    }

	@Override
	public void run() {
		while (true) {
			RunOnlyOnce next=null;	
			synchronized(tasks) {
				if (tasks.isEmpty()) return;
				next=tasks.removeFirst();
			}
			try {
				next.run();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}    
}
