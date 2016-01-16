package org.jclarion.clarion.swing.gui;


public class LocalServer extends GUIModel
{
	@Override
	public void send(final RemoteWidget w, final int command, final Object... params) {
		w.command(command,params);
	}

	@Override
	public void send(final RemoteWidget w,final ResponseRunnable nextTask,
			final int command,final Object... params) {
       	Object result=w.command(command,params);
       	if (nextTask!=null) nextTask.run(result);
	}

	@Override
	public Object sendRecv(final RemoteWidget w,final int command,final Object... params) {
       	return w.command(command,params);
	}

	@Override
	public void send(RemoteSemaphore rs, Object result) 
	{
		throw new IllegalStateException("Should never be called");
	}

}
