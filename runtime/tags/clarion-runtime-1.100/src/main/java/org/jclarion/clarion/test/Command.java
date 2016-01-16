package org.jclarion.clarion.test;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.swing.gui.RemoteSemaphore;
import org.jclarion.clarion.swing.gui.RemoteWidget;
import org.jclarion.clarion.swing.gui.ResponseRunnable;

public class Command implements ServerResponse
{
	public RemoteWidget w;
	public int command;
	public Object[] params;
	public ResponseRunnable task;
	public Object response;
	public boolean responseSet;
	
	public Command(RemoteWidget w,ResponseRunnable task, int command, Object... params)
	{
		this.w=w;
		this.command=command;
		this.params=params;
		this.task=task;
	}

	@Override
	public void setResult(Object o) 
	{
		synchronized(this) {
			response=o;
			responseSet=true;
			notifyAll();
		}
		if (task!=null) task.run(o);
	}
	
	public Object getResult()
	{
		return getResponse();
	}
	
	public Object getResponse()
	{
		synchronized(this) {
			while (!responseSet) {
				try {
					this.wait();
				} catch (InterruptedException e) {
					return null;
				}
			}
			return response;
		}
	}
	
	public void shutdown()
	{
		for ( Object o : params ) {
			if (o instanceof RemoteSemaphore) {
				((RemoteSemaphore)o).notify(null);
			}
			if (o instanceof AbstractWindowTarget) {
				((AbstractWindowTarget)o).post(Event.CLOSEDOWN);
			}
		}
		if (w instanceof AbstractWindowTarget) {
			((AbstractWindowTarget)w).post(Event.CLOSEDOWN);
		}
		setResult(null);
	}
}
