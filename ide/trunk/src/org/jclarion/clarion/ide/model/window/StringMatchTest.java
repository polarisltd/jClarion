package org.jclarion.clarion.ide.model.window;

import org.jclarion.clarion.control.AbstractControl;

public abstract class StringMatchTest extends MatchTest
{
	private String value;
	
	public StringMatchTest()
	{
	}
	
	public void setValue(String value)
	{
		this.value=value;
	}
	
	@Override
	public final boolean test(AbstractControl test) {
		return test(test,value);
	}

	public abstract boolean test(AbstractControl test, String value);
	
	
}
