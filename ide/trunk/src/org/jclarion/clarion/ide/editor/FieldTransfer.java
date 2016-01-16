package org.jclarion.clarion.ide.editor;

import java.io.ByteArrayInputStream;
import java.io.PrintStream;

import org.eclipse.swt.dnd.ByteArrayTransfer;
import org.eclipse.swt.dnd.TransferData;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.TextAppLoad;
import org.jclarion.clarion.appgen.app.TextAppStore;
import org.jclarion.clarion.util.SharedOutputStream;

/**
 * Serialize/deserialize a field onto the clipboard. 
 * 
 * Internal encoding same as how it is serialized/deserialized as a text file
 * 
 * @author barney
 *
 */
public class FieldTransfer extends ByteArrayTransfer
{
	private static final String FieldTransfer = "clarion/field";
	private static final int    FieldTransferID = registerType(FieldTransfer);
	
	private static final String[] FieldTransferArray = new String[] { FieldTransfer }; 
	private static final int[] FieldTransferIDArray = new int[] { FieldTransferID }; 
	
	@Override
	protected String[] getTypeNames() {
		return FieldTransferArray;
	}
	
	@Override
	protected int[] getTypeIds() {
		return FieldTransferIDArray;
	}
	
	private static FieldTransfer instance=new FieldTransfer();
	
	public static FieldTransfer getInstance()
	{
		return instance;
	}
	
	public static String encode(Field f)
	{
		SharedOutputStream sos = new SharedOutputStream();
		PrintStream ps = new PrintStream(sos);
		TextAppStore store = new TextAppStore();
		store.setTarget(ps);
		store.serializeField(f);
		ps.close();
		return new String(sos.toByteArray());
	}
	
	public static Field decode(String src)
	{
		TextAppLoad load=  new TextAppLoad(null);
		load.setSource("clipboard", new ByteArrayInputStream(src.getBytes()));
		return load.deserializeField();
	}
	
	
	@Override
	protected void javaToNative(Object object, TransferData transferData) 
	{
		if (object==null) return;
		if (!(object instanceof Field)) return;
		
		String item = encode((Field)object);
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
