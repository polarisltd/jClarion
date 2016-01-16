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
package org.jclarion.clarion.control;

import java.awt.Component;
import java.awt.Container;
import java.util.StringTokenizer;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Proplist;
import org.jclarion.clarion.swing.SimpleComboQueue;

public class ComboControl extends AbstractListControl {

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugBaseMetaData(sb);
    }

    public ComboControl setFormat(String format)
    {
        setProperty(Prop.FORMAT,format);
        return this;
    }
    
    public ComboControl setVCR(Integer control)
    {
    	setProperty(Prop.VCR,true);
    	if (control!=null) setProperty(Prop.VCRFEQ,control);
    	return this;
    }
    
    public ComboControl setMark(ClarionObject mark)
    {
    	setProperty(Prop.MARK,mark);
    	return this;
    }
    
    
    public ComboControl setGrid(int color)
    {
    	setProperty(Proplist.GRID,color);
    	return this;
    }

    public ComboControl setVScroll()
    {
        setProperty(Prop.VSCROLL,true);
        return this;
    }

    public ComboControl setFull()
    {
        setProperty(Prop.FULL,true);
        return this;
    }

    public ComboControl setColumn()
    {
        setProperty(Prop.COLUMN,true);
        return this;
    }

    public ComboControl setHVScroll()
    {
        setProperty(Prop.VSCROLL,true);
        setProperty(Prop.HSCROLL,true);
        return this;
    }

    public ComboControl setDrop(int size)
    {
        setProperty(Prop.DROP,size);
        return this;
    }

    public ComboControl setNoBar()
    {
        setProperty(Prop.NOBAR,true);
        return this;
    }
    
    public ComboControl setFrom(ClarionQueue from)
    {
        this.from=from;
        return this;
    }

    public ComboControl setFrom(String from)
    {
    	SimpleComboQueue q = new SimpleComboQueue();
    	StringTokenizer tok = new StringTokenizer(from,"|");
    	while (tok.hasMoreTokens()) {
    		q.item.setValue(tok.nextToken());
    		q.add();
    	}
    	return setFrom(q);
    }
    
    
    @Override
    public boolean isAcceptAllControl() {
        return true;
    }

    @Override
    public boolean validateInput() {
        return true;
    }

    @Override
    public String getIcon(int index) {
        return null;
    }

    @Override
    public ListStyleProperty getListStyle(int index) 
    {
        return null;
    }

    @Override
    public int getCreateType() {
        return Create.COMBO;
    }

    @Override
    public void constructSwingComponent(Container parent) 
    {
        createComboControl(parent,true);
    }

    @Override
    public boolean isTableFocus() {
        return false;
    }

    @Override
    public Component getComponent() {
        return getCombo();
    }
    
    
}
