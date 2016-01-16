package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.jclarion.clarion.appgen.loader.Definition;

import junit.framework.TestCase;

public class AbstractFieldStoreTest extends TestCase {

	private Field[] f;
	
	private Field create(String name)
	{
		Field f=new Field();
		f.setDefinition(new Definition(name,"      "));
		return f;
	}
	
	public void setUp()
	{
		f=new Field[10];		
		for (int scan=0;scan<f.length;scan++) {
			f[scan]=create("F"+scan);
		}
	}
	
	public void testSimple()
	{
		AbstractFieldStore afs = new AbstractFieldStore();
		for (Field s : f) {
			afs.addField(s);
		}
		assertStore(afs,f);
	}

	public void testReverseOrder()
	{
		AbstractFieldStore afs = new AbstractFieldStore();
		for (Field s : f) {
			afs.addField(s,0);
		}
		assertStore(afs,f[9],f[8],f[7],f[6],f[5],f[4],f[3],f[2],f[1],f[0]);
	}
	
	public void testKeyLookup()
	{
		AbstractFieldStore afs = new AbstractFieldStore();
		Field a = create("a");
		Field b = create("b");
		Field c = create("C");
		Field d = create("d");
		
		afs.addField(a);
		afs.addField(b);
		afs.addField(c);
		afs.addField(d);
		assertStore(afs,a,b,c,d);

		assertSame(b,afs.getField("b"));
		assertSame(b,afs.getField("B"));
		assertSame(c,afs.getField("c"));
		assertSame(c,afs.getField("C"));
	}
	
	public void testDelete()
	{
		AbstractFieldStore afs = new AbstractFieldStore();
		Field a = create("a");
		Field b = create("b");
		Field c = create("C");
		Field d = create("d");
		Field e = create("e");
		
		afs.addField(a);
		afs.addField(b);
		afs.addField(c);
		afs.addField(d);
		afs.addField(e);
		assertStore(afs,a,b,c,d,e);
		
		afs.deleteField("c");
		assertStore(afs,a,b,d,e);
		afs.deleteField("A");
		assertStore(afs,b,d,e);
		afs.deleteField("e");
		assertStore(afs,b,d);
	}
	
	public void testReplace()
	{
		AbstractFieldStore afs = new AbstractFieldStore();
		Field a = create("a");
		Field b = create("b");
		Field c = create("C");
		Field d = create("d");
		Field e = create("e");
		
		afs.addField(a);
		afs.addField(b);
		afs.addField(c);
		afs.addField(d);
		afs.addField(e);
		assertStore(afs,a,b,c,d,e);		
		
		Field replace = create("C");
		
		afs.replaceField("c", replace);
		assertStore(afs,a,b,replace,d,e);		
		assertSame(replace,afs.getField("c"));
	}

	public void testReplace2()
	{
		AbstractFieldStore afs = new AbstractFieldStore();
		Field a = create("a");
		Field b = create("b");
		Field c = create("C");
		Field d = create("d");
		Field e = create("e");
		
		afs.addField(a);
		afs.addField(b);
		afs.addField(c);
		afs.addField(d);
		afs.addField(e);
		assertStore(afs,a,b,c,d,e);		
		
		Field replace = create("replace");
		
		afs.replaceField("c", replace);
		assertStore(afs,a,b,replace,d,e);		
		assertSame(replace,afs.getField("replace"));
		assertNull(afs.getField("c"));
	}
	
	public void testRandomOrder()
	{
		Random r = new Random();
		for (int scan=0;scan<1000;scan++) {
			AbstractFieldStore afs = new AbstractFieldStore();
			List<Field> compare =new ArrayList<Field>();
			for (Field s : f) {
				int pos = r.nextInt(compare.size()+1);
				afs.addField(s,pos);
				compare.add(pos, s);
			}
			
			assertStore(afs,compare.toArray(new Field[compare.size()]));

			int pos = r.nextInt(10);
			
			assertSame(compare.get(pos),afs.getField(pos));
			assertSame(compare.get(0),afs.getFirstField());
			assertSame(compare.get(9),afs.getLastField());
			
			if (pos>0) {
				assertSame(compare.get(pos-1),afs.getPrevious(compare.get(pos)));
			}
			if (pos<9) {
				assertSame(compare.get(pos+1),afs.getNext(compare.get(pos)));
			}
			
		}
	}
	
	private void assertStore(AbstractFieldStore afs, Field... result) {
		
		int ofs=0;
		
		for (Field s : afs.getFields()) {
			assertSame(result[ofs++],s);
		}
		assertEquals(result.length,ofs);
	}
	
}
