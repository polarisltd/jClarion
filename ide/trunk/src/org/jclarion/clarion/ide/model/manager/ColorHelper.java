package org.jclarion.clarion.ide.model.manager;

import org.jclarion.clarion.constants.Color;

public class ColorHelper extends ManagerHelper {

	private static final ManagerHelper INSTANCE = new ColorHelper();

	public final static ManagerHelper getInstance() {
		return INSTANCE;
	}

	private ColorHelper() {
		super();
		put("COLOR:NONE", Color.NONE);
		put("COLOR:SCROLLBAR", Color.SCROLLBAR);
		put("COLOR:BACKGROUND", Color.BACKGROUND);
		put("COLOR:ACTIVECAPTION", Color.ACTIVECAPTION);
		put("COLOR:INACTIVECAPTION", Color.INACTIVECAPTION);
		put("COLOR:MENU", Color.MENU);
		put("COLOR:WINDOW", Color.WINDOW);
		put("COLOR:WINDOWFRAME", Color.WINDOWFRAME);
		put("COLOR:MENUTEXT", Color.MENUTEXT);
		put("COLOR:WINDOWTEXT", Color.WINDOWTEXT);
		put("COLOR:CAPTIONTEXT", Color.CAPTIONTEXT);
		put("COLOR:ACTIVEBORDER", Color.ACTIVEBORDER);
		put("COLOR:INACTIVEBORDER", Color.INACTIVEBORDER);
		put("COLOR:APPWORKSPACE", Color.APPWORKSPACE);
		put("COLOR:HIGHLIGHT", Color.HIGHLIGHT);
		put("COLOR:HIGHLIGHTTEXT", Color.HIGHLIGHTTEXT);
		put("COLOR:BTNFACE", Color.BTNFACE);
		put("COLOR:BTNSHADOW", Color.BTNSHADOW);
		put("COLOR:GRAYTEXT", Color.GRAYTEXT);
		put("COLOR:BTNTEXT", Color.BTNTEXT);
		put("COLOR:INACTIVECAPTIONTEXT", Color.INACTIVECAPTIONTEXT);
		put("COLOR:BTNHIGHLIGHT", Color.BTNHIGHLIGHT);
		put("COLOR:BLACK", Color.BLACK);
		put("COLOR:MAROON", Color.MAROON);
		put("COLOR:GREEN", Color.GREEN);
		put("COLOR:OLIVE", Color.OLIVE);
		put("COLOR:NAVY", Color.NAVY);
		put("COLOR:PURPLE", Color.PURPLE);
		put("COLOR:TEAL", Color.TEAL);
		put("COLOR:GRAY", Color.GRAY);
		put("COLOR:SILVER", Color.SILVER);
		put("COLOR:RED", Color.RED);
		put("COLOR:LIME", Color.LIME);
		put("COLOR:YELLOW", Color.YELLOW);
		put("COLOR:BLUE", Color.BLUE);
		put("COLOR:FUSCHIA", Color.FUSCHIA);
		put("COLOR:AQUA", Color.AQUA);
		put("COLOR:WHITE", Color.WHITE);
	}

}
