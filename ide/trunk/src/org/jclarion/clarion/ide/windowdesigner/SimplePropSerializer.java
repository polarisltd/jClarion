package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;

public class SimplePropSerializer extends PropSerializer 
{
	private Object def;

	public SimplePropSerializer()
	{
		
	}
	public SimplePropSerializer(Object def)
	{
		this.def=def;
	}
	
	public void deserialize(PropertyObject target,String type,String... params)
	{
		int pid=Prop.getPropID(type);
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
