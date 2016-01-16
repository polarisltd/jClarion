package org.jclarion.clarion.swing.gui;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.file.ClarionRandomAccessFileSystemFile;
import org.jclarion.clarion.runtime.CWinImpl;

public class FileServer extends AbstractWidget 
{
	private static FileServer instance=new FileServer();
	
	public static FileServer getInstance()
	{
		return instance;
	}
	
	protected FileServer()
	{
	}
	
	private static final int OPEN=1;
	private static final int LENGTH=2;
	private static final int READ=3;
	private static final int WRITE=4;
	private static final int CLOSE=5;
	private static final int CREATE=6;
	private static final int DELETE=7;
	private static final int LIST=8;

	public void open(int id,String name) throws FileNotFoundException
	{
		boolean b = (Boolean)CWinImpl.runNow(this,OPEN,id,name);
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
		CWinImpl.run(this,CLOSE,id);
	}
	
	public Object[] list(String name)
	{
		return (Object[])CWinImpl.runNow(this,LIST,name);
	}

	public boolean create(String name)
	{
		return (Boolean)CWinImpl.runNow(this,CREATE,name);
	}

	public boolean delete(String name)
	{
		return (Boolean)CWinImpl.runNow(this,DELETE,name);
	}
	
	private Map<Integer,ClarionRandomAccessFile> files = new HashMap<Integer,ClarionRandomAccessFile>();
	
	@Override
	public Object command(int command, Object... params) 
	{
		switch(command) {
			case LIST: {
				File f = new File((String)params[0]);
		        File kids[] = f.listFiles();
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
				String name = (String)params[0];
				File f = new File(name);
		        try {
		            f.delete();
		            return f.createNewFile();
		        } catch (IOException e) {
		            return false;
		        }
			}
			case DELETE: {
				String name = (String)params[0];
				File f = new File(name);
	            return f.delete();
			}
			case OPEN: {
				int id = (Integer)params[0];
				String name = (String)params[1];
				try {
					ClarionRandomAccessFileSystemFile f = new ClarionRandomAccessFileSystemFile(new File(name));
					synchronized(files) {
						files.put(id,f);
					}
					return true;
				} catch (IOException ex) { 
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
}
