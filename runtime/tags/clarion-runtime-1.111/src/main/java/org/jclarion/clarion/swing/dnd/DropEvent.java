package org.jclarion.clarion.swing.dnd;

import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.swing.gui.RemoteTypes;

public class DropEvent extends ClarionEvent
{
	private AbstractControl src;
	private AbstractControl target;
	private String data;

	@Override
	public Object[] getMetaData() {
		return new Object[] { super.getMetaData(),src,target,data };
	}

	@Override
	public int getType() {
		return RemoteTypes.SEM_DROP_EVENT;
	}

	@Override
	public void setMetaData(Object[] o) {
		super.setMetaData((Object[])o[0]);
		src=(AbstractControl)o[1];
		target=(AbstractControl)o[2];
		data=(String)o[3];
	}

	public DropEvent()
	{
	}
	
	public DropEvent(AbstractControl src,AbstractControl target,String data) {
		super(Event.DROP,target,true);
		this.src=src;
		this.target=target;
		this.data=data;
	}	
	
	public String getData()
	{
		return data;
	}
	
	public AbstractControl getSource()
	{
		return src;
	}
	
	public AbstractControl getTarget()
	{
		return target;
	}
}
