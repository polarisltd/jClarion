package org.jclarion.clarion.memory;

import org.jclarion.clarion.runtime.CMemory;

public abstract class CMem implements Cloneable
{
	public abstract CMem clone();
	
	public static CMem create()
	{
		return new CharBufferCMem();
	}

	public static CMem create(int size)
	{
		return new CharBufferCMem(size);
	}
	
	public static byte[] toByteArray(CMem in)
	{
		byte[] result = new byte[in.remaining()];
		for (int scan=0;scan<result.length;scan++) {
			result[scan]=(byte)in.readByte();
		}
		return result;
	}
	
	CMem()	// default constructor
	{
	}
	
	public abstract int remaining();
	
	public abstract int getSize();
	
	public abstract void resetRead();
	
	public abstract void resetWrite();
	
	public abstract void writeByte(int aByte);
	
	public abstract void writeChar(char aChar);
	
	public abstract void skipRead(int scan);
	
	public abstract void skipWrite(int scan);
	
	public boolean hasRemaing(int remain)
	{
		return remaining()>=remain;
	}
	
	public void writeInt(int aInt)
	{
		writeByte(aInt);
		writeByte(aInt>>8);
		writeByte(aInt>>16);
		writeByte(aInt>>24);
	}
	
	public void writeString(CharSequence seq)
	{
		for (int scan=0;scan<seq.length();scan++) {
			writeChar(seq.charAt(scan));
		}
	}
	
	public void writeObject(Object o)
	{
		writeInt(CMemory.address(o));
	}

	public abstract int readByte();
	
	public abstract char readChar();
	
	public int readInt()
	{
		return 
			(readByte()&0xff)
			+((readByte()&0xff)<<8)
			+((readByte()&0xff)<<16)
			+((readByte()&0xff)<<24);
	}

	public final String readString()
	{
		return readString(remaining());
	}
	
	public final String readString(int maxLength)
	{
		if (!hasRemaing(maxLength)) {
			maxLength=remaining();
		}
		DumbAppender da = new DumbAppender(maxLength);
		readString(da,maxLength);
		return new String(da.getCharArray());
	}
	
	public void readString(CMemAppender a,int maxLength)
	{
		if (!hasRemaing(maxLength)) {
			maxLength=remaining();
		}
		while ( maxLength>0 ) {
			a.append(readChar());
			maxLength--;
		}
	}
	
	public Object readObject()
	{
		return CMemory.resolveAddress(readInt()); 
	}

	public final void reset()
	{
		resetRead();
		resetWrite();
	}

	public static void fromByteArray(CMem sos, byte[] sA) {
		for (byte b : sA) {
			sos.writeByte(b);
		}
	}

	public void writeBytes(byte[] buffer, int ofs, int len) 
	{
		len=len+ofs;
		while (ofs<len) {
			writeByte(buffer[ofs++]);
		}
	}
	
	public void readBytes(byte[] buffer,int ofs,int len)
	{
		len=len+ofs;
		while (ofs<len) {
			buffer[ofs++]=(byte)readByte();
		}
	}
}
