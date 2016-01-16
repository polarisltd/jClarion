package org.jclarion.clarion.swing.dnd;

import java.awt.dnd.DragGestureEvent;
import java.awt.dnd.DragGestureListener;
import java.awt.dnd.DragSource;

import org.jclarion.clarion.control.AbstractControl;

public class ClarionDragGesture implements DragGestureListener
{
	private AbstractControl control;
	
	public ClarionDragGesture(AbstractControl control)
	{
		this.control=control;
	}
	
	@Override
	public void dragGestureRecognized(DragGestureEvent dge) 
	{
		dge.startDrag(DragSource.DefaultCopyNoDrop,new ClarionTransferable(control),new ClarionDragSourceListener());
	}

}
