package org.jclarion.clarion.swing.gui;

import java.util.Map;

public abstract class AbstractWidget implements RemoteWidget
{
	@Override
	public void disposeWidget() {
	}

	@Override
	public void addWidget(RemoteWidget child) {
	}

	
	@Override
	public Map<Integer, Object> getChangedMetaData() {
		return null;
	}

	@Override
	public Iterable<? extends RemoteWidget> getChildWidgets() {
		return null;
	}

	private int id;
	
	@Override
	public int getID() {
		return id;
	}

	@Override
	public RemoteWidget getParentWidget() {
		return null;
	}

	@Override
	public boolean isModalCommand(int command) {
		return false;
	}

	@Override
	public void setID(int id) {
		this.id=id;
	}

	@Override
	public void setMetaData(Map<Integer, Object> data) {
	}
}
