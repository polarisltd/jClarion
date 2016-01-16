package org.jclarion.clarion.memory;

/**
 * only to be used for strict binary streams. i.e. DOS file driver
 * 
 * @author barney
 *
 */
public class ByteBufferCMem extends CMem
{
	private byte[] 	buffer;
	private int 	readPos;
	private int		writePos;
	
	ByteBufferCMem(ByteBufferCMem base)
	{
		this.buffer=new byte[base.buffer.length];
		System.arraycopy(base.buffer,0,this.buffer,0,base.buffer.length);
		this.readPos=base.readPos;
		this.writePos=base.writePos;
	}

	public ByteBufferCMem() // package level scope
	{
		buffer=new byte[128];
	}

	public ByteBufferCMem(int initSize) // package level scope
	{
		buffer=new byte[initSize];
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
		return (char)buffer[readPos++];
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
		buffer[writePos++]=(byte)(aByte&0xff);
	}

	@Override
	public void writeChar(char aChar) {
		growBuffer(1);
		buffer[writePos++]=(byte)aChar;
	}

	private void growBuffer(int increment)
	{
		if (increment<0) return;
		if (writePos+increment<=buffer.length) return;
		
		int new_size=(writePos+increment)<<1;
		
		byte new_buffer[] = new byte[new_size];
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
	
	public byte[] getBytes()
	{
		return buffer;
	}

	@Override
	public ByteBufferCMem clone() {
		return new ByteBufferCMem(this);
	}
}
