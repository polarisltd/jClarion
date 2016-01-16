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

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.crash.CrashStream;
import org.jclarion.clarion.jdbc.JDBCSource;

public class CRun {
    private static Logger log = Logger.getLogger(CRun.class.getName());

    private static String[] args;
    
    public static String getSystemDescription()
    {
        return "Java "+System.getProperty("java.specification.version")
        +" ("+System.getProperty("java.runtime.version")+") "
        +System.getProperty("os.name")+" "+System.getProperty("os.arch")+"("
        +System.getProperty("sun.arch.data.model")+")";
    }

    public static String getDBDescription(ClarionString source)
    {
        try {
            Connection c = JDBCSource.get(source.toString().trim()).getConnection();
            Statement s=c.createStatement();
            try {
                ResultSet rs = s.executeQuery("select version()");
                try {
                    if (rs.next()) {
                        String r=rs.getString(1);
                        int comma = r.indexOf(',');
                        if (comma>-1) return r.substring(0,comma);
                        return r;
                    }
                } finally {
                    rs.close();
                }
            } finally {
                s.close();
            }
        } catch (SQLException ex) { 
        }
        return "";
    }
    
    public static int random(int lo,int hi)
    {   
        return (int)( Math.random()*(hi-lo)+lo );
    }

    private static List<Runnable> shutdownHooks=new ArrayList<Runnable>();
    private static List<Runnable> initThreadHooks=new ArrayList<Runnable>();
    
    public static void shutdown()
    {
        initThreadHooks.clear();
        List<Runnable> shutdownScan;
        synchronized(shutdownHooks) {
            shutdownScan=new ArrayList<Runnable>(shutdownHooks);
            shutdownHooks.clear();
        }
        
        for (Runnable r : shutdownScan) {
            try {
                r.run();
            } catch (Throwable t ) { }
        }
    }
    
    public static void addInitThreadHook(Runnable r) 
    {
        synchronized(initThreadHooks) {
            initThreadHooks.add(r);
        }
    }

    public static void initThread()
    {
        List<Runnable> shutdownScan;
        synchronized(initThreadHooks) {
            shutdownScan=new ArrayList<Runnable>(initThreadHooks);
        }
        for (Runnable r : shutdownScan) {
            try {
                r.run();
            } catch (Throwable t ) { 
                t.printStackTrace();
            }
        }
    }        
    
    public static void addShutdownHook(Runnable r) {
        synchronized(shutdownHooks) {
            shutdownHooks.add(r);
        }
    }

    public static void removeShutdownHook(Runnable r) {
        synchronized(shutdownHooks) {
            shutdownHooks.add(r);
        }
    }
    
    private static boolean testMode;
    
    public static boolean isTestMode()
    {
    	return testMode;
    }
    
    public static void setTestMode(boolean mode)
    {
    	testMode=mode;
    }
    
    /**
     * Initialise runtime environment with passed command line args
     * @param args
     */
    public static void init(String[] args) {
        CRun.args=args;
        if ("true".equals(System.getProperty("__clarion.unittest"))) return;
        if (isTestMode()) return;

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyMM");
            PrintStream fos = new PrintStream(new CrashStream(new FileOutputStream("c9_"+sdf.format(new java.util.Date())+".log",true)));
            System.setErr(fos);
            System.setOut(fos);
            log.info("Starting c9");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        if ("true".equals(System.getProperty("clarion.debug"))) {
            new org.jclarion.clarion.log.Debug();
        }
    }

    /**
     *  Get command line argument
     *  
     * @param string
     * @return
     */
    public static ClarionString command(String string) {
        
        if (string.equals("0")) {
            return new ClarionString("java");
        }
        
        if (string.startsWith("/")) {
            for (int scan=0;scan<args.length;scan++) {
                if (args[scan].equalsIgnoreCase(string)) {
                    return new ClarionString("1");
                }
            }
            return new ClarionString("");
        }
        
        if (string.length()==0) {
            StringBuilder r = new StringBuilder();
            for (int scan=0;scan<args.length;scan++) {
                if (scan>0) r.append(' ');
                r.append(args[scan]);
            }
            return new ClarionString(r.toString());
        }
        
        try {
            int i = Integer.parseInt(string);
            if (i<1 || i>args.length) return new ClarionString("");
            return new ClarionString(args[i-1]);
        } catch (NumberFormatException ex) { 
        }
        
        for (int scan=0;scan<args.length;scan++) {
            int eq = args[scan].indexOf('=');
            if (eq==-1) continue;
            if (args[scan].substring(0,eq).equalsIgnoreCase(string)) {
                return new ClarionString(args[scan].substring(eq+1));
            }
        }
        
        if (string.equals("#unitTest") && isTestMode()) {
        	return Clarion.newString("1");
        }
        
        return new ClarionString("");
    }
    
