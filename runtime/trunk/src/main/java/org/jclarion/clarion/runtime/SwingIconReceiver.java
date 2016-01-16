package org.jclarion.clarion.runtime;

import java.awt.Image;

import javax.swing.ImageIcon;
import javax.swing.SwingUtilities;

public abstract class SwingIconReceiver implements ImageReceiver
{
	private ImageIcon ic;
	private boolean receiveOnEvent;
	
	public SwingIconReceiver(boolean receiveOnEvent)
	{
		this.receiveOnEvent=receiveOnEvent;
	}
	
	public void init(String name,int prefx,int prefy,boolean usecache)
	{
		CWin.getInstance().getImage(name, prefx, prefy, usecache,this);
	}

	@Override
	public void setImage(Image src) 
	{		
		if (src==null) {
			this.ic=null;
		} else {
			this.ic=new ImageIcon(src);
		}
		if (!receiveOnEvent || SwingUtilities.isEventDispatchThread()) {
			setSwingIcon(ic);
		} else {
			SwingUtilities.invokeLater(new Runnable() {
				@Override
				public void run() {
					setSwingIcon(ic);
				}				
			});
		}
	}
	
	public abstract void setSwingIcon(ImageIcon ic);
}
