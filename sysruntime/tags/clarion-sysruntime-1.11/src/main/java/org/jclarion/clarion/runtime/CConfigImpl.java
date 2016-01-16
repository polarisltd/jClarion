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
import java.nio.channels.FileLock;
import java.nio.channels.OverlappingFileLockException;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 * Config file system
 * 
 * Note that although file system is same partial implementation of java.util.Properties
 * we are not using this class. The reason is that Properties is backed by a hash map which means
 * that order of properties written is unpredictable. We want a predictable write order : 
 * so that when we are rewriting new config files, the risk of corrupting the file is minimised.
 * 
 * This is achieved with following algorithm. whenver a key is to be written it is to be written
 * to the bottom of the file. So that if entry appears earlier, it is essentially replaced.
 * 
 * This means that if a total file write fails half way, the only risk is that a entry in the file
 * may be partially corrupted. But the overall integrity of the file is still largely maintained.
 * 
 * @author barney
 *
 */
public class CConfigImpl {
    private static Logger log = Logger.getLogger(CConfigImpl.class.getName());

    private File            file;

    private RandomAccessFile openFile;
    private FileLock         lock;
    
    private Map<String,String>   cache=new LinkedHashMap<String,String>();
    private long            lastModified;
    private long            length;
    
    private int             recordCount;
    
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
        
