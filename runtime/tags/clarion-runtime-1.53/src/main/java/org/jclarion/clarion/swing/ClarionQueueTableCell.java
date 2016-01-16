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

import java.awt.event.MouseEvent;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueueReader;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.control.ListColumn;
import org.jclarion.clarion.runtime.format.Formatter;

public class ClarionQueueTableCell 
{
    private ListColumn              column;
    private ClarionObject[]         row;
    private ClarionQueueReader      queue;
    private int                     record;

    public ClarionQueueTableCell(ClarionQueueReader queue,int record,ListColumn column,ClarionObject row[])
    {
        this.column=column;
        this.row=row;
        this.queue=queue;
        this.record=record;
    }
    
    public String toString()
    {
        int pos = column.getFieldNumber()-1;
        if (pos>=row.length || pos<0) return "";
        ClarionObject result=row[pos];
        Formatter p = column.getPicture();
        if (p!=null) {
            return p.format(result.toString()).trim();
        } else {
            return result.toString().trim();
        }
    }

    public ListColumn getColumn() {
        return column;
    }

    public ClarionObject getValue(int offset) {
        int pos = column.getFieldNumber()-1+offset;
        if (pos>=row.length) return new ClarionString("");
        return row[pos];
    }
    
    public boolean hasChildren(int pos)
    {
        return queue.hasChildren(record,column.getFieldNumber()+pos);
    }

    public ClarionObject[] getRow()
    {
        return row;
    }
    
    public boolean[] getSiblingTree(int pos)
    {
        return queue.getSiblingTree(record,column.getFieldNumber()+pos);
    }

    public void handleMouseEvent(MouseEvent e,int x, int y,int width,int height) {

        if (column.isTree()) {
            
            int ofs = 1 + (column.isIcon() | column.isTransparantIcon() ? 1 : 0);
            
            if (hasChildren(ofs) && e.getButton()==1) {
                
                boolean toggle=false;
                if (e.getClickCount()==2) {
                    toggle=true;
                } else {
                    int depth = Math.abs(getValue(ofs).intValue());
                    int dx = x-(depth*10+2);
                    int dy = y-(height/2-4);
                    if (dx>=-1 && dy>=-1 && dx<=9 && dy<=9) {
                        toggle=true;
                    }
                }
                
                if (toggle) {
                    queue.toggle(record,column.getFieldNumber()+ofs);
                }
            }
        }
    }

    public boolean equals(Object o)
    {
        if (o instanceof ClarionQueueTableCell) {
            return ((ClarionQueueTableCell)o).record==this.record;
        }
        return false;
    }

}
