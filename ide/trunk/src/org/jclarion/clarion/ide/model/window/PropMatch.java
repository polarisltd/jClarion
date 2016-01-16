package org.jclarion.clarion.ide.model.window;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.control.AbstractControl;

public class PropMatch extends StringMatchTest
{
	
	private int property;

	public PropMatch(int property)
	{
		this.property=property;
	}

	@Override
	public boolean test(AbstractControl test, String value) {
		ClarionObject co = test.getRawProperty(property,false);
		return co!=null && co.toString().equalsIgnoreCase(value);
	}

}
