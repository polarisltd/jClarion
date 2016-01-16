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
package org.jclarion.clarion.swing.winedit;

import java.util.Enumeration;
import java.util.Iterator;

import javax.swing.tree.TreeNode;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;

public class WindowTreeNode extends AbstractWinTreeNode 
{
    private AbstractWindowTarget target;

    public WindowTreeNode (AbstractWindowTarget target)
    {
        this.target=target;
    }

    @SuppressWarnings("unchecked")
    @Override
    public Enumeration children() {
        
        final Iterator<AbstractControl> scan = target.getControls().iterator();
        final TreeNode parent=this;
        
        return new Enumeration() {
            
            @Override
            public boolean hasMoreElements() {
                return scan.hasNext();
            }

            @Override
            public Object nextElement() {
                return new ControlTreeNode(parent,scan.next());
            }
        };
    }

    @Override
    public boolean getAllowsChildren() {
        return true;
    }

    @Override
    public TreeNode getChildAt(int childIndex) 
    {
        int count=0;
        for ( AbstractControl scan  : target.getControls() ) {
            if (count==childIndex) {
                return new ControlTreeNode(this,scan);
            }
            count++;
        }
        return null;
    }

    @Override
    public int getChildCount() {
        return target.getControls().size();
    }

    @Override
    public int getIndex(TreeNode node) {
        int count=0;
        AbstractControl control = ((ControlTreeNode)node).getControl();
        for ( AbstractControl scan  : target.getControls() ) {
            if (scan==control) {
                return count;
            }
            count++;
        }
        return -1;
    }

    @Override
    public TreeNode getParent() {
        return null;
    }

    @Override
    public boolean isLeaf() {
        return false;
    }
    
    @Override
    public PropertyObject get() {
        return target;
    }
    
    public int hashCode()
    {
        return 0;
    }
    
    public boolean equals(Object o)
    {
        if (o==null) return false; 
        return ((o instanceof WindowTreeNode) && ((WindowTreeNode)o).target==this.target);
    }
    
}
