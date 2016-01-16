package org.jclarion.clarion.runtime;

import java.util.Map;

public class JavaSysConfigImpl extends CConfigImpl
{
	public JavaSysConfigImpl(String name) {
		super(name);
		Map<String,String> cache = getCache();
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
	public synchronized void setProperty(String section, String key,String value) {
		super.setProperty(section, key, value);
		System.setProperty(section+"."+key,value);
	}
}
