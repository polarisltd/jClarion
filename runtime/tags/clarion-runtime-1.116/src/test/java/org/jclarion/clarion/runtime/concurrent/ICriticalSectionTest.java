package org.jclarion.clarion.runtime.concurrent;


public class ICriticalSectionTest extends ThreadHelper 
{
    
    public void testSimpleWaitAndRelease()
    {
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        
        ICriticalSection m = new ICriticalSection();
        
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(m));
        assertFalse(t2.isFinished(1000));
        
        t1.next(release(m));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
        
        t1.next(wait(m));
        assertFalse(t1.isFinished(1000));

        t2.next(release(m));
        assertTrue(t2.isFinished(1000));
        assertTrue(t1.isFinished(1000));
    }


    private Runnable release(final ICriticalSection m)
    {
        return new Runnable() {
            public void run()
            {
                m.Release();
            }
        };
    }
    
    private Runnable wait(final ICriticalSection m)
    {
        return new Runnable() {
            public void run()
            {
                m.Wait();
            }
        };
    }

}
