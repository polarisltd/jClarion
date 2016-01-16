package org.jclarion.clarion.swing.dnd;

import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.control.AbstractControl;

public class DragEvent extends ClarionEvent
{
	private AbstractControl src;
	private AbstractControl target;
	private String data;

	public DragEvent(AbstractControl src,AbstractControl target,String data) {
		super(Event.DRAG,src,true);
		this.src=src;
		this.target=target;
		this.data=data;
	}

	@Override
	public void consume(boolean isConsumed) {
		super.consume(isConsumed);
		if (isConsumed) {
			target.getWindowOwner().post(new DropEvent(src,target,data));
		}
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

	public void setData(String id) {
		this.data=id;
	}

}
