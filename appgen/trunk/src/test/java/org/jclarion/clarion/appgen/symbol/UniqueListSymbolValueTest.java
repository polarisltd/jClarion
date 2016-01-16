package org.jclarion.clarion.appgen.symbol;

import junit.framework.TestCase;

public class UniqueListSymbolValueTest extends TestCase {

	public void testAddSymbolValue() 
	{
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Apple,string:Banana,string:Pear]",test.toString());
	}

	public void testAddSymbolValueInt() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));

		test.add(SymbolValue.construct("Peach"),1);
		test.add(SymbolValue.construct("Mango"),3);
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
	}

	public void testDeleteInt() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());

		test.delete(5);		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach]",test.toString());

		test.delete(1);		
		assertEquals("[string:Banana,string:Mango,string:Peach]",test.toString());

		test.delete(2);		
		assertEquals("[string:Banana,string:Peach]",test.toString());
	}

	public void testDelete() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());

		test.select(5);
		test.delete();		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach]",test.toString());

		test.select(1);
		test.delete();		
		assertEquals("[string:Banana,string:Mango,string:Peach]",test.toString());

		test.select(2);
		test.delete();		
		assertEquals("[string:Banana,string:Peach]",test.toString());
	}

	public void testSize() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
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

	private void assertFix(int pos,UniqueListSymbolValue test,String val)
	{
		if (pos>0) {
			assertTrue(test.fix(SymbolValue.construct(val)));
			assertEquals(pos,test.instance());
			assertEquals(val,test.value().getString());
		} else {
			assertFalse(test.fix(SymbolValue.construct(val)));
		}
	}
	
	public void testFix_test1() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		
		assertFix(4,test,"Peach");
		assertFix(3,test,"Mango");
		assertFix(2,test,"Banana");
		assertFix(5,test,"Pear");
		assertFix(1,test,"Apple");
		assertFix(0,test,"peach");
		
		// add something else
		test.add(SymbolValue.construct("Cherry"));
		assertFix(5,test,"Peach");
		assertFix(4,test,"Mango");
		assertFix(2,test,"Banana");
		assertFix(6,test,"Pear");
		assertFix(1,test,"Apple");
		assertFix(3,test,"Cherry");

		// delete something
		test.delete();
		assertFix(4,test,"Peach");
		assertFix(3,test,"Mango");
		assertFix(2,test,"Banana");
		assertFix(5,test,"Pear");
		assertFix(1,test,"Apple");
		assertFix(0,test,"Cherry");
		
		// add a duplicate
		test.add(SymbolValue.construct("Pear"));
		assertFix(4,test,"Peach");
		assertFix(3,test,"Mango");
		assertFix(2,test,"Banana");
		assertFix(5,test,"Pear");
		assertFix(1,test,"Apple");
		assertFix(0,test,"Cherry");
		assertEquals(5,test.size());
		
		// add something to the end
		test.add(SymbolValue.construct("Watermellon"));
		assertFix(4,test,"Peach");
		assertFix(3,test,"Mango");
		assertFix(2,test,"Banana");
		assertFix(5,test,"Pear");
		assertFix(6,test,"Watermellon");
		assertFix(1,test,"Apple");
		assertFix(0,test,"Cherry");
		
		// and remove it
		test.delete(6);
		assertFix(4,test,"Peach");
		assertFix(3,test,"Mango");
		assertFix(2,test,"Banana");
		assertFix(5,test,"Pear");
		assertFix(1,test,"Apple");
		assertFix(0,test,"Cherry");
				
	}
	
	public void testSelect() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		assertSelect(test,3,"Mango");
		assertSelect(test,1,"Apple");
		assertSelect(test,4,"Peach");
		assertSelect(test,5,"Pear");
		assertSelect(test,2,"Banana");
	}

	private void assertSelect(UniqueListSymbolValue test, int i, String string) 
	{
		test.select(i);
		assertEquals(string,test.value().getString());
	}

	public void testFree() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));		
		test.add(SymbolValue.construct("Peach"),3);

		test.free();
		
		assertEquals(0,test.size());
		assertEquals("[]",test.toString());
		
		test.add(SymbolValue.construct("Peach"));

		assertEquals(1,test.size());
		assertEquals("[string:Peach]",test.toString());
	}

	public void testClone() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		UniqueListSymbolValue clone = test.clone();
		
		assertNotSame(clone,test);

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
		
		clone.add(SymbolValue.construct("Cherry"));

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Cherry,string:Mango,string:Peach,string:Pear]",clone.toString());
		
		assertFix(2,test,"Banana");
		assertFix(2,clone,"Banana");
		assertFix(0,test,"Cherry");
		assertFix(3,clone,"Cherry");
		assertFix(5,test,"Pear");
		assertFix(6,clone,"Pear");
		
		clone.delete(3);
		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
	}

	public void testCloneOrderedDump() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		UniqueListSymbolValue clone = test.clone();
		assertFix(0,test,"Watermellon");
		
		assertNotSame(clone,test);

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
		
		clone.add(SymbolValue.construct("Watermellon"));

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear,string:Watermellon]",clone.toString());
		
		assertFix(2,test,"Banana");
		assertFix(2,clone,"Banana");
		assertFix(0,test,"Watermellon");
		assertFix(6,clone,"Watermellon");
		assertFix(5,test,"Pear");
		assertFix(5,clone,"Pear");
		
		clone.delete(6);
		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
	}

	public void testCloneOrderedDump2() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		UniqueListSymbolValue clone = test.clone();
		assertFix(3,test,"Mango");
		
		assertNotSame(clone,test);

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
		
		clone.add(SymbolValue.construct("Nectarine"));

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Nectarine,string:Peach,string:Pear]",clone.toString());
		
		assertFix(2,test,"Banana");
		assertFix(2,clone,"Banana");
		assertFix(0,test,"Nectarine");
		assertFix(4,clone,"Nectarine");
		assertFix(5,test,"Pear");
		assertFix(6,clone,"Pear");
		
		clone.delete(4);
		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
	}

	public void testCloneOrderedDump3() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		UniqueListSymbolValue clone = test.clone();
		assertFix(3,test,"Mango");
		
		assertNotSame(clone,test);

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
		
		clone.add(SymbolValue.construct("Lemon"));

		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Lemon,string:Mango,string:Peach,string:Pear]",clone.toString());
		
		assertFix(2,test,"Banana");
		assertFix(2,clone,"Banana");
		assertFix(0,test,"Lemon");
		assertFix(3,clone,"Lemon");
		assertFix(5,test,"Pear");
		assertFix(6,clone,"Pear");
		
		clone.delete(3);
		
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",clone.toString());
	}
	
	public void testLoop() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		ListScanner ls = test.loop(false);
		assertLoop(test, ls, "Apple","Banana","Mango","Peach","Pear");
	}
	
	public void testMutateLoop() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		
		ListScanner ls = test.loop(false);

		assertPartLoop(test,ls,"Apple","Banana","Mango");

		test.add(SymbolValue.construct("Lemon"));
		test.add(SymbolValue.construct("Watermellon"));
		
		assertLoop(test,ls,"Peach","Pear","Watermellon");
	}

	public void testMutateLoop2() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		
		ListScanner ls = test.loop(false);

		assertPartLoop(test,ls,"Apple","Banana","Mango");

		test.fix(SymbolValue.construct("Pear"));
		test.delete();
		assertLoop(test,ls,"Peach");
	}

	public void testLoopR() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		ListScanner ls = test.loop(true);
		assertLoop(test, ls, "Pear","Peach","Mango","Banana","Apple");
	}
	
	public void testMutateLoop1R() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		
		ListScanner ls = test.loop(true);

		assertPartLoop(test, ls, "Pear","Peach","Mango");

		test.add(SymbolValue.construct("Lemon"));
		test.add(SymbolValue.construct("Watermellon"));
		
		assertLoop(test, ls, "Lemon","Banana","Apple");
	}

	public void testMutateLoop2R() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		assertEquals("[string:Apple,string:Banana,string:Mango,string:Peach,string:Pear]",test.toString());
		
		ListScanner ls = test.loop(true);

		assertPartLoop(test, ls, "Pear","Peach","Mango");

		test.fix(SymbolValue.construct("Banana"));
		test.delete();
		assertLoop(test,ls,"Apple");
	}
	

	public void testNestedLoops() {
		UniqueListSymbolValue test = new UniqueListSymbolValue();
		test.add(SymbolValue.construct("Peach"));
		test.add(SymbolValue.construct("Apple"));
		test.add(SymbolValue.construct("Mango"));
		test.add(SymbolValue.construct("Pear"));
		test.add(SymbolValue.construct("Banana"));
		
		ListScanner ls_1 = test.loop(false);
		ListScanner ls_2 = test.loop(false);
		ListScanner ls_3 = test.loop(false);
		
		assertTrue(ls_1.next());
		assertEquals("Apple",test.value().getString());

		assertTrue(ls_2.next());
		assertEquals("Apple",test.value().getString());
		
		assertTrue(ls_3.next());
		assertEquals("Apple",test.value().getString());

		assertTrue(ls_2.next());
		assertEquals("Banana",test.value().getString());
		
		assertTrue(ls_3.next());
		assertEquals("Banana",test.value().getString());

		assertTrue(ls_3.next());
		assertEquals("Mango",test.value().getString());
		
		test.add(SymbolValue.construct("Grape"),3);
		
		assertLoop(test,ls_1,"Banana","Grape","Mango","Peach","Pear");
		assertLoop(test,ls_2,"Grape","Mango","Peach","Pear");
		assertLoop(test,ls_3,"Peach","Pear");
	}
	
	private void assertLoop(UniqueListSymbolValue test,ListScanner l,String ...bits)
	{
		for (String t : bits ) {
			assertTrue(l.next());
			assertEquals(t,test.value().getString());			
		}
		assertFalse(l.next());
	}
	
	private void assertPartLoop(UniqueListSymbolValue test,ListScanner l,String ...bits)
	{
		for (String t : bits ) {
			assertTrue(l.next());
			assertEquals(t,test.value().getString());			
		}
	}
	
}
