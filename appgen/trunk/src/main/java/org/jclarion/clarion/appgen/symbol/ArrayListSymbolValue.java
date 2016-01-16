package org.jclarion.clarion.appgen.symbol;

import java.util.TreeMap;


public class ArrayListSymbolValue extends ListSymbolValue
{
	private boolean 	  					copyOnWrite;
	private TreeMap<SymbolValue,Integer>	positionFinder;	
	private SymbolValue[] 					array;
	private int 							size=0;	
	private int								fixLocation=0;
	private ArrayListScanner				latest;
	private boolean							mayHaveDups;
	
	private class ArrayListScanner extends ListScanner
	{
		private ArrayListScanner prev;
		private int 	next=1;
		private boolean reverse;
		
		public ArrayListScanner(boolean reverse)
		{
			this.prev=latest;
			latest=this;
			this.reverse=reverse;
			next = reverse ? size : 1;
		}
		
		public boolean finished()
		{
			if (next==0 || next>size) return true;
			return false;
		}

		@Override
		public boolean next() {
			if (finished()) {
				if (latest==this) {
					latest=this.prev;
				}
				return false;
			}
			fixLocation=next;
			alertFixChange();
			next=next+ (reverse ? -1 : +1);
			return true;
		}

		@Override
		public void dispose() {
			if (this==latest) {
				latest=this.prev;
			}
			next=0;
		}
	}

	
	public ArrayListSymbolValue()
	{
		array=new SymbolValue[4];			
	}
	
	public ArrayListSymbolValue(ArrayListSymbolValue base) 
	{
		base.copyOnWrite=true;
		this.copyOnWrite=true;
		
		this.positionFinder=base.positionFinder;
		this.array=base.array;
		this.size=base.size;
		this.mayHaveDups=base.mayHaveDups;
		this.fixLocation=base.fixLocation;
	}

	@Override
	public void add(SymbolValue value) {
		add(value,size+1);
	}

	@Override
	public void add(SymbolValue value, int pos) 
	{
		if (size==0) {
			positionFinder=new TreeMap<SymbolValue,Integer>();
			mayHaveDups=false;
		}
		adjustArray(size+1,pos,1);			
		array[pos-1]=value;
		if (positionFinder!=null) {
			if (!positionFinder.containsKey(value)) {
				positionFinder.put(value,pos);
			} else {
				mayHaveDups=true;
			}
		}
		size++;
		fixLocation=pos;
		alertFixChange();
	}

	private void adjustArray(int len,int pos,int move) 
	{
		if (pos>0 && pos<=size) {
			positionFinder=null;
		}
		
		if (copyOnWrite || len>array.length) {
			int newLength=array.length;
			if (newLength<4) newLength=4;
			while (newLength<len) {
				newLength=newLength<<1;
			}
			SymbolValue newArray[] = new SymbolValue[newLength];
			
			if (pos>0 && pos<=size) {
				System.arraycopy(array,0,newArray,0,pos-1);
				System.arraycopy(array,pos-1,newArray,pos-1+move,size-pos+1);
			} else {
				System.arraycopy(array,0,newArray,0,size);
			}
			array=newArray;
			if (copyOnWrite && positionFinder!=null) {
				positionFinder=new TreeMap<SymbolValue, Integer>(positionFinder);
			}
			copyOnWrite=false;
		} else if (pos>0 && pos<=size) {
			System.arraycopy(array,pos-1,array,pos-1+move,size-pos+1);
		}
		
		if (pos>0) {
			if (pos<=fixLocation) {
				fixLocation+=move;
			}		
			ArrayListScanner scanner=latest;
			while (scanner!=null) {
				if (!(move<0 ^ scanner.reverse)) {
					if (pos+move<=scanner.next) {
						scanner.next+=move;
					}
				} else {
					if (pos<=scanner.next) {
						scanner.next+=move;
					}
				}
				scanner=scanner.prev;
			}
		}
	}

	@Override
	public void delete(int pos) 
	{
		if (pos<1 || pos>size) return;
		SymbolValue toDelete=array[pos-1];
		adjustArray(size+1,pos+1,-1);
		if (positionFinder!=null) {
			if (mayHaveDups) {
				positionFinder=null;
			} else {
				positionFinder.remove(toDelete);
			}
		} else {
			positionFinder=null;
		}
		size--;
	}

	@Override
	public void delete() 
	{
		if (fixLocation>0) {
			delete(fixLocation);
			fixLocation=0;
			alertFixChange();
		}
	}

	@Override
	public int size() 
	{
		return size;
	}

	/**
	 * For unit tests only
	 */
	boolean usingEfficientFinder()
	{
		return positionFinder!=null;
	}
	
	@Override
	public boolean fix(SymbolValue value) 
	{
		int pos = find(value);
		if (pos==0) return false;
		fixLocation=pos;
		alertFixChange();
		return true;
	}

	private int find(SymbolValue value)
	{
		if (positionFinder!=null) {
			Integer pos = positionFinder.get(value);
			if (pos==null) {
				return 0;
			}
			return pos;
		}
		
		for (int scan=0;scan<size;scan++) {
			if (array[scan]==null) continue;
			if (array[scan].equals(value)) {
				return scan+1;
			}
		}		
		return 0;
	}
	
	public boolean contains(SymbolValue value)
	{
		return find(value)>0;
	}

	public int containsPos(SymbolValue value)
	{
		return find(value);
	}

	@Override
	public boolean select(int ofs) 
	{
		if (ofs>size || ofs<1) return false;
		fixLocation=ofs;
		alertFixChange();
		return true;
	}

	@Override
	public int instance() 
	{
		return fixLocation;		
	}

	@Override
	public SymbolValue value() 
	{
		if (fixLocation<1 || fixLocation>size) {
			return StringSymbolValue.BLANK;
		}
		return array[fixLocation-1];
	}

	@Override
	public void free() 
	{
		size=0;
		positionFinder=null;
	}

	@Override
	public ArrayListSymbolValue clone() 
	{
		return new ArrayListSymbolValue(this);
	}

	@Override
	public ListScanner loop(boolean reverse) 
	{
		return new ArrayListScanner(reverse);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("[");
		for (int scan=0;scan<size;scan++) {
			if (scan>0) sb.append(',');
			sb.append(array[scan]);
		}
		sb.append(']');
		return sb.toString();
	}

	@Override
	public void clear() {
		fixLocation=0;
		alertFixChange();
	}

	
}
