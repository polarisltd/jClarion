package org.jclarion.clarion.swing.gui;

public class RemoteResponse 
{
	private Object response;
	private boolean responseSet;
	public ResponseRunnable run;
	
	public RemoteResponse()
	{
	}
	
	public void setResponse(Object response)
	{
		synchronized(this) {
			this.response=response;
			responseSet=true;
			notifyAll();
		}
		if (run!=null) {
			run.run(response);
		}
	}
	
	public Object waitForResponse()
	{
		synchronized(this) {
			while (!responseSet) {
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			return response;
		}
	}
	
	public boolean isResponseReady(long wait)
	{
		long until = System.currentTimeMillis()+wait;
		synchronized(this) {
			while (!responseSet) {
				long waitNow = until-System.currentTimeMillis();
				if (waitNow<=0) return false;
				try {
					wait(waitNow);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
}
