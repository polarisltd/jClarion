package org.jclarion.clarion.print;

import java.awt.Graphics2D;


public abstract class CustomRender {
	public abstract boolean drawImage(String src,Page p,Graphics2D g2d, int x1, int y1, int width,int height);
}
