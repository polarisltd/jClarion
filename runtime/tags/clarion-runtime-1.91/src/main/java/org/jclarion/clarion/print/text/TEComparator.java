package org.jclarion.clarion.print.text;

import java.awt.Rectangle;
import java.util.Comparator;
import java.util.IdentityHashMap;
import java.util.Map;

import org.jclarion.clarion.print.TextElement;

public class TEComparator implements Comparator<TextElement>
{
	private int count=0;
	
	private static class Entry 
	{
		int x;
		int y;
		int count;
	}

	private Map<TextElement,Entry> e = new IdentityHashMap<TextElement,Entry>();
	
	@Override
	public int compare(TextElement o1, TextElement o2) 
	{
		Entry e1 = getEntry(o1);
		Entry e2 = getEntry(o2);
		
		if (e1.y!=e2.y) return e1.y-e2.y;
		if (e1.x!=e2.x) return e1.x-e2.x;
		return e1.count-e2.count;
	}

	private Entry getEntry(TextElement o1) 
	{
		Entry t = e.get(o1);
		if (t==null) {
			t=new Entry();
			Rectangle r = o1.getDimension();
			t.x=r.x;
			t.y=r.y;
			t.count=this.count++;
			e.put(o1,t);
		}
		return t;
	}

}
