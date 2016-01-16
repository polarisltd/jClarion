package org.jclarion.clarion.ide.model.fieldops;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.swt.widgets.TreeItem;
import org.jclarion.clarion.appgen.app.FieldStore;

public class MultiOp extends AbstractOp
{
	private List<AbstractOp> subActions=new ArrayList<AbstractOp>();
	
	public void add(AbstractOp item)
	{
		subActions.add(item);
	}

	@Override
	public void apply(FieldStore root) {
		for (AbstractOp scan : subActions) {
			scan.apply(root);
		}
	}

	@Override
	public void apply(TreeItem root) {
		for (AbstractOp scan : subActions) {
			scan.apply(root);
		}
	}

}
