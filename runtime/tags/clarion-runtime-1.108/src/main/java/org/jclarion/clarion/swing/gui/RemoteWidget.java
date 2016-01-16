package org.jclarion.clarion.swing.gui;

import java.util.Map;

public interface RemoteWidget {
	public Object command(int command,Object... params);
	public int getID();
	public void setID(int id);
	public Iterable<? extends RemoteWidget> 	getChildWidgets();
	public RemoteWidget getParentWidget();
	public void addWidget(RemoteWidget child);
	public boolean isModalCommand(int command);
	public boolean isGuiCommand(int command);    // if not true then local client doesn't need to deploy to AWT event thread
	public Map<Integer,Object> 		getChangedMetaData();
	public void setMetaData(Map<Integer,Object> data);
	public void disposeWidget();
	public int  getWidgetType();
	public CommandList getCommandList();
}
