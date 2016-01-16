package org.jclarion.clarion.ide.editor.rule;

import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.jclarion.clarion.lang.AbstractLexStream;

public class DocumentLexStream extends AbstractLexStream
{
	private char[]			  buffer=new char[512];
	private IDocument		  document;
	private int 			  buffMark=-1;
	private int				  buffOfs;
	private int 			  buffEnd;
	private int				  docOfs;
	private int 			  docLen;
	private int				  readDocOfs;
	
	public DocumentLexStream(IDocument base,int ofs,int len)
	{
		document=base;
		this.docOfs=ofs;
		this.docLen=len;
		this.readDocOfs=ofs;
	}

	@Override
	public int getEOFPosition(int ofs) 
	{
        if (!eof(ofs)) return -1;
        return buffEnd-buffOfs;
	}


	@Override
	public boolean eof(int ofs) {
		fillBuffer(ofs+1);
		return docLen==0 && this.buffOfs+ofs>=this.buffEnd;
	}

	@Override
	public char peek(int ofs) {
		fillBuffer(ofs+1);	
		if (docLen==0 && this.buffOfs+ofs>=this.buffEnd) return 0;
		return buffer[this.buffOfs+ofs]; 
	}

	@Override
	protected char readChar() {
		if (docLen==0 && this.buffOfs>=this.buffEnd) return 0;
		fillBuffer(1);	
		char result = buffer[buffOfs++];
		if (buffOfs==buffEnd  && buffMark==-1) {
			buffOfs=0;
			buffEnd=0;
		}
		readDocOfs++;
		return result;
	}
	
	private void fillBuffer(int len) 
	{
		if (docLen==0) return;		
		if (len<=this.buffEnd-this.buffOfs) return;
		
		int eOfs=0;
		int eLen=0;
		if (buffMark==-1) {
			eOfs=buffOfs;
			eLen=len;
		} else {
			eOfs=buffMark;
			eLen=len+buffOfs-buffMark;
		}
		
		if (eLen>buffer.length) {
			char[] newBuffer=new char[eLen<<1];
			System.arraycopy(buffer,eOfs,newBuffer,0,buffEnd-eOfs);
			resetBufferToZero(eOfs);
			buffer=newBuffer;
		}
		
		if (this.buffOfs+eLen>buffer.length) {
			System.arraycopy(buffer,eOfs,buffer,0,buffEnd-eOfs);
			resetBufferToZero(eOfs);
		}
		
		len=len-(buffEnd-buffOfs);
		if (len<buffer.length-buffEnd) {
			len=buffer.length-buffEnd;
		}
		if (len>docLen) {
			len=docLen;
		}
				
		if (len==0) return;
		try {
			document.get(docOfs,len).getChars(0,len,buffer,buffEnd);
		} catch (BadLocationException e) {
			e.printStackTrace();
		}
		buffEnd+=len;
		docLen-=len;
		docOfs+=len;
	}
	
	public void mark()
	{
		buffMark=buffOfs;
	}
	
	public void unmark()
	{
		buffMark=-1;
	}
	
	public void rewind()
	{
		if (buffMark==-1) return;
		readDocOfs=readDocOfs-buffOfs+buffMark;
		buffOfs=buffMark;
		buffMark=-1;
	}

	
	private void resetBufferToZero(int eOfs) {
		buffEnd=buffEnd-eOfs;
		buffOfs=buffOfs-eOfs;
		if (buffMark>-1) buffMark=0;
	}

	public int getDocumentOffset()
	{
		return readDocOfs;
	}
	
	public String toString()
	{
		return "M:"+buffMark+" O:"+buffOfs+" E:"+buffEnd+" L:"+buffer.length;
	}
}
