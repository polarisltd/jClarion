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
package org.jclarion.clarion;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


/**
 * Model clarion object on memory.
 * 
 * @author barney
 *
 */
public abstract class ClarionMemoryModel {
    
    
    public static abstract class MyReference
    {
        public abstract ClarionMemoryChangeListener get();
    }
    
    public static class MyWeakReference extends MyReference
    {
        private WeakReference<ClarionMemoryChangeListener> val;
        
        public MyWeakReference(ClarionMemoryChangeListener val)
        {
            this.val=new WeakReference<ClarionMemoryChangeListener>(val);
        }
        
        public ClarionMemoryChangeListener get() {
            return val.get();
        }
    }

    public static class MyStrongReference extends MyReference
    {
        private ClarionMemoryChangeListener val;
        
        public MyStrongReference(ClarionMemoryChangeListener val)
        {
            this.val=val;
        }
        
        public ClarionMemoryChangeListener get() {
            return val;
        }
    }
    
    private List<MyReference> listeners;
    
    /**
     * Write java object to memory as clarion would represent object in memory
     * 
     * @param is
     */
    public abstract void serialize(OutputStream is) throws IOException;
    
    /**
     * Read object from memory as clarion would represent object in memory
     */ 
    public abstract void deserialize(InputStream os)  throws IOException;
    
    /**
     * Listen for changes to the objects representation. Note that listener
     * is weakly referenced. You need to maintain a strong reference to the
     * listener object in order for it not to be garbage collected 
     * 
     * @param cmcl
     */
    public void addChangeListener(ClarionMemoryChangeListener cmcl)
    {
        addChangeListener(cmcl,false);
    }

    public void addChangeListener(ClarionMemoryChangeListener cmcl,boolean strong)
    {
        if (listeners==null) {
            synchronized(this) {
                if (listeners==null) {
                    listeners = new ArrayList<MyReference>();
                }
            }
        }
        
        synchronized(listeners) {
            if (strong) {
                listeners.add(new MyStrongReference(cmcl));
            } else {
                listeners.add(new MyWeakReference(cmcl));
            }
        }
    }

    /**
     * Stop Listening for changes to the objects representation
     * 
     * @param cmcl
     */
    public void removeChangeListener(ClarionMemoryChangeListener cmcl)
    {
        if (listeners==null) return;
        
        synchronized(listeners) {
            Iterator<MyReference> scan;
            scan = listeners.iterator();
            while (scan.hasNext()) {
                MyReference val = scan.next();
                ClarionMemoryChangeListener sval = val.get();
                if (sval==cmcl || sval==null) {
                    scan.remove();
                }
            }
        }
    }
    
    public boolean isAnyoneInterestedInChange()
    {
        return listeners!=null;
    }
    
    public int getListenerCount()
    {
        if (listeners==null) return 0;
        synchronized(listeners) {
            return listeners.size();
        }
    }
    
    public void notifyChange() {
        if (listeners==null) return;
        
        List<ClarionMemoryChangeListener> notify = null; 
        
        synchronized(listeners) {
            Iterator<MyReference> scan;
            scan = listeners.iterator();
            while (scan.hasNext()) {
                MyReference val = scan.next();
                ClarionMemoryChangeListener sval = val.get();
                if (sval==null) {
                    scan.remove();
                } else {
                    if (notify==null) {
                        notify = new ArrayList<ClarionMemoryChangeListener>();                        
                    }
                    notify.add(sval);
                }
            }
        }
        
        if (notify==null) return;
        
        for ( ClarionMemoryChangeListener scan : notify ) {
            scan.objectChanged(this);
        }
    }
}
