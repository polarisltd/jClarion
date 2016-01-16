package org.jclarion.clarion.test;

import org.jclarion.clarion.swing.gui.ResponseRunnable;

public class SimpleServerResponse implements ServerResponse,ResponseRunnable
{
	private Object result;
	private boolean resultSet;
	
	@Override
	public Object getResult() {
		synchronized(this) {
			while ( !resultSet ) {
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			return result;
		}
	}

	@Override
	public void setResult(Object o) {
		synchronized(this) {
			result=o;
			resultSet=true;
			notifyAll();
		}
	}

	@Override
	public void run(Object result) {
		setResult(result);
	}
}
