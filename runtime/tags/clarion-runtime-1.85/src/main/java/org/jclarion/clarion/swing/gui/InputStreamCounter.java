package org.jclarion.clarion.swing.gui;

import java.io.IOException;
import java.io.InputStream;

public class InputStreamCounter extends InputStream
{
	private InputStream base;
	private long counter;
	
	
	public InputStreamCounter(InputStream base)
	{
		this.base=base;
	}

	public long getCounter()
	{
		return counter;
	}
	
	public void resetCounter()
	{
		counter=0;
	}
	
	
	@Override
	public int read() throws IOException {
		int val = base.read();
		if (val>-1) counter++;
		return val;
	}

	@Override
	public int available() throws IOException {
		return base.available();
	}

	@Override
	public void close() throws IOException {
		base.close();
	}

	@Override
	public int read(byte[] b, int off, int len) throws IOException {
		int r= base.read(b, off, len);
		if (r>0) counter+=r;
		return r;
	}

	@Override
	public int read(byte[] b) throws IOException {
		int r= base.read(b);
		if (r>0) counter+=r;
		return r;
	}

	@Override
	public long skip(long n) throws IOException {
		long s=base.skip(n);
		if (s>0) counter+=s;
		return s;
	}
	
	
}
