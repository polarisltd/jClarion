package org.jclarion.clarion.memory;

public class CharBufferCMem extends CMem
{
	private char[] 	buffer;
	private int 	readPos;
	private int		writePos;
	
	CharBufferCMem(CharBufferCMem base)
	{
		this.buffer=new char[base.buffer.length];
		System.arraycopy(base.buffer,0,this.buffer,0,base.buffer.length);
		this.readPos=base.readPos;
		this.writePos=base.writePos;
	}
	
	CharBufferCMem() // package level scope
	{
		buffer=new char[128];
	}

	CharBufferCMem(int initSize) // package level scope
	{
		buffer=new char[initSize];
	}
	
	@Override
	public int getSize() {
		return writePos;
	}

	@Override
	public boolean hasRemaing(int remain) {
		return remaining()>=remain;
	}

	@Override
	public int readByte() {
		if (readPos>=writePos) return 0;
		return buffer[readPos++];
	}

	@Override
	public char readChar() {
		if (readPos>=writePos) return 0;
		return buffer[readPos++];
	}

	@Override
	public int remaining() {
		return writePos-readPos;
	}

	@Override
	public void resetRead() {
		readPos=0;
	}

	@Override
	public void resetWrite() {
		writePos=0;
	}

	@Override
	public void writeByte(int aByte) 
	{
		growBuffer(1);
		buffer[writePos++]=(char)(aByte&0xff);
	}

	@Override
	public void writeChar(char aChar) {
		growBuffer(1);
		buffer[writePos++]=aChar;
	}

	private void growBuffer(int increment)
	{
		if (increment<0) return;
		if (writePos+increment<=buffer.length) return;
		
		int new_size=(writePos+increment)<<1;
		
		char new_buffer[] = new char[new_size];
		System.arraycopy(buffer,0,new_buffer,0,writePos);
		buffer=new_buffer;
	}

	@Override
	public void skipRead(int scan) {
		readPos+=scan;
	}

	@Override
	public void skipWrite(int scan) {
		growBuffer(scan);
		writePos+=scan;
	}

	@Override
	public CharBufferCMem clone() {
		return new CharBufferCMem(this);
	}

}
