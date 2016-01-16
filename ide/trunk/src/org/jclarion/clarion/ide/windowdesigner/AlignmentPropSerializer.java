package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;

public class AlignmentPropSerializer extends PropSerializer 
{
	private int flag;
	private int align;

	public AlignmentPropSerializer()
	{
		
	}
	public AlignmentPropSerializer(int flag,int align)
	{
		this.flag=flag;
		this.align=align;
	}
	
	public void deserialize(PropertyObject target,String type,String... params)
	{
		target.setProperty(flag,true);
		if (params.length>0) {
			target.setProperty(align,params[0]);
		}
	}
}
