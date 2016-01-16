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

import java.awt.Component;
import java.awt.Container;
import java.awt.FocusTraversalPolicy;
import java.awt.Window;
import java.util.Iterator;

import javax.swing.JComponent;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JLayeredPane;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JRadioButton;
import javax.swing.JRootPane;
import javax.swing.JScrollBar;
import javax.swing.JScrollPane;
import javax.swing.JSpinner;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JToggleButton;
import javax.swing.JViewport;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane;
import javax.swing.table.JTableHeader;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.RadioControl;

public class ClarionFocusTraversalPolicy extends FocusTraversalPolicy  
{
    @SuppressWarnings("serial")
    private static class SwingContainerOrderFocusTraversalPolicy
        extends java.awt.ContainerOrderFocusTraversalPolicy
    {
        public boolean accept(Component aComponent) {
            return super.accept(aComponent);
        }
    }
    
    private static final SwingContainerOrderFocusTraversalPolicy
        fitnessTestPolicy = new SwingContainerOrderFocusTraversalPolicy();

    private static class MutableBoolean {
        boolean value = false;    
    }    
    
    private static final MutableBoolean found = new MutableBoolean();

    private static class ContainerIterator implements Iterator<Component>
    {
        private int start;
        private int stop;
        private int step;
        private Container container;
       
        
        private ContainerIterator(Container c,boolean reverse)
        {
            this.container=c;
            if (!reverse) {
                start=0;
                stop=c.getComponentCount();
                step=1;
            } else {
                start=c.getComponentCount()-1;
                stop=-1;
                step=-1;
            }
        }
        
        @Override
        public boolean hasNext() {
            return start!=stop;
        }

        @Override
        public Component next() {
            if (start==stop) throw new IllegalArgumentException("Waa!");
            Component result=container.getComponent(start);
            start+=step;
            return result;
        }

        @Override
        public void remove() {
        }
        
    }
    
    private static class ContainerIterable implements Iterable<Component>
    {
        private Container c;
        private boolean reverse;

        public ContainerIterable(Container c,boolean reverse)
        {
            this.c=c;
            this.reverse=reverse;
        }
        
        @Override
        public Iterator<Component> iterator() {
            return new ContainerIterator(c,reverse);
        }
    }

    private AbstractWindowTarget target;
    
    public ClarionFocusTraversalPolicy()
    {
    }

    public ClarionFocusTraversalPolicy(AbstractWindowTarget target)
    {
        this.target=target;
    }
    
    private Iterable<Component> getOrder(Container c,boolean reverse)
    {
        if (c instanceof ClarionContentPane) reverse=!reverse;
        return new ContainerIterable(c,reverse);
    }

    public boolean accept(Component scan,Component original) {
    	return accept(scan,original,true);
    }

    public boolean accept(Component scan,Component original,boolean obeySkip) {
        if (scan==null) return true;
        
        
        if (!fitnessTestPolicy.accept(scan)) return false;
        if (scan.getClass().getName().startsWith("com.sun")) return false; 
        if (scan instanceof Window) return false;
        if (scan instanceof JRootPane) return false;
        if (scan instanceof JLayeredPane) return false;
        if (scan instanceof JScrollPane) return false;
        if (scan instanceof JViewport) return false;
        if (scan instanceof JSpinner) return false;
        if (scan instanceof JPanel) return false;
        if (scan instanceof JTableHeader) return false;
        if (scan instanceof JScrollBar) return false;
        if (scan instanceof JInternalFrame) return false;
        if (scan instanceof JMenuBar) return false;
        if (scan instanceof JProgressBar) return false;
        if (scan instanceof JMenuItem) return false;
        if (scan instanceof JLabel) return false;
        if (scan instanceof JTabbedPane) return false;
        if (scan instanceof ClarionCanvas) return false;
        if (scan instanceof JRadioButton || scan instanceof RadioControl.FlatButton) {
            
            // rules for traversal of radios are as follows
            
            // sub rules when nothing is selected - standard handling
            
            // sub rules when something is selected -
            //  a) if traversing in then only select the selected item
            //  b) if traversing within then traverse out
            
            RadioControl rc = (RadioControl)((JComponent)scan).getClientProperty("clarion");
            OptionControl oc = (OptionControl)rc.getParent();
            
            boolean selected=false;
            for (AbstractControl c_child : ((AbstractControl)oc).getChildren()) {
                JToggleButton child = (JToggleButton)c_child.getComponent();
                if (child.isSelected() && child.isVisible() && child.isEnabled()) { 
                    selected=true;
                    break;
                }
            }
            
            if (selected) {
                if (original!=null) {
                    if (original instanceof JRadioButton || original instanceof RadioControl.FlatButton) {
                        RadioControl c_original = (RadioControl)((JComponent)original).getClientProperty("clarion");
                        if (oc==c_original.getParent()) {
                        	return false;
                        }
                    }
                }
                if (!((javax.swing.JToggleButton)scan).isSelected()) {
                	return false;
                }
            }
        }
        if (scan instanceof BasicInternalFrameTitlePane) return false;
        
        if (scan instanceof JTable) {
        	if (((JTable)scan).getRowCount()==0) return false; 
        }

        if (scan instanceof JComponent) {
            JComponent jc = (JComponent)scan;
            if (jc.getClientProperty("clarionSkipFocus")!=null && obeySkip) return false;
        }
        return true;
    }
    
