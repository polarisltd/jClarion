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

    /*
    
    // layer 0 = entry boxes strings etc
    // layer 1 = strings/labels
    // layer 2 = boxes, lines etc
    private int layerCount[]= new int[] { 0,0,0};
    


    public void remove(int index)
    {
        super.remove(index);
        if (index>layerCount[0]+layerCount[1]) {
            layerCount[2]--;
            return;
        }
        if (index>layerCount[0]) {
            layerCount[1]--;
            return;
        }
        layerCount[0]--;
        return;
    }
    
    public void removeAll()
    {
        super.removeAll();
        layerCount[0]=0;
        layerCount[1]=0;
        layerCount[2]=0;
    }
    
    */
    
    @Override
    protected void addImpl(Component comp, Object constraints, int index) 
    {
        int offset=0;
        
        /*
        int layer =0;
        while ( true ) {
            if (comp instanceof javax.swing.JLabel ) 
            {
                layer=1;
                break;
            }

            if (comp instanceof BoxImpl) {
                layer=2;
                break;
            }
        
            if (comp instanceof LineImpl) {
                layer=2;
                break;
            }
        
            if (comp instanceof javax.swing.JPanel ) 
            {
                layer=1;
                break;
            }
            break;
        }
        if (layer>=1) offset+=layerCount[0];
        if (layer>=2) offset+=layerCount[1];
        layerCount[layer]++;
        */
        
        super.addImpl(comp,constraints,offset);
        
    }
}
