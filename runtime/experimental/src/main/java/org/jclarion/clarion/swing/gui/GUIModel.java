package org.jclarion.clarion.swing.gui;

import java.io.File;
import java.io.FileNotFoundException;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.file.ClarionRandomAccessFileSystemFile;


public abstract class GUIModel 
{
	private static GUIModel client=new LocalClient();
	private static GUIModel server=new LocalServer();
	private static GUIFactory factory=null;
	
	public static GUIModel getClient()
	{
		return factory!=null ? factory.getClient() : client;
	}

	public static GUIModel getServer()
	{
		return factory!=null ? factory.getServer() : server;
	}
	
	public static void setClient(GUIModel client)
	{
		GUIModel.client=client;
	}

	public static void setServer(GUIModel server)
	{
		GUIModel.server=server;
	}
	
	public static void setFactory(GUIFactory factory) {
		GUIModel.factory=factory;
	}

	public abstract void send(RemoteWidget w,int command,Object... params);
	
	public abstract void send(RemoteWidget w,ResponseRunnable nextTask,int command,Object... params);

	public abstract Object sendRecv(RemoteWidget w,int command,Object... params);
	
	public abstract void send(RemoteSemaphore rs,Object result);

	public ClarionRandomAccessFile getFile(File f) throws FileNotFoundException 
	{
		return new ClarionRandomAccessFileSystemFile(f);
	}
	
	public void dispose(RemoteWidget w)
	{
	}
	
	public void dispose(RemoteSemaphore rs)
	{
	}
}
