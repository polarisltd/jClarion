package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;

public class FlagPropSerializer extends PropSerializer 
{
	public void deserialize(PropertyObject target,String type,String... params)
	{
		int pid=Prop.getPropID(type);
		if (pid==-1) {
			throw new RuntimeException("Cannot get PID for :"+type); 
		}
		target.setProperty(pid,true);
	}
}
