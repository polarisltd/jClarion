package org.jclarion.clarion.appgen.template;

import java.io.IOException;
import java.io.Reader;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;


import org.jclarion.clarion.util.SharedWriter;

public class BufferedWriteTarget extends WriteTarget
{
	private int length=0;
	private LinkedList<BufferedSegment> segments =new LinkedList<BufferedSegment>();
	private BufferedSegment currentSegment=null;

	public BufferedWriteTarget()
	{		
	}
	
	public void reset()
	{
		segments.clear();
		currentSegment=null;
		length=0;
	}
	
	public String getBuffer()
	{
		StringBuilder sb = new StringBuilder(getCharsWritten());
		for (BufferedSegment bs : segments) {
			sb.append(bs.getWriter().getBuffer(),0,bs.getWriter().getSize());
		}
		return sb.toString();
	}
	
	public SharedWriter asSharedWriter()
	{
		SharedWriter sw = new SharedWriter(getCharsWritten());
		for (BufferedSegment bs : segments) {
			sw.write(bs.getWriter().getBuffer(),0,bs.getWriter().getSize());
		}
		return sw;		
	}

	private BufferedSegment getSegment()
	{
		if (currentSegment==null) {
			currentSegment=new BufferedSegment();
			segments.add(currentSegment);
		}
		return currentSegment;
	}
	
	public boolean hasMetaData()
	{
		return !getSegment().getMetaData().isEmpty() && getSegment().getWriter().length()==0;
	}
	
	@Override
	public BufferedWriteTarget append(CharSequence csq) 
	{		
		getSegment().getWriter().append(csq,0,csq.length());
		return this;
	}

	@Override
	public WriteTarget append(CharSequence csq, int start, int end) 
	{
		getSegment().getWriter().append(csq,start,end);
		return this;
	}

	@Override
	public WriteTarget append(char c) 
	{
		getSegment().getWriter().append(c);
		return this;
	}

	@Override
	public int getCharsWritten() {
		return (currentSegment==null ? 0 : currentSegment.getWriter().getSize())+length;
	}
	
	@Override
	public void setCharsWritten(int length) 
	{
		if (currentSegment==null) {
			this.length=length;
		} else {
			this.length=length-currentSegment.getWriter().getSize();
		}
	}	
	
	
	public void flushInto(WriteTarget target) throws IOException
	{
		target.clearMarkup();
		for (BufferedSegment s : segments) {
			for (Map.Entry<String,Object> scan : s.getMetaData().entrySet()) {
				target.markup(scan.getKey(),scan.getValue());
			}
			target.append(s.getWriter());
			target.clearMarkup();
		}
	}
	
	@Override
	public void markup(String key,Object markup) 
	{
		if (getSegment().getWriter().length()>0) {
			clearMarkup();
		}
		getSegment().setMetaData(key, markup);
	}

	@Override
	public void clearMarkup() 
	{
		if (getSegment().isEmpty()) return;
		length+=currentSegment.getWriter().length();
		currentSegment=null;
	}
	
	private class MyReader extends Reader
	{
		private Iterator<BufferedSegment> segment;
		private SharedWriter writer;
		private int ofs;
		
		private MyReader()
		{
			segment=segments.iterator();
		}
		
		private boolean prepWriter()
		{
			while ( true ) {
				if (writer!=null && writer.getSize()<=ofs) writer=null;
				if (writer!=null) return true;
				if (!segment.hasNext()) return false;
				writer=segment.next().getWriter();
				ofs=0;
			}
		}
		
		@Override
		public int read(char[] cbuf, int off, int len) throws IOException 
		{
			if (!prepWriter()) return -1;
			int remain = writer.getSize()-ofs;
			if (remain<len) len=remain;
			System.arraycopy(writer.getBuffer(),ofs,cbuf,off,len);
			ofs+=len;
			return len;
		}

		@Override
		public void close() throws IOException 
		{
		}

		@Override
		public long skip(long n) throws IOException 
		{
			long orig=n;
			while (n>0) {
				if (!prepWriter()) return orig-n;				
				int remain = writer.getSize()-ofs;
				if (remain>n) remain=(int)n;
				ofs=ofs+remain;
				n=n-remain;
			}
			return orig;
		}
	}
	
	public Reader getReader() 
	{
		return new MyReader();
	}

	@Override
	public void close() {
	}

	public Iterable<BufferedSegment> getSegments() 
	{
		return segments;
	}


}
