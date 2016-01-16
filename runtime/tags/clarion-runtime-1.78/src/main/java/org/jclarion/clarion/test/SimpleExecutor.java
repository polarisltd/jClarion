package org.jclarion.clarion.test;

import java.util.LinkedList;

public class SimpleExecutor extends Thread
{
	public SimpleExecutor(String name)
	{
		super(name);
		setDaemon(true);
	}

	private LinkedList<Runnable> tasks=new LinkedList<Runnable>();
	
	public void deploy(Runnable r) {
		synchronized(tasks) {
			tasks.add(r);
			tasks.notifyAll();
		}
	}
	
	public void run()
	{
		while (true) {
			Runnable next=null;
			synchronized(tasks) {
				while (tasks.isEmpty()) {
					try {
						tasks.wait();
					} catch (InterruptedException e) {
						return;
					}
				}
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
