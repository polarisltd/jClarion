package org.jclarion.clarion.swing.gui;

import java.util.HashMap;
import java.util.Map;

public class CommandList 
{
	public static CommandList create()
	{
		return new CommandList();
	}
	
	private Map<Integer,String> mapToName=new HashMap<Integer,String>();
	private Map<String,Integer> nameToMap=new HashMap<String,Integer>();

	public CommandList add(String name,int id)
	{
		return add(id,name);
	}
	
	public CommandList add(int id,String name)
	{
		mapToName.put(id,name);
		nameToMap.put(name,id);
		return this;
	}
	
	public String getName(int id)
	{
		return mapToName.get(id);
	}
	
	public int getID(String name)
	{
		return nameToMap.get(name);
	}
}
