package org.jclarion.clarion.appgen.symbol;

import java.lang.ref.WeakReference;
import java.util.Iterator;

import org.jclarion.clarion.ClarionObject;



public abstract class ListSymbolValue extends SymbolValue implements Iterable<SymbolValue>
{
	public abstract void 			add(SymbolValue value);
	public abstract void 			add(SymbolValue value,int pos);
	public abstract void 			delete(int pos);
	public abstract void 			delete();
	public abstract int				size();
	public abstract boolean			fix(SymbolValue value);
	public abstract boolean			select(int ofs);
	public abstract int				instance();
	public abstract SymbolValue		value();
	public abstract void 			free();
	public abstract void 			clear();
	public abstract ListSymbolValue clone();
	public abstract ListScanner		loop(boolean reverse);
	public abstract int				containsPos(SymbolValue value);
	
	private WeakReference<SymbolEntry>	last;
	
	public void setSymbolEntry(SymbolEntry entry)
	{
		if (entry==null) {
			last=null;
		} else if (last==null || last.get()!=entry) {
			last=new WeakReference<SymbolEntry>(entry);
		}
	}
	
	public void alertFixChange()
	{
		if (last!=null) {
			last.get().alertDependentsOfFixChange();
		}
	}
	
	@Override
	public ClarionObject asClarionObject() {
		SymbolValue fix = value();
		if (fix==null) {
			return new NullObject(this);
		} else {
			return new StringScalarObject(fix.getString(), this);
		}
	}

	
	@Override
	public int getInt() 
	{
		SymbolValue fix = value();
		if (fix!=null) {
			return fix.getInt();
		}
		return 0;
	}

	@Override
	public String getString() 
	{
		SymbolValue fix = value();
		if (fix!=null) {
			return fix.getString();
		}
		return null;
	}
	
	public Iterator<SymbolValue> iterator() {
		return new Iterator<SymbolValue>() {
			
			private ListScanner loop=loop(false);
			private SymbolValue next=null;
			
			@Override
			public boolean hasNext() {
				while (next==null) {
					if (loop==null) return false;
					if (!loop.next()) {
						loop=null;
						return false;
					}
					next=value();
				}
				return true;
			}

			@Override
			public SymbolValue next() {
				if (!hasNext()) throw new IllegalStateException("Iterator exhausted");
				SymbolValue ret = next;
				next=null;
				return ret;
			}

			@Override
			public void remove() {
			}
		};
	}
	
	@Override
	public String serialize() {		
		return "# not implemented";
	}		
}

