package org.jclarion.clarion.appgen.template.at;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;

public class AdditionExecutionState {

	private static class Entry
	{
		private SymbolEntry 	entry;
		private String			newValue;
		private String 			oldValue;
		private boolean			restore;
	}
	
	private AtSourceSession 	session;
	private List<Entry> 		saveState;
	private AtSourceSession 	oldSource;

	public AdditionExecutionState(AtSourceSession session)
	{
		this.session=session;
		this.oldSource = session.getEnvironment().getCurrentSource();
		
		if (oldSource!=session) {
			/*if (oldSource!=null) {
				if (oldSource.getBaseScope()!=oldSource.getScope()) {
					System.err.println("SCOPE CHANGE WITH AUTO from "+oldSource+" to "+session);
					throw new IllegalStateException("EX");
				}
			}*/
			getExecuteState(session);
			init();
		}
		
		session.getEnvironment().setCurrentSource(session);
		
	}
	
	/**
	 * Recursively get state; making surce prepareToExecute is called on ancestors before descendents
	 * @param scan
	 */
	private void getExecuteState(AtSourceSession scan) {
		if (scan==null || scan==oldSource) return;
		getExecuteState(scan.getParent());
		scan.getSource().prepareToExecute(this);
	}

	public void set(String symbol,String value,boolean restore)
	{
		Entry e = new Entry();
		e.entry=session.getEnvironment().getScope().get(symbol);
		if (e.entry==null) {
			throw new IllegalStateException("Could not find symbol: "+symbol);
		}
		e.oldValue=e.entry.getFix();
		e.newValue=value;
		e.restore=restore && e.oldValue!=null;
		if (saveState==null) {
			saveState=new ArrayList<Entry>();
		}
		saveState.add(e);
	}
	
	private void init()
	{
		if (saveState!=null) {
			for (Entry e : saveState) {
				e.entry.list().values().fix(SymbolValue.construct(e.newValue));
			}
		}
	}
	
	public void finish()
	{
		session.getEnvironment().setCurrentSource(oldSource);
		
		if (saveState!=null) {
			for (Entry e : saveState) {
				if (e.restore) {
					e.entry.list().values().fix(SymbolValue.construct(e.oldValue));
				}
			}
		}
	}

}
