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

import java.beans.PropertyChangeEvent;
import java.beans.PropertyVetoException;
import java.beans.VetoableChangeListener;

import javax.swing.JComponent;
import javax.swing.JInternalFrame;

public class FramePropertyListener implements VetoableChangeListener
{
    private static FramePropertyListener instance=new FramePropertyListener();
    
    public static FramePropertyListener getInstance()
    {
        return instance;
    }
    
    @Override
    public void vetoableChange(PropertyChangeEvent evt) throws PropertyVetoException 
    {
        if (evt.getPropertyName().equals(JInternalFrame.IS_SELECTED_PROPERTY) && evt.getNewValue()==Boolean.TRUE) 
        {
            if (evt.getSource() instanceof JComponent) {
                if (((JComponent)evt.getSource()).getClientProperty("shadow")!=null) {             
                    throw new PropertyVetoException("Not allowed",evt);
                }
            }
        }
    }
}
