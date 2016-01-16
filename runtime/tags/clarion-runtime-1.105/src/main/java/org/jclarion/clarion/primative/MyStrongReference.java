package org.jclarion.clarion.primative;
import org.jclarion.clarion.ClarionMemoryChangeListener;

public class MyStrongReference extends MyReference
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
