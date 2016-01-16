package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Propprint;

public class PaperSerializer extends PropSerializer 
{
	public void deserialize(PropertyObject target,String type,String... params)
	{
		target.setProperty(Propprint.PAPER,params[0]);
		if (params.length>1) {
			target.setProperty(Propprint.PAPERWIDTH,params[1]);
		} 
		if (params.length>2) {
			target.setProperty(Propprint.PAPERHEIGHT,params[2]);
		} 
	}
}
