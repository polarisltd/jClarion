package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;

public class UsePropSerializer extends PropSerializer 
{
	public void deserialize(PropertyObject target,String type,String... params)
	{
		((ExtendProperties)target.getExtend()).setUsevar(params);
		target.setId(params[0]);
	}
}
