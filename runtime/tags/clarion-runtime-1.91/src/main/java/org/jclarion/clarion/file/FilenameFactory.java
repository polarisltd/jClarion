package org.jclarion.clarion.file;

import java.io.File;

import org.jclarion.clarion.swing.gui.FileServer;

public class FilenameFactory {

	private static FilenameFactory instance=new FilenameFactory();
	
	public static FilenameFactory getInstance()
	{
		return instance;
	}
	
	public static void setInstance(FilenameFactory factory)
	{
		instance=factory;
	}
	
	public File getFile(String name)
	{
		return new File(FileServer.clientPrep(name));
	}
}
