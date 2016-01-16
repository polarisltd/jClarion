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
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JToggleButton;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionBorder;
import org.jclarion.clarion.swing.ClarionLayoutManager;

public class OptionControl extends AbstractControl implements SimpleMnemonicAllowed  {

    private List<RadioControl> controls=new ArrayList<RadioControl>();
    
    @Override
    public void addChild(AbstractControl control)
    {
        add((RadioControl)control);
    }
    
    public void add(RadioControl control)
    {
        controls.add(control);
        control.setParent(this);
        if (control.getValue()==null) control.setValue(String.valueOf(controls.size()));
    }
    
    public Collection<RadioControl> getChildren()
    {
        return controls;
    }

    public Collection<RadioControl> getRadioButtons() {
        return controls;
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
    public int getCreateType() {
        return Create.OPTION;
    }
    

    private JPanel panel;
    

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
    public void opened()
    {
        if (getUseObject() == null) {
            use(new ClarionString());
        }    	
        int count = 0;
        for (final RadioControl rc : getRadioButtons()) {
            count++;
            if (rc.getRawProperty(Prop.VALUE) == null) rc.setValue(String.valueOf(count));
        }
        super.opened();
    }
    
    @Override
    public void constructSwingComponent(Container parent) {
        panel = new JPanel();
        panel.setOpaque(false);
        panel.setLayout(new ClarionLayoutManager());
        parent.add(panel);
        panel.setBorder(new ClarionBorder(this, -1, 1, true));

        KeyListener radioKey = new KeyListener() {

            @Override
            public void keyPressed(KeyEvent e) {

                int dir = 0;

                if (e.getKeyCode() == KeyEvent.VK_DOWN
                        || e.getKeyCode() == KeyEvent.VK_RIGHT) {
                    dir = 1;
                }

                if (e.getKeyCode() == KeyEvent.VK_UP
                        || e.getKeyCode() == KeyEvent.VK_LEFT) {
                    dir = -1;
                }

                if (dir == 0)
                    return;

                JComponent _r = (JComponent) e.getComponent();
                RadioControl r = (RadioControl) _r.getClientProperty("clarion");

                OptionControl g = (OptionControl) r.getParent();
                Collection<RadioControl> _c = g.getChildren();
                RadioControl c[] = new RadioControl[_c.size()];
                _c.toArray(c);

                // Container g = r.getParent();
                // Component c[] = g.getComponents();

                int scan = 0;
                while (scan < c.length) {
                    if (c[scan] == r) {
                        break;
                    }
                    scan++;
                }
                if (scan == c.length) return;

                for (int nxt = 1; nxt < c.length; nxt++) {
                    int test = (c.length + nxt * dir + scan) % c.length;
                    if (!c[test].getComponent().isEnabled()) continue;
                    if (!c[test].getComponent().isVisible()) continue;

                    RadioControl rc = c[test];
                    rc.doClickOnFocus();
                    c[test].getComponent().requestFocusInWindow();
                    return;
                }
            }

            @Override
            public void keyReleased(KeyEvent e) {
            }

            @Override
            public void keyTyped(KeyEvent e) {
            }
        };

        for (final RadioControl rc : getRadioButtons()) {
            rc.constructSwingComponent(parent);
            rc.getButton().addKeyListener(radioKey);
        }

        configureFont(panel);
        configureColor(panel);
        setPositionAndState();

    }

    protected JToggleButton getToggleButton() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public ClarionObject getLocalProperty(int index) {
        
        if (index == Prop.SELSTART) 
        {
            int count = 0;
            for (RadioControl rc : getRadioButtons()) {
                count++;
                if (getUseObject().compareTo(rc.getValue()) == 0) {
                    return new ClarionNumber(count);
                }
            }
        }
        return super.getLocalProperty(index);
    }

    public static final int SELECT_RADIO=200;
    

    @Override
	public Object command(int command, Object... params) {
    	if (command==ACCEPT) {
    		getUseObject().setValue(params[0]);
    		if ((Boolean)params[1]) {
                post(Event.ACCEPTED);
            }    		
    		return null;
    	}
    	if (command==SELECT_RADIO) {
            RadioControl rc = (RadioControl)params[0];
            rc.setForcedRadioSelect();
            rc.getButton().doClick();
    		return null;
    	}
		return super.command(command, params);
	}

	@Override
    protected void doNotifyLocalChange(int indx, ClarionObject value) {
        
        if (indx==Prop.SELSTART) {            
            int ofs = value.intValue();
            if (ofs<1 || ofs > getChildren().size()) return;
            final RadioControl rc = controls.get(ofs-1);            
            CWinImpl.run(this,SELECT_RADIO,rc);
        }
        
        super.doNotifyLocalChange(indx, value);
    }

    @Override
    public Component getComponent() {
        return panel;
    }
}
