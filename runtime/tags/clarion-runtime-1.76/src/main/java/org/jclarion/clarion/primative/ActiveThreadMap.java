package org.jclarion.clarion.primative;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.TimerTask;

import org.jclarion.clarion.runtime.ClarionTaskManager;

public class ActiveThreadMap<V> 
{
    private static final int SIZE=8;
    private static final int AND=7;
    
    private static class Entry<V>
    {
        //private long   lastAccessed;

        private Entry(Thread key,V value)
        {
            this._key=key;
            this._value=value;
        }

        private Thread _key;
        private V _value;
        
        public boolean isAlive()
        {
            return _key.isAlive();
        }
        
        public V getValue()
        {
            return _value;
        }
        
        public Thread getKey()
        {
            return _key;
        }
        
        public void setValue(V value)
        {
            this._value=value;
        }
        
        public void setValue(Thread key,V value)
        {
            this._value=value;
            this._key=key;
        }
    }
    
    private Entry<V>[][] hash;
    
    @SuppressWarnings("unchecked")
	public ActiveThreadMap()
    {
        hash=new Entry[SIZE][];
    }
    
    @SuppressWarnings("unchecked")
	public void put(Thread thread,V value)
    {
        List<V> cleanup=null;
        
        synchronized(this) {

            int indx = ((int) thread.getId()) & AND;
            Entry<V>[] bucket = hash[indx];
            if (bucket == null) {
                bucket = new Entry[1];
                hash[indx] = bucket;
                bucket[0] = new Entry(thread, value);
                return;
            }

            int slot = -1;
            boolean empty = true;
            for (int scan = 0; scan < bucket.length; scan++) {

                Entry e = bucket[scan];

                if (e != null && e.getKey() == thread) {
                    e.setValue(value);
                    return;
                }

                if (e == null || !e.isAlive()) {
                    slot = scan;
                    continue;
                }

                empty = false;
            }

            if (empty && slot > 0) {

                for (Entry e : bucket) {
                    cleanup = addToCleanup(cleanup, e);
                }

                bucket = new Entry[1];
                hash[indx] = bucket;
                slot = 0;
            }

            if (slot == -1) {
                Entry[] newBucket = new Entry[bucket.length << 1];
                System.arraycopy(bucket, 0, newBucket, 0, bucket.length);
                slot = bucket.length;
                bucket = newBucket;
                hash[indx] = bucket;
            }

            Entry e = bucket[slot];
            if (e != null) {
                if (e.getKey() != thread) {
                    cleanup = addToCleanup(cleanup, e);
                }
                e.setValue(thread,value);
            } else {
                bucket[slot] = new Entry(thread, value);
            }
        }
        cleanup(cleanup);
    }
    
