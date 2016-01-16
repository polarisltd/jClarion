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

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.PropertyObjectListener;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.runtime.CWin;

public class BoxImpl extends Box implements ClarionCanvas
{
    /**
     * 
     */
    private static final long serialVersionUID = -1278925434206770718L;
    
    private BoxControl control;
    
    private Color background;
    private Color border;
    
    public BoxImpl(BoxControl control)
    {
        super(BoxLayout.X_AXIS);
        this.control=control;
        getInfo();
        
        control.addListener(new PropertyObjectListener() {

            @Override
            public Object getProperty(PropertyObject owner, int property) {
                return null;
            }

            @Override
            public void propertyChanged(PropertyObject owner, int property,
                    ClarionObject value) {
//                repaint();
            } 
        } );
    }

    public void getInfo()
    {
        background=CWin.getInstance().getColor(control,Prop.FILL);
        setOpaque(background!=null);
        border=CWin.getInstance().getColor(control,Prop.COLOR);
        if (border==null) border=Color.black;
    }

    @Override
    protected void paintComponent(Graphics g) {
        if (background!=null) {
          g.setColor(background);
          g.fillRect(0,0,getWidth(),getHeight());
      }
      if (border!=null) {
          g.setColor(border);
          g.drawRect(0,0,getWidth()-1,getHeight()-1);
      }
    }
}
