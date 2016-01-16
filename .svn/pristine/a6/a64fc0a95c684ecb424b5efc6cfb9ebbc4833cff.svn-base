package org.jclarion.clarion.appgen.template;

import java.io.IOException;

/**
 * Write target is similar to java standard appendable, but template system needs a few other things.
 * 
 * @author barney
 *
 */
public abstract class WriteTarget implements Appendable
{
	public abstract WriteTarget append(CharSequence csq) throws IOException;
	public abstract WriteTarget append(CharSequence csq, int start, int end) throws IOException;
	public abstract WriteTarget append(char c) throws IOException;
	public abstract int getCharsWritten();
	public abstract void setCharsWritten(int length);
	public abstract void markup(String parameter,Object markup);
	public abstract void clearMarkup();
	public abstract void close();
}
