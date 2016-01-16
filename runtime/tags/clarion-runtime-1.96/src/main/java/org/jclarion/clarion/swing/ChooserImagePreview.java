package org.jclarion.clarion.swing;

import javax.swing.*;

import org.jclarion.clarion.runtime.CWin;

import java.beans.*;
import java.awt.*;
import java.io.File;

public class ChooserImagePreview extends JComponent implements PropertyChangeListener 
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -4699899544832482057L;
		ImageIcon thumbnail = null;
	    File file = null;

	public ChooserImagePreview(JFileChooser fc) {
		setPreferredSize(new Dimension(200, 100));
		fc.addPropertyChangeListener(this);
	}

	public void loadImage() {
		if (file == null) {
			thumbnail = null;
			return;
		}

		// Don't use createImageIcon (which is a wrapper for getResource)
		// because the image we're trying to load is probably not one
		// of this program's own resources.
		
		
        Image i = CWin.getInstance().getImage(file.getPath(),200,100,false);
        if (i!=null) thumbnail=new ImageIcon(i);
	}

	public void propertyChange(PropertyChangeEvent e) {
		boolean update = false;
		String prop = e.getPropertyName();

		// If the directory changed, don't show an image.
		if (JFileChooser.DIRECTORY_CHANGED_PROPERTY.equals(prop)) {
			file = null;
			update = true;

			// If a file became selected, find out which one.
		} else if (JFileChooser.SELECTED_FILE_CHANGED_PROPERTY.equals(prop)) {
			file = (File) e.getNewValue();
			update = true;
		}

		// Update the preview accordingly.
		if (update) {
			thumbnail = null;
			if (isShowing()) {
				loadImage();
				repaint();
			}
		}
	}

	protected void paintComponent(Graphics g) {
		if (thumbnail == null) {
			loadImage();
		}

		int width=0;
		int height=0;
		
		if (thumbnail != null) {
			width=thumbnail.getIconWidth();
			height=thumbnail.getIconHeight();
			
			if (width>180) {
				height=height*180/width;
				width=180;
			}
		}
			
		int x = getWidth() / 2 - width / 2;
		int y = getHeight() / 2 - height / 2;

		if (y < 0) {
			y = 0;
		}

		if (x < 5) {
			x = 5;
		}
		
		if (thumbnail != null) {
			Graphics2D g2d = (Graphics2D)g;
			g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION,RenderingHints.VALUE_INTERPOLATION_BILINEAR);
			g.drawImage(thumbnail.getImage(),x,y,x+width,y+height,0,0,thumbnail.getIconWidth(),thumbnail.getIconHeight(),this);
		}
		
		String preview="Image Preview";
		
		g.drawString(preview,(getWidth()-g.getFontMetrics().stringWidth(preview))/2,y+height+g.getFontMetrics().getAscent());
	}
}
