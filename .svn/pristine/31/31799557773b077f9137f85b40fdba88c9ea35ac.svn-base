package org.jclarion.clarion.swing.gui;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.LinkedList;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.runtime.CWin;


/**
 * Represent a network node
 * 
 * Actual work is deferred to supplied underlying model
 * 
 * @author barney
 *
 */
public class NetworkModel extends GUIModel implements Runnable
{
	private GUIModel 	  local;
	private RemoteNetwork network;
	private InputStream  in;
	private OutputStream out;
	private Thread reader;
	private TaskProcessor processor;
	private String name;
	private boolean shutdown=false;
	private LinkedList<RemoteCommand> tasks = new LinkedList<RemoteCommand>();
	private boolean runShutdownActivities=true;

	public static final int VERSION=1;
	
	private class TaskProcessor extends Thread
	{
		public void run()
		{
			processTasks();
		}
	}
	
	public NetworkModel()
	{
	}
	
	@SuppressWarnings("unchecked")
	public <K extends RemoteWidget> K getWidget(K aWidget)
	{
		return (K)network.getWidget(aWidget.getID());
	}

	public NetworkModel(GUIModel local,RemoteNetwork network,InputStream in,OutputStream out)
	{
		init(local,network,in,out);
	}

	
	public void doNotRunShutdownActivities()
	{
		runShutdownActivities=false;
	}
	
	public void init(GUIModel local,RemoteNetwork network,InputStream in,OutputStream out)
	{
		this.local=local;
		this.network=network;
		this.out=out;
		this.in=in;
		//this.in=new InputStreamCounter(in);
		reader=new Thread(this);
		reader.start();
		processor = new TaskProcessor();
		processor.start();
		try {
			out.write(VERSION);
		} catch (IOException ex) { 
			handleException(ex);
		}		
		name = local.getClass().getName();
		name=name.substring(name.lastIndexOf('.')+1);
	}
	
	public Thread getReaderThread()
	{
		return reader;
	}

	public NetworkModel(RemoteNetwork network,OutputStream out)
	{
		this.network=network;
		this.out=out;
	}
	
	@Override
	public void send(RemoteWidget w, int command, Object... params) 
	{
		try {
			synchronized(out) {
				if (shutdown) throw new NetworkError();
				network.writeCommand(out,command,false,null,w,params);
			}
		} catch (IOException e) {
			handleException(e);
		}
	}
	

	@Override
	public void send(RemoteWidget w, ResponseRunnable nextTask, int command,Object... params) {
		try {
			synchronized(out) {
				if (shutdown) throw new NetworkError();
				network.writeCommand(out,command,true,nextTask,w,params);
			}
		} catch (IOException e) {
			handleException(e);
		}
	}

	@Override
	public void send(RemoteSemaphore rs, Object result) 
	{
		try {
			synchronized(out) {
				if (shutdown) throw new NetworkError();
				network.notifySemaphore(out,rs,result);
			}
		} catch (IOException e) {
			handleException(e);
		}
	}

	@Override
	public Object sendRecv(RemoteWidget w, int command, Object... params) 
	{
		try {
			RemoteResponse rr;
			synchronized(out) {
				if (shutdown) throw new NetworkError();
				rr=network.writeCommand(out,command,true,null,w,params);
			}
			Object o = rr.waitForResponse();
			return o; 
		} catch (IOException e) {
			handleException(e);
			return null;
		}
	}

	@Override
	public void run() {
		//System.out.println("START "+name);
		
		try {
			int version = in.read();
			if (version==-1) {
				shutdown();
				return;
			}
			if (version!=VERSION) {
				if (local instanceof LocalClient) {
					CWin.message(
						Clarion.newString("Incompatible client/server versions. Network GUI cannot run"),
						Clarion.newString("Network GUI"),
						Icon.HAND
					);
				}
				shutdown();
				return;
			}
		} catch (IOException ex) { 
			handleException(ex);
		}
		
		while ( true ) {
			try {
				final RemoteCommand c = network.readCommand(in,this,false);
				if (c==null) break;
				//System.out.println(c);
				//in.resetCounter();
				synchronized(tasks) {
					tasks.add(c);
					tasks.notifyAll();
				}
			} catch (IOException ex) {
				handleException(ex);
				break;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		shutdown();
	}

	public void processTasks()
	{
		main: while(true) {
			final RemoteCommand c;
			synchronized(tasks) {
				while (tasks.isEmpty()) {
					if (shutdown) break main;
					try {
						tasks.wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
				c=tasks.removeFirst();
			}
			try {
				if (c.source==null) {
					continue;
				}
				if (c.command==RemoteNetwork.COMMAND_RESPONSE) {
					network.processResponse(c);
					continue;
				}
				
				if (c.response!=0) {
					//if (c.response>32767) {
						// run and async followup.
						ResponseRunnable rr=new ResponseRunnable() {
							@Override
							public void run(Object result) {
								try {
									synchronized(out) {
										if (shutdown) return;
										network.writeResponse(out,c,result);
									}
								} catch (IOException e) {
									handleException(e);
								}
							}
						};
						local.send(c.source,rr,c.command,c.params);
					/*} else {
						// want a fast reply
						Object o = local.sendRecv(c.source,c.command,c.params);
						synchronized(out) {
							if (!shutdown) {
								network.writeResponse(out,c,o);
							}
						}
					}*/
				} else {
					local.send(c.source,c.command,c.params);
				}
			/*} catch (IOException ex) {
				ex.printStackTrace();
				shutdown();
				return;*/
			} catch (RuntimeException ex) {
				System.out.println(ex);
			}
		}
	
		if (!runShutdownActivities) return; 
	
		if (GUIModel.getClient() instanceof LocalClient ) {
			if (network.testMemoryUsage("local")) {
				CWin.message(Clarion.newString("Connection Lost"),
						Clarion.newString("Local Connection"),
						Icon.CONNECT
				);
				System.exit(0);
			}
		}
		
		if (GUIModel.getServer() instanceof LocalServer ) {
			CWin.getInstance().shutdown();
		}
	}
	
	public void shutdown()
	{
		synchronized(out) {
			if (shutdown) return;
			shutdown=true;
			out.notifyAll();
		}	
		try {
			out.close();
		} catch (IOException ex) { }
		try {
			in.close();
		} catch (IOException ex) { }
		synchronized(tasks) {
			tasks.notifyAll();			
		}
		network.shutdown();
	}
	
	private void handleException(IOException ex)
	{
		shutdown();
		throw new NetworkError();
	}
	
	public String toString()
	{
		return "NetworkModel:"+name;
	}

	public ClarionRandomAccessFile getFile(File f) throws FileNotFoundException 
	{
		return new NetworkedFile(f.getAbsolutePath(),network.getNextID());
	}

	@Override
	public void dispose(RemoteSemaphore rs) {
		network.dispose(rs);
	}

	@Override
	public void dispose(RemoteWidget w) {
		network.dispose(w);
	}

	public boolean testMemoryUsage()
	{
		return network.testMemoryUsage(this.name);
	}

	public void cleanup() {
		network.cleanup();
	}
	
}
