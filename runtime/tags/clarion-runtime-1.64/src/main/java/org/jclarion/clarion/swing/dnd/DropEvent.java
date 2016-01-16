package org.jclarion.clarion.swing.dnd;

import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.control.AbstractControl;

public class DropEvent extends ClarionEvent
{
	private AbstractControl src;
	private AbstractControl target;
	private String data;

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
