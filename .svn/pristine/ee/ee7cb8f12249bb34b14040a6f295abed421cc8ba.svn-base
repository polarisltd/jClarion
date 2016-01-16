package org.jclarion.clarion.runtime;

import java.util.HashMap;
import java.util.Map;

public class JavaSysConfigImpl extends CConfigImpl
{
	private FileConfigImpl base;
	
	public JavaSysConfigImpl(String name) {
		base=new FileConfigImpl(name);
		Map<String,String> cache = base.getCache();
		if (cache!=null) {
			for (Map.Entry<String,String> e : cache.entrySet()) {
				System.setProperty(e.getKey(),e.getValue());
			}
		}
	}

	@Override
	public synchronized String getProperty(String section, String key) {
		return System.getProperty(section+"."+key);
	}

	@Override
	public Map<String, String> getProperties() {
		
		HashMap<String,String> result=new HashMap<String,String>();
		for ( Map.Entry<Object,Object> scan : System.getProperties().entrySet()) {
			Object key = scan.getKey();
			Object value = scan.getValue();
			if (key==null || value==null) continue;
			result.put(key.toString(),value.toString());
		}
		return result;
	}

	@Override
	public synchronized void setProperty(String section, String key,String value) {
		base.setProperty(section, key, value);
		System.setProperty(section+"."+key,value);
	}

    @Override
	public void finish() {
		base.finish();
    }
}
