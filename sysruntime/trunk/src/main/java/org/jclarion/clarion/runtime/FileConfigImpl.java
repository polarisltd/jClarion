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
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 * Config file system
 *
 * 
 * 
 * @author barney
 *
 */
public class FileConfigImpl  extends CConfigImpl {
    private static Logger log = Logger.getLogger(CConfigImpl.class.getName());

    private File            	file;
    private File				parent;
    
    
    private PropInfo			cache=new PropInfo();
    
    private static class PropInfo
    {
    	private Map<String,String> data=new LinkedHashMap<String,String>();
    	private int  recordCount;
    	private long lastModified;
    	private long length;
    }
    
    public FileConfigImpl(String name)
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
        parent=file.getParentFile();
        if (parent==null) parent=file.getAbsoluteFile().getParentFile();
        
        
        boolean loaded=loadProperties(true);
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
                cache.data.put((section+l.substring(0,eq)).toLowerCase(),l.substring(eq+1));
            }
            r.close();

            saveProperties();
            
        } catch (IOException e) {
            log.log(Level.WARNING,"Could not read:"+e.getMessage(),e);
        }
    }
    
    public Map<String,String> getCache()
    {
    	return cache.data;
    }
    
    @Override
	public Map<String, String> getProperties() {
    	return cache.data;
	}

	public String getProperty(String section,String key)
    {
        loadProperties(false);
        synchronized(cache) {
        	return cache.data.get((section+"."+key).toLowerCase());
        }
    }

    public void setProperty(String section,String key,String value)
    {
        
    	
        if (value==null) value="";
        String ikey=(section+"."+key).toLowerCase();
        synchronized(cache) {
            if (value.equals(cache.data.get(ikey))) return; // already set        	
        }
        
        final int len[] = new int[] { 0 };

        try {
            final OutputStream bos = new FileOutputStream(file,true);
            
            OutputStream os = new OutputStream()
            {

    			@Override
    			public void write(byte[] b) throws IOException {
    				bos.write(b);
    				len[0]=b.length;
    			}

    			@Override
    			public void write(byte[] b, int off, int l) throws IOException {
    				bos.write(b, off, l);
    				len[0]+=l;
    			}

    			@Override
    			public void flush() throws IOException {
    				bos.flush();
    			}

    			@Override
    			public void close() throws IOException {
    				bos.close();
    			}

    			@Override
    			public void write(int b) throws IOException {
    				bos.write(b);
    				len[0]++;
    			}
            };
        	BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
        	writeStream(bw,ikey,value);
        	bw.close();
        } catch (IOException ex) { 
            log.severe("Failed to append "+file);
            ex.printStackTrace();
        }
    
        boolean schedule=false;
        
        synchronized(cache) {
            cache.data.remove(ikey);
            cache.data.put(ikey,value);
        	cache.lastModified=System.currentTimeMillis();
        	cache.length+=len[0];
        	cache.recordCount++;
        	if (cache.data.size()*120/100 < cache.recordCount && cache.recordCount>10) {
        		schedule=true;
        	}
        }
        
        if (schedule) scheduleFlush();
    }

    private static final int RETRY_LIMT=10;
    
    private void copyFile(File from,File to) throws IOException 
    {
    	FileOutputStream fos = new FileOutputStream(to);
    	FileInputStream fis = new FileInputStream(from);
    	byte[] buffer = new byte[65536];
    	while ( true ) {
    		int len = fis.read(buffer);
    		if (len<=0) break;
    		fos.write(buffer,0,len);
    	}
    	fos.close();
    	fis.close();
    }

    private boolean loadProperties(boolean force)
    {
    	if (!force) {
    		String message=null;
    		
    		boolean exists=file.exists();
    		long lastModified=exists ? file.lastModified() : 0;
    		long length =exists ? file.length() : 0;
    		
    		synchronized(cache) {
    			
    			if (cache.lastModified==0) {
    			} else {
    				if (exists) {
    					if (lastModified>cache.lastModified) {
    						message="Modified "+(lastModified-cache.lastModified)+"ms ago";
    					} else if (length!=cache.length) {
    						message="Length has changed from "+cache.length+" to "+length;
    					}
    					if (message==null) {
    						return false;
    					}
    				}
    			}
    		}
    		if (message!=null) {
    			log.info(message+". Reloading "+file);
    		}
    	}
        
        log.info("Loading "+file);
        
        // check for temp files etc

        int retry=0;
        while (true) {
        	if (retry>0) {
        		log.info("Retry #"+retry);
        		try {
					Thread.sleep(retry*100+(int)(Math.random()*50));
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
        	}
        	if (retry==RETRY_LIMT) break;
        	retry++;
        	
        	try { 
        		File thisFile=null;
        		File oldFile=null;
        		File newFile=null;
        
        		for (File scan : parent.listFiles()) {
        			if (scan.getName().equals(file.getName())) {
        				thisFile=scan;
        			}
        			if (scan.getName().equals(file.getName()+".old")) {
        				oldFile=scan;
        			}
        			if (scan.getName().equals(file.getName()+".new")) {
        				newFile=scan;        		
        			}
        		}

        		if (thisFile==null && oldFile==null && newFile==null) {
        			log.info("File does not exist");
        			return false;
        		}
        	
        		if (oldFile!=null) {
        			log.info("Unexpected old file");
        			long age = System.currentTimeMillis()- oldFile.lastModified();
        			if (age<0) age=0;
        			if (age<5000) {
        				if (retry<RETRY_LIMT/2) continue;
        				try {
							Thread.sleep(5000-age);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
            			continue;
        			}
            		if (thisFile==null || oldFile.length()>thisFile.length()) {
            			log.info("Reverting old file");
            			File tFile=File.createTempFile(file.getName(),"tmp",parent);
            			copyFile(oldFile, tFile);
            			tFile.renameTo(new File(parent,file.getName()+".new"));
            		} else {
            			log.info("Retaining new file");
            		}
        			oldFile.delete();
        			continue;
        		}
        		
        		if (newFile!=null) {
        			if (newFile.lastModified()<System.currentTimeMillis()-5000) {
        				log.info("Ignoring new file. It is >5 seconds old");
        				newFile.delete();
        				continue;
        			}
        			
        			if (thisFile!=null) {
        				log.info("Renaming file to old");
        				oldFile=new File(parent,file.getName()+".old");
        				if (!thisFile.renameTo(oldFile)) {
        					continue;
        				}
        			}
        			
        			log.info("Renaming new to file");
        			if (!newFile.renameTo(file)) {
        				continue;
        			}
        			if (oldFile!=null) {
        				log.info("Deleting old");
        				oldFile.delete();
        				oldFile=null;
        			}
        			thisFile=file;
        		}
        		
        		if (thisFile==null) continue;
        		
        		
        		PropInfo inf = readConfig(thisFile);
        		synchronized(cache) {
        			cache.length=inf.length;
        			cache.lastModified=inf.lastModified;
        			cache.recordCount=inf.recordCount;
        			cache.data=inf.data;
        		}
        		return true;
        		
        		
        	} catch (IOException ex) {
        		ex.printStackTrace();
        	}
        }
 
        return false;
    }
    
    private void saveProperties()
    {
        try {
        	File f = File.createTempFile(file.getName(),"tmp",parent);

        	BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f)));
            bw.write("# Clarion Properties");
            bw.write(EOL);
            
            synchronized(cache.data) { 
            	for ( Map.Entry<String,String> e : cache.data.entrySet()) {
            		writeStream(bw,e.getKey(),e.getValue());
            	}
            }
            bw.flush();
            bw.close();
            f.renameTo(new File(parent,file.getName()+".new"));
            f.delete();
        } catch (IOException ex) { 
            log.severe("Failed to save "+file);
            ex.printStackTrace();
        }
        loadProperties(true);
    }


    private int decodeHex(int val)
    {
        if (val>='0' && val<='9') return val-'0';
        if (val>='a' && val<='f') return val-'a'+10;
        if (val>='A' && val<='F') return val-'A'+10;
        return -1;
    }
    
    private PropInfo readConfig(File in) throws IOException
    {
    	final PropInfo result = new PropInfo();
    	result.lastModified=in.lastModified();
    	final InputStream bis = new FileInputStream(in);
    	
    	InputStream is=new InputStream() {

			@Override
			public int read() throws IOException {
				int r = bis.read();
				if (r>-1) result.length++;
				return r;
			}

			@Override
			public int read(byte[] b) throws IOException {
				int r = bis.read(b);
				if (r>0) result.length+=r;
				return r;
			}

			@Override
			public int read(byte[] b, int off, int len) throws IOException {
				int r = bis.read(b, off, len);
				if (r>0) result.length+=r;
				return r;
			}

			@Override
			public long skip(long n) throws IOException {
				long r=bis.skip(n);
				if (r>0) result.length+=r;
				return r;
			}

			@Override
			public int available() throws IOException {
				return bis.available();
			}

			@Override
			public void close() throws IOException 
			{
				bis.close();
			}

			@Override
			public synchronized void mark(int readlimit) 
			{
			}

			@Override
			public synchronized void reset() throws IOException {
				throw new IllegalStateException("Not supported");
			}

			@Override
			public boolean markSupported() {
				return false;
			}
    	};
    	is = new BufferedInputStream(is);
    	
    	Reader r = new InputStreamReader(is);
    	
        StringBuilder builder=new StringBuilder();
        String key=null;
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
                    result.recordCount++;
                    result.data.remove(key);
                    result.data.put(key,builder.toString());
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
        
        r.close();
        
        if (key!=null) {
            result.data.remove(key);
            result.data.put(key,builder.toString());
            result.recordCount++;
        }        
        return result;
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
    	synchronized(cache) {
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
        Thread t;
        synchronized (cache) {
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
        synchronized(cache) {
            while ( true ) {
                long wait = flushTime-System.currentTimeMillis();
                if (wait>0) {
                    try {
                        cache.wait(wait);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                } else {
                    break;
                }
            }
        }
        
        loadProperties(false);
        saveProperties();
        
        synchronized(cache) {
        	flush=null;
        	cache.notifyAll();
        }
    }

    @Override
    public void finish() {
    	join();
    }

}
