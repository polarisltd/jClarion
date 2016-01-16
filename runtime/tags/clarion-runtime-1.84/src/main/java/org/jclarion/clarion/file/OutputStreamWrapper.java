package org.jclarion.clarion.file;

import java.io.IOException;
import java.io.OutputStream;

import org.jclarion.clarion.ClarionRandomAccessFile;

public class OutputStreamWrapper extends OutputStream
{
	private ClarionRandomAccessFile file;
	private byte[] buffer=new byte[8192];
	private int pos=0;
	
	public OutputStreamWrapper(ClarionRandomAccessFile file)
	{
		this.file=file;
	}

	@Override
	public void write(int b) throws IOException {
		if (pos==buffer.length) {
			flush();
		}
		buffer[pos++]=(byte)b;
	}
	
	@Override
	public void write(byte[] b, int off, int len) throws IOException {
		if (len>=buffer.length) {
			flush();
			file.write(b,off,len);
			return;
		}
		if (pos+len>buffer.length) {
			flush();			
		}
		System.arraycopy(b,off,buffer,pos,len);
		pos+=len;
	}

	public void flush() throws IOException
	{
		if (pos>0) {
			file.write(buffer,0,pos);
			pos=0;
		}
	}
	
	public void close() throws IOException
	{
		try {
			flush();			
		} catch (IOException ex) { }
		file.close();
	}

}
