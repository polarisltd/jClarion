package org.jclarion.clarion.ide.model;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.runtime.Assert;
import org.eclipse.jface.viewers.TreeNode;

public class GenericTreeNode extends TreeNode {

	public GenericTreeNode() {
		this(null);
	}

	public GenericTreeNode(Object value) {
		super(value);
	}

	public void addChild(GenericTreeNode child) {
		List<GenericTreeNode> kids = getKids();
		if (!kids.contains(child)) {
			kids.add(child);
			setKids(kids);
		}
		child.setParent(this);
	}

	public void addChildAfter(GenericTreeNode newChild, GenericTreeNode afterChild) {
		List<GenericTreeNode> kids = getKids();
		Assert.isTrue(kids.contains(afterChild));

		if (!kids.contains(newChild)) {
			int index = kids.indexOf(afterChild) + 1;
			if (index < kids.size()) {
				kids.add(index, newChild);
			} else {
				kids.add(newChild); // At end
			}

			setKids(kids);
		}

		newChild.setParent(this);
	}

	public void removeChild(GenericTreeNode child) {
		List<GenericTreeNode> kids = getKids();
		if (kids.contains(child)) {
			child.setParent(null);
			kids.remove(child);
		}
		setKids(kids);
	}

	public boolean hasParent() {
		return (getParent() != null);
	}

	public boolean hasSiblings() {
        return hasParent() && (getParent().getChildren().length > 1);
	}

	public List<GenericTreeNode> getSiblings() {
		Assert.isTrue(hasParent());
		return ((GenericTreeNode) getParent()).getKids();
	}

	/**
	 * Returns <code>true</code> if this node has siblings and it is in the
	 * first index position
	 */
	public boolean isFirstChild() {
		return hasSiblings() && (getSiblings().indexOf(this) == 0);
	}

	/**
	 * Returns <code>true</code> if this node has siblings and it is in the
	 * last index position
	 */
	public boolean isLastChild() {
		if (hasSiblings()) {
			List<GenericTreeNode> siblings = getSiblings();
			return siblings.indexOf(this) == (siblings.size() - 1);
		}
		return false;
	}

	public boolean isOnlyChild() {
		return !hasSiblings();
	}

	/**
	 * Returns <code>true</code> if this node has siblings and can move to a
	 * lower index position
	 */
	public boolean canMoveDown() {
		return hasSiblings() && (getSiblings().indexOf(this) > 0);
	}

	/**
	 * Returns <code>true</code> if this node has siblings and can move to a
	 * higher index position
	 */
	public boolean canMoveUp() {
		if (hasSiblings()) {
			List<GenericTreeNode> siblings = getSiblings();
			return siblings.indexOf(this) < (siblings.size() - 1);
		}
		return false;
	}

	/**
	 * Moves this node to a lower index position among its siblings
	 */
	public void moveDown() {
		Assert.isTrue(canMoveDown());
		swapPositionsWithSibling(-1);
	}

	/**
	 * Moves this node to a higher index position among its siblings
	 */
	public void moveUp() {
		Assert.isTrue(canMoveUp());
		swapPositionsWithSibling(1);
	}

	/**
	 * Descends this node down the hierarchy, making it it a child of
	 * <code>parent</code>. Its existing parent will become its grand parent
	 */
	public void becomeChildOf(GenericTreeNode parent) {
		Assert.isTrue(parent instanceof GenericTreeNode);
		GenericTreeNode grandParent = (GenericTreeNode) getParent();

		parent.setParent(grandParent);
		parent.addChild(this);

		// Replace the index occupied by the child with its new parent
		List<GenericTreeNode> grandKids = grandParent.getKids();
		grandKids.set(grandKids.indexOf(this), parent);
		grandParent.setKids(grandKids);
	}

	/**
	 * Ascends this node up the hierarchy, making it a sibling of its parent at
	 * the specified index. Its existing grand parent will become its parent.
	 * The old parent is returned.
	 */
	public GenericTreeNode becomeSiblingOfParent(int index) {
		Assert.isTrue(getParent() instanceof GenericTreeNode);
		Assert.isTrue(getParent().getParent() instanceof GenericTreeNode);

		GenericTreeNode parent = (GenericTreeNode) getParent();
		parent.removeChild(this);

		GenericTreeNode grandParent = (GenericTreeNode) parent.getParent();
		setParent(grandParent);

		List<GenericTreeNode> siblings = grandParent.getKids();
		siblings.add(index, this);
		grandParent.setKids(siblings);

		return parent;
	}

	/**
	 * Same as {@link #getChildren()}, but returns the children cast to
	 * {@link GenericTreeNode}
	 */
	public List<GenericTreeNode> getKids() {
		List<GenericTreeNode> kids = new ArrayList<GenericTreeNode>();
		if (hasChildren()) {
			for (TreeNode kid : getChildren()) {
				kids.add((GenericTreeNode) kid);
			}
		}
		return kids;
	}

	private void setKids(List<GenericTreeNode> kids) {
		setChildren(kids.toArray(new TreeNode[kids.size()]));
	}

	/**
	 * Swaps this node with its sibling located at <code>distance</code> index
	 * positions from this node
	 */
	private void swapPositionsWithSibling(int distance) {
		List<GenericTreeNode> siblings = getSiblings();
		int oldIndex = siblings.indexOf(this);
		int newIndex = oldIndex + distance;
		GenericTreeNode sibling = siblings.get(newIndex);
		siblings.set(oldIndex, sibling);
		siblings.set(newIndex, this);
		((GenericTreeNode) getParent()).setKids(siblings);
	}

}
