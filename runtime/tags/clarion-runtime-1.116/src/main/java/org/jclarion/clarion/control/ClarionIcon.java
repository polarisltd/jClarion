package org.jclarion.clarion.control;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.ImageObserver;

import javax.swing.Icon;
import javax.swing.JLabel;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.ImageReceiver;
import org.jclarion.clarion.swing.WaitingImageObserver;

public abstract class ClarionIcon implements Icon, ClarionIconData, ImageReceiver
{
	private Image 	image;
	private Image 	drawImage;
	private int		width;
	private int		height;
	private int		iwidth;
	private int 	iheight;
	private ImageControl img;
	
	public ClarionIcon(ImageControl img)
	{
		this.img=img;
        String text = img.getProperty(Prop.TEXT).toString();
        if (text.length()>0) {
        	CWin.getInstance().getImage(text,0,0,false,this);
        } else {
            ClarionObject payload = img.getRawProperty(Prop.IMAGEBITS);
            if (payload!=null) {
            	setImage(CWin.getInstance().getImageFromBinaryData(payload));
            }
        }        
	}
	
	

	@Override
	public void setImage(Image src) {
		image=src;
        if (image!=null) {
        	WaitingImageObserver wait = new WaitingImageObserver();
        	iwidth=image.getWidth(wait);
        	if (iwidth==-1) {
        		wait.waitTillDone();
            	iwidth=image.getWidth(wait);
        	}
        	iheight=image.getHeight(wait);
        	if (iheight==-1) {
        		wait.waitTillDone();
            	iheight=image.getHeight(wait);
        	}
        }
        width=iwidth;
        height=iheight;
        drawImage=image;

        ClarionObject mw = img.getRawProperty(Prop.MAXWIDTH,false);
    	ClarionObject mh = img.getRawProperty(Prop.MAXHEIGHT,false);

        if (!img.isProperty(Prop.CENTERED) && (mw==null || mh==null)) {
        	JLabel l = img.getLabel();
        	if (l!=null) {
        		Dimension d  = l.getSize();
        		width=d.width;
        		height=d.height;
        		if (drawImage!=null && width>0 && height>0) {
        			drawImage=drawImage.getScaledInstance(width,height,Image.SCALE_AREA_AVERAGING);
        		}
        	}        	
        } else {
        	if (mw!=null && mh!=null) {
        		int imw = ((AbstractWindowTarget)img.getOwner()).widthDialogToPixels(mw.intValue());
        		int imh = ((AbstractWindowTarget)img.getOwner()).heightDialogToPixels(mh.intValue());
        		if (imw>0 && imh>0) {
        			width=imw;
        			height=imh;
        			drawImage=drawImage.getScaledInstance(imw,imh,Image.SCALE_AREA_AVERAGING);
        		}
        	}
        }
        
        ready();
	}

	public abstract void ready();


	private ImageObserver observer; 
	
	@Override
	public void paintIcon(final Component c, Graphics g, int x, int y) 
	{
		if (observer==null) {
			observer=new ImageObserver() {
				@Override
				public boolean imageUpdate(Image img, int infoflags, int x,int y, int width, int height) {
			        if ((infoflags & (ImageObserver.ALLBITS)) != 0) {
			        	c.repaint();
			        	return false;
			        }
			        return true;
				}
				
			};
		}
		if (drawImage!=null) {
			g.drawImage(drawImage,x,y,observer);
		}
	}

	@Override
	public int getIconWidth() 
	{
		return width;
	}

	@Override
	public int getIconHeight() 
	{
		return height;
	}

	/* (non-Javadoc)
	 * @see org.jclarion.clarion.control.ClarionIconData#getImageWidth()
	 */
	@Override
	public int getImageWidth() 
	{
		return iwidth;
	}

	/* (non-Javadoc)
	 * @see org.jclarion.clarion.control.ClarionIconData#getImageHeight()
	 */
	@Override
	public int getImageHeight() 
	{
		return iheight;
	}
	
	
	/* (non-Javadoc)
	 * @see org.jclarion.clarion.control.ClarionIconData#getImage()
	 */
	@Override
	public Image getImage() {
		return image;
	}
}
