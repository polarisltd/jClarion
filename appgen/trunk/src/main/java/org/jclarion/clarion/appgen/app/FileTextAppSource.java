package org.jclarion.clarion.appgen.app;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileTextAppSource implements TextAppSource
{	
	private File path;

	public FileTextAppSource(String path)
	{
		this.path=new File(path);
	}

	@Override
	public Object get(String name) {
		return new File(path,name);
	}

	@Override
	public String[] getAll(String extension) 
	{
		if (extension!=null) {
			extension="."+extension.toLowerCase();
		}
		List<String> result = new ArrayList<String>();
		for (File kid : path.listFiles()) {
			if (!kid.isFile()) continue;
			if (extension==null || kid.getName().toLowerCase().endsWith(extension)) {
				result.add(kid.getName());
			}
		}
		return result.toArray(new String[result.size()]);
	}

	@Override
	public InputStream open(Object source) throws IOException {
		return new FileInputStream((File)source);
	}
}
