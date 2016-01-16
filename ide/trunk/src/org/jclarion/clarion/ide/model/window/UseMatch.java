package org.jclarion.clarion.ide.model.window;

import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;

public class UseMatch extends StringMatchTest
{
	@Override
	public boolean test(AbstractControl test, String value) 
	{
		ExtendProperties ep = (ExtendProperties)test.getExtend();
		if (ep==null) return false;
		if (ep.getUsevar()==null) return false;
		
		String usevar = ep.getUsevar();
		
		return prep(value).equalsIgnoreCase(prep(usevar));
	}

	private String prep(String value) {
		
		int start=value.lastIndexOf(',')+1;
		if (start<value.length() && value.charAt(start)=='?') start++;
		return value.substring(start);
	}

}
