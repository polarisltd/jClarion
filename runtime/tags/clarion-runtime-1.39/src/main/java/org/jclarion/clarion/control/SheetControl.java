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
import java.awt.KeyboardFocusManager;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.swing.JPanel;
import javax.swing.JToggleButton;

import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.swing.ClarionBorder;
import org.jclarion.clarion.swing.SwingAccept;
import org.jclarion.clarion.swing.SwingTask;
import org.jclarion.clarion.swing.TabLayout;

public class SheetControl extends AbstractControl 
{
    public SheetControl setNoSheet()
    {
        setProperty(Prop.NOSHEET,true);
        return this;
    }

    public SheetControl setWizard()
    {
        setProperty(Prop.WIZARD,true);
        return this;
    }

    public SheetControl setSpread()
    {
        setProperty(Prop.SPREAD,true);
        return this;
    }

    private List<TabControl> tabs = new ArrayList<TabControl>();
    
    public void add(TabControl control)
    {
        tabs.add(control);
        control.setParent(this);
    }
    
    public Collection<TabControl> getTabs()
    {
        return tabs;
    }

    @Override
    public Collection<TabControl> getChildren() {
        return getTabs();
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
        return Create.SHEET;
    }

    private class ChangeListener implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(ClarionMemoryModel model) {

            int val = getUseObject().intValue();
            if (val < 1 || val > getTabs().size()) return;

            if (val==selection) return;

            // bit dodgy ! - use TabControl!
            Component c[] = pane.getComponents();
            for (int scan = 0; scan < c.length; scan++) {
                JToggleButton b = (JToggleButton) c[scan];
                if (scan == val - 1) {
                    b.setSelected(true);
                    //b.setContentAreaFilled(true);
                    //b.setBorderPainted(false);
                } else {
                    b.setSelected(false);
                    //b.setContentAreaFilled(false);
                    //b.setBorderPainted(true);
                }
            }

