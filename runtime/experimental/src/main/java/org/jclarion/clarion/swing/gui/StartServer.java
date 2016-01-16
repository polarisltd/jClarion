package org.jclarion.clarion.swing.gui;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class StartServer {

	public static void start(String host,int port)
	{
		try {
			Socket s = new Socket(host,port);
			start(s);
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
	
	public static void start()
	{
		int port = 5000;
		String sport = System.getProperty("port");
		if (sport!=null) {
			port=Integer.parseInt(sport);
		}
		
		try {
			ServerSocket ss = new ServerSocket(port);
			System.out.println("WATING ON "+port);
			Socket t = ss.accept();
			System.out.println("CONNECTED");
			start(t);
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
	
	private static NetworkModel nm;
	
	public static void start(Socket t) throws IOException
	{
		t.setTcpNoDelay(true);
		nm = new NetworkModel();
		nm.init(GUIModel.getServer(), new RemoteNetwork(), t.getInputStream(),t.getOutputStream());
		GUIModel.setClient(nm);
	}
	
	public static void finish()
	{
		if (nm!=null) {
			nm.shutdown();
		}
	}
}