    @Override
    public Component getComponentAfter(Container aContainer,
                                       Component aComponent) {
        if (aContainer == null || aComponent == null) {
            throw new IllegalArgumentException("aContainer and aComponent cannot be null");
        }
        if (!aContainer.isFocusTraversalPolicyProvider() && !aContainer.isFocusCycleRoot()) {
            throw new IllegalArgumentException("aContainer should be focus cycle root or focus traversal policy provider");
        } else if (aContainer.isFocusCycleRoot() && !aComponent.isFocusCycleRoot(aContainer)) {
            throw new IllegalArgumentException("aContainer is not a focus cycle root of aComponent");
        }

        synchronized(aContainer.getTreeLock()) {
            found.value = false;
            Component retval = getComponentAfter(aContainer,aComponent,aComponent,found);
            if (retval != null) {
                return retval;
            } else if (found.value) {
                return getFirstComponent(aContainer);
            } else {
                return null;
            }
        }
    }

    private Component getComponentAfter(Container aContainer,
            Component aOriginal,
            Component aComponent,
            MutableBoolean found) 
    {
        if (found.value && !(aContainer.isVisible() && aContainer.isDisplayable())) {
        //if (!(aContainer.isVisible() && aContainer.isDisplayable())) {
            return null;
        }

        if (found.value) {
            if (accept(aContainer,aOriginal)) {            
                return aContainer;
            }
        } else if (aContainer == aComponent) {
            found.value = true;
            if (!(aContainer.isVisible() && aContainer.isDisplayable())) {
                return null;
            }
        }

        for ( Component comp : getOrder(aContainer,false) ) {
            if ((comp instanceof Container) && !((Container)comp).isFocusCycleRoot()) {
                Component retval = null;
                FocusTraversalPolicy policy=null;
                if (((Container)comp).isFocusTraversalPolicyProvider()) {
                    Container cont = (Container) comp;
                    policy = cont.getFocusTraversalPolicy();
                    if (found.value) {
                        retval = policy.getDefaultComponent(cont);
                    } else {
                        found.value = cont.isAncestorOf(aComponent);                    
                        if (found.value)  {
                            if (aComponent == policy.getLastComponent(cont)) {
                                // Reached last component, going to wrap - should switch to next provider
                                retval = null;
                            } else {
                                retval = policy.getComponentAfter(cont, aComponent);
                            }
                        }
                    }
                } else {
                    retval = getComponentAfter((Container)comp,
                         aOriginal,
                         aComponent,
                         found);
                }   
                if (retval != null) {
                    return retval;
                }
            } else if (found.value) {
                if (accept(comp,aOriginal)) {
                    return comp;
                }
            } else if (comp == aComponent) {
                found.value = true;
            }

            if (found.value &&
                    getImplicitDownCycleTraversal() &&
                    (comp instanceof Container) &&
                    ((Container)comp).isFocusCycleRoot())
            {
                Container cont = (Container)comp;
                Component retval = cont.getFocusTraversalPolicy().
                getDefaultComponent(cont);
                if (retval != null) {
                    return retval;
                }
            }
        }

        return null;
    }
    
    @Override
    public Component getComponentBefore(Container aContainer,
                                        Component aComponent) {
        if (aContainer == null || aComponent == null) {
            throw new IllegalArgumentException("aContainer and aComponent cannot be null");
        }
        if (!aContainer.isFocusTraversalPolicyProvider() && !aContainer.isFocusCycleRoot()) {
            throw new IllegalArgumentException("aContainer should be focus cycle root or focus traversal policy provider");
        } else if (aContainer.isFocusCycleRoot() && !aComponent.isFocusCycleRoot(aContainer)) {
            throw new IllegalArgumentException("aContainer is not a focus cycle root of aComponent");
        }
        synchronized(aContainer.getTreeLock()) {
            found.value = false;
            Component retval = getComponentBefore(aContainer, aComponent,aComponent,
                                                  found);
            if (retval != null) {
                return retval;
            } else if (found.value) {
                return getLastComponent(aContainer);
            } else {
                return null;
            }
        }
    }

