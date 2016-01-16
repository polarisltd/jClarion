package org.jclarion.clarion.appgen.template;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.Reader;

public class DefaultExecutionEnvironmentFileSystem implements ExecutionEnvironmentFileSystem
{
	@Override
	public Reader read(String name, boolean testFirst) throws IOException {
		File f = new File(name);
		if (testFirst && !f.exists()) {
			return null;
		}
		return new java.io.InputStreamReader(
				new java.io.BufferedInputStream(
					new java.io.FileInputStream(name)
				),"windows-1252"
			);
	}

	@Override
	public WriteTarget write(String name, boolean append) throws IOException {
		return new WriterWriteTarget(new BufferedWriter(
				new java.io.OutputStreamWriter(
					new java.io.FileOutputStream(name,append),
					"windows-1252"
				)
			));
	}

}
