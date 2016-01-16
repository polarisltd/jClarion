package org.jclarion.clarion.appgen.embed;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;
import java.util.TreeSet;

/**
 * A simple version of WildcardEmbedStore.  Can only handle embeds which match perfectly, cannot handle explict/implicit wild card.
 * 
 * Useful for embeds sourced from the app. No good for #AT embeds.  Should run faster than wildcard version
 * 
 * @author barney
 */
public class SimpleEmbedStore<X extends AbstractAdvise> implements AdviseStore, Iterable<X >
{

	private Map<EmbedKey,TreeSet<X>> store=new HashMap<EmbedKey,TreeSet<X>>();

	public void add(X advise)
	{
		EmbedKey key = advise.getKey();
		TreeSet<X> set = store.get(key);
		if (set==null) {
			set=new TreeSet<X>();
			store.put(key,set);
		}
		set.add(advise);
	}
	
	public void delete(X advise)
	{
		EmbedKey key = advise.getKey();
		TreeSet<X> set = store.get(key);
		if (set==null) return;
		set.remove(advise);
		if (set.isEmpty()) {
			store.remove(key);
		}
	}
	
	@Override
	public Iterator<? extends Advise> get(EmbedKey key, int minPriority,int maxPriority) {
		return AdviseHelper.constrain(store.get(key), minPriority, maxPriority);
	}
	
	public Iterator<X> iterator()
	{
		ArrayList<X> result = new ArrayList<X>();
		
		TreeMap<EmbedKey,TreeSet<X>>  map = new TreeMap<EmbedKey,TreeSet<X>> (new Comparator<EmbedKey>() {
			@Override
			public int compare(EmbedKey o1, EmbedKey o2) {
				int diff = o1.getName().compareTo(o2.getName());
				if (diff!=0) return diff;
				
				int i1 = o1.getInstanceCount();
				int i2 = o2.getInstanceCount();
				int min = i1<i2 ? i1 : i2;
				
				for (int scan=0;scan<min;scan++) {
					diff = o1.getInstance(scan).compareTo(o2.getInstance(scan));
					if (diff!=0) return diff;
				}
				return i1-i2;
			}
		});
		map.putAll(store);
		
		
		for (TreeSet<X> scan : map.values()) {
			result.addAll(scan);
		}
		return result.iterator();
	}

	@Override
	public void debug(EmbedKey key) 
	{
	}

	public void debug() 
	{
		for (Map.Entry<EmbedKey,TreeSet<X> >t : store.entrySet()) {
			System.err.println(t.getKey());
			for (X s : t.getValue() ) {
				System.err.println("  "+s.getPriority()+":"+s.getInstanceID());
			}
		}
	}
}
