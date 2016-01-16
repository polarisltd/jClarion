package org.jclarion.clarion.file;

import java.io.IOException;
import java.io.InputStream;

public class SkipSafeInputStream extends InputStream {

	private InputStream base;

	public SkipSafeInputStream(InputStream base)
	{
		this.base=base;
	}

	@Override
	public int read() throws IOException {
		return base.read();
	}

	@Override
	public int read(byte[] b) throws IOException {
		return base.read(b);
	}

	@Override
	public int read(byte[] b, int off, int len) throws IOException {
		return base.read(b, off, len);
	}
	
	private byte[] skipBuffer;

	@Override
	public long skip(long n) throws IOException {
		
		int skip = n>65536 ? 65536 : (int)n; 
		
		if (skipBuffer==null) {
			skipBuffer=new byte[65536];
		}
		return base.read(skipBuffer,0,skip);
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
	public synchronized void mark(int readlimit) {
		base.mark(readlimit);
	}

	@Override
	public synchronized void reset() throws IOException {
		base.reset();
	}

	@Override
	public boolean markSupported() {
		return base.markSupported();
	}
	

}
