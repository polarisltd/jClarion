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


import java.awt.Color;
import java.awt.Graphics;

import javax.swing.Box;
import javax.swing.BoxLayout;

public class ShadowCanvas extends Box
{
    private static final Color shadowColor = new Color(192,192,200,192);
    
    public ShadowCanvas() 
    {
        super(BoxLayout.X_AXIS);
    }

    private static final long serialVersionUID = -8465737896131279441L;

    @Override
    protected void paintComponent(Graphics g) 
    {
        g.setColor(shadowColor);
        g.fillRect(0,0,getWidth(),getHeight());
    }
}
