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
package org.jclarion.clarion;


public interface ClarionQueueReader {

    public abstract boolean hasChildren(int row,int pos);
    
    public abstract boolean[] getSiblingTree(int row,int pos);

    public abstract void toggle(int record, int column);
    
    public abstract void removeListener(ClarionQueueListener cmcl);
    
    public abstract void addListener(ClarionQueueListener cmcl);
    
    public abstract ClarionObject[] getRecord(int pos);
    
    public abstract ClarionObject getValueAt(int row,int column);
    //public abstract void setValueAt(int row,int column,ClarionObject value);
    public abstract int getQueueRow(int row);
    public abstract int getQueueColumn(int col);
    
    public abstract int records();

    public abstract int convertQueueIndexToScreenIndex(int v);

    public abstract int convertScreenIndexToQueueIndex(int v);

}
