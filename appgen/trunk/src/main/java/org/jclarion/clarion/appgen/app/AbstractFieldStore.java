package org.jclarion.clarion.appgen.app;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class AbstractFieldStore implements FieldStore
{
	private static class Entry
	{
		private Entry previous;
		private Entry next;		
		private Field entry;
		
		public Entry(Entry previous,Entry next,Field f) {
			this.previous=previous;
			this.next=next;
			this.entry=f;
		}
	}
	
	private Map<String,Entry> fields = new HashMap<String,Entry>();
	private Entry head;
	private Entry tail;

	
	public AbstractFieldStore()
	{
	}
	
	public void clear()
	{
		fields.clear();
		head=null;
		tail=null;
	}
	
	public int getOffset(Field f)
	{
		int ofs=0;
		Entry scan = head;
		while (scan!=null) {
			if (scan.entry==f) return ofs;
			scan=scan.next;
			ofs++;
		}
		return -1;
	}
	
	public Field getPrevious(Field f)
	{
		Entry e = fields.get(f.getLabel().toLowerCase());
		if (e!=null && e.previous!=null) return e.previous.entry;
		return null;
	}

	public Field getNext(Field f)
	{
		Entry e = fields.get(f.getLabel().toLowerCase());
		if (e!=null && e.next!=null) return e.next.entry;
		return null;
	}
	
	public AbstractFieldStore(FieldStore base)
	{
		for (Field f : base.getFields()) {
			addField(new Field(f));
		}
	}
	
	private void addEntry(Entry previous,Entry next,Field f)
	{
		Entry e = new Entry(previous,next,f);
		if (previous==null) {
			head=e;
		} else {
			previous.next=e;
		}
		if (next==null) {
			tail=e;
		} else {
			next.previous=e;
		}
		fields.put(f.getLabel().toLowerCase(),e);
		f.setStore(this);
	}
	
	@Override
	public void addField(Field f) {
		addEntry(tail,null,f);
	}
	
	@Override
	public void replaceField(String oldName, Field newField) 
	{
		Entry e = fields.get(oldName.toLowerCase());
		if (e==null) {
			addField(newField);
			return;
		}
		
		if (!oldName.equalsIgnoreCase(newField.getLabel())) {
			fields.remove(oldName.toLowerCase());
			fields.put(newField.getLabel().toLowerCase(),e);
		}
		e.entry=newField;
		newField.setStore(this);
	}
	
	public Field getField(int position)
	{
		Entry scan=null;
		if (position<fields.size()/2) {
			scan=head;
			while (position>0 && scan!=null) {
				scan=scan.next;
				position--;
			}
		} else {
			scan=tail;
			position=fields.size()-position-1;
			while (position>0 && scan!=null) {
				scan=scan.previous;
				position--;
			}			
		}
		return scan!=null ? scan.entry: null;
	}
	
	public Field getFirstField()
	{
		return head!=null ? head.entry :null;
	}

	public Field getLastField()
	{
		return tail!=null ? tail.entry :null;
	}
	
	public int getFieldCount()
	{
		return fields.size();
	}
	

	@Override
	public void addField(Field f, int position) 
	{
		Entry prev=null;
		Entry next=null;
		
		// scan from head to tail, or tail to head, depending on which direction is faster
		
		if (position<fields.size()/2) {
			next=head;
			while (position>0 && next!=null) {
				prev=next;
				next=next.next;
				position--;
			}
		} else {
			prev=tail;
			position=fields.size()-position;
			while (position>0 && prev!=null) {
				next=prev;
				prev=prev.previous;
				position--;
			}			
		}
		addEntry(prev,next,f);
	}

	@Override
	public Field getField(String name) 
	{
		Entry e = fields.get(name.toLowerCase());
		return e==null ? null : e.entry;
	}

	private static class FieldIterator implements Iterator<Field>
	{
		private Entry prev;
		private Entry scan;

		public FieldIterator(Entry start)
		{
			this.scan=start;
		}

		@Override
		public boolean hasNext() {
			return scan!=null;
		}

		@Override
		public Field next() {
			prev=scan;
			scan=scan.next;
			return prev.entry;
		}

		@Override
		public void remove() {
		}
	}
	
	@Override
	public Iterable<Field> getFields() {
		return new Iterable<Field>() {
			@Override
			public Iterator<Field> iterator() {
				return new FieldIterator(head);
			}
			
		};
	}

	@Override
	public void deleteField(String name) {
		Entry e = fields.remove(name.toLowerCase());
		if (e==null) return;
		
		if (e.previous==null) {
			head=e.next; 
		} else {
			e.previous.next=e.next;
		}
		
		if (e.next==null) {
			tail=e.previous;
		} else {
			e.next.previous=e.previous;
		}
	}

	@Override
	public Field getParentField() {
		return null;
	}
	
	@Override
	public FieldStore getParentStore()
	{
		return null;
	}
}
