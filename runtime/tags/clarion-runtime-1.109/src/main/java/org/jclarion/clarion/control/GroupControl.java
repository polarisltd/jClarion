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
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.SwingUtilities;

import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.swing.ClarionBorder;
import org.jclarion.clarion.swing.ClarionLayoutManager;


public class GroupControl extends AbstractControl 
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
        return Create.GROUP;
    }

    private JComponent base;
    private JComponent panel;
    
    @Override
    public void clearMetaData() {
        this.panel=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"panel",panel);
    }
    
        
    @Override
    public void constructSwingComponent(Container parent) {
    	if (panel!=null) return;
    	
    	
    	if (isProperty(Prop.HSCROLL) || isProperty(Prop.VSCROLL)) {
            panel = new JPanel();
            final JPanel base = new JPanel(new FlowLayout(FlowLayout.LEFT));
            base.add(panel);
    		JScrollPane pane = new JScrollPane(base,
    				isProperty(Prop.VSCROLL) ? JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED : JScrollPane.VERTICAL_SCROLLBAR_NEVER,
    				isProperty(Prop.HSCROLL) ? JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED : JScrollPane.HORIZONTAL_SCROLLBAR_NEVER 
    	    		) { 
						private static final long serialVersionUID = 8827314181300001314L;

				public Dimension getPreferredSize()
    			{
    				Dimension x = getViewport().getPreferredSize();
    				Dimension s = getSize();
    				
    				if (x.height>s.height) { x.width+=getVerticalScrollBar().getWidth(); } 
    				if (x.width>s.width) { x.height+=getHorizontalScrollBar().getHeight(); } 
    				
    				return x;
    			}
    			
    			private int testLayout()
    			{
    				return (this.getHorizontalScrollBar().isVisible() ? 1 : 0) +
    						(this.getVerticalScrollBar().isVisible() ? 2 : 0);
    			}
    			
    			public void doLayout()
    			{
        			int before = testLayout();
        			super.doLayout();
        			if (testLayout()==before) {
        				return;
        			}
        			
        			final JLabel l = new JLabel("");
        			base.add(l);
        			getRootPane().revalidate();
					SwingUtilities.invokeLater(new Runnable() {
						@Override
						public void run() {
							base.remove(l);
		        			getRootPane().revalidate();
						}
					});
    			}
    		};

    		pane.getVerticalScrollBar().setUnitIncrement(20);
    		pane.getHorizontalScrollBar().setUnitIncrement(40);
    		pane.setAlignmentX(0);
    		this.base=pane;
    		base.setOpaque(false);
    		pane.getViewport().setOpaque(false);
    		pane.setViewportBorder(null);
    	} else {
            panel = new JPanel();
    		base=panel;
    	}
        panel.setOpaque(false);
       
        if (configureLayout(panel)) {        	
        	addComponent(parent,base);
        	parent=panel;
        } else {
        	panel.setLayout(new ClarionLayoutManager());
        	addComponent(parent,base);
        }
        
        for (AbstractControl child : getChildren()) 
        {
            child.constructSwingComponent(parent);
        }

        base.setBorder(new ClarionBorder(this, -1, 1, true));
        configureFont(panel);
        configureColor(panel);
        setPositionAndState();
   }

    @Override
    public Component getComponent() {
        return panel;
    }
    
    
}
