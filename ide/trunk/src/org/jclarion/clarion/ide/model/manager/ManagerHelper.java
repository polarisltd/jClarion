package org.jclarion.clarion.ide.model.manager;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class ManagerHelper {

	private final Map<String, Integer> nameValues;
	private final Map<Integer,String> valueNames;

	public ManagerHelper() {
		nameValues = new HashMap<String, Integer>();
		valueNames = new HashMap<Integer,String>();
	}

	public Collection<String> getNames() {
		return nameValues.keySet();
	}

	public Collection<Integer> getValues() {
		return nameValues.values();
	}

	public Integer getValue(String name) {
		if (name==null) return null;				
		return nameValues.get(name.toUpperCase());		
	}

	public String getName(Integer value) {
		return valueNames.get(value);
	}

	void put(String name, int value) {
		nameValues.put(name.toUpperCase(), value);
		valueNames.put(value,name);
	}

}
