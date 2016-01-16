package org.jclarion.clarion.swing.gui;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class StartClient {

	public static void main(String args[])
	{
		String host="localhost";
		if (args.length>0) host=args[0];
		int port = 5000;
		if (args.length>1) {
			String sport = args[1];
			if (sport!=null) {
				port=Integer.parseInt(sport);
			}
		}
		
		try {
			Socket t;
			if ("server".equals(System.getProperty("socketType"))) {
				ServerSocket ss = new ServerSocket(port);
				t=ss.accept();
			} else {
				t = new Socket(host,port);
			}
			t.setTcpNoDelay(true);
			NetworkModel nm = new NetworkModel();
			nm.init(GUIModel.getClient(),new RemoteNetwork(Integer.MAX_VALUE/2),t.getInputStream(),t.getOutputStream());
			GUIModel.setServer(nm);
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
}
