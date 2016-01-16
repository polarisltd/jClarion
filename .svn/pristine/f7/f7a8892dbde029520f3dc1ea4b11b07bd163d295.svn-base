package org.jclarion.clarion.appgen.template.prompt;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.BufferedWriteTargetReader;
import org.jclarion.clarion.appgen.template.ExecutionEnvironmentFileSystem;
import org.jclarion.clarion.appgen.template.WriteTarget;

public class MemoryFileSystem implements ExecutionEnvironmentFileSystem
{
	private static Map<String,BufferedWriteTarget> out = new HashMap<String,BufferedWriteTarget>();
	
	public static void log()
	{
		System.out.println(out.keySet());
	}
	
	@Override
	public Reader read(String name, boolean testFirst) throws IOException {
		BufferedWriteTarget bwt = out.get(name);
		if (bwt==null) return null;
		String buffer = bwt.getBuffer();
		return new BufferedWriteTargetReader(buffer.toCharArray(),buffer.length(),bwt);
	}

	@Override
	public WriteTarget write(String name, boolean append) throws IOException {
		BufferedWriteTarget bwt = null;
		if (append) {
			bwt = out.get(name);
		}
		if (bwt==null) {
			bwt=new BufferedWriteTarget();
			out.put(name,bwt);
		}
		return bwt;
	}
	
	public BufferedWriteTarget get(String name)
	{
		return out.get(name);
	}

}
