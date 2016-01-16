package org.jclarion.clarion.ide.model;

import javax.swing.JPopupMenu;

import org.jclarion.clarion.ide.editor.AbstractClarionEditor;

public interface JavaSwingContributor extends AbstractClarionEditor
{
	public void contributePopup(JPopupMenu menu);
}
