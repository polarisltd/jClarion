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
package org.jclarion.clarion.swing;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.AbstractButton;
import javax.swing.border.Border;

public class FlatBorder implements Border 
{
    private Border          real;
    //private AbstractButton  button;
    private boolean         focus;
    private boolean         over;
    
    public static void init(AbstractButton button)
    {
        Border b = button.getBorder();
        button.setBorder(new FlatBorder(button,b));
    }
    
    public FlatBorder(AbstractButton button,Border real)
    {
        this.real=real;
        
        button.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
                focus=true;
            }

            @Override
            public void focusLost(FocusEvent e) {
                focus=false;
            }} );
        
        button.addMouseListener(new MouseListener() {

            @Override
            public void mouseClicked(MouseEvent e) {
            }

            @Override
            public void mouseEntered(MouseEvent e) {
                over=true;
            }

            @Override
            public void mouseExited(MouseEvent e) {
                over=false;
            }

            @Override
            public void mousePressed(MouseEvent e) {
            }

            @Override
            public void mouseReleased(MouseEvent e) {
            } } );
        
    }
    
    @Override
    public Insets getBorderInsets(Component c) {
        return real.getBorderInsets(c);
    }

    @Override
    public boolean isBorderOpaque() {
        return false;
    }

    @Override
    public void paintBorder(Component c, Graphics g, int x, int y, int width,
            int height) 
    {
        if (over || focus) {
            real.paintBorder(c,g,x,y,width,height);
        }
    }
}
