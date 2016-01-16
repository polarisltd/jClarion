package org.jclarion.clarion.print.text;

import java.util.HashMap;
import java.util.Iterator;
import java.util.TreeSet;

public class ColumnList 
{
	private TreeSet<ColumnGroup> groups=new TreeSet<ColumnGroup>();
	private HashMap<Column,Integer>	 columns=new HashMap<Column,Integer>();
	
	public void add(Column c)
	{
		if (columns.containsKey(c)) return;
		columns.put(c,null);
		add(c,groups.iterator());
	}
	
	public void finish()
	{
		int count = 0; 
		for (ColumnGroup cg : groups ) {
			for (Column c : cg.getColumns() ) {
				columns.put(c,count);
			}
			count++;
		}
	}
	
	public int getPosition(Column c)
	{
		return columns.get(c);
	}

	private void add(Column c, Iterator<ColumnGroup> i) 
	{
		while ( i.hasNext() ) {
			ColumnGroup cg = i.next();
			if (cg.containsExact(c)) return;
			
			ColumnGroup.Result r = cg.contains(c);
			if (r==ColumnGroup.Result.YES) {
				cg.add(c);
				groups=new TreeSet<ColumnGroup>(groups);
				return;
			}
			if (r==ColumnGroup.Result.PARTIAL) {
				Column[] reject = cg.resolveConflict(c);
				groups=new TreeSet<ColumnGroup>(groups);
				if (reject.length>0) {
					i=null;
					for (Column rej : reject ) {
						add(rej,groups.tailSet(cg,false).iterator());
					}
				}
				if (cg.contains(c)==ColumnGroup.Result.YES) {
					cg.add(c);				
					groups=new TreeSet<ColumnGroup>(groups);
					return;
				}
				if (i==null) i = groups.tailSet(cg,false).iterator();
			}
		}
		ColumnGroup cg = new ColumnGroup();
		cg.add(c);
		groups.add(cg);
	}
	
	public String toString()
	{
		return groups.toString();
	}
}
