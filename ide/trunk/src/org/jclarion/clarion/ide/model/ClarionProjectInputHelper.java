package org.jclarion.clarion.ide.model;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IProject;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.part.FileEditorInput;

public class ClarionProjectInputHelper {
	
	public static IProject getProject(IEditorInput input)
	{
		if (input==null) return null;
		IProject project=null;
		if (input instanceof FileEditorInput) {
			IFile file = ((FileEditorInput)input).getFile();
			if (file!=null) {
				project=file.getProject();
			}
		}
		if (input instanceof ClarionProjectInput) {
			project = ((ClarionProjectInput)input).getProject();
		}
		return project;
	}
}
