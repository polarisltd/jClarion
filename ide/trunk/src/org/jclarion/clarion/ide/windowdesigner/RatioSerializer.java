package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class RatioSerializer extends PropSerializer 
{
	
	
	@Override
	public void deserialize(PropertyObject target, String type, Lex... params) {
		
		if (params.length==1 && params[0]!=null && params[0].type==LexType.string) {
			target.setProperty(Prop.RATIO,params[0].value);
			return;
		}
		
		for (int scan=0;scan<params.length && scan<4;scan++) {
			if (params[scan]==null) continue;
			if (params[scan].value==null) continue;
			target.setProperty(Prop.RATIO_X+scan,params[scan].value);
		}
	}

	public void deserialize(PropertyObject target,String type,String... params)
	{
		throw new IllegalStateException("Not Used");
	}
}
