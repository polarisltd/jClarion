package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;

public class PreSerializer extends PropSerializer 
{
	public void deserialize(PropertyObject target,String type,String... params)
	{
		((ExtendProperties)target.getExtend()).setPre(params[0]);
	}
}
