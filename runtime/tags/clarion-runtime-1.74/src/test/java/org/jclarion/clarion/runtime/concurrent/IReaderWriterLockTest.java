package org.jclarion.clarion.runtime.concurrent;



public class IReaderWriterLockTest extends ThreadHelper 
{
    public void testTrueReadBlockMode()
    {
        IReaderWriterLock l = new IReaderWriterLock();
        
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        MyHelper t3 = getHelper();
        
        t1.next(wait(l.reader()));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(l.writer()));
        assertFalse(t2.isFinished(1000));

        t3.next(wait(l.reader()));
        assertFalse(t3.isFinished(1000));
        
        t1.next(release(l.reader()));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
        assertFalse(t3.isFinished(1000));
        
        t2.next(release(l.writer()));
        assertTrue(t2.isFinished(1000));
        assertTrue(t3.isFinished(1000));
    }

    
    public void testTrueReadBlockMode2()
    {
        IReaderWriterLock l = new IReaderWriterLock(true);
        
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        MyHelper t3 = getHelper();
        
        t1.next(wait(l.reader()));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(l.writer()));
        assertFalse(t2.isFinished(1000));

        t3.next(wait(l.reader()));
        assertFalse(t3.isFinished(1000));
        
        t1.next(release(l.reader()));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
        assertFalse(t3.isFinished(1000));
        
        t2.next(release(l.writer()));
        assertTrue(t2.isFinished(1000));
        assertTrue(t3.isFinished(1000));
    }

    public void testTrueReadBlockMode3()
    {
        IReaderWriterLock l = new IReaderWriterLock(null);
        
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        MyHelper t3 = getHelper();
        
        t1.next(wait(l.reader()));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(l.writer()));
        assertFalse(t2.isFinished(1000));

        t3.next(wait(l.reader()));
        assertFalse(t3.isFinished(1000));
        
        t1.next(release(l.reader()));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
        assertFalse(t3.isFinished(1000));
        
        t2.next(release(l.writer()));
        assertTrue(t2.isFinished(1000));
        assertTrue(t3.isFinished(1000));
    }
    
    public void testFalseReadBlockMode()
    {
        IReaderWriterLock l = new IReaderWriterLock(false);
        
        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        MyHelper t3 = getHelper();
        
        t1.next(wait(l.reader()));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(l.writer()));
        assertFalse(t2.isFinished(1000));

        t3.next(wait(l.reader()));
        assertTrue(t3.isFinished(1000));
        
        t1.next(release(l.reader()));
        assertTrue(t1.isFinished(1000));
        assertFalse(t2.isFinished(1000));
        assertTrue(t3.isFinished(1000));
        
        t3.next(release(l.reader()));
        assertTrue(t3.isFinished(1000));
        assertTrue(t2.isFinished(1000));
    }
    
    public void testWriterAcquisitionBlocksReaders()
    {
        IReaderWriterLock l = new IReaderWriterLock();

        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();
        MyHelper t3 = getHelper();

        t1.next(wait(l.writer()));
        assertTrue(t1.isFinished(1000));
        
        t2.next(wait(l.reader()));
        assertFalse(t2.isFinished(1000));

        t1.next(release(l.writer()));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));
        
        t3.next(wait(l.reader()));
        assertTrue(t3.isFinished(1000));
        
        t1.next(wait(l.writer()));
        assertFalse(t1.isFinished(1000));

        t2.next(release(l.reader()));
        assertTrue(t2.isFinished(1000));
        assertFalse(t1.isFinished(1000));

        t3.next(release(l.reader()));
        assertTrue(t3.isFinished(1000));
        assertTrue(t1.isFinished(1000));
    }
    
    public void testCompetingWriters()
    {
        IReaderWriterLock l = new IReaderWriterLock();

        MyHelper t1 = getHelper();
        MyHelper t2 = getHelper();

        t1.next(wait(l.writer()));
        assertTrue(t1.isFinished(1000));

        t2.next(wait(l.writer()));
        assertFalse(t2.isFinished(1000));

        t1.next(release(l.writer()));
        assertTrue(t1.isFinished(1000));
        assertTrue(t2.isFinished(1000));

        t1.next(wait(l.writer()));
        assertFalse(t1.isFinished(1000));

        t2.next(release(l.writer()));
        assertTrue(t2.isFinished(1000));
        assertTrue(t1.isFinished(1000));

        t1.next(release(l.writer()));
        assertTrue(t1.isFinished(1000));
    }
    
    private Runnable release(final ISyncObject m)
    {
        return new Runnable() {
            public void run()
            {
                m.Release();
            }
        };
    }
    
    private Runnable wait(final ISyncObject m)
    {
        return new Runnable() {
            public void run()
            {
                m.Wait();
            }
        };
    }

}
