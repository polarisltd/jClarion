package org.jclarion.clarion.ide.model.manager;

import org.jclarion.clarion.constants.Prop;

class OrientationPropIdHelper extends ManagerHelper {

	public static final String LEFT = "LEFT";
	public static final String RIGHT = "RIGHT";
	public static final String CENTER = "CENTER";
	public static final String DECIMAL = "DECIMAL";
	public static final String DEFAULT = LEFT;

	private static final ManagerHelper INSTANCE = new OrientationPropIdHelper();

	public final static ManagerHelper getInstance() {
		return INSTANCE;
	}

	private OrientationPropIdHelper() {
		super();
		put(LEFT, Prop.LEFT);
		put(RIGHT, Prop.RIGHT);
		put(CENTER, Prop.CENTER);
		put(DECIMAL, Prop.DECIMAL);
	}

}
