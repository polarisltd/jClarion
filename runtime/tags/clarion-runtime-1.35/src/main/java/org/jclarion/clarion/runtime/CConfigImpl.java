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

import java.io.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;


public class CConfigImpl {
    private static Logger log = Logger.getLogger(CConfigImpl.class.getName());

    private File            jfile;
    private File            nfile;
    private Properties      cache;
    private long            lastModified;
    private long            length;
    
    public CConfigImpl(String name)
    {
        name=name.toLowerCase();
        
        String jname = name;
        int indx;
        indx = jname.lastIndexOf('\\');
        if (indx>=0) {
            jname=jname.substring(indx+1);
        }

        indx = jname.lastIndexOf(".ini");
        if (indx>=0) {
            jname=jname.substring(0,indx);
        }

        indx = jname.lastIndexOf(".properties");
        if (indx==-1) {
            jname=jname+".properties";
        }
        
        jfile=new File(jname);
        nfile=new File(jname+".new");
        
        
        boolean loaded=false;
        if (nfile.exists()) {
            nfile.renameTo(jfile);
        }
        loaded=loadProperties();
        if (loaded) return;
        
        String iname = name;
        File ifile;
        ifile=new File(iname);
        if (!ifile.exists()) {
            ifile=new File("\\windows\\"+iname);
            if (!ifile.exists()) {
                ifile=new File("c:\\windows\\"+iname);
            }
        }
        if (!ifile.exists()) return;
        
        
        try {
            BufferedReader r = new BufferedReader(new FileReader(ifile));
            cache = new Properties();
            String section="";
            while ( true ) {
                String l = r.readLine();
                if (l==null) break;
                l=l.trim();
                if (l.length()==0) continue;
                if (l.charAt(0)==';') continue;
                if (l.charAt(0)=='[') {
                    section=l.substring(1,l.length()-1)+".";
                    continue;
                }
                
                int eq = l.indexOf('=');
                if (eq==-1) continue;
                cache.setProperty((section+l.substring(0,eq)).toLowerCase(),l.substring(eq+1));
            }
            r.close();

            saveProperties();
            
        } catch (IOException e) {
            log.log(Level.WARNING,"Could not read:"+e.getMessage(),e);
        }
    }

    private synchronized void recordFileChange(File in)
    {
        lastModified=in.lastModified();
        length=in.length();
    }
    
    private synchronized boolean isFileChanged()
    {
        if (jfile.lastModified()!=lastModified) return true;
        if (jfile.length()!=length) return true;
        return false;
    }
    
    public String getProperty(String section,String key)
    {
        synchronized(this) {
            if (isFileChanged()) {
                loadProperties();
            }
            if (cache==null) return null;
            return cache.getProperty((section+"."+key).toLowerCase());
        }
    }

    public void setProperty(String section,String key,String value)
    {
        
        String ikey=(section+"."+key).toLowerCase();
        
        Properties p = new Properties();
        
        boolean change = !value.equals(p.getProperty(ikey));
        if (!change && !isFileChanged()) return;
        
        p.setProperty(ikey,value);

        log.fine("Writing to:"+jfile);
        
        synchronized(this) {
            try {
                BufferedWriter bw = new BufferedWriter(new FileWriter(jfile,true));
                p.store(bw,null);
                bw.close();
                recordFileChange(jfile);
            } catch (IOException e) {
                log.severe("Could not append to property file");
                e.printStackTrace();
            }
        
            if (cache==null) cache=new Properties();
            cache.setProperty(ikey,value);
        }

        scheduleFlush();
    }
    
    public synchronized boolean loadProperties()
    {
        for (int test=0;test<2;test++) {
            
            File in = test==0 ? nfile : jfile;
            if (!in.exists()) continue;
            cache = null;
            try {
                BufferedReader r;
                r = new BufferedReader(new FileReader(in));
                cache = new Properties();
                cache.load(r);
                r.close();
                recordFileChange(in);
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    public synchronized void saveProperties()
    {
        File out;
        try {
            out = File.createTempFile("cfg",".tmp",jfile.getParentFile());
            BufferedWriter bw = new BufferedWriter(new FileWriter(out,false));
            cache.store(bw,"Clarion properties");
            bw.close();

            if (isFileChanged()) {
                out.delete();
                return;
            }
            
            nfile.delete();
            if (out.renameTo(nfile)) {
                
                for (int attempt=0;attempt<5;attempt++) {
                    jfile.delete();
                    if (!nfile.renameTo(jfile)) {
                        log.severe("Could not rename "+out+" to "+jfile);
                        try {
                            Thread.sleep(500);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    } else {
                        log.info("Rewritten config");
                        break;
                    }
                }
            }
            
            out.delete();
        } catch (IOException e) {
            log.log(Level.SEVERE,"Could not save file changes! : "+e.getMessage(),e);
            e.printStackTrace();
        }
        lastModified=jfile.lastModified();
    }

    private Thread flush;
    private long   flushTime;     
    
    private void scheduleFlush()
    {
        synchronized(this) {
            flushTime=System.currentTimeMillis()+1000;
            if (flush!=null) return;
            flush = new Thread("Property Flusher") {
                public void run() {
                    flush();
                }
            };
        }
        flush.start();
    }
    
    public void join()
    {
        synchronized(this) {
            while (flush!=null) {
                try {
                    wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    private void flush()
    {
        synchronized(this) {
            while ( true ) {
                long wait = flushTime-System.currentTimeMillis();
                if (wait>0) {
                    try {
                        wait(wait);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                } else {
                    break;
                }
            }
            loadProperties();
            saveProperties();
            flush=null;
            notifyAll();
        }
    }
}
