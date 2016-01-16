package org.jclarion.clarion.ide.model.app;


import org.jclarion.clarion.appgen.app.Procedure;

public class ProcedureSave extends AbstractListenerContainer<ProcedureSaveListener>
{
	public static ProcedureSave get(Procedure base)
	{
		ProcedureSave ps = (ProcedureSave)base.meta().getObject("procedureSaveListeners");
		if (ps==null) {
			synchronized(base.meta()) {
				ps = (ProcedureSave)base.meta().getObject("procedureSaveListeners");
				if (ps==null) {
					ps=new ProcedureSave();
					base.meta().setObject("procedureSaveListeners",ps);
				}
			}
		}
		return ps;
	}	
}
