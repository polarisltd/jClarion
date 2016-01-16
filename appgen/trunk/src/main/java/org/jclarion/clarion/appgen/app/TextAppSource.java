package org.jclarion.clarion.appgen.app;

import java.io.IOException;
import java.io.InputStream;

public interface TextAppSource {
	public Object get(String name);
	public String[] getAll(String extension);
	public InputStream open(Object source) throws IOException;	
}
