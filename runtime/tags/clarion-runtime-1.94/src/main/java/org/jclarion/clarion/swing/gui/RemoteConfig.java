package org.jclarion.clarion.swing.gui;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.runtime.CConfigImpl;
import org.jclarion.clarion.runtime.CConfigStore;

public class RemoteConfig extends CConfigImpl 
{
	private CConfigImpl 			serverConfig;
	private Map<String,String>		clientConfig;
	private String file;
	
	public RemoteConfig(String file)
	{
		this.file=file;
		serverConfig=CConfigStore.getInstance(file);
	}
	
	private synchronized void init()
	{
		if (clientConfig==null) {
			clientConfig=FileServer.getInstance().getAllRemoteConfig("remote-"+file);
		}
		if (clientConfig==null) {
			clientConfig=new HashMap<String, String>();
		}
	}
	
	@Override
	public Map<String, String> getProperties() 
	{
		init();
		return clientConfig;
	}

	@Override
	public String getProperty(String section, String key) {
		init();
		String lookup=null;
		if (key==null) {
			lookup=section;
		} else if (section!=null) {
			lookup=section+"."+key;
		} else {
			lookup=key;
		}
		if (lookup==null) return null;
		lookup=lookup.toLowerCase();
		synchronized(clientConfig) {
			String result=clientConfig.get(lookup);
			if (result!=null) return result;
		}
		return serverConfig.getProperty(section,key);
	}

	@Override
	public void setProperty(String section, String key, String value) 
	{
		init();
		String lookup=null;
		if (key==null) {
			lookup=section;
		} else if (section!=null) {
			lookup=section+"."+key;
		} else {
			lookup=key;
		}
		if (lookup==null) return;
		lookup=lookup.toLowerCase();
		synchronized(clientConfig) {
			String result=clientConfig.get(lookup);
			if (result!=null && result.equals(value)) {
				// nothing to save
				return;
			}
			clientConfig.put(lookup,value);
		}
		FileServer.getInstance().setRemoteConfig(section,key,value,"remote-"+file);
	}	
}
