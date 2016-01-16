package org.jclarion.clarion.ide.model;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.resources.IContainer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.runtime.CoreException;
import org.jclarion.clarion.appgen.app.TextAppSource;

public class ProjectAppLoader implements TextAppSource
{
	private IContainer container;

	public ProjectAppLoader(IContainer container)
	{
		this.container=container;
	}

	@Override
	public Object get(String arg0) {
		return container.findMember(arg0);
	}

	@Override
	public String[] getAll(String extension) {
		List<String> result = new ArrayList<String>();
		try {
			for (IResource r : container.members()) {
				if (!(r instanceof IFile)) continue;
				if (r.getFileExtension()==null) continue;				
				if (extension==null || r.getFileExtension().equalsIgnoreCase(extension)) {
					result.add(r.getName());
				}
			}
		} catch (CoreException e) {
			e.printStackTrace();
		}
		return result.toArray(new String[result.size()]);
	}

	@Override
	public InputStream open(Object arg0) throws IOException {
		try {
			return ((IFile)arg0).getContents();
		} catch (CoreException e) {
			throw new IOException(e);
		}
	}

}
