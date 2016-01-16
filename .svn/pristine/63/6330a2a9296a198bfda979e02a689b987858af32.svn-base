package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;

public class SimpleMappedPropSerializer extends PropSerializer 
{
	private Object def;
	private int pid;

	public SimpleMappedPropSerializer(int id)
	{
		this.pid=id;		
	}
	public SimpleMappedPropSerializer(int id,Object def)
	{
		this.pid=id;
		this.def=def;
	}
	
	public void deserialize(PropertyObject target,String type,String... params)
	{
		if (pid==-1) {
			throw new RuntimeException("Cannot get PID for :"+type); 
		}
		if (params.length>0) {
			target.setProperty(pid,params[0]);
		} else if (def!=null) {
			target.setProperty(pid,def);
		}
	}
}
