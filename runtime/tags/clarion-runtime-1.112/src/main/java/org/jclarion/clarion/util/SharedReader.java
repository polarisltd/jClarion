package org.jclarion.clarion.util;

import java.io.IOException;
import java.io.Reader;

public class SharedReader extends Reader
{
	private char buffer[];
	private int len;
	private int pos;
	private int mark;
	
	public SharedReader(char buffer[],int len)
	{
		this.buffer=buffer;
		this.len=len;
	}

	@Override
	public void close() throws IOException 
	{
		pos=len;
	}

	@Override
	public int read(char[] cbuf, int off, int len) throws IOException 
	{
		if (len==0) return 0;
		if (this.len-this.pos<len) {
			len=this.len-this.pos;
		}
		if (len<=0) return -1;
		System.arraycopy(this.buffer,pos,cbuf,off,len);
		pos+=len;
		return len;
	}

	@Override
	public void mark(int readAheadLimit) throws IOException {
		this.mark=this.pos;
	}

	@Override
	public boolean markSupported() {
		return true;
	}

	@Override
	public int read() throws IOException {
		if (pos>=len) return -1;
		return buffer[pos++];
	}

	@Override
	public boolean ready() throws IOException {
		return true;
	}

	@Override
	public void reset() throws IOException {
		pos=mark;
	}

	@Override
	public long skip(long n) throws IOException {
		if (n>len-pos) n=len-pos;
		pos+=n;
		return n;
	}
}
