package org.jclarion.clarion.ide.model;

import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.model.app.AbstractListenerContainer;

public class DirtyProcedureMonitor {
	
	public static DirtyProcedureMonitor get(Procedure proc)
	{
		DirtyProcedureMonitor d = (DirtyProcedureMonitor)proc.meta().getObject("DirtyProcedureMonitor");
		if (d==null) {
			d=new DirtyProcedureMonitor();
			proc.meta().setObject("DirtyProcedureMonitor",d);
		}
		return d;
	}
	
	public static void fire(Procedure proc)
	{
		DirtyProcedureMonitor d = (DirtyProcedureMonitor)proc.meta().getObject("DirtyProcedureMonitor");
		if (d==null) return;
		for (DirtyProcedureListener scan : d.listeners) {
			scan.procedureChanged();
		}
	}
	
	private AbstractListenerContainer<DirtyProcedureListener> listeners=new AbstractListenerContainer<DirtyProcedureListener>(); 
	
	private DirtyProcedureMonitor()
	{
	}
	
	public void addListener(DirtyProcedureListener listener)
	{
		listeners.add(listener);
	}

	public void removeListener(DirtyProcedureListener listener)
	{
		listeners.remove(listener);
	}
}
