package org.jclarion.clarion.swing.dnd;

import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.dnd.DnDConstants;
import java.awt.dnd.DropTargetDragEvent;
import java.awt.dnd.DropTargetDropEvent;
import java.awt.dnd.DropTargetEvent;
import java.awt.dnd.DropTargetListener;
import java.io.IOException;

import org.jclarion.clarion.control.AbstractControl;

public class ClarionDropTargetListener implements DropTargetListener 
{
	private AbstractControl control;
	
	public ClarionDropTargetListener(AbstractControl control)
	{
		this.control=control;
	}

	private AbstractControl getSource(Transferable t)
	{
		if (!t.isDataFlavorSupported(ClarionTransferable.ClarionFlavor)) return null;
		try {
			return (AbstractControl)t.getTransferData(ClarionTransferable.ClarionFlavor);
		} catch (UnsupportedFlavorException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public void dragEnter(DropTargetDragEvent dtde) {
		AbstractControl src = getSource(dtde.getTransferable());
		if (src!=null && src.dropInto(control)!=null) {
			dtde.acceptDrag(DnDConstants.ACTION_COPY);
		}
	}

	@Override
	public void dragExit(DropTargetEvent dte) {
	}

	@Override
	public void dragOver(DropTargetDragEvent dtde) {
		AbstractControl src = getSource(dtde.getTransferable());
		if (src!=null && src.dropInto(control)!=null) {
			dtde.acceptDrag(DnDConstants.ACTION_COPY);
		}
	}

	@Override
	public void drop(DropTargetDropEvent dtde) {
		AbstractControl src = getSource(dtde.getTransferable());
		if (src!=null) {
			String match = src.dropInto(control);
			if (match!=null) {
				control.getWindowOwner().post(new DragEvent(src,control,match));
			}
			dtde.acceptDrop(DnDConstants.ACTION_COPY);
			dtde.dropComplete(true);
		}
	}

	@Override
	public void dropActionChanged(DropTargetDragEvent dtde) {
	}

}
