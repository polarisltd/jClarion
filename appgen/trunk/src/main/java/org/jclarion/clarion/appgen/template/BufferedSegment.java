package org.jclarion.clarion.appgen.template;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.util.SharedWriter;

public class BufferedSegment {
	private SharedWriter writer=new SharedWriter();
	private Map<String,Object> metaData=new HashMap<String,Object>();
	
	public SharedWriter getWriter()
	{
		return writer;
	}
	
	public Object getMetaData(String key)
	{
		return metaData.get(key);
	}
	
	public void setMetaData(String key,Object value)
	{
		metaData.put(key,value);
	}
	
	public Map<String,Object> getMetaData()
	{
		return metaData;
	}
	
	public boolean isEmpty()
	{
		return metaData.isEmpty() && writer.getSize()==0;
	}
}
