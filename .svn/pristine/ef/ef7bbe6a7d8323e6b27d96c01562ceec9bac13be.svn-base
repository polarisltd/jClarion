package org.jclarion.clarion.appgen.template;

import java.io.IOException;
import java.io.Writer;

public class WriterWriteTarget extends WriteTarget
{

	private Writer target;
	private int length;

	public WriterWriteTarget(Writer target)
	{
		this.target=target;
	}

	@Override
	public WriteTarget append(CharSequence csq) throws IOException {
		target.append(csq);
		length+=csq.length();
		return this;
	}

	@Override
	public WriteTarget append(CharSequence csq, int start, int end) throws IOException {
		target.append(csq,start,end);
		if (end>start) {
			length+=end-start;
		}
		return this;
	}

	@Override
	public WriteTarget append(char c) throws IOException {
		target.append(c);
		length++;
		return this;
	}

	@Override
	public int getCharsWritten() {
		return length;
	}
	
	public void close()
	{
		try {
			target.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void markup(String key,Object markup) 
	{
	}

	@Override
	public void clearMarkup() 
	{
	}

	@Override
	public void setCharsWritten(int length) {
		this.length=length;
	}
	
	
}
