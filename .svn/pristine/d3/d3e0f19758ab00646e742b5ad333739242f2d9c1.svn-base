package org.jclarion.clarion.ide.builder;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IFolder;
import org.eclipse.core.runtime.CoreException;
import org.jclarion.clarion.appgen.template.AppendableWriteTarget;
import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.ExecutionEnvironmentFileSystem;
import org.jclarion.clarion.appgen.template.WriteTarget;
import org.jclarion.clarion.util.SharedOutputStream;

public class AppGenFileSystem implements ExecutionEnvironmentFileSystem
{
	private IFolder base;
	
	public AppGenFileSystem(IFolder base)
	{
		this.base=base;
	}

	@Override
	public Reader read(String name, boolean testFirst) throws IOException {
		IFile file = base.getFile(name);
		if (testFirst && !file.exists()) return null;		
		try {
			return new InputStreamReader(file.getContents(true));
		} catch (CoreException e) {
			e.printStackTrace();
			throw new IOException(e);
		}
	}

	@Override
	public WriteTarget write(final String name,final boolean append) throws IOException {
		return new BufferedWriteTarget() {
			
			private boolean closed=false;
			
			@Override
			public void close() {
				
				if (closed) return;
				closed=true;
				try {
					SharedOutputStream sos = new SharedOutputStream();
					OutputStreamWriter osw = new OutputStreamWriter(sos);
					flushInto(new AppendableWriteTarget(osw));
					osw.close();

					IFile file = base.getFile(name);					
					if (!file.exists()) {
						file.create(sos.getInputStream(), true,null);
					} else {
						if (append) {
							file.appendContents(sos.getInputStream(),true, true,null);
						} else {
							file.setContents(sos.getInputStream(),true, true,null);
						}
					}
					file.setDerived(true,null);
				} catch (IOException e) {
					e.printStackTrace();
				} catch (CoreException e) {
					e.printStackTrace();
				}
			}
			
			public void finalize()
			{
				if (!closed) {
					System.err.println("Not finalized!!!");
				}
			}
			
		};
	}

}
