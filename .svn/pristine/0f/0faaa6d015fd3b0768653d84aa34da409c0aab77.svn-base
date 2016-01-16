package org.jclarion.clarion.test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

public class TeeStream extends OutputStream
{
	private OutputStream base;
	private byte[] buffer=new byte[4096];
	int pos=0;

	public TeeStream(OutputStream base) throws FileNotFoundException 
	{
		this.base=base;
	}

	@Override
	public void close() throws IOException {
		base.close();
	}

	@Override
	public void flush() throws IOException {
		base.flush();
	}

	@Override
	public void write(byte[] b, int off, int len) throws IOException {
		base.write(b, off, len);
		resize(len);
		System.arraycopy(b,off,buffer,pos,len);
		pos+=len;
	}

	@Override
	public void write(byte[] b) throws IOException {
		base.write(b);
		resize(b.length);
		System.arraycopy(b,0,buffer,pos,b.length);
		pos+=b.length;
	}

	@Override
	public void write(int b) throws IOException {
		base.write(b);
		resize(1);
		buffer[pos++]=(byte)b;
	}
	

	private void resize(int len)
	{
		if (pos+len<=buffer.length) return;
		int newSize=buffer.length<<1;
		while (newSize<pos+len) {
			newSize=newSize<<1;
		}
		byte nb[]=new byte[newSize];
		System.arraycopy(buffer,0,nb,0,pos);
		buffer=nb;
	}
	
	public void rewrite(OutputStream out) throws IOException
	{
		out.write(buffer,0,pos);
	}
}
