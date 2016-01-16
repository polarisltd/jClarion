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
package org.jclarion.clarion.swing;

import java.util.ArrayList;
import java.util.Collection;
import java.util.IdentityHashMap;
import java.util.WeakHashMap;

public class AWTBlocker 
{
    private static WeakHashMap<Thread,AWTBlocker> instance=new WeakHashMap<Thread, AWTBlocker>();
    
    public static AWTBlocker getInstance(Thread t)
    {
        synchronized(instance) {
            AWTBlocker blocker = instance.get(t);
            if (blocker==null) {
                blocker=new AWTBlocker();
                instance.put(t,blocker);
            }
            return blocker;
        }
    }

    private boolean blocked;
    private IdentityHashMap<Runnable,Boolean> listeners;
    
    public AWTBlocker()
    {
        blocked=false;
        listeners=new IdentityHashMap<Runnable, Boolean>();
    }
    
    public void setBlockState(boolean state)
    {
        Collection<Runnable> notify=null;
        
        synchronized(this) {
            blocked=state;
            if (blocked && !listeners.isEmpty()) {
                notify=new ArrayList<Runnable>();
                notify.addAll(listeners.keySet());
            }
        }
        
        if (notify!=null) {
            for (Runnable r : notify ) {
                r.run();
            }
        }
    }
    
    public boolean addListener(Runnable r)
    {
        synchronized(this) {
            if (blocked) {
                return true;
            }
            listeners.put(r,Boolean.TRUE);
        }
        return false;
    }

    public void removeListener(Runnable r)
    {
        synchronized(this) {
            listeners.remove(r);
        }
    }
    
}