    @SuppressWarnings("unchecked")
    public synchronized V get(Thread thread)
    {
        int indx = ((int)thread.getId())&AND;
        Entry[] bucket = hash[indx];
        if (bucket==null) return null;
        for (int scan=0;scan<bucket.length;scan++) {
            Entry e = bucket[scan];
            if (e!=null && e.getKey()==thread) {
                return (V)e.getValue(); 
            }
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    public synchronized V remove(Thread thread)
    {
        int indx = ((int)thread.getId())&AND;
        Entry[] bucket = hash[indx];
        if (bucket==null) return null;
        for (int scan=0;scan<bucket.length;scan++) {
            Entry e = bucket[scan];
            if (e!=null && e.getKey()==thread) {
                Object result = e.getValue();
                bucket[scan]=null;
                return (V)result; 
            }
        }
        return null;
    }

    int getMemoryFootprint()
    {
        int count=0;
        for (Entry<V>[] scan : hash ) {
            if (scan!=null) {
                count+=scan.length;
            }
        }
        return count;
    }

    @SuppressWarnings("unchecked")
    public void clear() 
    {
        Entry<V>[][] old;
        synchronized(this) {
            old=hash;
            hash=new Entry[SIZE][];
        }
        
        for (Entry ea[] : old ) 
        {
            if (ea==null) continue;
            for (Entry<V> e : ea ) {
                if (e!=null) {
                    cleanup(e.getValue());
                }
            }
        }
    }
    
    private static class ScheduledPack<SV> extends TimerTask
    {
        final WeakReference<ActiveThreadMap<SV>> wr_atm;
        
        public ScheduledPack(ActiveThreadMap<SV> base)
        {
            wr_atm = new WeakReference<ActiveThreadMap<SV>>(base);
        }
        
        public void run()
        {
            ActiveThreadMap<SV> atm = wr_atm.get();
            if (atm==null) {
                cancel();
            } else {
                atm.pack();
            }
        }
    }
        
    public void schedulePack(int delay)
    {
        ClarionTaskManager.getInstance().getTimer().schedule(
            new ScheduledPack<V>(this),
            new java.util.Date(),delay);
    }
    
    @SuppressWarnings("unchecked")
    public void pack()
    {
        List<V> cleanup=new ArrayList<V>();
        synchronized(this) {
            for (int s1 =0;s1<hash.length;s1++) {
                Entry ea[] = hash[s1];
                if (ea==null) continue;
                boolean empty=true;
                for (int s2=0;s2<ea.length;s2++) {
                    Entry<V> e = ea[s2];
                    if (e==null) continue;
                    if (e.isAlive()) {
                        empty=false;
                        continue;
                    }
                    cleanup.add(e.getValue());
                    ea[s2]=null;
                }
                if (empty) {
                    hash[s1]=null;
                }
            }
        }
        
        cleanup(cleanup);
    }
    
    public void cleanup(V object)
    {
        if (object==null) return;
        if (object instanceof Cleanup) {
            ((Cleanup) object).cleanup();
        }
    }

    private void cleanup(List<V> l)
    {
        if (l==null) return;
        for (V val : l ) {
            cleanup(val);
        }
    }
    
    @SuppressWarnings("unchecked")
    private List<V> addToCleanup(List<V> l,Entry e)
    {
        if (e==null) return l;
        if (e.isAlive()) return l;
        if (l==null) l =new ArrayList<V>();
        l.add((V)e.getValue());
        return l;
    }

	public Iterable<Thread> keys() {
		return new KeyIterable<V>(this);
	}

	public Iterable<V> values() {
		return new ValueIterable<V>(this);
	}

	private static class KeyIterable<V> implements Iterable<Thread>
	{
		private ActiveThreadMap<V> map;

		public KeyIterable(ActiveThreadMap<V> map) {
			this.map=map;
		}

		@Override
		public Iterator<Thread> iterator() {
			return new KeyIterator<V>(map);
		}		
	}
	
	private static class KeyIterator<V> extends EntryIterator<Thread,V>
	{
		public KeyIterator(ActiveThreadMap<V> map) {
			super(map);
		}

		@Override
		protected Thread getNext(Entry<V> next) {
			return next.getKey();
		}
	}

	private static class ValueIterable<V> implements Iterable<V>
	{
		private ActiveThreadMap<V> map;

		public ValueIterable(ActiveThreadMap<V> map) {
			this.map=map;
		}

		@Override
		public Iterator<V> iterator() {
			return new ValueIterator<V>(map);
		}		
	}
	
	private static class ValueIterator<V> extends EntryIterator<V,V>
	{
		public ValueIterator(ActiveThreadMap<V> map) {
			super(map);
		}

		@Override
		protected V getNext(Entry<V> next) {
			return next.getValue();
		}
	}
	
	
	private static abstract class EntryIterator<K,V> implements Iterator<K>
	{
		private int 		bucketPos=0;
		private int 		hashPos=0;
		private Entry<V>	next=null;
		private Entry<V>	remove=null;
		private ActiveThreadMap<V> map;
		
		public EntryIterator(ActiveThreadMap<V> map)
		{
			this.map=map;
		}

		@Override
		public boolean hasNext() {
			synchronized(this) {
				while (next==null) {
					if (hashPos>=map.hash.length) return false;
					if (map.hash[hashPos]==null) {
						hashPos++;
						continue;
					}
					if (bucketPos>=map.hash[hashPos].length) {
						hashPos++;
						bucketPos=0;
						continue;
					}
					next=map.hash[hashPos][bucketPos++];
					if (next!=null && !next.isAlive()) { next=null; }
				}
				return true;
			}
		}

		@Override
		public final K next() {
			if (!hasNext()) throw new RuntimeException("Exhausted");
			remove=next;
			next=null;
			return getNext(remove);
		}
		
		protected abstract K getNext(Entry<V> next);

		@Override
		public void remove() {
			map.remove(remove.getKey());
		}
	}
	
}
