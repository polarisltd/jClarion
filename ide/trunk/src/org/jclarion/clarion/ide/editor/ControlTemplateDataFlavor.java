package org.jclarion.clarion.ide.editor;

import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.FlavorMap;
import java.awt.datatransfer.SystemFlavorMap;

public class ControlTemplateDataFlavor extends DataFlavor 
{
	public static final ControlTemplateDataFlavor TEMPLATE = new ControlTemplateDataFlavor();
	
	static {
		FlavorMap map = SystemFlavorMap.getDefaultFlavorMap();
		if (map instanceof SystemFlavorMap) {
			SystemFlavorMap systemMap = (SystemFlavorMap)map;
			systemMap.addFlavorForUnencodedNative("clarion/controltemplate",TEMPLATE);
		}
	}
	public static void init()
	{
	}
	
	private ControlTemplateDataFlavor()
	{
		super("clarion/controltemplate","Control Template");
	}
	
		
}
