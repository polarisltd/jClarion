package org.jclarion.clarion.appgen.symbol;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

import org.jclarion.clarion.appgen.symbol.user.SymbolFixKey;
import org.jclarion.clarion.appgen.template.cmd.Widget;


/**
 *  A symbol entry represents an entry from a scope.
 *  
 *  These objects can be cached in different scopes. For example to save walking down scope tree every lookup, the topmost tree can cache 
 *  results from deeper scopes. 
 *  
 * @author barney
 *
 */
public abstract class SymbolEntry 
{
	public static SymbolEntry create(String name,String type,ValueType valueType,SymbolStore store)
	{
		if (valueType==ValueType.scalar) {
			return new ScalarSymbolEntry(name,type,store);
		}
		return new MultiSymbolEntry(name,type,valueType,store);
	}
		
	private String 							name;
	private String 							type;
	private SymbolStore 					store;

	//private HashSet<SymbolEntry>			dependents=new HashSet<SymbolEntry>();
	
	public SymbolEntry(String name,String type,SymbolStore store)
	{
		this.name=name;
		this.type=type;
		this.store=store;
		/*for (SymbolEntry se : store.getDependencies()) {
			se.addDependent(this);
		}*/
	}

	public abstract ValueType getValueType();

	/*
	public void addDependent(SymbolEntry entry)
	{
		dependents.add(entry);
	}
	*/

	/*
	public void removeDependent(SymbolEntry entry)
	{
		dependents.remove(entry);
	}
	
	public Iterable<SymbolEntry> getDependents()
	{
		return dependents;
	}
	*/
	
	public void dispose()
	{
		/*
		for (SymbolEntry se : store.getDependencies()) {
			se.removeDependent(this);
		}
		*/
	}
	
	
	public SymbolStore getStore()
	{
		return store;
	}
	
	public String getName()
	{
		return name;
	}

	public String getType()
	{
		return type;
	}
	
	private Widget widget;
	
	public Widget getWidget()
	{
		return widget;
	}
	
	public void setWidget(Widget widget)
	{
		this.widget=widget;
	}
	
	public abstract SymbolValue getAny();
	public abstract SymbolValue getValue();
	public abstract SymbolEntry clone(SymbolStore clonedStore);
	
	public abstract ScalarSymbolEntry scalar();
	public abstract MultiSymbolEntry list();
	public abstract void clear();
	
	private LinkedList<DependentListener> listeners=new LinkedList<DependentListener>();
	
	public boolean hasDependents()
	{
		return listeners!=null;
	}
	
	public void addDependentListener(DependentListener target)
	{
		listeners.add(target);
	}
	
	public void removeDependentListener(DependentListener target)
	{
		listeners.removeLastOccurrence(target);
	}
	
	private int fixChangeCounter=1;
	
	public int getFixCounter()
	{
		return fixChangeCounter;
	}
	
	public void alertDependentsOfFixChange()
	{
		fixChangeCounter++;
		
		/*
		 * for (DependentListener di : listeners ) {
			di.alertFixChange(this);
		}*/
	}

	public void alertDependentsOfPurge()
	{
		for (DependentListener di : listeners ) {
			di.alertPurge(this);
		}
	}
	
	public void alertListenersOfValueChange(String from,String to) 
	{
		for (DependentListener di : listeners ) {
			di.alertValueChange(this,from,to);
		}
	}

	public String getFix()
	{
		SymbolValue sv = getValue();
		if (sv!=null) {
			return sv.getString();
		}
		return null;
	}
	
	
	public Iterable<SymbolEntry> getDependencies()
	{
		return store.getDependencies();
	}
	
	
	public SymbolFixKey snapshotDependencies()
	{
		List<String> values=new ArrayList<String>();
		for (SymbolEntry se : getDependencies()) {
			values.add(se.getFix()==null ? "null" : se.getFix());
		}
		return new SymbolFixKey(values.toArray(new String[values.size()]));
	}

	
	private class ValueIterator implements Iterator<SymbolValue>
	{
		Stack<Iterator<SymbolValue>> stack=new Stack<Iterator<SymbolValue>>();
		SymbolValue next=null;
		
		public ValueIterator()
		{
			stack.push(store.getAllPossibleValues().iterator());
		}

		@Override
		public boolean hasNext() {
			while (next==null) {
				if (stack.isEmpty()) return false;
				if (!stack.peek().hasNext()) {
					stack.pop();
					continue;
				}
				next = stack.peek().next();
				if (next instanceof ListSymbolValue) {
					stack.push( ((ListSymbolValue)next).iterator() );
					next=null;
				}
			}
			return true;
		}

		@Override
		public SymbolValue next() {
			if (!hasNext()) throw new IllegalStateException("Iterator Exhausted");
			SymbolValue ret = next;
			next=null;
			return ret;
		}

		@Override
		public void remove() {
		}		
	}
	
	public Iterable<SymbolValue> getAllPossibleValues() {
		return new Iterable<SymbolValue>() {
			@Override
			public Iterator<SymbolValue> iterator() {
				return new ValueIterator();
			}
		};
	}
	
}
	
	
