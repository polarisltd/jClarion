package org.jclarion.clarion.ide.model.manager;

import org.jclarion.clarion.constants.Prop;

class OrientationOffsetPropIdHelper extends ManagerHelper {

	private static final ManagerHelper INSTANCE = new OrientationOffsetPropIdHelper();

	public final static ManagerHelper getInstance() {
		return INSTANCE;
	}

	private OrientationOffsetPropIdHelper() {
		super();
		put("LEFT", Prop.LEFTOFFSET);
		put("RIGHT", Prop.RIGHTOFFSET);
		put("CENTER", Prop.CENTEROFFSET);
		put("DECIMAL", Prop.DECIMALOFFSET);
	}

}
