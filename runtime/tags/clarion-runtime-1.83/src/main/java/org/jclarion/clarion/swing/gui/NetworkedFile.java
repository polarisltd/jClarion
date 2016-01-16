package org.jclarion.clarion.swing.gui;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.jclarion.clarion.file.RingBufferedInputStreamClarionFile;

public class NetworkedFile extends RingBufferedInputStreamClarionFile
{
	private int id;
	private String name;
	private int len=-1;
	
	public NetworkedFile(String name,int id) throws FileNotFoundException
	{
		this.name=name;
		this.id=id;
		FileServer.getInstance().open(id,name);
	}
	
	@Override
	public long length() throws IOException {
		if (len==-1) {
			len=FileServer.getInstance().length(id);
		}
		return len;
	}
	
	private int writeBufferPos=0;
	private byte[] writeBuffer=new byte[16384];
	private int writeBufferLen=0;
	
	public void flush(boolean wait)
	{
		if (writeBufferLen==0) return;
		if (wait) {
			FileServer.getInstance().flush(id,writeBufferPos,pack(writeBuffer,writeBufferLen));
		} else {
			FileServer.getInstance().write(id,writeBufferPos,pack(writeBuffer,writeBufferLen));			
		}
		writeBufferLen=0;
	}

	private byte[] pack(byte buffer[],int len)
	{
		if (buffer.length==len) return buffer;
		byte[] b = new byte[len];
		System.arraycopy(buffer,0,b,0,len);
		return b;
	}
	
	@Override
	public void write(byte[] buff, int pos, int len) throws IOException {
		super.closeStream();
		
		if (len+writeBufferLen>writeBuffer.length || len>writeBuffer.length/2) {
			flush(false);
		}

		if (len<writeBuffer.length/2) {
			if (writeBufferLen!=0 && writeBufferPos+writeBufferLen!=position()) {
				flush(false);
			}
		}
		
		if (len<writeBuffer.length/2) {
			if (writeBufferLen==0) {
				writeBufferPos=(int)position();
			}			
			System.arraycopy(buff,0,writeBuffer,writeBufferLen,len);
			writeBufferLen+=len;
		} else {
			FileServer.getInstance().write(id,(int)position(),pack(buff,len));
		}
		super.adjustPosition(len);
		if (this.len!=-1 && position()>this.len) {
			this.len=(int)position();
		}
	}



	@Override
	protected InputStream createStream() throws IOException {
		return new InputStream() {
			
			public long pos=0;
			
			public long skip(long aSkip)
			{
				pos+=aSkip;
				return aSkip;
			}
			
			@Override
			public int read() throws IOException {
				throw new IOException("Not supported");
			}

			@Override
			public int read(byte[] b, int off, int len) throws IOException 
			{
				byte[] result = FileServer.getInstance().read(id,(int)pos,len);
				if (result==null) throw new IOException("Error on read");
				System.arraycopy(result,0,b,off,result.length);
				pos+=result.length;
				return result.length;
			}			
		};
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public void close() throws IOException
	{
		flush(true);
		super.close();
		FileServer.getInstance().close(id);
	}

	@Override
	public int read(byte[] target, int ofs, int len) throws IOException {
		flush(true);
		return super.read(target, ofs, len);
	}
	
	
}
