package org.jclarion.clarion.primative;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import junit.framework.TestCase;

public class ActiveThreadMapTest extends TestCase 
{
    private static class LiveThread extends Thread
    {
        private boolean shutdown;

        @Override
        public void run()
        {
            synchronized(this) {
                while (!shutdown) { 
                    try {
                        wait();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        
        public void shutdown()
        {
            synchronized(this) {
                shutdown=true;
                notifyAll();
            }
            try {
                join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    private List<LiveThread> threads=new ArrayList<LiveThread>();
    
    private LiveThread create()
    {
        LiveThread lt = new LiveThread();
        lt.start();
        threads.add(lt);
        return lt;
    }
    
    public void tearDown()
    {
        for (LiveThread lt : threads ) {
            lt.shutdown();
        }
        threads.clear();
    }

    public void testSimpleOperations()
    {
        ActiveThreadMap<Object> atm = new ActiveThreadMap<Object>();
        assertNull(atm.get(Thread.currentThread()));
        Object o  =new Object();
        atm.put(Thread.currentThread(),o);
        assertSame(o,atm.get(Thread.currentThread()));
        assertSame(o,atm.remove(Thread.currentThread()));
        assertNull(atm.get(Thread.currentThread()));
        assertNull(atm.remove(Thread.currentThread()));
    }
    
    public void testIterators()
    {
        LiveThread lt[] = new LiveThread[30];
        ActiveThreadMap<Object> atm = new ActiveThreadMap<Object>();
        Map<Thread,Object> map = new HashMap<Thread,Object>();
        for (int scan=0;scan<lt.length;scan++) {
            lt[scan]=create();
            Object o = new Integer(scan);
            atm.put(lt[scan],o);
            map.put(lt[scan],o);
        }
    
        assertIterable(30,atm.keys(),map.keySet());
        assertIterable(30,atm.values(),map.values());

        for (int scan=0;scan<lt.length;scan++) {
        	lt[scan].shutdown();
        	map.remove(lt[scan]);
            assertIterable(29-scan,atm.keys(),map.keySet());
            assertIterable(29-scan,atm.values(),map.values());
        }
    }
    
    private void assertIterable(int count,Iterable<?> keys, Collection<?> keySet) 
    {
    	HashSet<Object> t = new HashSet<Object>();
    	for (Object o : keys ) {
    		t.add(o);
    	}
    	HashSet<Object> u = new HashSet<Object>();
    	for (Object o : keySet ) {
    		u.add(o);
    	}
    	assertEquals(count,t.size());
    	assertEquals(count,u.size());
    	assertEquals(t,u);
	}

	public void testActiveMapIsAsAccurateAsHashMap()
    {
        LiveThread lt[] = new LiveThread[30];
        for (int scan=0;scan<lt.length;scan++) {
            lt[scan]=create();
        }
        
        Map<Thread,Object> map = new HashMap<Thread,Object>();
        ActiveThreadMap<Object> atm = new ActiveThreadMap<Object>();
        
        Random r = new Random();
        
        for (int scan=0;scan<1000000;scan++) {
            
            Object o = new Object();
            Thread t = lt[r.nextInt(30)];

            switch(r.nextInt(3)) {
                case 0:
                    assertSame(atm.remove(t),map.remove(t));
                    break;
                case 1:
                    assertSame(atm.get(t),map.get(t));
                    break;
                case 2:
                    atm.put(t,o);
                    map.put(t,o);
                    break;
            }
        }
     
        assertTrue(""+atm.getMemoryFootprint(),atm.getMemoryFootprint()<=60);
    }

    public void testActiveMapDoesNotLeakOnThreadParade()
    {
        Map<Thread,Object> map = new HashMap<Thread,Object>();
        ActiveThreadMap<Object> atm = new ActiveThreadMap<Object>();
        

        Random r = new Random();

        for (int ms=0;ms<1000;ms++) {
            LiveThread lt[] = new LiveThread[30];
            for (int scan=0;scan<lt.length;scan++) {
                lt[scan]=create();
            }

            for (int scan = 0; scan < 10000; scan++) {

                Object o = new Object();
                Thread t = lt[r.nextInt(30)];

                switch (r.nextInt(3)) {
                case 0:
                    assertSame(atm.remove(t), map.remove(t));
                    break;
                case 1:
                    assertSame(atm.get(t), map.get(t));
                    break;
                case 2:
                    atm.put(t, o);
                    map.put(t, o);
                    break;
                }
            }

            assertTrue(""+atm.getMemoryFootprint(),atm.getMemoryFootprint() <= 60);
            
            tearDown();
        }
    }
    
    private static class CleanupTest implements Cleanup
    {
        int cleanup;
        
        @Override
        public void cleanup()
        {
            cleanup++;
        }
    }

    public void testPackEmpty()
    {
        ActiveThreadMap<CleanupTest> atm = new ActiveThreadMap<CleanupTest>();
        atm.pack();
    }

    public void testClearEmpty()
    {
        ActiveThreadMap<CleanupTest> atm = new ActiveThreadMap<CleanupTest>();
        atm.clear();
    }

    public void testCleanup()
    {
        ActiveThreadMap<CleanupTest> atm = new ActiveThreadMap<CleanupTest>();
        LiveThread lt[] = new LiveThread[30];
        CleanupTest ct[] = new CleanupTest[30];
        CleanupTest ct2[] = new CleanupTest[30];
        
        for (int scan=0;scan<30;scan++) {
            lt[scan]=create();
            ct[scan]=new CleanupTest();
            atm.put(lt[scan],ct[scan]);
        }
        
        for (int scan=0;scan<30;scan++) {
            lt[scan].shutdown();
            lt[scan]=create();
            ct2[scan]=new CleanupTest();
            atm.put(lt[scan],ct2[scan]);
        }
        
        assertTrue(countCleanup(ct)>20);
        assertTrue(countCleanup(ct)<=30);
        assertEquals(0,countCleanup(ct2));
        atm.pack();
        assertEquals(30,countCleanup(ct));
        assertEquals(0,countCleanup(ct2));
        atm.clear();
        assertEquals(30,countCleanup(ct));
        assertEquals(30,countCleanup(ct2));
    }
    
    private int countCleanup(CleanupTest[] ct)
    {
        int count=0;
        for (CleanupTest c : ct ){
            count+=c.cleanup;
        }
        return count; 
    }
}
