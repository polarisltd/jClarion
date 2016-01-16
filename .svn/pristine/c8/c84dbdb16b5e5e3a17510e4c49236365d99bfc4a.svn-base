package org.jclarion.clarion.appgen.embed;

import java.util.Iterator;
import java.util.LinkedList;


public class MultiAdviseStore implements AdviseStore
{
	private LinkedList<AdviseStore> stores = new LinkedList<AdviseStore>(); 

	public MultiAdviseStore()
	{
	}
	
	public void push(AdviseStore store)
	{
		stores.add(store);
	}
		
	public void pop()
	{
		stores.removeLast();
	}
	
	@Override
	public Iterator<? extends Advise> get(EmbedKey key,int minPriority,int maxPriority) {
		return new MultiAdviseIterator<Advise>(stores,key,minPriority,maxPriority);
	}

	@Override
	public String toString() {
		return "MultiAdviseStore [stores=" + stores + "]";
	}

	public void debug(EmbedKey key) 
	{
		for (AdviseStore store : stores ) {
			System.err.println(" "+store);
			store.debug(key);
		}
	}

}
