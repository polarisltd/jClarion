package org.jclarion.clarion.ide.expression;

import org.eclipse.core.expressions.PropertyTester;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.CoreException;

public class ProjectTest extends PropertyTester
{
	@Override
	public boolean test(Object receiver, String property, Object[] args,Object expectedValue) {
		if (!(receiver instanceof IProject)) return false;
		IProject recv = (IProject)receiver;
		if (property.equals("isClarionProject")) {
			try {
				return expectedValue.equals (recv.isNatureEnabled("jclarion.Clarion"));
			} catch (CoreException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

}
