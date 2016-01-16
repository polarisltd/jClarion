package org.jclarion.clarion.ide.editor.rule;

import org.eclipse.jface.text.DocumentEvent;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IRegion;
import org.eclipse.jface.text.ITypedRegion;
import org.eclipse.jface.text.presentation.IPresentationDamager;

/**
 * A simple damager that reports damage to the entire partition. The default damager constrains damage to a single line which is not what we want for clarion
 * since some syntax highlighting can be multiline.  Though arguably we should and will eventually implement some structures (such as omit blocks) as partitions so we can 
 * avail to cool  features such as code folding
 * 
 * @author barney
 */
public class SimpleDamager implements IPresentationDamager
{
	@Override
	public IRegion getDamageRegion(ITypedRegion partition, DocumentEvent e, boolean documentPartitioningChanged) 
	{
		return partition;
	}

	@Override
	public void setDocument(IDocument document) {
	}
}
