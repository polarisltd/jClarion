package org.jclarion.clarion.swing;

import java.io.EOFException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.swing.SwingUtilities;

import org.jclarion.clarion.swing.gui.GUIFactory;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.LocalClient;
import org.jclarion.clarion.swing.gui.LocalServer;
import org.jclarion.clarion.swing.gui.NetworkModel;
import org.jclarion.clarion.swing.gui.RemoteNetwork;

public class TestGUIFactory implements GUIFactory
{
	
	private class MyConnectedPipe
	{
		private byte[] buffer=new byte[8192];
		private int head;
		private int tail;
		private boolean close=false;
		private InputStream is;
		private OutputStream os;
		private int count=0;
		
		public MyConnectedPipe()
		{
			os=new OutputStream() {
				@Override
				public void write(int b) throws IOException {
					synchronized(buffer) {
						while (true ) {
							if (close) throw new EOFException();
							if (head+1==tail || (head==buffer.length-1 && tail==0)) {
								try {
									buffer.wait();
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
								continue;
							}
							buffer[head++]=(byte)b;
							count++;
							if (head==buffer.length) head=0;
							buffer.notifyAll();
							return;
						}
					}
					// TODO Auto-generated method stub
				}
				public void close() throws IOException {
					closeAll();
				};
			};
			is=new InputStream() {
				@Override
				public int read() throws IOException {
					synchronized(buffer) {
						while (true ) {
							if (close) return -1;
							if (head==tail) {
								try {
									buffer.wait();
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
								continue;
							}
							int r = buffer[tail++]&0xff;
							if (tail==buffer.length) tail=0;
							buffer.notifyAll();
							return r;
						}
					}
				}
				
				public void close() throws IOException {
					closeAll();
				};
			};

		}
		
		public void closeAll()
		{
			synchronized(buffer) {
				close=true;
				buffer.notifyAll();
			}			
		}
		
		public void waitUntilIdle()
		{
			synchronized(buffer) {
				if (close) return;
				if (head==tail) return;
				try {
					buffer.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}

		public OutputStream getOutputStream()
		{
			return os; 
		}
		
		public InputStream getInputStream()
		{
			return is; 		
		}
	}
	
	private NetworkModel client;
	private NetworkModel server;

	private MyConnectedPipe p1;
	private MyConnectedPipe p2;
	
	private GUIModel localClient=new LocalClient();
	private GUIModel localServer=new LocalServer();

	public TestGUIFactory()
	{
		p1=new MyConnectedPipe();
		p2=new MyConnectedPipe();
		
		client=new NetworkModel();
		server=new NetworkModel();
		client.doNotRunShutdownActivities();
		server.doNotRunShutdownActivities();
		
		client.init(localClient,new RemoteNetwork(),p1.getInputStream(),p2.getOutputStream());
		server.init(localServer,new RemoteNetwork(Integer.MAX_VALUE/2),p2.getInputStream(),p1.getOutputStream());
	}

	public void waitIdle()
	{
		p1.waitUntilIdle();
		p2.waitUntilIdle();
	}

	public boolean testMemoryUsage()
	{
		if (client.testMemoryUsage()) return true;
		if (server.testMemoryUsage()) return true;
		return false;		
	}
	
	public boolean shutdown()
	{
		client.shutdown();
		server.shutdown();
		p1.closeAll();
		p2.closeAll();
		System.out.println("gui:"+p1.count+" svr:"+p2.count); 
		try {
			client.getReaderThread().join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		try {
			server.getReaderThread().join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		client.cleanup();
		server.cleanup();
		
		boolean err=false;
		if (client.testMemoryUsage()) err=true;
		if (server.testMemoryUsage()) err=true;
		return err;
	}

	public NetworkModel getNetworkClient()
	{
		return client;
	}

	public NetworkModel getNetworkServer()
	{
		return server;
	}
	
	private boolean isClientThread()
	{
		if (SwingUtilities.isEventDispatchThread()) return true;
		if (Thread.currentThread()==client.getReaderThread()) return true;
		return false;
	}

	@Override
	public GUIModel getClient() {
		GUIModel result = isClientThread() ? localClient : server;
		//System.out.println(Thread.currentThread().getName()+" -> getClient() = "+result);
		return result;
	}

	@Override
	public GUIModel getServer() {
		GUIModel result = isClientThread() ? client : localServer;
		//System.out.println(Thread.currentThread().getName()+" -> getServer() = "+result);
		return result;
	}	
}
