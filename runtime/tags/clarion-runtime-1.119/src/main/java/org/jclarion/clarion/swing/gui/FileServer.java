package org.jclarion.clarion.swing.gui;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.file.ClarionRandomAccessFileSystemFile;
import org.jclarion.clarion.runtime.CConfigStore;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CWinImpl;

public class FileServer extends AbstractWidget 
{
	private static FileServer instance=new FileServer();;
	
	public static FileServer getInstance()
	{
		return instance;
	}
	
	protected FileServer()
	{
	}
	
    @Override
	public CommandList getCommandList() {
		return CommandList.create()
			.add("OPEN",1)
			.add("LENGTH",2)
			.add("READ",3)
			.add("WRITE",4)
			.add("CLOSE",5)
			.add("CREATE",6)
			.add("DELETE",7)
			.add("LIST",8)
			.add("GET_PATH",9)
			.add("LAST_MODIFIED",10)
			.add("IS_DIRECTORY",11)
    	;
	}
	
	private static final int OPEN=1;
	private static final int LENGTH=2;
	private static final int READ=3;
	private static final int WRITE=4;
	private static final int CLOSE=5;
	private static final int CREATE=6;
	private static final int DELETE=7;
	private static final int LIST=8;
	private static final int GET_PATH=9;
	private static final int LAST_MODIFIED=10;
	private static final int IS_DIRECTORY=11;
    public static final int GET_ALL_CONFIG=12;
    public static final int SET_CONFIG=13;


    @Override
    public boolean isGuiCommand(int command)
    {
    	return false;
    }        
	
	public static String prep(String name)
	{
		return clientPrep(name);
	}
	
	public static String serverPrep(String name)
	{
		name=name.trim();
		if (CFile.isAbsolute(name)) return name;
		return CFile.getPath()+"\\"+name;
	}
	
	public static String clientPrep(String name)
	{
		name=name.trim();
		name=name.replace('\\',File.separatorChar);
		return name;
	}
	
	public long lastModified(String name)
	{
		return (Long)CWinImpl.runNow(this,LAST_MODIFIED,serverPrep(name));		
	}

	public boolean isDirectory(String name)
	{
		return (Boolean)CWinImpl.runNow(this,IS_DIRECTORY,serverPrep(name));		
	}
	
	public void open(int id,String name) throws FileNotFoundException
	{
		boolean b = (Boolean)CWinImpl.runNow(this,OPEN,id,serverPrep(name));
		if (!b) throw new FileNotFoundException(name);
	}

	public int length(int id) throws IOException
	{
		int i = (Integer)CWinImpl.runNow(this,LENGTH,id);
		if (i==-1) throw new IOException("Cannot get length");
		return i;
	}

	public byte[] read(int id,int pos,int len)
	{
		return (byte[])CWinImpl.runNow(this,READ,id,pos,len);
	}

	public void write(int id,int pos,byte data[])
	{
		CWinImpl.run(this,WRITE,id,pos,data);
	}

	public void flush(int id,int pos,byte data[])
	{
		CWinImpl.runNow(this,WRITE,id,pos,data);
	}
	
	public void close(int id)
	{
		CWinImpl.runNow(this,CLOSE,id);
	}
	
	public Object[] list(String name)
	{
		return (Object[])CWinImpl.runNow(this,LIST,serverPrep(name));
	}

	public boolean create(String name)
	{
		return (Boolean)CWinImpl.runNow(this,CREATE,serverPrep(name));
	}

	public boolean delete(String name)
	{
		return (Boolean)CWinImpl.runNow(this,DELETE,serverPrep(name));
	}

    @SuppressWarnings("unchecked")
	public Map<String,String> getAllRemoteConfig(String name)
    {
    	return (Map<String,String>)CWinImpl.runNow(this,GET_ALL_CONFIG,name);
    }

    public void setRemoteConfig(String section,String key,String value,String file)
    {
    	CWinImpl.run(this,SET_CONFIG,section,key,value,file);
    }
	
