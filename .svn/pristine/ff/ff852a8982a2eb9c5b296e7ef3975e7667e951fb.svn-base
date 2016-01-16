package org.jclarion.clarion.file;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

public class ResourceClarionFile extends RingBufferedInputStreamClarionFile
{
	private String name;
	public ResourceClarionFile(String name)
	{
		this.name=name;
	}
	
	
	@Override
	protected InputStream createStream() throws IOException {
		InputStream is = getClass().getResourceAsStream(name);
		if (is==null) {
			is=ClassLoader.getSystemClassLoader().getResourceAsStream(name);
		}
		if (is==null) throw new FileNotFoundException(name);
		return is;
	}

	@Override
	public String getName() {
		return null;
	}

}
