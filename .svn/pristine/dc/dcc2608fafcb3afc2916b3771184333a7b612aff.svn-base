package org.jclarion.clarion.ide.editor;

import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.FlavorMap;
import java.awt.datatransfer.SystemFlavorMap;

public class DefinitionDataFlavor extends DataFlavor 
{
	public static final DefinitionDataFlavor DEFINITION = new DefinitionDataFlavor();
	
	static {
		FlavorMap map = SystemFlavorMap.getDefaultFlavorMap();
		if (map instanceof SystemFlavorMap) {
			SystemFlavorMap systemMap = (SystemFlavorMap)map;
			systemMap.addFlavorForUnencodedNative("clarion/definition",DEFINITION);
		}
	}
	public static void init()
	{
	}
	
	private DefinitionDataFlavor()
	{
		super("clarion/definition","Definition");
	}
	
		
}
