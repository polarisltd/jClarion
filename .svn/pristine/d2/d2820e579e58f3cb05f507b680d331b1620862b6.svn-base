package org.jclarion.clarion.appgen.symbol;

import junit.framework.TestCase;

public class ArrayListSymbolValueTest extends TestCase {

	public void testAddSymbolValue() 
	{
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Apple,string:Pear,string:Banana]",test.toString());
	}

	public void testAddSymbolValueInt() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));

		test.add(SymbolValue.construct("Peach"),1);
		test.add(SymbolValue.construct("Mango"),3);
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
	}

	public void testDeleteInt() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());

		test.delete(5);		
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear]",test.toString());

		test.delete(1);		
		assertEquals("[string:Apple,string:Mango,string:Pear]",test.toString());

		test.delete(2);		
		assertEquals("[string:Apple,string:Pear]",test.toString());
	}

	public void testDelete() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());

		test.select(5);
		test.delete();		
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear]",test.toString());

		test.select(1);
		test.delete();		
		assertEquals("[string:Apple,string:Mango,string:Pear]",test.toString());

		test.select(2);
		test.delete();		
		assertEquals("[string:Apple,string:Pear]",test.toString());
	}

	public void testSize() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		assertEquals(0,test.size());
		test.add(SymbolValue.construct("Apple"));
		assertEquals(1,test.size());
		test.add(SymbolValue.construct("Pear"));
		assertEquals(2,test.size());
		test.add(SymbolValue.construct("Banana"));		
		assertEquals(3,test.size());
		test.add(SymbolValue.construct("Peach"),1);
		assertEquals(4,test.size());
		test.add(SymbolValue.construct("Mango"),3);
		assertEquals(5,test.size());

		test.delete(5);		
		assertEquals(4,test.size());

		test.delete(1);		
		assertEquals(3,test.size());

		test.delete(3);		
		assertEquals(2,test.size());

		test.delete(2);		
		assertEquals(1,test.size());
		
		test.delete(1);		
		assertEquals(0,test.size());
	}

	
	public void testFix_test1() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		
		
		assertTrue(test.fix(SymbolValue.construct("Peach")));
		assertEquals(1,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Mango")));
		assertEquals(3,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(5,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Apple")));
		assertEquals(2,test.instance());
		
		assertFalse(test.fix(SymbolValue.construct("peach")));
		
		// add something else
		test.add(SymbolValue.construct("Cherry"));
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Cherry")));
		assertEquals(6,test.instance());

		// still using efficient finder at this point?
		assertTrue(test.usingEfficientFinder());

		// still using efficient finder at this point?
		test.delete();
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		assertFalse(test.fix(SymbolValue.construct("Cherry")));
		assertTrue(test.usingEfficientFinder());
		
		// add a duplicate
		test.add(SymbolValue.construct("Pear"));
		
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(5,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		
		// add something else
		test.add(SymbolValue.construct("Cherry"));
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(5,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Cherry")));
		assertEquals(7,test.instance());
		
		// delete last item
		test.delete();
		assertFalse(test.usingEfficientFinder());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		assertFalse(test.fix(SymbolValue.construct("Cherry")));
		
		test.delete(6);
		assertFalse(test.usingEfficientFinder());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		assertFalse(test.fix(SymbolValue.construct("Cherry")));
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		
		assertTrue(test.fix(SymbolValue.construct("Peach")));
		assertEquals(1,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Mango")));
		assertEquals(3,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(5,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(4,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Apple")));
		assertEquals(2,test.instance());
		
		assertFalse(test.fix(SymbolValue.construct("peach")));
		
		
	}
	
	public void testFix_deleteDropsEfficientFinder() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		

		assertTrue(test.usingEfficientFinder());
		test.delete(3);
		assertFalse(test.usingEfficientFinder());
		
		assertTrue(test.fix(SymbolValue.construct("Peach")));
		assertEquals(1,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(4,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(3,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Apple")));
		assertEquals(2,test.instance());				
	}	

	public void testFix_insertDropsEfficientFinder() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		

		assertTrue(test.usingEfficientFinder());
		test.add(SymbolValue.construct("Cherry"),3);
		assertFalse(test.usingEfficientFinder());
		
		assertTrue(test.fix(SymbolValue.construct("Peach")));
		assertEquals(1,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Mango")));
		assertEquals(4,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(6,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(5,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Apple")));
		assertEquals(2,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Cherry")));
		assertEquals(3,test.instance());
	}	

	public void testFix_insertDupDropsEfficientFinder() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		

		assertTrue(test.usingEfficientFinder());
		test.add(SymbolValue.construct("Peach"),3);
		assertFalse(test.usingEfficientFinder());
		
		assertTrue(test.fix(SymbolValue.construct("Peach")));
		assertEquals(1,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Mango")));
		assertEquals(4,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(6,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Pear")));
		assertEquals(5,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Apple")));
		assertEquals(2,test.instance());
		assertTrue(test.fix(SymbolValue.construct("Peach")));
		assertEquals(1,test.instance());
	}	
	
	public void testSelect() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		test.select(1);
		assertEquals("Peach",test.value().getString());
		test.select(2);
		assertEquals("Apple",test.value().getString());
		test.select(3);
		assertEquals("Mango",test.value().getString());
		test.select(4);
		assertEquals("Pear",test.value().getString());
		test.select(5);
		assertEquals("Banana",test.value().getString());
	}

	public void testFree() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		assertTrue(test.usingEfficientFinder());
		test.add(SymbolValue.construct("Peach"),3);
		assertFalse(test.usingEfficientFinder());

		test.free();
		
		assertEquals(0,test.size());
		assertEquals("[]",test.toString());
		
		test.add(SymbolValue.construct("Peach"));

		assertEquals(1,test.size());
		assertEquals("[string:Peach]",test.toString());
		assertTrue(test.usingEfficientFinder());
	}

	public void testClone() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		ArrayListSymbolValue clone = test.clone();
		
		assertNotSame(clone,test);

		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		assertTrue(test.usingEfficientFinder());
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",clone.toString());
		assertTrue(clone.usingEfficientFinder());
		
		clone.add(SymbolValue.construct("Cherry"));

		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		assertTrue(test.usingEfficientFinder());
		
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana,string:Cherry]",clone.toString());
		assertTrue(clone.usingEfficientFinder());
		
		assertTrue(test.fix(SymbolValue.construct("Banana")));
		assertEquals(5,test.instance());
		assertFalse(test.fix(SymbolValue.construct("Cherry")));
		assertEquals(5,test.instance());
		
		assertTrue(clone.fix(SymbolValue.construct("Banana")));
		assertEquals(5,clone.instance());
		assertTrue(clone.fix(SymbolValue.construct("Cherry")));
		assertEquals(6,clone.instance());
		assertEquals(5,test.instance());
		
		clone.delete(3);
		
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		assertTrue(test.usingEfficientFinder());
		
		assertEquals("[string:Peach,string:Apple,string:Pear,string:Banana,string:Cherry]",clone.toString());
		assertFalse(clone.usingEfficientFinder());
	}

	public void testLoop() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		ListScanner ls = test.loop(false);
		for (int scan=1;scan<=5;scan++) {
			assertTrue(ls.next());
			assertEquals(scan,test.instance());
		}
		assertFalse(ls.next());
	}
	
	public void testInsertLoop() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		
		ListScanner ls = test.loop(false);

		assertTrue(ls.next());
		assertEquals("Peach",test.value().getString());
		
		assertTrue(ls.next());
		assertEquals("Apple",test.value().getString());
		
		test.add(SymbolValue.construct("Cherry"),3);
		assertEquals("[string:Peach,string:Apple,string:Cherry,string:Mango,string:Pear,string:Banana]",test.toString());

		assertTrue(ls.next());
		assertEquals("Cherry",test.value().getString());

		assertTrue(ls.next());
		assertEquals("Mango",test.value().getString());
		
		test.add(SymbolValue.construct("Lemon"),6);
		assertEquals("[string:Peach,string:Apple,string:Cherry,string:Mango,string:Pear,string:Lemon,string:Banana]",test.toString());
		
		assertTrue(ls.next());
		assertEquals("Pear",test.value().getString());

		test.add(SymbolValue.construct("Grape"),1);
		assertEquals("[string:Grape,string:Peach,string:Apple,string:Cherry,string:Mango,string:Pear,string:Lemon,string:Banana]",test.toString());

		assertTrue(ls.next());
		assertEquals("Lemon",test.value().getString());
		

		assertTrue(ls.next());
		assertEquals("Banana",test.value().getString());

		assertFalse(ls.next());
	}

	public void testDeleteLoop() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		
		ListScanner ls = test.loop(false);

		assertTrue(ls.next());
		assertEquals("Peach",test.value().getString());

		test.delete();
		assertEquals("[string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());

		assertTrue(ls.next());
		assertEquals("Apple",test.value().getString());

		test.delete(2);
		assertEquals("[string:Apple,string:Pear,string:Banana]",test.toString());

		assertTrue(ls.next());
		assertEquals("Pear",test.value().getString());

		test.delete(3);
		assertEquals("[string:Apple,string:Pear]",test.toString());

		assertFalse(ls.next());
	}

	public void testLoopR() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		ListScanner ls = test.loop(true);
		for (int scan=5;scan>=1;scan--) {
			assertTrue(ls.next());
			assertEquals(scan,test.instance());
		}
		assertFalse(ls.next());
	}
	
	public void testInsertLoopR() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		
		ListScanner ls = test.loop(true);

		assertTrue(ls.next());
		assertEquals("Banana",test.value().getString());
		
		assertTrue(ls.next());
		assertEquals("Pear",test.value().getString());
		
		test.add(SymbolValue.construct("Cherry"),3);
		assertEquals("[string:Peach,string:Apple,string:Cherry,string:Mango,string:Pear,string:Banana]",test.toString());

		assertTrue(ls.next());
		assertEquals("Mango",test.value().getString());
		
		test.add(SymbolValue.construct("Lemon"),2);
		assertEquals("[string:Peach,string:Lemon,string:Apple,string:Cherry,string:Mango,string:Pear,string:Banana]",test.toString());
		
		assertTrue(ls.next());
		assertEquals("Cherry",test.value().getString());

		test.add(SymbolValue.construct("Grape"),7);
		assertEquals("[string:Peach,string:Lemon,string:Apple,string:Cherry,string:Mango,string:Pear,string:Grape,string:Banana]",test.toString());

		assertTrue(ls.next());
		assertEquals("Apple",test.value().getString());
		
		test.add(SymbolValue.construct("Melon"),3);
		assertEquals("[string:Peach,string:Lemon,string:Melon,string:Apple,string:Cherry,string:Mango,string:Pear,string:Grape,string:Banana]",test.toString());

		assertTrue(ls.next());
		assertEquals("Lemon",test.value().getString());

		assertTrue(ls.next());
		assertEquals("Peach",test.value().getString());
		
		assertFalse(ls.next());
	}

	public void testDeleteLoopR() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear,string:Banana]",test.toString());
		
		ListScanner ls = test.loop(true);

		assertTrue(ls.next());
		assertEquals("Banana",test.value().getString());

		test.delete();
		assertEquals("[string:Peach,string:Apple,string:Mango,string:Pear]",test.toString());

		assertTrue(ls.next());
		assertEquals("Pear",test.value().getString());

		test.delete(3);
		assertEquals("[string:Peach,string:Apple,string:Pear]",test.toString());

		assertTrue(ls.next());
		assertEquals("Apple",test.value().getString());

		test.delete(1);
		assertEquals("[string:Apple,string:Pear]",test.toString());

		assertFalse(ls.next());
	}

	public void testNestedLoops() {
		ArrayListSymbolValue test = new ArrayListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		ListScanner ls_1 = test.loop(false);
		ListScanner ls_2 = test.loop(false);
		ListScanner ls_3 = test.loop(false);
		
		assertTrue(ls_1.next());
		assertEquals("Peach",test.value().getString());

		assertTrue(ls_2.next());
		assertEquals("Peach",test.value().getString());
		
		assertTrue(ls_3.next());
		assertEquals("Peach",test.value().getString());

		assertTrue(ls_2.next());
		assertEquals("Apple",test.value().getString());
		
		assertTrue(ls_3.next());
		assertEquals("Apple",test.value().getString());

		assertTrue(ls_3.next());
		assertEquals("Mango",test.value().getString());
		
		test.add(SymbolValue.construct("Grape"),3);
		
		assertLoop(test,ls_1,"Apple","Grape","Mango","Pear","Banana");
		assertLoop(test,ls_2,"Grape","Mango","Pear","Banana");
		assertLoop(test,ls_3,"Pear","Banana");
	}
	
	private void assertLoop(ArrayListSymbolValue test,ListScanner l,String ...bits)
	{
		for (String t : bits ) {
			assertTrue(l.next());
			assertEquals(t,test.value().getString());			
		}
		assertFalse(l.next());
	}
	
	
}

