package org.jclarion.clarion;

public  interface ClarionCloneable {
	public abstract Object clarionClone();
	public abstract void clear(int method);
	public abstract void clear();
	public abstract void setValue(Object o);
}
