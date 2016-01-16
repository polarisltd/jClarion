package org.jclarion.clarion.appgen.symbol.system;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;

import junit.framework.TestCase;

public class ROSetListSymbolTest extends TestCase {

	public void testBasic()
	{
		List<String> s = new ArrayList<String>();
		s.add("Apple");
		s.add("Banana");
		s.add("Pear");
		
		ROSetListSymbol list = new ROSetListSymbol(s);
		assertEquals(3,list.size());
		
		assertTrue(list.select(1));
		assertEquals("Apple",list.value().getString());
		
		assertTrue(list.select(2));
		assertEquals("Banana",list.value().getString());
		
		assertTrue(list.fix(new StringSymbolValue("Apple")));
		assertEquals(1,list.instance());
		
		ListScanner scanner = list.loop(false);
		assertTrue(scanner.next());
		assertEquals("Apple",list.value().getString());
		assertEquals(1,list.instance());
		assertTrue(scanner.next());
		assertEquals("Banana",list.value().getString());
		assertEquals(2,list.instance());
		assertTrue(scanner.next());
		assertEquals("Pear",list.value().getString());
		assertEquals(3,list.instance());
		assertFalse(scanner.next());
		
	}
}
