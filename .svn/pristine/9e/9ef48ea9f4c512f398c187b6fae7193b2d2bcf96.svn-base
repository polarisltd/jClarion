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

import javax.swing.SwingUtilities;

public class AWTBlocker 
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
			try {
				base.run();
			} finally {
				alterModal(-1);
			}
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
    }

    /**
     * Targeted to be short lived call
     * 
     * @param r
     */
    public void runAsSoonAsPossibleOnSwing(Runnable xr,boolean modal ) {

    	if (modal) {
    		alterModal(1);
        	try {
				SwingUtilities.invokeAndWait(new ModalTask(xr));
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
        	return;
    	}
    	
    	RunOnlyOnce task=new RunOnlyOnce(xr,this);
    	SwingUtilities.invokeLater(task);
    	
   		while ( true ) {
   			AWTController ctl;
   			synchronized(this) {
   				if (task.isFinished()) break;
   				ctl=current; 
   			}  
   			if (ctl==null || !ctl.runTask(task)) {
       			synchronized(this) {
       				current=null;
       				if (task.isFinished()) break;
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
   				task.waitUntilFinished();
   			}
  		}
    }    
}
