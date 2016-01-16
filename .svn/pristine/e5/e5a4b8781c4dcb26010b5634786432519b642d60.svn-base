package org.jclarion.clarion.ide.model.app;

import org.jclarion.clarion.appgen.app.App;

public class ProcedureNameSave extends AbstractListenerContainer<ProcedureSaveListener>
{
	public static ProcedureNameSave get(App base,String name)
	{
		name="procedureNameSaveListeners."+(name.toLowerCase());
		ProcedureNameSave ps = (ProcedureNameSave)base.meta().getObject(name);
		if (ps==null) {
			synchronized(base.meta()) {
				ps = (ProcedureNameSave)base.meta().getObject(name);
				if (ps==null) {
					ps=new ProcedureNameSave();
					base.meta().setObject(name,ps);
				}
			}
		}
		return ps;
	}	
}
