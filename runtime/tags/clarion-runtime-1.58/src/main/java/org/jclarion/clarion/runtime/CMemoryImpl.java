/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.runtime;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.jclarion.clarion.Threaded;

public class CMemoryImpl 
{
    private static CMemoryImpl instance ;
   
    public static CMemoryImpl getInstance()
    {
        if (instance==null) {
            synchronized(CMemoryImpl.class) {
                if (instance==null) instance=new CMemoryImpl(); 
            }
        }
        return instance;
    }
    
    private int lastMemRef=0;
    
    private static class Entry {

        private Thread                _thread;
        private WeakReference<Object> _val;
        private Object                _realVal;
        private int                   _hash;
        
        public Entry(Object base,Object realVal,Thread t) {
            _thread=t;
            this._val=new WeakReference<Object>(base);
            this._realVal=realVal;
            _hash = System.identityHashCode(base)+ (t!=null? t.hashCode() : 0);
        }
        
        public Object getEntry() {
            Object r = _val.get();
            if (r==null) return null;
            if (_realVal!=null) return _realVal; 
            return r;
        }

        public int hashCode() {
            return _hash;
        }
     
        public boolean equals(Object o) {
            if (o==null) return false;
            if (o instanceof Entry) {
                Entry oe = (Entry)o;
                Object l = getEntry();
                Object r = oe.getEntry();
                if (l==null || r==null || l!=r) return false;
                if (_thread!=oe._thread) return false;
                return true;
            }
            return false;
        }
    }

    private Map<Entry,Integer> objectToID;
    private Map<Integer,Entry> idToObject;
    
    
    public CMemoryImpl()
    {
        objectToID=new HashMap<Entry,Integer>();
        idToObject=new HashMap<Integer,Entry>();
        CRun.addShutdownHook(new Runnable() { 
            public void run()
            {
                instance=null;
            }
        } );
    }

    private void clean(Iterator<Entry> scan)
    {
        while (scan.hasNext()) {
            Entry value = scan.next();
            if (value.getEntry()==null) {
                scan.remove();
            }
        }
    }
    
    
    public void forceClean()
    {
        clean(objectToID.keySet().iterator());
        clean(idToObject.values().iterator());
    }
    
    private long lastClean=0;
    public void clean()
    {
        if (lastClean+5000<System.currentTimeMillis()) {
            forceClean();
            lastClean=System.currentTimeMillis();
        }
    }
    
    public int address(Object o) 
    {
        return address(o,null);
    }
    
    public int address(Object o,Thread t) 
    {
        clean();
        if (o==null) return 0;
        
        Entry e = new Entry(o,null,t);
        Integer result = objectToID.get(e);
        if (result!=null) return result;

        result = ++lastMemRef;
        
        if (t!=null) {
            if (o instanceof Threaded) {
                Threaded to = (Threaded)o;
                Object lock = to.getLockedObject(t);

                Entry lockEntry = new Entry(o,lock,null);
                
                objectToID.put(e,result);
                objectToID.put(lockEntry,result);
                idToObject.put(result,lockEntry);
             
                return result;
            }
        }
        
        objectToID.put(e,result);
        idToObject.put(result,e);
        return result;
    }
    
    public Object resolveAddress(int val)
    {
        clean();
        if (val==0) return null;
        
        Entry e  = idToObject.get(val);
        if (e!=null) return e.getEntry();
        return null;
    }

    private static class TieList
    {
        public Map<Integer,Integer> list=new HashMap<Integer,Integer>();
        public int lastValue;
    }
    
    private Map<String,TieList> ties=new HashMap<String,TieList>();
    
    public int tied(String key,int index)
    {
        TieList t = ties.get(key);
        if (t==null) return 0;
        
        Integer result = t.list.get(index);
        if (result==null) return 0;
        return result.intValue();
    }

    public int tie(String key,int index,int value)
    {
        TieList t = ties.get(key);
        if (t==null) {
            t=new TieList();
            ties.put(key,t);
            if (index==0) index=1;
        }
        
        if (index==0) {
            index = t.lastValue++;
            while (t.list.containsKey(index)) index++;
        }
        
        if (index>t.lastValue) t.lastValue=index;
        t.list.put(index,value);
        
        return index;
    }

    public void untie(String key,int index)
    {
        TieList t = ties.get(key);
        if (t!=null) {
            t.list.remove(index);
            if (t.list.isEmpty()) {
                ties.remove(key);
            }
        }
    }
    
}
