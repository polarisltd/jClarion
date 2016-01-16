package org.jclarion.clarion.appgen.template;

import java.io.IOException;

public class AppendableWriteTarget extends WriteTarget
{

	private Appendable target;
	private int length;

	public AppendableWriteTarget(Appendable target)
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

	@Override
	public void markup(String key,Object markup) 
	{
	}

	@Override
	public void clearMarkup() 
	{
	}

	@Override
	public void close() {
		// TODO Auto-generated method stub
	}

	@Override
	public void setCharsWritten(int length) {
		this.length=length;
	}
	
	
}
