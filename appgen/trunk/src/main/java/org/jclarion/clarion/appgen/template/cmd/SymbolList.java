package org.jclarion.clarion.appgen.template.cmd;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.Set;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;

public class SymbolList {

	
	private SymbolEntry[] 			symbolArray;
	private LinkedList<Integer>		symbolBuffer=new LinkedList<Integer>();
	private LinkedList<SymbolEntry> symbols = new LinkedList<SymbolEntry>();
	private Set<String> symbolNames = new HashSet<String>();
	
	public void add(SymbolEntry se)
	{
		symbolBuffer.add(symbols.size());
		doAdd(se);
	}
	
	private void doAdd(SymbolEntry se) {
		if (symbolNames.contains(se.getName().toLowerCase())) return;
		for (SymbolEntry scan : se.getDependencies()) {
			doAdd(scan);
		}
		symbolNames.add(se.getName().toLowerCase());
		symbols.add(se);
		symbolArray=null;
	}
	
	public void remove()
	{
		int count = symbolBuffer.removeLast();
		
		if (count==0) {
			symbolNames.clear();
			symbols.clear();
		} else {
			while (symbols.size()>count) {
				SymbolEntry se = symbols.removeLast();
				symbolNames.remove(se.getName().toLowerCase());
			}
		}
		symbolArray=null;
	}
	
	public SymbolEntry[] asArray()
	{
		if (symbolArray==null) {
			symbolArray=symbols.toArray(new SymbolEntry[symbols.size()]);
		}
		return symbolArray;
	}

}
