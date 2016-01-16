package org.jclarion.clarion.ide.editor;

import org.eclipse.core.resources.IFile;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorMatchingStrategy;
import org.eclipse.ui.IEditorReference;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.ide.ResourceUtil;
import org.jclarion.clarion.ide.model.EmbeditorInput;

public class ClarionMatchStrategy implements IEditorMatchingStrategy
{
	@Override
	public boolean matches(IEditorReference editorRef, IEditorInput input) 
	{
		try {		
			IEditorInput target = editorRef.getEditorInput();
			
			if (target.equals(input)) return true;

			if (target instanceof EmbeditorInput) {
				EmbeditorInput ei = (EmbeditorInput)target;
				IFile file = ResourceUtil.getFile(input);
				if (file==null) return false;
				if (!ei.isEditModule()) return false;
				if (!file.isDerived()) return false;
				return ei.getModule().getName().equalsIgnoreCase(file.getName());
			}
		} catch (PartInitException e) {
			e.printStackTrace();
		}
		return false;
	}

}
