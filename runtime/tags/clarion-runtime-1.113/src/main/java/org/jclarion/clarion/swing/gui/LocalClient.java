package org.jclarion.clarion.swing.gui;

import java.util.Arrays;

import javax.swing.SwingUtilities;

import org.jclarion.clarion.swing.AWTBlocker;

public class LocalClient extends GUIModel
{
	@Override
	public void send(final RemoteWidget w, final int command, final Object... params) {
        if (SwingUtilities.isEventDispatchThread() || !w.isGuiCommand(command)) {
        	w.command(command,params);
        } else {
            SwingUtilities.invokeLater(new Runnable() {
            	public void run() {
                	w.command(command,params);            		
            	}
            });
        }
	}

	@Override
	public void send(final RemoteWidget w,final ResponseRunnable nextTask,
			final int command,final Object... params) {
        if (SwingUtilities.isEventDispatchThread() || !w.isGuiCommand(command)) {
        	Object result=w.command(command,params);
        	if (nextTask!=null) nextTask.run(result);
        } else {

        	/*
            SwingUtilities.invokeLater(new Runnable() {
            	public void run() {
                	Object result = w.command(command,params);            		
                	if (nextTask!=null) nextTask.run(result);
            	}
            });
            */
            
           	AWTBlocker.getInstance().runAsSoonAsPossibleOnSwing(
           			new Runnable() {
           				public void run() {
           					Object o = w.command(command,params);
           					if (nextTask!=null) nextTask.run(o);
           				}

           				public String toString()
           				{
           					return w.getClass()+" "+w.getCommandList().getName(command)+" "+Arrays.toString(params);
           				}
           				
           			},w.isModalCommand(command),false);
         }		
	}

	@Override
	public Object sendRecv(final RemoteWidget w,final int command,final Object... params) {
        if (SwingUtilities.isEventDispatchThread() || !w.isGuiCommand(command)) {
        	return w.command(command,params);
        } else {
        	final Object[] result=new Object[1];
           	AWTBlocker.getInstance().runAsSoonAsPossibleOnSwing(
           			new Runnable() {
           				public void run() {
           					result[0]=w.command(command,params);            		
           				}

           				public String toString()
           				{
           					return w.getClass()+" "+w.getCommandList().getName(command)+" "+Arrays.toString(params);
           				}
               			
           			},w.isModalCommand(command),true);
            return result[0];
        }
	}

	@Override
	public void send(RemoteSemaphore rs, Object result) 
	{
		throw new IllegalStateException("Should never be called");
	}

	@Override
	public boolean isLocal() {
		return true;
	}

}
