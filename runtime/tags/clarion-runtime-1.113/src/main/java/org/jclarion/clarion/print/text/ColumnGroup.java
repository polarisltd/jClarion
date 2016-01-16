package org.jclarion.clarion.print.text;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

public class ColumnGroup implements Comparable<ColumnGroup>
{
	public static enum Result
	{
		YES, NO, PARTIAL; 
	}
	
	int position=0;

	private Set<Column> columns=new HashSet<Column>();
	private Column first;

	public ColumnGroup()
	{
	}
	
	public ColumnGroup(Column c)
	{
		first=c;
	}
	
	
	public boolean containsExact(Column c)
	{
		return columns.contains(c);
	}
	
	public Result contains(Column c)
	{
		Result r = null;
		for (Column t : columns ) {
			if (t.overlaps(c)) {
				if (r==Result.NO) {
					return Result.PARTIAL;
				} else {
					r=Result.YES;
				}
			} else {
				if (r==Result.YES) {
					return Result.PARTIAL;
				} else {
					r=Result.NO;
				}				
			}
		}
		return r==null ? Result.NO : r;
	}
	
	public Column[] resolveConflict(Column c)
	{
		TreeSet<Column> set = new TreeSet<Column>();
		set.add(c);
		set.addAll(columns);
		
		ColumnGroup rebuild = new ColumnGroup();
		rebuild.add(set.first());
		set.remove(set.first());
		
		MAIN: while ( true ) {
			Iterator<Column> scan = set.iterator();
			while (scan.hasNext()) {
				Column t = scan.next();
				Result r = rebuild.contains(t);
				if (r==Result.NO) continue;
				if (r==Result.YES) {
					rebuild.add(t);
					scan.remove();
					continue MAIN;
				}				
			}
			set.remove(c);
			for (Column t : set ) {
				columns.remove(t);
				first=null;
			}
			Column r[] = new Column[set.size()];
			set.toArray(r);
			return r;
		}
	}

	public void add(Column c)
	{
		columns.add(c);
		first=null;
	}

	public Column getFirst()
	{
		if (first==null) {
			for (Column t : columns ) {
				if (first==null) {
					first=t;
					continue;
				}
				if (t.compareTo(first)<-1) {
					first=t;
				}
			}
		}
		return first;
	}
	
	@Override
	public int compareTo(ColumnGroup o) {
		return getFirst().compareTo(o.getFirst());
	}

	public ColumnGroup increment() {
		return new ColumnGroup(getFirst().increment());
	}

	public Iterable<Column> getColumns() {
		return columns;
	}
	
	public String toString()
	{
		return (new TreeSet<Column>(columns)).toString();
	}
}
