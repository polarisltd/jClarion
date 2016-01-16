package org.jclarion.clarion.appgen.template;

import java.io.Reader;

public class MarkedStringReader extends Reader
{
	private String source;
	private int pos;
	private int len;
	private int mark;



	public MarkedStringReader(String source,int pos)
	{
		this.source=source;
		this.pos=pos;
		len =this.source.length();
	}
	
	public int getPos()
	{
		return pos;
	}
	
	@Override
	public int read(char[] cbuf, int off, int len) 
	{
		int remain=len-pos;
		if (remain==0) return -1;
		if (len>remain) len=remain;
		source.getChars(pos,pos+len,cbuf, off);
		pos+=len;
		return len;
	}

		
	@Override
	public int read() 
	{
		if (pos==len) return -1;
		return source.charAt(pos++);
	}
	
	
	@Override
	public long skip(long n)
	{
		int remain=len-pos;
		if (n>remain) {
			n=remain;			
		}
		pos+=n;
		return n;
	}

	@Override
	public boolean markSupported() {
		return true;
	}

	@Override
	public void mark(int readAheadLimit)
	{
		mark=pos;
	}

	@Override
	public void reset()
	{
		pos=mark;
	}

	@Override
	public void close() 
	{
	}

	public void setLength(int pos) 
	{
		len=pos;
	}

}
