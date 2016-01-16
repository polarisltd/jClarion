/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.print;

import java.awt.Color;
import java.awt.Font;
import java.awt.Image;

public abstract class PrintContext 
{

    public abstract void setColor(Color white);

    public abstract void clip(int x1, int y1, int width, int height);

    public abstract void setFont(Font font);

    public abstract int stringWidth(String text);

    public abstract void drawString(String text, int x, int y,boolean transparent);
    
    public abstract void drawImage(Image img,int x,int y,int width,int height);

    public abstract void restoreClip();

    public abstract int getHeight();

    public abstract void drawLine(int x1, int y1, int x2, int y2, int width);

    public abstract void box(int x1, int y1, int width, int height, 
            Color fg, Color bg,int lineWidth,int curve);

    public abstract void translate(int scaleX, int scaleY);
    
    public abstract void restoreTranslation();

    public abstract void start();
    
    public abstract void complete();
}
