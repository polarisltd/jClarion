package org.jclarion.clarion.test;


public abstract class WaitRunnable implements Runnable 
{
	private boolean done;
	private Object result;

	@Override
	public final void run() 
	{
		result = doRun();
		synchronized(this) {
			done=true;
			notifyAll();
		}
	}
	
	public Object getResult()
	{
		synchronized(this) {
			while (!done) {
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}
	
	public abstract Object doRun(); 

}
