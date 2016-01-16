package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;

public class MultiPropSerializer extends PropSerializer 
{
	public void deserialize(PropertyObject target,String type,String... params)
	{
		int pid=Prop.getPropID(type);
		if (pid==-1) {
			throw new RuntimeException("Cannot get PID for :"+type); 
		}
		for (int scan=0;scan<params.length;scan++) {
			if (params[scan].equals("")) continue; 
			target.setProperty(pid,scan+1,params[scan]);
		}		
	}
}
