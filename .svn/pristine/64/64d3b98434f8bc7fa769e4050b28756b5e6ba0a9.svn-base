package org.jclarion.clarion.appgen.app;

import java.util.HashMap;
import java.util.Map;

/**
 * Meta data associated with a model item.  Used by IDE layers to track things like whether or not model item is dirty
 * 
 * @author barney
 */
public class Meta 
{
	private Object object;
	private Map<String,Object> objectMap;
	private boolean dirty;

	public Object getObject()
	{
		return object;
	}
	
	public void setObject(Object object)
	{
		this.object=object;
	}
	
	public Object getObject(String key)
	{
		if (objectMap==null) return null;
		return objectMap.get(key);
	}
	
	public void setObject(String key,Object value)
	{
		if (objectMap==null) objectMap=new HashMap<String,Object>();
		objectMap.put(key,value);
	}
	
	public boolean isDirty()
	{
		return dirty;
	}
	
	public void setDirty(boolean dirty)
	{
		this.dirty=dirty;
	}
}
