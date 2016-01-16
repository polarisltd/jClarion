package org.jclarion.clarion.runtime;

import javax.swing.AbstractButton;
import javax.swing.ImageIcon;

public class SwingButtonIconReceiver extends SwingIconReceiver 
{

	private AbstractButton button;

	public SwingButtonIconReceiver(AbstractButton button)
	{
		super(true);
		this.button=button;
	}
	
	@Override
	public void setSwingIcon(ImageIcon ic) {
		button.setIcon(ic);
	}

}
