package org.jclarion.clarion.appgen.template.cmd;

import org.jclarion.clarion.appgen.template.TemplateChain;

public interface InsertAwareParent 
{
	public void addInsert(TemplateChain chain, InsertCmd insertCmd);
}
