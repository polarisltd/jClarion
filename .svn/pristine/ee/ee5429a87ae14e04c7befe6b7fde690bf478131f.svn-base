package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class SpecialPropSerializer extends PropSerializer 
{
	private Object def;

	public SpecialPropSerializer()
	{
		
	}
	public SpecialPropSerializer(Object def)
	{
		this.def=def;
	}
	
	@Override
	public void deserialize(PropertyObject target, String type,Lex... params) {
		int pid=Prop.getPropID(type);
		if (pid==-1) {
			throw new RuntimeException("Cannot get PID for :"+type); 
		}
		if (params.length==1) {
			if (params[0].type==LexType.label) {
				target.setProperty(pid,"!"+params[0].value);
			} else {
				target.setProperty(pid,params[0].value);
			}
		} else if (def!=null) {
			target.setProperty(pid,def);
		}
	}
	
	public void deserialize(PropertyObject target,String type,String... params)
	{
		throw new IllegalStateException("Not here");
	}
}
