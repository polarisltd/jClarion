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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import junit.framework.TestCase;

public class ClarionEventTest extends TestCase 
{
    private ClarionEvent ce[];
    private ClarionWindow cw[];

    private Object monitor = new Object();
    
    public void setUp()
    {
        runCountOk=0;
        runCountNotOk=0;
        noRunCountOk=0;
        noRunCountNotOk=0;
        waitCountOk=0;
        waitCountNotOk=0;
    }

    private volatile int runCountOk;
    private volatile int runCountNotOk;
    private volatile int noRunCountOk;
    private volatile int noRunCountNotOk;
    private volatile int waitCountOk;
    private volatile int waitCountNotOk;
    
    public void testRaceToConsume()
    {
        ce = new ClarionEvent[100];
        
        for (int scan=0;scan<ce.length;scan++) {
            ce[scan]=new ClarionEvent(scan,scan*2,false);
        }
        
        List<Runnable> r = new ArrayList<Runnable>();
        
        for (int scan=0;scan<ce.length;scan++) {
            
            final int s=scan;
            
            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    ce[s].consume(s%2==0);
                }
            });

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    if (ce[s].getConsumeResult()) {
                        synchronized(monitor) {
                            waitCountOk++;
                        }
                    } else {
                        synchronized(monitor) { waitCountNotOk++; }
                    }
                }
            });

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    Boolean r = ce[s].runOnConsumedResult(new Runnable() {

                        @Override
                        public void run() {
                            if (ce[s].getConsumeResult()) {
                                synchronized(monitor) {  runCountOk++; }
                            } else {
                                synchronized(monitor) {  runCountNotOk++; }
                            }
                        }
                    });
                    if (r!=null) {
                        if (r.booleanValue()) {
                            synchronized(monitor) {  noRunCountOk++; }
                        } else {
                            synchronized(monitor) { noRunCountNotOk++; }
                        }
                    }
                }
            });
        }
        
        runTasksAndWait(r);

        synchronized(monitor) {
            
            int aboveZero = 
                ((runCountNotOk>0)?1:0) +
                ((runCountOk>0)?1:0) +
                ((noRunCountNotOk>0)?1:0) +
                ((noRunCountOk>0)?1:0);
            
            assertTrue(aboveZero>2);
            
            assertEquals(ce.length/2,runCountOk+noRunCountOk);
            assertEquals(ce.length/2,runCountNotOk+noRunCountNotOk);
            assertEquals(ce.length/2,waitCountOk);
            assertEquals(ce.length/2,waitCountNotOk);
        }
    }

    public void testRaceToConsumeWithClosingWindows()
    {
        ce = new ClarionEvent[100];
        cw = new ClarionWindow[ce.length/2];

        for (int scan=0;scan<cw.length;scan++) {
            cw[scan]=new ClarionWindow();
            cw[scan].setActiveState(false);
        }
        
        for (int scan=0;scan<ce.length;scan++) {
            ce[scan]=new ClarionEvent(scan,scan*2,false);
        }
        
        List<Runnable> r = new ArrayList<Runnable>();

        for (int scan=0;scan<cw.length;scan++) {
            final int s=scan;
            
            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    cw[s].setActiveState(false);
                }
            });
        }
        
        for (int scan=0;scan<ce.length;scan++) {
            
            final int s=scan;
            
            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    ce[s].consume(false);
                }
            });

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    cw[s/2].post(ce[s]);
                }
            });

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    if (ce[s].getConsumeResult()) {
                        synchronized(monitor) {  waitCountOk++; }
                    } else {
                        synchronized(monitor) {  waitCountNotOk++; }
                    }
                }
            });

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    Boolean r = ce[s].runOnConsumedResult(new Runnable() {

                        @Override
                        public void run() {
                            if (ce[s].getConsumeResult()) {
                                synchronized(monitor) {  runCountOk++; }
                            } else {
                                synchronized(monitor) { runCountNotOk++;}
                            }
                        }
                    });
                    if (r!=null) {
                        if (r.booleanValue()) {
                            synchronized(monitor) { noRunCountOk++;}
                        } else {
                            synchronized(monitor) { noRunCountNotOk++;}
                        }
                    }
                }
            });
        }
        
        runTasksAndWait(r);
        
        synchronized(monitor)  {
            
            int aboveZero = 
                ((runCountNotOk>0)?1:0) +
                ((runCountOk>0)?1:0) +
                ((noRunCountNotOk>0)?1:0) +
                ((noRunCountOk>0)?1:0) +
                ((waitCountNotOk>0)?1:0) +
                ((waitCountOk>0)?1:0);
            
            assertTrue(aboveZero>3);
            
            /*
            assertTrue(runCountNotOk>0);
            assertTrue(runCountOk>0);
            assertTrue(noRunCountNotOk>0);
            assertTrue(noRunCountOk>0);
            assertTrue(waitCountNotOk>0);
            assertTrue(waitCountOk>0);
            */
        
            assertEquals(ce.length,waitCountOk+waitCountNotOk);
            assertEquals(ce.length,runCountOk+noRunCountOk+runCountNotOk+noRunCountNotOk);
        }
    }

    
    public void testRaceToConsumeWithClosingWindows2()
    {
        ce = new ClarionEvent[100];
        cw = new ClarionWindow[ce.length/2];

        for (int scan=0;scan<cw.length;scan++) {
            cw[scan]=new ClarionWindow();
            cw[scan].setActiveState(false);
        }
        
        for (int scan=0;scan<ce.length;scan++) {
            ce[scan]=new ClarionEvent(scan,scan*2,false);
        }
        
        List<Runnable> r = new ArrayList<Runnable>();

        for (int scan=0;scan<cw.length;scan++) {
            final int s=scan;
            
            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    cw[s].setActiveState(false);
                }
            });
        }
        
        for (int scan=0;scan<ce.length;scan++) {
            
            final int s=scan;

            
            if (Math.random()<0.5) {
                r.add(new Runnable() {
                    @Override
                    public void run() {
                        sleep();
                        ce[s].consume(false);
                    }
                });
            }

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    cw[s/2].post(ce[s]);
                }
            });

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    if (ce[s].getConsumeResult()) {
                        synchronized(monitor)  { 
                            synchronized(monitor) { waitCountOk++;}
                        }
                    } else {
                        synchronized(monitor)  { 
                            synchronized(monitor) { waitCountNotOk++;}
                        }
                    }
                }
            });

            r.add(new Runnable() {
                @Override
                public void run() {
                    sleep();
                    Boolean r = ce[s].runOnConsumedResult(new Runnable() {

                        @Override
                        public void run() {
                            if (ce[s].getConsumeResult()) {
                                synchronized(monitor) { runCountOk++;}
                            } else {
                                synchronized(monitor) { runCountNotOk++;}
                            }
                        }
                    });
                    if (r!=null) {
                        if (r.booleanValue()) {
                            synchronized(monitor) { noRunCountOk++;}
                        } else {
                            synchronized(monitor) { noRunCountNotOk++;}
                        }
                    }
                }
            });
        }
        
        runTasksAndWait(r);
        
        synchronized(monitor)  { 
            int aboveZero = 
                ((runCountNotOk>0)?1:0) +
                ((runCountOk>0)?1:0) +
                ((noRunCountNotOk>0)?1:0) +
                ((noRunCountOk>0)?1:0) +
                ((waitCountNotOk>0)?1:0) +
                ((waitCountOk>0)?1:0);
            
            assertTrue(aboveZero>3);
        
            assertEquals(ce.length,waitCountOk+waitCountNotOk);
            assertEquals(ce.length,runCountOk+noRunCountOk+runCountNotOk+noRunCountNotOk);
        }
    }
    
    public void runTasksAndWait(List<Runnable> r) 
    {
        Collections.shuffle(r);
        
        final Thread t[] = new Thread[r.size()];
        
        int count=0;
        for (Runnable ru : r ) {
            t[count] = new Thread(ru);
            count++;
        }
        
        for (Thread tr : t ) {
            tr.start();
        }
                    
        
        int lastAliveCount=-1;
        
        while ( true ) {
            
            int thisAliveCount=0;
            
            Thread n = null;
            for (int scan=0;scan<t.length;scan++) {
                if (t[scan].isAlive()) {
                    thisAliveCount+=1;
                    n=t[scan];
                }
            }
            
            if (n==null) {
                break;
            }

            assertTrue(" Alive jobs : "+thisAliveCount,thisAliveCount!=lastAliveCount);
            lastAliveCount=thisAliveCount;
            
            try {
                n.join(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        for (int scan=0;scan<t.length;scan++) {
            try {
                t[scan].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            t[scan]=null;
        }
        
        System.gc();
    }
    public void sleep()
    {
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