            selection=val;
            toggleMode(getMode(Prop.HIDE), Prop.HIDE);
        }
    }
    
    private JPanel          pane;
    private ChangeListener  listener;
    private int             selection=-1;
    private int             changing=-1;
    private boolean         forcedUpdate;
    
    @Override
    public void clearMetaData() {
        this.pane=null;
        this.listener=null;
        this.selection=-1;
        this.changing=-1;
        this.forcedUpdate=false;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"pane",pane);
        debugMetaData(sb,"listener",listener);
        debugMetaData(sb,"selection",selection);
        debugMetaData(sb,"changing",changing);
        debugMetaData(sb,"forcedUpdate",forcedUpdate);
    }

    public void constructTab(TabControl control)
    {
        boolean wizard = isProperty(Prop.WIZARD);
        
        int count=0;
        for ( TabControl test : tabs ) {
            if (!test.canConstruct()) continue;
            count++;
            if (test==control) {
                break;
            }
        }
        
        if (!wizard) {
            control.initButton(pane,count);
        }

        for (AbstractControl tc : ((AbstractControl) control).getChildren()) 
        {
            if (!tc.canConstruct()) continue;
            tc.constructSwingComponent(getWindowOwner().getContentPane());
        }
    }

    @Override
    public void constructSwingComponent(Container parent) {
        pane = new JPanel();
        boolean wizard = isProperty(Prop.WIZARD);
        if (!wizard) {
            setProperty(Prop.BOXED, true);
        }
        pane.setLayout(new TabLayout(isProperty(Prop.SPREAD)));
        //pane.setLayout(new TabLayout(true));
        parent.add(pane);
        pane.setOpaque(false);
        pane.setBorder(new ClarionBorder(this, 1, 1, false));

        int count = 0;
        for (final TabControl tab : getTabs()) {
            count++;
            if (!wizard) {
                tab.initButton(pane,count);
            }

            for (AbstractControl tc : ((AbstractControl) tab).getChildren()) 
            {
                tc.constructSwingComponent(parent);
            }
        }

        int init = 1;

        if (getUseObject() != null) {
            init = getUseObject().intValue();
            if (init < 1) init = 1;
            if (init > getTabs().size()) init = getTabs().size();
            getUseObject().setValue(init);

            listener=new ChangeListener();
            getUseObject().addChangeListener(listener);
        }

        selection=init;
        setProperty(Prop.SELSTART, init);

        configureFont(pane);
        configureColor(pane);
        setPositionAndState();
        toggleMode(getMode(Prop.HIDE), Prop.HIDE);
    }

    @Override
    public ClarionObject getLocalProperty(int index) {
        if (index == Prop.SELSTART) {
            if (changing>-1) return new ClarionNumber(changing);
            if (selection>-1) return new ClarionNumber(selection);
        }
        return super.getLocalProperty(index);
    }

    private SheetControl getUs()
    {
        return this;
    }
    
    private class ChangeTabTask implements Runnable
    {
        private ClarionEvent ev;
        private int          val;
        private Runnable     nextTask=null;
        
        public ChangeTabTask(ClarionEvent ev,int val,Runnable nextTask)
        {
            this.ev=ev;
            this.val=val;
            this.nextTask=nextTask;
        }

        @Override
        public void run() 
        {
            if (!ev.getConsumeResult()) {
                changing=-1;
                forcedUpdate=false;
                return;
            }
            
            JPanel pane = getUs().pane;
            if (pane==null) return;
            
            try {
                // dodgy!
                Component c[] = pane.getComponents();
                    for (int scan = 0; scan < c.length; scan++) {
                        JToggleButton b = (JToggleButton) c[scan];
                        if (scan == val - 1) {
                            b.setSelected(true);
                            //b.setContentAreaFilled(true);
                            //b.setBorderPainted(false);
                        } else {
                            b.setSelected(false);
                            //b.setContentAreaFilled(false);
                            //b.setBorderPainted(true);
                        }
                    }

                    selection=val;

                    KeyboardFocusManager.getCurrentKeyboardFocusManager()
                        .clearGlobalFocusOwner();
                    toggleMode(getMode(Prop.HIDE),Prop.HIDE);

                    if (getUseObject() != null) {
                        getUseObject().setValue(val);
                    }

                    post(Event.NEWSELECTION);

                    if (!forcedUpdate) {
                        Container base = pane.getFocusCycleRootAncestor();
                        Component nc = base.getFocusTraversalPolicy()
                            .getComponentAfter(base, pane);                 
                        if (nc != null) {
                            nc.requestFocusInWindow();
                        }
                    }
            } finally {
                changing=-1;
                forcedUpdate=false;
                if (nextTask!=null) nextTask.run();
            }
        }
    }

    public void changeValue(int val,Runnable nextTask)
    {
        if (val < 1) return;
        if (val > getTabs().size()) return;
        if (val==selection) return;

        AbstractControl focus = getWindowOwner().getCurrentFocus();
        if (focus != null) {
            SwingAccept accept = focus.getAccept();
            if (accept != null) {
                if (!accept.accept(false)) return;
            }
        }
       
        changing=val;
        ClarionEvent ce = post(Event.TABCHANGING);
        Runnable ctt = new SwingTask(new ChangeTabTask(ce,val,nextTask));
        if (ce.runOnConsumedResult(ctt)!=null) ctt.run();
    }
    
    @Override
    protected void notifyLocalChange(int indx,final ClarionObject value) 
    {
        if (indx == Prop.SELSTART && pane!=null) {
            changeValue(value.intValue(),null);
        }
        super.notifyLocalChange(indx, value);
    }

    public void forceUpdate() {
        forcedUpdate=true;
    }

    public TabControl getSelectedTab()
    {
        if (selection<=0) return null;
        return tabs.get(selection-1);
    }

    @Override
    public Component getComponent() {
        return pane;
    }

    @Override
    public void addChild(AbstractControl control) {
        add((TabControl)control);
    }
    
}
