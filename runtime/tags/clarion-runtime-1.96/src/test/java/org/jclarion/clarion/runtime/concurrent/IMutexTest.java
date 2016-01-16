package org.jclarion.clarion.runtime.concurrent;


public class IMutexTest extends ThreadHelper 
{
    
    public void testSimpleWaitAndRelease()
    {
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        
        IMutex m = new IMutex();
        
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

    public void testCallWaitManyTimes()
    {
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        
        IMutex m = new IMutex();
        
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(m));
        assertFalse(t2.isFinished(1000));
     
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t1.next(release(m));
        assertTrue(t1.isFinished(1000));
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

    public void testMultiRelease()
    {
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        
        IMutex m = new IMutex();
        
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(m));
        assertFalse(t2.isFinished(1000));
     
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t1.next(release(m,2));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
        
        t1.next(wait(m));
        assertFalse(t1.isFinished(1000));

        t2.next(release(m));
        assertTrue(t2.isFinished(1000));
        assertTrue(t1.isFinished(1000));
    }

    public void testOverRelease()
    {
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        
        IMutex m = new IMutex();
        
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(m));
        assertFalse(t2.isFinished(1000));
     
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t1.next(release(m,3));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
        
        t1.next(wait(m));
        assertFalse(t1.isFinished(1000));

        t2.next(release(m));
        assertTrue(t2.isFinished(1000));
        assertTrue(t1.isFinished(1000));
    }
    
    public void testTryWait() throws InterruptedException
    {
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        
        IMutex m = new IMutex();
        
        t1.next(wait(m));
        assertTrue(t1.isFinished(1000));
        
        t2.next(tryWait(m,500,1));
        assertTrue(t2.isFinished(1000));
     
        t2.next(tryWait(m,5000,0));

        Thread.sleep(100);
        
        t1.next(release(m));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
    }
    
    private Runnable release(final IMutex m)
    {
        return new Runnable() {
            public void run()
            {
                m.Release();
            }
        };
    }
    
    private Runnable release(final IMutex m,final int count)
    {
        return new Runnable() {
            public void run()
            {
                m.Release(count);
            }
        };
    }

    private Runnable wait(final IMutex m)
    {
        return new Runnable() {
            public void run()
            {
                m.Wait();
            }
        };
    }

    private Runnable tryWait(final IMutex m,final int millis,final int result)
    {
        return new Runnable() {
            public void run()
            {
                assertEquals(result,m.TryWait(millis));
            }
        };
    }
    
}
