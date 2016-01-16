package org.jclarion.clarion.appgen.template;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public class FileLoaderSource implements TemplateLoaderSource
{
	private File path;
	private Map<String,File> filenames;
		
	public FileLoaderSource(String path)
	{
		this.path=new File(path);
		filenames=new HashMap<String,File>();
		for (File f : this.path.listFiles()) {
			if (!f.isFile()) continue;
			filenames.put(f.getName().toLowerCase(),f);
		}
	}

	@Override
	public InputStream get(String name) throws IOException
	{
		return new FileInputStream(filenames.get(name.toLowerCase()));
	}
}
