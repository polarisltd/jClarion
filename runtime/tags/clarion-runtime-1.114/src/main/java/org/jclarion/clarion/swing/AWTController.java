package org.jclarion.clarion.swing;

public interface AWTController {
	public boolean runTask(Runnable r);
	public void cancel();
}
