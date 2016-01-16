package org.jclarion.clarion.ide.model.manager;

import org.jclarion.clarion.constants.Prop;

class UnitsPropIdHelper extends ManagerHelper {

	public static final String THOUS = "1/1000 Inch";
	public static final String MM = "Millimetres";
	public static final String POINTS = "Points";

	private static final ManagerHelper INSTANCE = new UnitsPropIdHelper();

	public final static ManagerHelper getInstance() {
		return INSTANCE;
	}

	private UnitsPropIdHelper() {
		super();
		put(THOUS, Prop.THOUS);
		put(MM, Prop.MM);
		put(POINTS, Prop.POINTS);
	}

}