    private static boolean hard;
    
    public static void setHardAssert(boolean hard)
    {
        CRun.hard=hard;
    }
    
    /**
     *  Clarion assertion test
     *  
     * @param assertion
     */
    public static void _assert(boolean assertion)
    {
        if (!assertion) {
            if (hard) {
                throw new RuntimeException("Assert Failed!");
            } else {
                System.err.println("Assert Failed! (soft)");
                Thread.dumpStack();
            }
        }
    }

    public static void _assert(boolean assertion,String msg)
    {
        if (!assertion) {
            if (hard) {
                throw new RuntimeException("Assertion Error:"+msg);
            } else {
                System.err.println("Assert Failed! (soft):"+msg);
                Thread.dumpStack();
            }
        }
    }

    /**
     *  Halt program
     *  
     * @param i
     * @param message
     */
    public static void halt(Integer i,String message) {
        
        if (message!=null && message.length()>0) {
            CWin.message(Clarion.newString(message),Clarion.newString("HALT"),Icon.HAND);
        }
        System.exit(0);
    }

    /**
     *  Stop program
     *  
     * @param message
     */
    public static void stop(String message)
    {
        if (message!=null && message.length()>0) {
            CWin.message(Clarion.newString(message),Clarion.newString("STOP"),Icon.HAND);
        }
        System.exit(0);
    }

    /**
     * Return first match of specified value
     * 
     * @param s
     * @param objs
     * @return
     */
    public static ClarionNumber inlist(String s,ClarionString objs[])
    {
        ClarionString cs = new ClarionString(s);
        
        for (int scan=0;scan<objs.length;scan++) {
            if (cs.equals(objs[scan])) return new ClarionNumber(scan+1);
        }
        return new ClarionNumber(0);
    }

    /**
     * return matching object
     * 
     * @param i
     * @param objs
     * @return
     */
    public static ClarionObject choose(int i,ClarionObject objs[])
    {
        if (objs.length==0) {
            return choose(i!=1,null,null);
        }
        
        if (i<1) return objs[objs.length-1];
        if (i>objs.length) return objs[objs.length-1];
        return objs[i-1];
    }

    /**
     * Retrun either first or second based on condition
     * 
     * @param aBool
     * @param o1
     * @param o2
     * @return
     */
    public static ClarionObject choose(boolean aBool,ClarionObject o1,ClarionObject o2)
    {
        if (o1==null) o1=new ClarionNumber(1);
        if (o2==null) o2=new ClarionNumber(0);
        return aBool ? o1 : o2;
    }
    
    /**
     * Return 1 or 0 based on condition
     * 
     * @param bool
     * @return
     */
    public static ClarionNumber choose(boolean bool)
    {
        return new ClarionNumber(bool ? 1 : 0); 
    }

    /**
     * Get current thread ID
     * 
     * @return
     */
    public static int getThreadID()
    {
        return (int)Thread.currentThread().getId();
    }

    public static Thread getThread(int id)
    {
        
        ThreadGroup tg = Thread.currentThread().getThreadGroup();
        while (tg.getParent()!=null) {
        	tg=tg.getParent();
        }
        
        int count = Thread.activeCount();
        if (count<4) count=4;
        count+=2;
        while ( true ) {
        	Thread t[] = new Thread[count];
        	int cnt=Thread.enumerate(t);
        	for (int scan=0;scan<cnt;scan++) {
        		if (t[scan].getId()==id) {
        			return t[scan];
        		}
        	}
        	if (cnt==count) {
        		count=count<<1;
        		continue;        	
        	}
            return null;
        }
    }

    /**
     *  Return true if object is between lower and upper
     *  
     * @param o
     * @param lower
     * @param upper
     * @return
     */
    public static boolean inRange(ClarionObject o,ClarionObject lower,ClarionObject upper)
    {
        return (o.compareTo(lower)>=0 && o.compareTo(upper)<=0);
    }
    
    
    /**
     *  Start new thread
     *  
     * @param r
     */
    public static Thread start(Runnable r)
    {
        r=new MonitoredRunnable(r);
        Thread t = new Thread(r);
        t.start();
        
        AbstractWindowTarget awt = CWin.getWindowTarget(); 
        if (awt instanceof ClarionApplication) {
        	((ClarionApplication)awt).registerThread(t);
        }
        
        return t;
    }

    /**
     *  Yield to other running threads
     */
    public static void yield()
    {
        Thread.yield();
    }
    
    public static int call(String dll,String function,Integer params)
    {
        return 0;
    }
}
