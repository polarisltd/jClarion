package org.jclarion.clarion.ide.model;

import junit.framework.TestCase;

public class GenericTreeNodeTest extends TestCase {

	private GenericTreeNode grandParent;
	private GenericTreeNode parent;
	private GenericTreeNode child;
	private GenericTreeNode orphan;

	@Override
	protected void setUp() throws Exception {
		grandParent = new GenericTreeNode("grand parent");
		parent = new GenericTreeNode("parent");
		child = new GenericTreeNode("child");
		orphan = new GenericTreeNode("orphan");

		grandParent.addChild(parent);
		parent.addChild(child);
	}

	public void testAddChild() {
		parent.addChild(orphan);
		assertEquals(2, parent.getKids().size());

		assertEquals(child, parent.getKids().get(0));
		assertEquals(orphan, parent.getKids().get(1));
	}

	public void testAddChildAfter() {
		parent.addChildAfter(orphan, child);
		assertEquals(2, parent.getKids().size());
		assertEquals(child, parent.getKids().get(0));
		assertEquals(orphan, parent.getKids().get(1));

		GenericTreeNode anotherOrphan = new GenericTreeNode("another orphan");
		parent.addChildAfter(anotherOrphan, child);
		assertEquals(3, parent.getKids().size());
		assertEquals(child, parent.getKids().get(0));
		assertEquals(anotherOrphan, parent.getKids().get(1));
		assertEquals(orphan, parent.getKids().get(2));
	}

	public void removeChild() {
		assertEquals(1, parent.getKids());
		parent.removeChild(child);
		assertEquals(0, parent.getKids());
	}

	public void hasParent() {
		assertFalse(grandParent.hasParent());
		assertTrue(parent.hasParent());
		assertTrue(child.hasParent());
	}

	public void hasSiblings() {
		assertFalse(grandParent.hasSiblings());
		assertFalse(parent.hasSiblings());
		assertFalse(child.hasSiblings());

		parent.addChild(orphan);
		assertTrue(child.hasSiblings());
	}

	public void testIsFirstChild() {
		assertFalse(grandParent.isFirstChild());
		assertFalse(parent.isFirstChild());
		assertFalse(child.isFirstChild());

		parent.addChild(orphan);
		assertTrue(child.isFirstChild());
		assertFalse(orphan.isFirstChild());
	}

	public void testIsLastChild() {
		assertFalse(grandParent.isLastChild());
		assertFalse(parent.isLastChild());
		assertFalse(child.isLastChild());

		parent.addChild(orphan);
		assertTrue(orphan.isLastChild());
		assertFalse(child.isLastChild());
	}

	public void testIsOnlyChild() {
		assertTrue(grandParent.isOnlyChild());
		assertTrue(parent.isOnlyChild());
		assertTrue(child.isOnlyChild());

		parent.addChild(orphan);
		assertFalse(child.isOnlyChild());
		assertFalse(orphan.isOnlyChild());
	}

	public void testCanMoveDown() {
		assertFalse(grandParent.canMoveDown());
		assertFalse(parent.canMoveDown());
		assertFalse(child.canMoveDown());

		parent.addChild(orphan);
		assertTrue(orphan.canMoveDown());
		assertFalse(child.canMoveDown());
	}

	public void testCanMoveUp() {
		assertFalse(grandParent.canMoveUp());
		assertFalse(parent.canMoveUp());
		assertFalse(child.canMoveUp());

		parent.addChild(orphan);
		assertTrue(child.canMoveUp());
		assertFalse(orphan.canMoveUp());
	}

	public void testMoveDown() {
		parent.addChild(orphan);
		assertTrue(child.isFirstChild());
		assertTrue(orphan.isLastChild());

		orphan.moveDown();
		assertTrue(orphan.isFirstChild());
		assertTrue(child.isLastChild());
	}

	public void testMoveUp() {
		parent.addChild(orphan);
		assertTrue(child.isFirstChild());
		assertTrue(orphan.isLastChild());

		child.moveUp();
		assertTrue(orphan.isFirstChild());
		assertTrue(child.isLastChild());
	}

	public void testBecomeChildOf() {
		parent.becomeChildOf(child);
		assertEquals(child, parent.getParent());
		assertEquals(grandParent, parent.getParent().getParent());
	}

	public void testBecomeSiblingOf() {
		child.becomeSiblingOfParent(0);
		assertEquals(grandParent, child.getParent());
		assertEquals(2, grandParent.getKids().size());
	}

}
