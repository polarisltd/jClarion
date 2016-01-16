package org.jclarion.clarion.primative;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;
import java.util.TimerTask;

import org.jclarion.clarion.runtime.ClarionTaskManager;

public class ActiveThreadMap<V> 
{
    private static final int SIZE=8;
    private static final int AND=7;
    
    private static class Entry
    {
        private Entry(Thread key,Object value)
        {
            this.key=key;
            this.value=value;
        }

        private Thread key;
        private Object value;
    }
    
    private Entry[][] hash;
    
    public ActiveThreadMap()
    {
        hash=new Entry[SIZE][];
    }
    
    public void put(Thread thread,V value)
    {
        List<V> cleanup=null;
        
        synchronized(this) {

            int indx = ((int) thread.getId()) & AND;
            Entry[] bucket = hash[indx];
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

                if (e != null && e.key == thread) {
                    e.value = value;
                    return;
                }

                if (e == null || !e.key.isAlive()) {
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
                if (e.key != thread) {
                    cleanup = addToCleanup(cleanup, e);
                }
                e.key = thread;
                e.value = value;
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
            if (e!=null && e.key==thread) {
                return (V)e.value; 
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
            if (e!=null && e.key==thread) {
                Object result = e.value;
                bucket[scan]=null;
                return (V)result; 
            }
        }
        return null;
    }

    int getMemoryFootprint()
    {
        int count=0;
        for (Entry[] scan : hash ) {
            if (scan!=null) {
                count+=scan.length;
            }
        }
        return count;
    }

    @SuppressWarnings("unchecked")
    public void clear() 
    {
        Entry[][] old;
        synchronized(this) {
            old=hash;
            hash=new Entry[SIZE][];
        }
        
        for (Entry ea[] : old ) 
        {
            if (ea==null) continue;
            for (Entry e : ea ) {
                if (e!=null) {
                    cleanup((V)e.value);
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
                    Entry e = ea[s2];
                    if (e==null) continue;
                    if (e.key.isAlive()) {
                        empty=false;
                        continue;
                    }
                    cleanup.add((V)e.value);
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
        if (e.key.isAlive()) return l;
        if (l==null) l =new ArrayList<V>();
        l.add((V)e.value);
        return l;
    }
}
