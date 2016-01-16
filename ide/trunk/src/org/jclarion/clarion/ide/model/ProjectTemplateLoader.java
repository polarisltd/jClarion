package org.jclarion.clarion.ide.model;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import org.eclipse.core.resources.IContainer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.runtime.CoreException;
import org.jclarion.clarion.appgen.template.TemplateLoaderSource;

public class ProjectTemplateLoader implements TemplateLoaderSource
{
	//private IContainer container;
	private Map<String,IFile> templatefiles;


	public ProjectTemplateLoader(IContainer container)
	{
		//this.container=container;
		templatefiles=new HashMap<String,IFile>();
		try {
			for (IResource target : container.members()) {
				if (target instanceof IFile) {
					templatefiles.put(target.getName().toLowerCase(),(IFile)target);
				}
			}
		} catch (CoreException e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public InputStream get(String arg0) throws IOException {
		try {
			return templatefiles.get(arg0.toLowerCase()).getContents();
		} catch (CoreException e) {
			throw new IOException(e.getMessage());
		}
	}

}
