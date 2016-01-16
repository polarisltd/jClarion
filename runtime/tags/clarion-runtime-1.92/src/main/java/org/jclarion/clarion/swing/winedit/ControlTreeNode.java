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

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;

public class ControlTreeNode extends AbstractWinTreeNode
{

    private AbstractControl control;
    private TreeNode        parent;

    public ControlTreeNode(TreeNode parent,AbstractControl control)
    {
        this.parent=parent;
        this.control=control;
    }
    
    public AbstractControl getControl()
    {
        return control;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public Enumeration children() {
        
        final Iterator<? extends AbstractControl> scan = control.getChildren().iterator();
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
        return new ControlTreeNode(this,control.getChild(childIndex));
    }

    @Override
    public int getChildCount() {
        return control.getChildren().size();
    }

    @Override
    public int getIndex(TreeNode node) {
        AbstractControl child = ((ControlTreeNode)node).getControl();
        return control.getChildIndex(child);
    }

    @Override
    public TreeNode getParent() {
        return parent;
    }

    @Override
    public boolean isLeaf() {
        return getChildCount()==0;
    }
    
    @Override
    public PropertyObject get() {
        return control;
    }
    
    public int hashCode()
    {
        return control.getUseID();
    }
    
    public boolean equals(Object o)
    {
        if (o==null) return false; 
        return ((o instanceof ControlTreeNode) && ((ControlTreeNode)o).control==this.control);
    }
    
    
}
