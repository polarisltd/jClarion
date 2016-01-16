package org.jclarion.clarion.ide.editor;

import org.jclarion.clarion.ide.model.app.AbstractListenerContainer;

public class EditorCloseProducer
{
	private AbstractListenerContainer<EditorClosedListener> container=new AbstractListenerContainer<EditorClosedListener>();

	public void addEditorCloseListener(EditorClosedListener listener)
	{
		container.add(listener);
	}
	
	public void removeEditorCloseListener(EditorClosedListener listener)
	{
		container.remove(listener);
	}
	
	public void fire()
	{
		for (EditorClosedListener scan : container) {
			scan.editorClosed();
		}
	}
}
