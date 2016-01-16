package org.jclarion.clarion.appgen.embed;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

/**
 * This object represents a collection of embed keys optimally organised so that retrieval of matching keys is reasonably efficient.
 * 
 *  EmbedKeys can contain wild cards for example
 *  
 *  #AT(%symbol,'Foo','Bar','Baz')
 *  #AT(%symbol,'Foo',,'Baz')
 *  #AT(%symbol,'Foo')
 *  
 *  The first one must match Foo, Bar, Baz but the second one, the second parameter is an optional wildcard, the 3rd example matches anything that
 *  starts with 'Foo'
 *  
 *  This is done by indexing WildCarded Entries. On lookup we match every wildcard entry to search entry.  The result of this then
 *  feeds into another hash that stores all the concrete aspects
 *  
 * @author barney
 *
 */
public class WildcardEmbedStore<X extends AbstractAdvise> implements AdviseStore
{
	/**
	 * A structure used to index every instance object on wildcarded embed keys
	 * 
	 * @author barney
	 *
	 */
	private static class Entry {
		
		/**
		 * Advise objects that explicitly match a given string
		 */
		private Map<String,Set<EmbedKey>> matches=new HashMap<String,Set<EmbedKey>>();
		
		/**
		 * Advise objects which have wildcards at a certain position
		 */
		private Set<EmbedKey> wildCards=new HashSet<EmbedKey>();
		
		/**
		 * number of objects that terminate at this entry level. Implicit wildcard counts beyound this level
		 */
		private int terminationCount=0;
		
	}
	
	
	private Map<String,List<Entry>> wildcardEntries=new HashMap<String,List<Entry>>();
	
	
	/**
	 * The actual objects we are caching; come wildcarded EmbedKey to advise set  
	 */
	private Map<EmbedKey,TreeSet<X>> data=new HashMap<EmbedKey,TreeSet<X>>(); 
	
	/**
	 * A cache of used embeds. These will not be copied down. Assumption is that used
	 * embeds are of no interest to embed points invoked by ancestors
	 */
	private Set<EmbedKey> used=new HashSet<EmbedKey>();
	
	public void add(X advise)
	{
		getTarget(advise.getKey()).add(advise);
	}
	
	public void addAll(WildcardEmbedStore<X> from)
	{
		for (Map.Entry<EmbedKey,TreeSet<X>> scan : from.data.entrySet()) {
			EmbedKey key = scan.getKey();
			if (from.used!=null && from.used.contains(key)) continue;
			getTarget(key).addAll(scan.getValue());
		}
	}
	
	private TreeSet<X> getTarget(EmbedKey key)
	{
		TreeSet<X> target = data.get(key);
		if (target==null) {
			if (key.containsWildcards()) {
				List<Entry> set = wildcardEntries.get(key.getName());
				if (set==null) {
					set=new ArrayList<Entry>(6);
					wildcardEntries.put(key.getName(),set);
				}	
				Entry e=null;
				for (int scan=0;scan<key.getInstanceCount();scan++) {							
					if (set.size()<=scan) {
						e=new Entry();
						set.add(e);
					} else {
						e=set.get(scan);
					}
			
					String value = key.getInstance(scan);
					if (value==null) {
						e.wildCards.add(key);
					} else {
						Set<EmbedKey> ts = e.matches.get(value);
						if (ts==null) {
							ts=new HashSet<EmbedKey>();
							e.matches.put(value,ts);
						}
						ts.add(key);
					}
				}
				e.terminationCount++;
			}
			target=new TreeSet<X>();
			data.put(key,target);
		}	
		return target;
	}

	private static final class Fit implements Comparable<Fit> 
	{
		private int pos;
		private boolean wildcardonly;
		private Set<EmbedKey> exact;		
		private Set<EmbedKey> wildCards;
		private int size;
		
		@Override
		public int compareTo(Fit o) {
			int diff = size-o.size;
			if (diff==0) diff=pos-o.pos;
			return diff;
		}

		@Override
		public String toString() {
			return "Fit [pos=" + pos + ", wildcardonly=" + wildcardonly
					+ ", exact=" + (exact==null ? null : exact.size()) + ", wildCards=" + wildCards.size()
					+ ", size=" + size + "]";
		}		

		
		
	}
	
	public Iterator<? extends Advise> get(EmbedKey find,int minPriority,int maxPriority)
	{
		MultiAdviseIterator<X> mai = new MultiAdviseIterator<X>();
		
		List<Entry> set = wildcardEntries.get(find.getName());
		if (set!=null) {			
			TreeSet<Fit> fitlist= new TreeSet<Fit>();
			int count=0;
			for (int scan=0;scan<find.getInstanceCount() && scan<set.size();scan++) {			
				Entry e = set.get(scan);
				String val = find.getInstance(scan);
				Fit f=  new Fit();
				f.pos=scan;
				f.exact=e.matches.get(val);
				f.wildCards=e.wildCards;
				f.size=f.wildCards.size()+(f.exact!=null ? f.exact.size() : 0 )+count;
				f.wildcardonly=e.matches.isEmpty();
				fitlist.add(f);
				count+=e.terminationCount;
			}
		
		
			if (!fitlist.isEmpty()) {			
				Fit first = fitlist.pollFirst();
				HashSet<EmbedKey> result = new HashSet<EmbedKey>(first.wildCards.size()+(first.exact!=null ? first.exact.size() : 0 ) );
				result.addAll(first.wildCards);
				if (first.exact!=null) result.addAll(first.exact);			

				for (Fit f: fitlist) {
					if (f.wildcardonly) continue;
					Iterator<EmbedKey> search = result.iterator();
					while (search.hasNext()) {
						EmbedKey match = search.next();
						if (match.getInstanceCount()<=f.pos) continue; 					// implicit wild card. Retain
						if (f.wildCards.contains(match)) continue; 						// explicit wild card. Retain
						if (f.exact!=null && f.exact.contains(match)) continue; 		// explicit find. Retain
						search.remove();
					}
				}

				for (EmbedKey match : result ) {
					if (match.getInstanceCount()>find.getInstanceCount()) continue;		// not allowed
					TreeSet<X> items = getData(match);
					if (items==null) continue;
					mai.add(AdviseHelper.constrain(items,minPriority,maxPriority));
				}
			}
		}
		
		// get the wildcard matches
		while ( true ) {
			mai.add(AdviseHelper.constrain(getData(find),minPriority,maxPriority));
			if (find.getInstanceCount()==0) break;
			find=find.shorten();
		}
		
		mai.completeAdd();
		
		return mai;		
	}

	private TreeSet<X> getData(EmbedKey match) {
		TreeSet<X> res = data.get(match);
		if (res!=null && used!=null) {
			used.add(match);
		}
		return res;
	}
	
	public void finishTrackingUsed()
	{
		used=null;
	}

	@Override
	public void debug(EmbedKey key) 
	{
		while ( true ) {
			TreeSet<X> scan = data.get(key);
			if (scan!=null && !scan.isEmpty()) {
				System.err.println("   "+key);
				for (X a : scan) {
					System.err.println("      "+a.getPriority()+" "+a.getInstanceID()+" "+a);
				}
			}
			if (key.getInstanceCount()==0) break;
			key=key.shorten();
		}
	}

	public void debug() 
	{
		for (Map.Entry<EmbedKey,TreeSet<X> >t : data.entrySet()) {
			System.err.println(t.getKey());
			for (X s : t.getValue() ) {
				System.err.println("  "+s.getPriority()+":"+s.getInstanceID()+" "+s);
			}
		}
		
	}
	
	
}
