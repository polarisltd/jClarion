package org.jclarion.clarion.primative;

import java.lang.ref.WeakReference;

import org.jclarion.clarion.ClarionMemoryChangeListener;

public class MyWeakReference extends MyReference
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
