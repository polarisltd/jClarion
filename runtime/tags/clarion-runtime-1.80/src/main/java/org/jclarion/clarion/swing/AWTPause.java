package org.jclarion.clarion.swing;

import org.jclarion.clarion.swing.gui.ResponseRunnable;

public class AWTPause implements AWTController, ResponseRunnable 
{
	private boolean finished;
	private Object  result;
	private Runnable run;
	
	public AWTPause()
	{
		AWTBlocker.getInstance().setController(this);
	}
	
	public Object getResult()
	{
		while (true) {
			boolean exit=false;
			Runnable runit=null;
			synchronized(this) {
				if (!finished && run==null) {
					try {
						wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					continue;
				}
				if (finished) exit=true;
				runit=run;
			}
			if (runit!=null) {
				try {
					runit.run();
				} catch (Exception ex) { 
				}
				synchronized(this) {
					run=null;
					notifyAll();
				}
			}
			if (exit) break;
		}
		return result;
	}
	
	@Override
	public void run(Object result) 
	{
		synchronized(this) {
			finished=true;
			this.result=result;
			notifyAll();
		}
	}

	@Override
	public void cancel() 
	{
		synchronized(this) {
			if (finished) return;
			finished=true;
			notifyAll();
		}
	}

	@Override
	public boolean runTask(Runnable r) {
		synchronized(this) {
			while (true) {
				if (finished) return false;
				if (run==null) break;
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			run=r;
			notifyAll();
			while (run==r) {
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
}
