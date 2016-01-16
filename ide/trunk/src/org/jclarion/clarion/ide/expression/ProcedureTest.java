package org.jclarion.clarion.ide.expression;

import org.eclipse.core.expressions.PropertyTester;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class ProcedureTest extends PropertyTester
{
	@Override
	public boolean test(Object receiver, String property, Object[] args,Object expectedValue) {
		if (!(receiver instanceof ProcedureModel)) return false;
		ProcedureModel recv = (ProcedureModel)receiver;
		if (property.equals("procedureExists")) {
			return expectedValue.equals (recv.getProcedure()!=null);
		}
		return false;
	}

}
