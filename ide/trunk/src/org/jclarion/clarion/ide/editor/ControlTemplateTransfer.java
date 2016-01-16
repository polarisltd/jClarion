package org.jclarion.clarion.ide.editor;


import org.eclipse.swt.dnd.ByteArrayTransfer;
import org.eclipse.swt.dnd.TransferData;

/**
 * Serialize/deserialize a field onto the clipboard. 
 * 
 * Internal encoding same as how it is serialized/deserialized as a text file
 * 
 * @author barney
 *
 */
public class ControlTemplateTransfer extends ByteArrayTransfer
{
	private static final String ControlTremplateTransfer = "clarion/controltemplate";
	private static final int    ControlTremplateTransferID = registerType(ControlTremplateTransfer);
	
	private static final String[] ControlTremplateTransferArray = new String[] { ControlTremplateTransfer }; 
	private static final int[] ControlTremplateTransferIDArray = new int[] { ControlTremplateTransferID }; 
	
	@Override
	protected String[] getTypeNames() {
		return ControlTremplateTransferArray;
	}
	
	@Override
	protected int[] getTypeIds() {
		return ControlTremplateTransferIDArray;
	}
	
	private static ControlTemplateTransfer instance=new ControlTemplateTransfer();
	
	public static ControlTemplateTransfer getInstance()
	{
		return instance;
	}
	
	@Override
	protected void javaToNative(Object object, TransferData transferData) 
	{
		if (object==null) return;
		String item = object.toString();
		super.javaToNative(item.getBytes(), transferData);
	}

	@Override
	protected Object nativeToJava(TransferData transferData) 
	{
		 byte[] buffer = (byte[])super.nativeToJava(transferData);
		 if (buffer==null) return null;
		 return new String(buffer);
	}

	
}