    private Component getComponentBefore(Container aContainer,Component aOriginal,
            Component aComponent,
            MutableBoolean found) 
    {
        if (!(aContainer.isVisible() && aContainer.isDisplayable())) {
            return null;
        }

        for ( Component comp : getOrder(aContainer,true) ) {
            if (comp == aComponent) {
                found.value = true;
            } else if ((comp instanceof Container) &&
                    !((Container)comp).isFocusCycleRoot()) {
                Component retval = null;
                if (((Container)comp).isFocusTraversalPolicyProvider()) {
                    Container cont = (Container) comp;
                    FocusTraversalPolicy policy = cont.getFocusTraversalPolicy();
                    if (found.value) {
                        retval = policy.getLastComponent(cont);
                    } else {
                        found.value = cont.isAncestorOf(aComponent);                    
                        if (found.value) {
                            if (aComponent == policy.getFirstComponent(cont)) {
                                retval = null;
                            } else {
                                retval = policy.getComponentBefore(cont, aComponent);
                            }
                        }
                    }
                } else {
                    retval = getComponentBefore((Container)comp,aOriginal,
                         aComponent,
                         found);
                }
                if (retval != null) {
                    return retval;
                }
            } else if (found.value) {
                if (accept(comp,aOriginal)) {
                    return comp;
                }
            }
        }

        if (found.value) {
            if (accept(aContainer,aOriginal)) {
                return aContainer;
            }
        } else if (aContainer == aComponent) {
            found.value = true;
        }

        return null;
    }
    
    @Override
    public Component getFirstComponent(Container aContainer) {
        if (aContainer == null) {
            throw new IllegalArgumentException("aContainer cannot be null");
        }

        synchronized(aContainer.getTreeLock()) {
            if (!(aContainer.isVisible() &&
                  aContainer.isDisplayable()))
            {
                return null;
            }

            if (accept(aContainer,null)) {
                return aContainer;
            }

            for ( Component comp : getOrder(aContainer,false) ) {
                if (comp instanceof Container &&
                        !((Container)comp).isFocusCycleRoot())
                {
                    Component retval = null;
                    Container cont = (Container)comp;
                    if (cont.isFocusTraversalPolicyProvider()) {
                        FocusTraversalPolicy policy = cont.getFocusTraversalPolicy();
                        retval = policy.getDefaultComponent(cont);
                    } else {
                        retval = getFirstComponent((Container)comp);
                    }
                    if (retval != null) {
                        return retval;
                    }
                } else if (accept(comp,null)) {
                    return comp;
                }
            }
        }

        if (aContainer instanceof JRootPane) return aContainer;
        return null;            
    }

    @Override
    public Component getLastComponent(Container aContainer) {
        if (aContainer == null) {
            throw new IllegalArgumentException("aContainer cannot be null");
        }
        synchronized(aContainer.getTreeLock()) {
            if (!(aContainer.isVisible() &&
                  aContainer.isDisplayable()))
        {
                return null;
            }

            for ( Component comp : getOrder(aContainer,true) ) {
                if (comp instanceof Container &&
                        !((Container)comp).isFocusCycleRoot())
                {
                    Component retval = null;
                    Container cont = (Container)comp;
                    if (cont.isFocusTraversalPolicyProvider()) {
                        FocusTraversalPolicy policy = cont.getFocusTraversalPolicy();
                        retval = policy.getLastComponent(cont);
                    } else {
                        retval = getLastComponent((Container)comp);
                    }
                    if (retval != null) {
                        return retval;
                    }
                } else if (accept(comp,null)) {
                    return comp;
                }
            }

            if (accept(aContainer,null)) {
                return aContainer;
            }
        }

        return null;            
    }

    public boolean getImplicitDownCycleTraversal() {
        return true;
    }

    @Override
    public Component getDefaultComponent(Container container) {
        if (target!=null && target.getInitialSelectControl()!=null) {
            Component c = target.getInitialSelectControl().getComponent();
            if (c!=null && accept(c,null)) {
                target.setInitialSelectControl(null);
                return c;
            }
        }
        return getFirstComponent(container);
    }

    @Override
    public Component getInitialComponent(Window window) {
        if (target!=null && target.getInitialSelectControl()!=null) {
            Component c = target.getInitialSelectControl().getComponent();
            if (c!=null && accept(c,null)) {
                target.setInitialSelectControl(null);
                return c;
            }
        }
        return super.getInitialComponent(window);
    }

    
    
}
