package org.jclarion.clarion.ide.editor;

import org.jclarion.clarion.ide.model.app.ProcedureModel;

public interface EmbedProvider {
	public EmbedHelper getEmbedHelper();
	public ProcedureModel getModel();
}
