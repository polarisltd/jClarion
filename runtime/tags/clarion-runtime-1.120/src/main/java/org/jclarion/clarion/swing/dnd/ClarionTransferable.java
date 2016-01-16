package org.jclarion.clarion.swing.dnd;

import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.IOException;

import org.jclarion.clarion.control.AbstractControl;

public class ClarionTransferable implements Transferable
{
	public static final DataFlavor ClarionFlavor=new DataFlavor(AbstractControl.class,"jclarion");

	private AbstractControl control;
	
	public ClarionTransferable(AbstractControl control)
	{
		this.control=control;
	}
	
	@Override
	public Object getTransferData(DataFlavor flavor) throws UnsupportedFlavorException, IOException 
	{
		return control;
	}

	@Override
	public DataFlavor[] getTransferDataFlavors() 
	{
		return new DataFlavor[] { ClarionFlavor };
	}

	@Override
	public boolean isDataFlavorSupported(DataFlavor flavor) 
	{
		if (flavor==ClarionFlavor) return true;
		if (flavor.getRepresentationClass()==AbstractControl.class) return true;
		return false;
	}
	
	public AbstractControl getControl()
	{
		return control;
	}
}
