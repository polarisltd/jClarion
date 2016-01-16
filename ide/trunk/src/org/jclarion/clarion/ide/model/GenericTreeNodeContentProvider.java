package org.jclarion.clarion.ide.model;

import org.eclipse.core.runtime.Assert;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.Viewer;

public class GenericTreeNodeContentProvider implements ITreeContentProvider {

	public final GenericTreeNode root;

	public GenericTreeNodeContentProvider() {
		this.root = new GenericTreeNode(null) {
			@Override
			public String toString() {
				return "Root";
			}
		};
	}

	@Override
	public void dispose() {
		// Empty
	}

	@Override
	public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
		// Empty
	}

	@Override
	public Object[] getElements(Object inputElement) {
		if (root.hasChildren()) {
			return root.getChildren();
		}
		return new GenericTreeNode[0];
	}

	@Override
	public Object[] getChildren(Object parentElement) {
		if (parentElement instanceof GenericTreeNode) {
			return ((GenericTreeNode) parentElement).getChildren();
		}
		return null;
	}

	@Override
	public Object getParent(Object element) {
		if (element instanceof GenericTreeNode) {
			return ((GenericTreeNode) element).getParent();
		}
		return null;
	}

	@Override
	public boolean hasChildren(Object element) {
		if (element instanceof GenericTreeNode) {
			return ((GenericTreeNode) element).hasChildren();
		}
		return false;
	}

	public boolean hasContent() {
		return root.hasChildren();
	}

	public GenericTreeNode getFirstChild() {
		Assert.isTrue(hasContent());
		return root.getKids().get(0);
	}

}
