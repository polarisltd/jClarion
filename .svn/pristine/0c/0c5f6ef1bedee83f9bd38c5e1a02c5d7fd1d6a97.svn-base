package org.jclarion.clarion.appgen.embed;

import java.util.Iterator;
import java.util.TreeSet;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;

public class AdviseHelper {

	private static class TailAdvise extends AbstractAdvise
	{
		public TailAdvise(int priority) {
			super(priority,0,0);
		}

		@Override
		public void run(ExecutionEnvironment env,EmbedKey source) { }

		@Override
		public EmbedKey getKey() {
			return null;
		}

	}
	
	private static class ConstrainedIterator<X extends AbstractAdvise> implements Iterator<X>
	{
		private X next;
		private Iterator<X> scan;
		private int maxPriority;
		
		public ConstrainedIterator(Iterator<X> scan,int maxPriority)
		{
			this.scan=scan;
			this.maxPriority=maxPriority;
		}
		
		@Override
		public boolean hasNext() 
		{
			if (next==null) {
				if (!scan.hasNext()) return false;
				next=scan.next();
			}			
			return next.getPriority()<=maxPriority;
		}

		@Override
		public X next() {
			if (!hasNext()) {
				throw new IllegalStateException("Exhausted");
			}
			X result = next;
			next=null;
			return result;
		}

		@Override
		public void remove() {
		}
	}
	
	@SuppressWarnings("rawtypes")
	private static Iterator emptyIterator=new Iterator() {
				@Override
				public boolean hasNext() {
					return false;
				}

				@Override
				public Object next() {
					return null;
				}

				@Override
				public void remove() {
				}
			};
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static <X> Iterator<X> constrain(TreeSet<X> vals, int minPriority,int maxPriority) 
	{
		if (vals==null) {
			return emptyIterator;
		}
		
		Iterator<X> result=null;		
		if (minPriority>1) {
			// erase generic type so we limit set to tailadvise
			result=((TreeSet)vals).tailSet(new TailAdvise(minPriority)).iterator();
		} else {
			result = vals.iterator();
		}

		if (maxPriority<10000) {
			// constrain iterator results.
			result = new ConstrainedIterator(result,maxPriority);
		}

		return result;
	}
}