	private Map<Integer,ClarionRandomAccessFile> files = new HashMap<Integer,ClarionRandomAccessFile>();
	
	@Override
	public Object command(int command, Object... params) 
	{
		switch(command) {
			case GET_ALL_CONFIG: {
				return CConfigStore.getInstance((String)params[0]).getProperties();
			}
			case SET_CONFIG: {
				CConfigStore.setProperty(
						(String)params[0],
						(String)params[1],
						(String)params[2],
						(String)params[3]
					);
				return null;
			}
			case GET_PATH: {
				try {
					return new File(".").getAbsoluteFile().getCanonicalFile().getPath();
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}
			case LAST_MODIFIED: { 
				String name = clientPrep((String)params[0]);
				File f = new File(name);
				return f.lastModified();
			}
			case IS_DIRECTORY: { 
				String name = clientPrep((String)params[0]);
				File f = new File(name);
				return f.isDirectory();
			}
			case LIST: {
				String name = clientPrep((String)params[0]);
				File f = new File(name);
		        File kids[] = f.listFiles();
		        if (kids==null) return null;
				Object[] files = new Object[kids.length];
				for (int scan=0;scan<kids.length;scan++) {
					File kid=kids[scan];
					files[scan]=new Object[] { 
						kid.getName(),
						kid.canWrite(),
						kid.isHidden(),
						kid.isDirectory(),
						kid.lastModified(),
						kid.length()
					};
				}
				return files;
			}
		
			case CREATE: {
				String name = clientPrep((String)params[0]);
				File f = new File(name);
		        try {
		            f.delete();
		            return f.createNewFile();
		        } catch (IOException e) {
		        	e.printStackTrace();
		            return false;
		        }
			}
			case DELETE: {
				String name = clientPrep((String)params[0]);
				File f = new File(name);
	            return f.delete();
			}
			case OPEN: {
				int id = (Integer)params[0];
				String name = clientPrep((String)params[1]);
				try {
					ClarionRandomAccessFileSystemFile f = new ClarionRandomAccessFileSystemFile(new File(name));
					synchronized(files) {
						files.put(id,f);
					}
					return true;
				} catch (IOException ex) {
					ex.printStackTrace();
					return false;
				}
			}	
			case LENGTH: {
				int id = (Integer)params[0];
				ClarionRandomAccessFile f;
				synchronized(files) {
					f=files.get(id);
				}
				if (f==null) return -1;
				try {
					return (int)f.length();
				} catch (IOException e) {
					e.printStackTrace();
					return -1;
				}
			}
			case READ: {
				int id = (Integer)params[0];
				int pos = (Integer)params[1];
				int len = (Integer)params[2];
				ClarionRandomAccessFile f;
				synchronized(files) {
					f=files.get(id);
				}
				if (f==null) return null;
				try {
					f.seek(pos);
					byte[] buffer = new byte[len];
					int p=0;
					while (p<len) {
						int r = f.read(buffer,p,len-p);
						if (r<=0) break;
						p=p+r;
					}
					if (p<len) {
						byte[] trim= new byte[p];
						System.arraycopy(buffer,0,trim,0,p);
						return trim;
					} else {
						return buffer;
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}
			case WRITE: {
				int id = (Integer)params[0];
				int pos = (Integer)params[1];
				byte data[] = (byte[])params[2];
				ClarionRandomAccessFile f;
				synchronized(files) {
					f=files.get(id);
				}
				if (f==null) return null;
				try {
					f.seek(pos);
					f.write(data,0,data.length);
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}
			case CLOSE: {
				int id = (Integer)params[0];
				ClarionRandomAccessFile f;
				synchronized(files) {
					f=files.remove(id);
				}
				if (f!=null) {
					try {
						f.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				return null;
			}
		}
		return null;
	}

	@Override
	public int getWidgetType() {
		return RemoteTypes.FILE;
	}

	public String getPath() {
		return (String)CWinImpl.runNow(this,GET_PATH);
	}

}
