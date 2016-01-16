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

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.BoxImpl;
import org.jclarion.clarion.swing.gui.CommandList;

public class BoxControl extends AbstractControl 
{

    public BoxControl setFillColor(int color)
    {
        setProperty(Prop.FILL,color);
        return this;
    }

    public BoxControl setRound()
    {
        setProperty(Prop.ROUND,true);
        return this;
    }
    
    public BoxControl setLineWidth(int width)
    {
        setProperty(Prop.LINEWIDTH,width);
        return this;
    }

    @Override
    public boolean isAcceptAllControl() {
        return false;
    }

    @Override
    public boolean validateInput() {
        return true;
    }

    @Override
    public int getCreateType() {
        return Create.BOX;
    }

    private BoxImpl bi;
    
    @Override
    public void clearMetaData() {
        bi=null;
        super.clearMetaData();
    }
    
    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"bi",bi);
    }
    

    @Override
    public void constructSwingComponent(Container parent) 
    {
        bi = new BoxImpl(this);
        setPositionAndState();
        parent.add(bi);
    }

    @Override
    public Component getComponent() {
        return bi;
    }
    
    @Override
	public CommandList getCommandList() {
    	return super.getCommandList()
    		.add("REPAINT",REPAINT)
    	;
    }
    
    public static final int REPAINT=100;

    @Override
	public Object command(int command, Object... params) {
    	switch(command) {
    		case REPAINT: {
                BoxImpl box = bi;
                if (box!=null) {
                    box.getInfo();
                    box.repaint();
                }
    			return null;
    		}
    	}
		return super.command(command, params);
	}

	@Override
    protected void doNotifyLocalChange(int indx,final ClarionObject value) 
    {
        super.doNotifyLocalChange(indx, value);
        if (indx==Prop.BACKGROUND || indx==Prop.FILL) {
            CWinImpl.run(this,REPAINT); 
        }
    }

    
    
}
