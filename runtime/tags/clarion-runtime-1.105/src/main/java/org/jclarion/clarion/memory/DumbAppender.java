package org.jclarion.clarion.memory;

public class DumbAppender implements CMemAppender
{
	private char[] buffer;
	private int pos;
	
	public DumbAppender(int size)
	{
		buffer=new char[size];
	}

	@Override
	public void append(char c) {
		buffer[pos++]=c;
	}
	
	public char[] getCharArray()
	{
		return buffer;
	}

}
