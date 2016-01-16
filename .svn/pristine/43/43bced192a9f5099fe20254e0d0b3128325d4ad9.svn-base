package org.jclarion.clarion.ide.editor;

import org.eclipse.swt.dnd.ByteArrayTransfer;
import org.eclipse.swt.dnd.TransferData;
import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.embed.EmbedKey;

/**
 * Serialize/deserialize an embed onto the clipboard. Byte format resembles html.
 * 
 * i.e.
 * 
 * keya:valuea
 * keyb:valueb
 * keyc:valuec
 * <empty line>
 * [content]
 * 
 * @author barney
 *
 */
public class EmbedTransfer extends ByteArrayTransfer
{
	private static final String EmbedTransfer = "clarion.embed";
	private static final int    EmbedTransferID = registerType(EmbedTransfer);
	
	private static final String[] EmbedTransferArray = new String[] { EmbedTransfer }; 
	private static final int[] EmbedTransferIDArray = new int[] { EmbedTransferID }; 
	
	@Override
	protected String[] getTypeNames() {
		return EmbedTransferArray;
	}
	
	@Override
	protected int[] getTypeIds() {
		return EmbedTransferIDArray;
	}
	
	private static EmbedTransfer instance=new EmbedTransfer();
	
	public static EmbedTransfer getInstance()
	{
		return instance;
	}
	
	
	@Override
	protected void javaToNative(Object object, TransferData transferData) 
	{
		if (object==null) return;
		if (!(object instanceof Embed)) return;
		
		Embed e = (Embed)object;
		
		StringBuilder sb= new StringBuilder();
		sb.append("Priority:").append(e.getPriority()).append('\n');
		sb.append("Indent:").append(e.isIndent()).append('\n');
		if (e.getKey()!=null) {
			sb.append("Key:");
			sb.append(e.getKey().getName());
			for (int scan=0;scan<e.getKey().getInstanceCount();scan++) {
				sb.append(",").append(e.getKey().getInstance(scan));
			}
			sb.append('\n');
		}
		sb.append('\n');
		sb.append(e.getValue());
				
		super.javaToNative(sb.toString().getBytes(), transferData);
	}

	@Override
	protected Object nativeToJava(TransferData transferData) 
	{
		 byte[] buffer = (byte[])super.nativeToJava(transferData);
		 if (buffer==null) return null;
		 
		 String s = new String(buffer);
		 
		 int priority=0;
		 boolean indent=false;
		 EmbedKey ekey=null;
		 
		 boolean any=false;
		 while ( true ) {
			 int nl = s.indexOf('\n');
			 if (nl==-1) break;
			 if (nl==0) {
				 s=s.substring(1);
				 break;
			 }
			 
			 int sep = s.indexOf(':');
			 if (sep==-1 || sep>nl) {
				 if (!any) break;
				 s.substring(nl+1);
				 continue;
			 }
			 
			 
			 any=true;
			 
			 String key = s.substring(0,sep);
			 String value = s.substring(sep+1,nl);
			 
			 s=s.substring(nl+1);
			 
			 if (key.equals("Priority")) {
				 priority=Integer.parseInt(value);
			 }
			 if (key.equals("Indent")) {
				 indent=Boolean.parseBoolean(value);
			 }
			 
			 if (key.equals("Key")) {
				 int ne = value.indexOf(',');
				 if (ne==-1) {
					 ekey=new EmbedKey(value);
				 } else {
					 String name = value.substring(0,ne);
					 String bits[] = value.substring(ne+1).split(",");
					 ekey=new EmbedKey(name,bits);
				 }
			 }
		 }
		 
		 Embed e = new Embed(priority,ekey,0);
		 e.setValue(s);
		 e.setIndent(indent);
		 
		 return e;
	}

	
}
