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

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JToolBar;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.Create;
//import org.jclarion.clarion.swing.ClarionLayoutManager;
import org.jclarion.clarion.constants.Prop;

public class ToolbarControl extends AbstractControl 
{
    private List<AbstractControl> controls=new ArrayList<AbstractControl>();

    @Override
    public void addChild(AbstractControl control)
    {
        add(control);
    }

    public void removeChild(AbstractControl control)
    {
        controls.remove(control);
    }
    
    
    public AbstractControl add(AbstractControl child)
    {
        controls.add(child);
        child.setParent(this);
        return this;
    }
    
    public Collection<AbstractControl> getChildren() {
        return controls;
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
        return Create.TOOLBAR;
    }

    private JComponent toolbar;
    
    @Override
    public void clearMetaData() {
        this.toolbar=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"panel",toolbar);
    }
    
    @Override
    public void constructSwingComponent(Container parent) {
    	if (toolbar!=null) return;
    	
    	ClarionObject location = getRawProperty(Prop.DOCK);
    	if (location!=null) {
    		toolbar=new JPanel();
    	} else {
    		toolbar = new JToolBar();
    	}
    	toolbar.setOpaque(true);
    	
    	
    	configureLayout(toolbar);

        Container scan=parent;
        while ( scan!=null ) {
        	if (scan.getLayout() instanceof BorderLayout) {
        		break;
        	}
        	scan=scan.getParent();
        }
        if (scan==null) scan=parent;
        
        if (location==null) {
        	scan.add(toolbar,BorderLayout.NORTH);       
        } else {
        	String s = location.toString().toLowerCase();
        	if (s.equals("north")) {
            	scan.add(toolbar,BorderLayout.NORTH);       
        	} else if (s.equals("east")) {
                scan.add(toolbar,BorderLayout.EAST);       
        	} else if (s.equals("west")) {
                scan.add(toolbar,BorderLayout.WEST);       
        	} else if (s.equals("south")) {
                scan.add(toolbar,BorderLayout.SOUTH);       
            }        		
        }

        for (AbstractControl child : getChildren()) 
        {
            child.constructSwingComponent(toolbar);
        }

        configureFont(toolbar);
        configureColor(toolbar);
        setPositionAndState();
   }

    @Override
    public Component getComponent() {
        return toolbar;
    }
    
    
}
