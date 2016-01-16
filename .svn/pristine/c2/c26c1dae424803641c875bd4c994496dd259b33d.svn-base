package org.jclarion.clarion.ide.editor;


import org.eclipse.swt.dnd.ByteArrayTransfer;
import org.eclipse.swt.dnd.TransferData;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionLoader;

/**
 * Serialize/deserialize a field onto the clipboard. 
 * 
 * Internal encoding same as how it is serialized/deserialized as a text file
 * 
 * @author barney
 *
 */
public class DefinitionTransfer extends ByteArrayTransfer
{
	private static final String DefinitionTransfer = "clarion/definition";
	private static final int    DefinitionTransferID = registerType(DefinitionTransfer);
	
	private static final String[] DefinitionransferArray = new String[] { DefinitionTransfer }; 
	private static final int[] DefinitionTransferIDArray = new int[] { DefinitionTransferID }; 
	
	@Override
	protected String[] getTypeNames() {
		return DefinitionransferArray;
	}
	
	@Override
	protected int[] getTypeIds() {
		return DefinitionTransferIDArray;
	}
	
	private static DefinitionTransfer instance=new DefinitionTransfer();
	
	public static DefinitionTransfer getInstance()
	{
		return instance;
	}
	
	public static String encode(Definition f)
	{
		return f.render();
	}
	
	public static Definition decode(String src)
	{
		return DefinitionLoader.loadItem(src);
	}
	
	
	@Override
	protected void javaToNative(Object object, TransferData transferData) 
	{
		if (object==null) return;
		if (!(object instanceof Definition)) return;
		
		String item = encode((Definition)object);
		super.javaToNative(item.getBytes(), transferData);
	}

	@Override
	protected Object nativeToJava(TransferData transferData) 
	{
		 byte[] buffer = (byte[])super.nativeToJava(transferData);
		 if (buffer==null) return null;
		 String s = new String(buffer);
		 return decode(s);
	}

	
}
