package org.jclarion.clarion.appgen.symbol;

import java.util.Iterator;

import org.jclarion.clarion.appgen.symbol.user.SymbolFixKey;

public class IndependentStore extends SymbolStore
{
	private SymbolValue value;

	@Override
	public SymbolValue load() {
		return value;
	}

	@Override
	public void save(SymbolValue value) {
		this.value=value;
	}

	public IndependentStore clone()
	{
		IndependentStore c = new IndependentStore();
		if (value!=null) {
			c.value=value.clone();
		}
		return c;
	}
	
	private static Iterator<SymbolEntry> emptyIterator=new Iterator<SymbolEntry>() {
		@Override
		public boolean hasNext() {
			return false;
		}
		@Override
		public SymbolEntry next() {
			throw new IllegalStateException("None");
		}
		@Override
		public void remove() {
		}
	};
	
	private static Iterable<SymbolEntry> emptyIterable=new Iterable<SymbolEntry>() {
		@Override
		public Iterator<SymbolEntry> iterator() {
			return emptyIterator;
		}
	};


	@Override
	public Iterable<SymbolEntry> getDependencies() {
		return emptyIterable;
	}

	@Override
	public String toString() {
		if (value==null) return "(null)";
		return value.toString();
	}

	
	@Override
	public Iterable<SymbolValue> getAllPossibleValues() 
	{
			return new Iterable<SymbolValue>() {
				@Override
				public Iterator<SymbolValue> iterator() {
					return new Iterator<SymbolValue>() {
						boolean hasNext=value!=null;
						@Override
						public boolean hasNext() {
							return hasNext;
						}
						@Override
						public SymbolValue next() {
							hasNext=false;
							return value;
						}

						@Override
						public void remove() {
						}
					};
				}
			};
	}
	
	private class It implements Iterator<SymbolFixKey>
	{
		private SymbolFixKey key; 
		
		public It(SymbolFixKey key)
		{
			this.key=key;
		}
		
		@Override
		public boolean hasNext() {
			return key!=null;
		}

		@Override
		public SymbolFixKey next() {
			if (key!=null) {
				SymbolFixKey ret = key;
				key=null;
				return ret;
			}
			throw new IllegalStateException("Iterator Exhausted");
		}

		@Override
		public void remove() {
		}
		
	}

	@Override
	public Iterable<SymbolFixKey> find(final SymbolValue match,int limit) 
	{
		return new Iterable<SymbolFixKey>() {
			@Override
			public Iterator<SymbolFixKey> iterator() {
				return new It( value!=null && value.contains(match) ? new SymbolFixKey(new String[0]) : null );
			}			
		};
	}

	@Override
	public int getModifyVersion() {
		return 0;
	}

	@Override
	public boolean isSystemStore() {
		return false;
	}	
}