        file=new File(jname);
        
        
        boolean loaded=loadProperties();
        if (loaded) {
            return;
        }
        
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
            FileReader fr = new FileReader(ifile);
            BufferedReader r = new BufferedReader(fr);
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
                cache.put((section+l.substring(0,eq)).toLowerCase(),l.substring(eq+1));
            }
            r.close();

            saveProperties(true);
            lastModified=0;
            loadProperties();
            
        } catch (IOException e) {
            log.log(Level.WARNING,"Could not read:"+e.getMessage(),e);
        }
    }
    
    public synchronized String getProperty(String section,String key)
    {
        loadProperties();
        return cache.get((section+"."+key).toLowerCase());
    }

    public synchronized void setProperty(String section,String key,String value)
    {
        if (value==null) value="";
        String ikey=(section+"."+key).toLowerCase();
        
        try {
            openFile(true,true);
            if (openFile==null) return;
            lock(false);
            
            long lm = file.lastModified();
            long len = file.length();
            
            if (lm!=lastModified || len!=length) {  
                lastModified=lm;
                length=len;
                doLoad();
            }

            if (value.equals(cache.get(ikey))) return; // already set

            openFile.seek(openFile.length());
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(getSaveStream()));
            writeStream(bw,ikey,value);
            bw.flush();
            
            cache.remove(ikey);
            cache.put(ikey,value);
            
        } catch (IOException ex) { 
            log.severe("Failed to append "+file);
            ex.printStackTrace();
        } finally {
            cleanup();
        }
        
        cache.put(ikey,value);
        lastModified=file.lastModified();
        length=file.length();
        recordCount++;

        // once duplicated records reach point where there is 20% duplication then flush
        if (cache.size()*120/100 < recordCount && recordCount>10) scheduleFlush();
    }

    private void openFile(boolean create,boolean rw) throws IOException
    {
        if (openFile==null) {
            if (!file.exists()) {
                if (!create) return;
                file.createNewFile();
            }
            openFile=new RandomAccessFile(file,file.canWrite() && rw ? "rw" : "r");
        }
    }
    
    private void lock(boolean shared) throws IOException
    {
        releaseLock();
        try {
            lock=openFile.getChannel().lock(0,Long.MAX_VALUE,shared);
            return;
        } catch (OverlappingFileLockException ex) {
            log.warning("Could not lock properties file due to overlap");
        }
        try {
            lock=openFile.getChannel().lock(0,1,shared);
            return;
        } catch (OverlappingFileLockException ex) {
            log.warning("Still Could not lock properties file due to overlap");
        }
    }
    
    private void releaseLock() throws IOException {
        if (lock!=null) {
            lock.release();
            lock=null;
        }
    }

    private void cleanup()
    {
        if (lock!=null) {
            try {
                lock.release();
            } catch (IOException e) {
                e.printStackTrace();
            }
            lock=null;
        }
        if (openFile!=null) {
            try {
                openFile.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            openFile=null;
        }
    }

    private void doLoad() throws IOException
    {
        log.info("Loading "+file);
        
        openFile.seek(0);
        InputStream is = new InputStream() {

            @Override
            public int read() throws IOException 
            {
                return openFile.read();
            }

            @Override
            public int available() throws IOException {
                long len = openFile.length()-openFile.getFilePointer();
                if (len>Integer.MAX_VALUE) return Integer.MAX_VALUE;
                return (int)len;
            }

            @Override
            public void close() throws IOException 
            {
            }

            @Override
            public int read(byte[] b, int off, int len) throws IOException 
            {
                return openFile.read(b,off,len);
            }

            @Override
            public int read(byte[] b) throws IOException {
                return openFile.read(b);
            }

            @Override
            public long skip(long n) throws IOException {
                if (n>Integer.MAX_VALUE) {
                    return openFile.skipBytes(Integer.MAX_VALUE);
                } else {
                    return openFile.skipBytes((int)n);
                }
            }
        };
        
        BufferedReader r = new BufferedReader(new InputStreamReader(is));
        cache.clear();
        readConfig(r,cache);
        log.info("Loaded "+recordCount+" lines "+cache.size()+" config items");
        
    }
    
    private boolean loadProperties()
    {
        if (!file.exists()) return false;
        if (file.lastModified()==lastModified && file.length()==length) return false; 
        
        try {
            openFile(false,false);
            if (openFile==null) return false;
            lock(true);
            
            long lm = file.lastModified();
            long len = file.length();
            
            if (lm==lastModified && len==length) return false;
            lastModified=lm;
            length=len;

            doLoad();
            
            return true;

        } catch (IOException ex) { 
            log.severe("Failed to load "+file);
            ex.printStackTrace();
            return false;
        } finally {
            cleanup();
        }
    }
    
    private void saveProperties(boolean force)
    {
        try {
            openFile(true,true);
            if (openFile==null) return;
            lock(false);
            if (!force) {
                if (file.lastModified()!=lastModified || file.length()!=length) return;
            }

            openFile.seek(0);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(getSaveStream()));
            bw.write("# Clarion Properties");
            bw.write(EOL);
            for ( Map.Entry<String,String> e : cache.entrySet()) {
                writeStream(bw,e.getKey(),e.getValue());
            }
            bw.flush();
            openFile.setLength(openFile.getFilePointer());
        } catch (IOException ex) { 
            log.severe("Failed to save "+file);
            ex.printStackTrace();
        } finally {
            cleanup();
        }
        lastModified=file.lastModified();
        length=file.length();
        recordCount=cache.size();
        log.info("Rewritten config for "+file);
    }

    private OutputStream getSaveStream() 
    {
        return new OutputStream()
        {

            @Override
            public void write(int b) throws IOException {
                openFile.write(b);
            }

            @Override
            public void write(byte[] b, int off, int len) throws IOException {
                openFile.write(b,off,len);
            }

            @Override
            public void write(byte[] b) throws IOException {
                openFile.write(b);
            }
        };
    }

    private int decodeHex(int val)
    {
        if (val>='0' && val<='9') return val-'0';
        if (val>='a' && val<='f') return val-'a'+10;
        if (val>='A' && val<='F') return val-'A'+10;
        return -1;
    }
    
    private void readConfig(Reader r,Map<String,String> config) throws IOException
    {
        StringBuilder builder=new StringBuilder();
        String key=null;
        recordCount=0;
        while ( true ) {
            int c = r.read();
            if (c==-1) break;
            if (c=='\\') {
                c= r.read();
                if (c==-1) break;
                if (c=='n') c='\n';
                if (c=='r') c='\r';
                if (c=='t') c='\t';
                if (c=='u') {
                    
                    int u1=decodeHex(r.read());
                    if (u1==-1) continue;
                    
                    int u2=decodeHex(r.read());
                    if (u2==-1) continue;
                    
                    int u3=decodeHex(r.read());
                    if (u3==-1) continue;
                    
                    int u4=decodeHex(r.read());
                    if (u4==-1) continue;
                    
                    c=(u1<<12)+(u2<<8)+(u3<<4)+u4;
                }
                builder.append((char)c);
                continue;
            }

            if ((c==' ' || c=='\t') && builder.length()==0) continue;
            if (key==null && (c=='!' || c=='#') && builder.length()==0) {
                while (c!='\n' && c!=-1) {
                    c=r.read();
                }
                continue;
            }
            
            if (c=='\r' || c=='\n') {
                if (key==null) {
                    builder.setLength(0);
                } else {
                    recordCount++;
                    config.remove(key);
                    config.put(key,builder.toString());
                    key=null;
                    builder.setLength(0);
                }
                continue;
            }
            
            if (key==null && (c==':' || c=='=')) {
                key=builder.toString();
                builder.setLength(0);
                continue;
            }
            
            builder.append((char)c);
        }
        
        if (key!=null) {
            config.remove(key);
            config.put(key,builder.toString());
            recordCount++;
        }
    }
    
    private static char hex[]="0123456789abcdef".toCharArray();
    
    private static String EOL=System.getProperty("line.separator");
    
    private void writeStream(Writer w,String key,String value) throws IOException
    {
        for (int scan=0;scan<key.length();scan++) {
            writeChar(key.charAt(scan),scan,w);
        }
        w.write('=');
        for (int scan=0;scan<value.length();scan++) {
            writeChar(value.charAt(scan),scan,w);
        }
        w.write(EOL);
    }
    
    private void writeChar(char c,int scan,Writer w) throws IOException 
    {
        if (c==' ' && scan==0) {
            w.write('\\');
        }

        if (c=='\t') {
            w.write('\\');
            c='t';
        }
        
        if (c == ':' || c == '=' || c=='#' || c=='!' || c=='\\') {
            w.write("\\");
        }
        if (c == '\n') {
            w.write("\\");
            c = 'n';
        }
        if (c == '\r') {
            w.write("\\");
            c = 'r';
        }
        if (c<32 || c > 127) {
            w.write("\\");
            w.write("u");
            w.write(hex[(c >> 12) & 0xf]);
            w.write(hex[(c >> 8) & 0xf]);
            w.write(hex[(c >> 4) & 0xf]);
            w.write(hex[(c) & 0xf]);
            return;
        }

        w.write(c);
    }
    
    private Thread flush;
    private long   flushTime;     
    
    private void scheduleFlush()
    {
        flushTime=System.currentTimeMillis()+1000;
        if (flush!=null) return;
        flush = new Thread("Property Flusher") {
            public void run() {
                flush();
            }
        };
        flush.start();
    }
    
    public void join()
    {
        Thread t;
        synchronized (this) {
            t = flush;
        }
        if (t != null) {
            try {
                t.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
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
            saveProperties(false);
            flush=null;
            notifyAll();
        }
    }
}
