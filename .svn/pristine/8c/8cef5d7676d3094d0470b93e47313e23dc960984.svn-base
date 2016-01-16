package org.jclarion.clarion.ide.model.app;

import java.util.Iterator;

public class AbstractListenerContainer<X> implements Iterable<X>
{
	private static class Listener<X>
	{
		private X listener;
		private Listener<X> next;
		private boolean  removed=false;
	}
	
	private Listener<X> head=null;
	private Listener<X> tail=null;
	
	public AbstractListenerContainer()
	{
	}
	
	public void add(X listener)
	{
		synchronized(this) {
			Listener<X> l = new Listener<X>();
			if (tail==null) {
				head=l;
			} else {
				tail.next=l;
			}
			l.listener=listener;
			tail=l;
		}
	}
	
	public void remove(X listener) {
		synchronized(this) {
			Listener<X> scan = head;
			Listener<X> prev = null;
			while (scan!=null) {
				if (scan.listener==listener) {
					scan.removed=true;
					if (prev!=null) {
						prev.next=scan.next;
					} else {
						head=scan.next;
					}
					if (scan==tail) {
						tail=prev;
					}
					break;
				}
				prev=scan;
				scan=scan.next;
			}
		}
	}

	private static class ListenerIterator<X> implements Iterator<X>
	{
		private Listener<X> scan;
		private Object   semaphore;
		
		public ListenerIterator(Listener<X> head,Object semaphore)
		{
			this.scan=head;
			this.semaphore=semaphore;
		}
		
		@Override
		public boolean hasNext() {
			synchronized(semaphore) {
				while (scan!=null && scan.removed) {
					scan=scan.next;
				}
				return scan!=null;
			}
		}

		@Override
		public X next() {
			Listener<X> result=null;
			synchronized(semaphore) {
				result=scan;
				scan=scan.next;
			}
			return result.listener;
		}

		@Override
		public void remove() {
		}
	}
	
	@Override
	public Iterator<X> iterator() {
		return new ListenerIterator<X>(head,this);
	}
}
