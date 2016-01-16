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

import javax.swing.JPanel;

public class ClarionContentPane extends JPanel 
{
    public ClarionContentPane()
    {
    }
    
    /**
     * 
     */
    private static final long serialVersionUID = 8296617904233402996L;

    @Override
    public boolean isOptimizedDrawingEnabled() {
        return false;
    }   

    @Override
    protected void addImpl(Component comp, Object constraints, int index) 
    {
        int offset=0;
        super.addImpl(comp,constraints,offset);
    }
}
