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
        
        private WeakReference<Object> value;
        private int hash;
        
        public Entry(Object o) {
            value=new WeakReference<Object>(o);
            hash = System.identityHashCode(o);
        }
        
        public Object getEntry() {
            return value.get();
        }

        public int hashCode() {
            return hash;
        }
     
        public boolean equals(Object o) {
            if (o==null) return false;
            if (o instanceof Entry) {
                Object l = getEntry();
                Object r = ((Entry)o).getEntry();
                if (l==null || r==null || l!=r) return false;
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
        clean();
        if (o==null) return 0;
        
        Entry e = new Entry(o);
        Integer result = objectToID.get(e);
        if (result!=null) return result;

        result = ++lastMemRef;
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
