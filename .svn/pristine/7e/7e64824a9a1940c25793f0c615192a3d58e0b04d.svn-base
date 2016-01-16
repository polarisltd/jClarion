package org.jclarion.clarion.ide.view.properties;

/**
 * Minimises the effort required to implement a dual integer property section
 */
abstract class AbstractDualIntegerPropertySection extends AbstractDualTextPropertySection {

	private int prop1;
	private int prop2;

	public AbstractDualIntegerPropertySection(int prop1,int prop2)
	{
		this.prop1=prop1;
		this.prop2=prop2;
	}

	@Override
	Object getValue1() {
		return getPropertyManager().getInteger(prop1);
	}

	@Override
	void setValue1AsString(Object priorValue, String value, boolean commit) {
		Integer ivalue = propInt(value);
		if (!commit) {
			getObject().setClonedProperty(prop1,ivalue);
		} else {
			getPropertyManager().setProp(prop1, priorValue,ivalue);
		}	
	}

	private Integer propInt(String value) {
		Integer ivalue = null;
		if (value!=null && value.trim().length()>0) {
			try {
				ivalue=Integer.parseInt(value);
			} catch (NumberFormatException ex) { }
		}
		return ivalue;
	}

	@Override
	Object getValue2() {
		return getPropertyManager().getInteger(prop2);	
	}

	@Override
	void setValue2AsString(Object priorValue, String value, boolean commit) {
		Integer ivalue = propInt(value);
		if (!commit) {
			getObject().setClonedProperty(prop2,ivalue);
		} else {
			getPropertyManager().setProp(prop2, priorValue,ivalue);
		}	
	}
}