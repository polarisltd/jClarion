package org.jclarion.clarion.appgen.embed;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.TreeSet;

public class MultiAdviseIterator<X extends Advise> implements Iterator<Advise>
{
	private static class Entry<X extends Advise> implements Comparable<Entry<X>>
	{
		private Iterator<? extends X> iterator;
		private Advise next;
		private int ofs;
		public Entry(Iterator<? extends X> iterator,int ofs) {
			this.iterator=iterator;
			this.ofs=ofs;
		}
		
		@Override
		public int compareTo(Entry<X> o) {
			int diff = next.compareTo(o.next);
			if (diff==0) diff=ofs-o.ofs;
			return diff;
		}
	}
	
	private TreeSet<Entry<X>> sources=new TreeSet<Entry<X>>();
	private Entry<X> last = null;
	
	public MultiAdviseIterator()
	{
	}
	
	@SuppressWarnings("unchecked")
	public MultiAdviseIterator(LinkedList<AdviseStore> stores, EmbedKey key,int minPriority,int maxPriority) 
	{
		for (AdviseStore scan : stores ) {
			@SuppressWarnings("rawtypes")
			Iterator as = scan.get(key,minPriority,maxPriority);
			add(as);
		}
		completeAdd();
	}
	
	public void completeAdd()
	{
		if (last!=null && !sources.isEmpty()) {
			last.next=last.iterator.next();
			sources.add(last);
			last=null;
		}
	}
	
	public void add(Iterator<? extends X> as) {
		if (as.hasNext()) {
			Entry<X> e = new Entry<X>(as,sources.size()+ (last!=null ? 1 : 0));
			if (last!=null) {
				last.next=last.iterator.next();
				sources.add(last);
			}
			last=e;
		}		
	}
	
	@Override
	public boolean hasNext() {
		if (last!=null) {
			return last.iterator.hasNext();
		}
		return !sources.isEmpty();
	}

	@Override
	public Advise next() {
		if (last!=null) {
			return last.iterator.next();
		}
		
		last = sources.pollFirst();
		Advise ret = last.next;
		if (sources.isEmpty()) {
			last.next=null;
		} else {			
			if (last.iterator.hasNext()) {						
				last.next=last.iterator.next();
				sources.add(last);
			}			
			last=null;
		}
		return ret;
	}

	@Override
	public void remove() {
	}

}
