package org.jclarion.clarion;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.jclarion.clarion.runtime.OverGlue;

public class ClarionArray<T extends Object> extends ClarionMemoryModel implements ClarionCloneable 
{
	private Object[] array;

    private ClarionMemoryChangeListener notifyChildChange = new ClarionMemoryChangeListener() {
        @Override
        public void objectChanged(ClarionMemoryModel model) {
            notifyChange();
        }
    };
	
	public ClarionArray(int size) {
		array=new Object[size];
	}

	private ClarionArray(Object[] obj)
	{
		this.array=new Object[obj.length];
		for (int scan=0;scan<obj.length;scan++) {
			if (obj[scan]==null) continue;
			if (obj[scan] instanceof ClarionCloneable) {
				this.array[scan]=((ClarionCloneable)obj[scan]).clarionClone();
			}
		}
		monitor();
	}
	
	public ClarionArray(T obj,int size)
	{
		array=new Object[size];
		if (obj!=null && obj instanceof ClarionCloneable) {
			ClarionCloneable c = (ClarionCloneable)obj;
			for (int scan=0;scan<size;scan++) {
				array[scan]=c.clarionClone();
			}
		}
		monitor();
	}

	private void monitor()
	{
		for (Object o : array ) {
			if (o==null) continue;
			if (o instanceof ClarionMemoryModel) {
				((ClarionMemoryModel)o).addChangeListener(notifyChildChange);
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	public T get(int ofs)
	{
		return (T)array[ofs-1];
	}
	
	public void set(int ofs,T obj)
	{
		array[ofs-1]=obj;
	}
	
	@Override
	public void deserialize(InputStream os) throws IOException {
		for ( Object o : array ) {
			if (o==null) continue;
			if (!(o instanceof ClarionMemoryModel)) continue;
			((ClarionMemoryModel)o).deserialize(os);
		}
	}

	@Override
	public void serialize(OutputStream is) throws IOException {
		for ( Object o : array ) {
			if (o==null) continue;
			if (!(o instanceof ClarionMemoryModel)) continue;
			((ClarionMemoryModel)o).serialize(is);
		}
	}

	@Override
	public Object getLockedObject(Thread t) {
		return this;
	}

	@Override
	public Object clarionClone() {
		return new ClarionArray<T>(array);
	}

	public ClarionArray<ClarionArray<T>> dim(int size)
	{
		return new ClarionArray<ClarionArray<T>>(this,size); 
	}
	
    public ClarionArray<T> setOver(ClarionMemoryModel over) 
    {
        OverGlue glue = new OverGlue(this,over);
        glue.objectChanged(over);
        return this;
    }

    public int length()
    {
    	return array.length;
    }

	@Override
	public void clear(int method) {
		for ( Object o : array ) {
			if (o==null) continue;
			if (!(o instanceof ClarionCloneable)) continue;
			((ClarionCloneable)o).clear(method);
		}
	}

	@Override
	public void clear() {
		clear(0);
	}

	@Override
	public void setValue(Object o) 
	{
 		if (o instanceof ClarionArray<?>) {
 			ClarionArray<?> ca = (ClarionArray<?>)o;
 			for (int scan=0;scan<ca.array.length;scan++) {
 				if (ca.array[scan]==null) {
 					array[scan]=null;
 					continue;
 				}
 				if (ca.array[scan] instanceof ClarionCloneable) {
 					array[scan]=((ClarionCloneable)ca.array[scan]).clarionClone();
 				}
 			}
 		}
	}
}
