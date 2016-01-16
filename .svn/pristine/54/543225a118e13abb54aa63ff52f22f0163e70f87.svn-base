package org.jclarion.clarion.ide.windowdesigner;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class ValuePropSerializer extends PropSerializer {

	@Override
	public void deserialize(PropertyObject target, String type,String... params) {
		throw new IllegalStateException("Not allowed");
	}

	@Override
	public void deserialize(PropertyObject target, String type,Lex... params) {
		if (params.length==1) {
			set(target,Prop.VALUE,params[0]);
		}
		if (params.length==2) {
			set(target,Prop.TRUEVALUE,params[0]);
			set(target,Prop.FALSEVALUE,params[1]);
		}
	}

	private void set(PropertyObject target, int prop, Lex lex) 
	{
		if (lex.type==LexType.label) {
			target.setProperty(prop,"!"+lex.value);
		} else {
			target.setProperty(prop,lex.value);
		}
	}
	
}
