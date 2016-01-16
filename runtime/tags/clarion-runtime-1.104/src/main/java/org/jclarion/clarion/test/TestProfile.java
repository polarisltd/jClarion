package org.jclarion.clarion.test;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.gui.RemoteWidget;

public class TestProfile 
{
	private String name;

	public TestProfile(String name)
	{
		this.name=name;
	}
	
	public boolean isLogWorthy(RemoteWidget w,int command,Object... params)
	{
		if (w==null) return true;
		if (w instanceof CWinImpl) {
			switch(command) {
				case CWinImpl.DISPOSE:
					return false;
			}
			return true;
		}
		if (w instanceof AbstractControl) {
			switch(command) {
				case AbstractControl.ACTUAL_SIZE_NOTIFY:
					return false;
				case AbstractControl.NOTIFY_AWT_CHANGE:
					switch((Integer)params[0]) {
						case Prop.XPOS:
						case Prop.YPOS:
						case Prop.WIDTH:
						case Prop.HEIGHT:
						case Prop.FONTSIZE:
							return false;
					}
					return true;
			}
			return true;
		}
		if (w instanceof AbstractWindowTarget) {
			switch(command) {
				case AbstractWindowTarget.NOP:
					return name.equals("gui"); 
				case AbstractWindowTarget.REPAINT:
				case AbstractWindowTarget.SET_DEFAULT_BUTTON:
				case AbstractWindowTarget.PLAYBACK:
					return false;
				case AbstractWindowTarget.POST:
					switch(   ((ClarionEvent)params[0]).getEvent() ) {
						case Event.MOVED:
							return false;
						//case Event.SIZED: sized is important because it affects lists
					}
					return true;
				case AbstractWindowTarget.AWT_CHANGE:
					switch((Integer)params[0]) {
						case Prop.ICON:
						case Prop.XPOS:
						case Prop.YPOS:
						case Prop.WIDTH:
						case Prop.HEIGHT:
						case Prop.MAXIMIZE:
							return false;
					}
					return true;
			}
		}
		return true;
	}	
}
