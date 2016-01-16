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

import javax.swing.tree.TreeNode;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;

public abstract class AbstractWinTreeNode implements TreeNode
{
    public abstract PropertyObject get();
    
    public final String toString()
    {
        PropertyObject po = get();

        StringBuilder out = new StringBuilder();
        String fullname=po.getClass().getName();
        out.append(fullname.substring(fullname.lastIndexOf('.')+1));
        out.append(" ");
        out.append(po.getProperty(Prop.TEXT).toString().trim());
        out.append(" ");
        out.append(po.getProperty(Prop.USE).toString().trim());
        
        return out.toString();
    }
}
