package org.jclarion.clarion.swing.gui;

/**
 * Clarion events and open monitor objects 
 * 
 * @author barney
 */
public interface RemoteSemaphore 
{
	public int 		getID();
	public void 	setID(int id);
	public void 	setID(int id,GUIModel remote);
	public int 		getType();
	public Object[] getMetaData();
	public void 	setMetaData(Object o[]);
	public void		notify(Object result);
	public boolean	isNetworkSemaphore();  // semaphore notification may need to travel over network
}
