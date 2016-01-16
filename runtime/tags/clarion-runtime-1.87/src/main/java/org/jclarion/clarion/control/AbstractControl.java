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

import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FocusTraversalPolicy;
import java.awt.Insets;
import java.awt.Point;
import java.awt.Toolkit;
import java.awt.Window;
import java.awt.datatransfer.DataFlavor;
import java.awt.dnd.DnDConstants;
import java.awt.dnd.DragSource;
import java.awt.dnd.DropTarget;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TooManyListenersException;

import javax.swing.Icon;
import javax.swing.JComponent;
import javax.swing.JInternalFrame;
import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import javax.swing.SwingUtilities;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.runtime.format.Formatter;
import org.jclarion.clarion.swing.ClarionFocusTraversalPolicy;
import org.jclarion.clarion.swing.SwingAccept;
import org.jclarion.clarion.swing.dnd.ClarionDragGesture;
import org.jclarion.clarion.swing.dnd.ClarionDropTargetListener;
import org.jclarion.clarion.swing.gui.CommandList;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.RemoteWidget;
import org.jclarion.clarion.constants.*;

public abstract class AbstractControl extends PropertyObject implements RemoteWidget
{
    protected class Refresh implements Runnable
    {
        @Override
        public void run() {
        	refresh();
        }
    }	
	
    private int useID;
    private ClarionObject useObject;
    private AbstractTarget owner;
    private AbstractControl parent;
    private String			drag[];
    private String			drop[];
    
    public abstract int getCreateType();
    
    public boolean containsUse(ClarionObject use)
    {
        if (this.useObject==use) return true;
        for ( AbstractControl ac : getChildren() ) {
            if (ac.containsUse(use)) return true;
        }
        return false;
    }
    
    public AbstractTarget getOwner()
    {
        if (owner!=null) return owner;
        if (parent!=null) {
            owner=parent.getOwner();
        }
        return owner;
    }
    
    public final AbstractWindowTarget getWindowOwner()
    {
        return (AbstractWindowTarget)getOwner();
    }
    
    public void setOwner(AbstractTarget target)
    {
         this.owner=target;
    }

    public void addChild(AbstractControl control)
    {
        throw new RuntimeException("Not supported");
    }

    public void removeChild(AbstractControl control)
    {
        throw new RuntimeException("Not supported");
    }
    
    public AbstractControl getParent()
    {
        return parent;
    }
    
    private static Collection<AbstractControl> noChildren=new ArrayList<AbstractControl>();
    
    public Collection<? extends AbstractControl> getChildren()
    {
        return noChildren;
    }
    
    public AbstractControl getChild(int index)
    {
        Iterator<? extends AbstractControl> control = getChildren().iterator();
        while (control.hasNext() && index>0) {
            if (control.hasNext()) {
                control.next();
            } else {
                return null;
            }
            index--;
        }
        if (control.hasNext()) return control.next();
        return null;
    }

    public int getChildIndex(AbstractControl control)
    {
        int count=0;
        for (AbstractControl test : getChildren()) {
            if (test==control) return count;
            count++;
        }
        return -1;
    }

    public void setParent(AbstractControl parent)
    {
        this.parent=parent;
    }
    
    public void setUseID(int id)
    {
        useID=id;
    }
    
    public int getUseID()
    {
        if (useID==0 && getOwner()!=null) return getOwner().register(this);
        return useID;
    }

    public AbstractControl setDragID(String... id)
    {
    	this.drag=id;
    	return this;
    }
    
    public AbstractControl setDropID(String... id)
    {
    	this.drop=id;
    	return this;
    }
    
    public AbstractControl setText(String text)
    {
        setProperty(Prop.TEXT,text);
        return this;
    }
    
    public AbstractControl setPicture(String picture)
    {
        setProperty(Prop.TEXT,picture);
        return this;
    }
    
    private Formatter picture;
        
    public Formatter getPicture()
    {
        if (picture!=null) return picture;
        if (useObject==null) return null;
        ClarionObject picture = getRawProperty(Prop.TEXT);
        if (picture==null) return null;
        this.picture=Formatter.construct(picture.toString());
        if (this.picture!=null) {
            initPicture(this.picture);
        }
        return this.picture;
    }
    
    protected void initPicture(Formatter formatter)
    {
    }

    public String dropInto(AbstractControl dropTarget)
    {
    	if (dropTarget==this) return null;
    	if (drag==null) return null;
    	if (dropTarget.drop==null) return null;
    	
    	String[] smallest;
    	String[] biggest;
    	
    	// copy smallest into a hash
    	if (dropTarget.drop.length>drag.length) {
    		smallest=drag;
    		biggest=dropTarget.drop;
    	} else {
    		biggest=drag;
    		smallest=dropTarget.drop;
    	}
    	
    	if (smallest.length>2) {
    		Set<String> s = new HashSet<String>();
    		for (String t : smallest ) {
    			if (t==null) continue;
    			s.add(t);
    		}
    		for (String t : biggest ) {
    			if (s.contains(t)) return t;
    		}
    	} else {
    		for (String t1 : biggest ) {
    			if (t1==null) continue;
    			for (String t2 : smallest ) {
    	   			if (t2==null) continue;
    	   			if (t1.equals(t2)) return t1;
    	   		}
    		}
    	}
    	return null;
    }
    
    public AbstractControl setCenter(Integer i)
    {
        setProperty(Prop.CENTER,true);
        setProperty(Prop.CENTEROFFSET,i);
        return this;
    }

    public AbstractControl setAlrt(int keycode)
    {
        setProperty(Prop.ALRT,255,keycode);
        return this;
    }

    public AbstractControl setBoxed()
    {
        setProperty(Prop.BOXED,true);
        return this;
    }

    public AbstractControl setTransparent()
    {
        setProperty(Prop.TRN,true);
        return this;
    }

    public AbstractControl setBevel(Integer b1,Integer b2,Integer b3)
    {
        if (b1!=null) setProperty(Prop.BEVELOUTER,b1);
        if (b2!=null) setProperty(Prop.BEVELINNER,b2);
        if (b3!=null) setProperty(Prop.BEVELSTYLE,b3);
        return this;
    }

    public AbstractControl setStandard(int std)
    {
        setProperty(Prop.STD,std);
        return this;
    }

    public AbstractControl setLeft(Integer i)
    {
        setProperty(Prop.LEFT,true);
        setProperty(Prop.LEFTOFFSET,i);
        return this;
    }

    public AbstractControl setRight(Integer i)
    {
        setProperty(Prop.RIGHT,true);
        setProperty(Prop.RIGHTOFFSET,i);
        return this;
    }

    public AbstractControl setDecimal(Integer i)
    {
        setProperty(Prop.DECIMAL,true);
        setProperty(Prop.DECIMALOFFSET,i);
        return this;
    }
    
    public AbstractControl setAt(Integer x,Integer y,Integer width,Integer height)
    {
        setProperty(Prop.XPOS,x);
        setProperty(Prop.YPOS,y);
        setProperty(Prop.WIDTH,width);
        setProperty(Prop.HEIGHT,height);
        return this;
    }
    
    public AbstractControl setFont(String typeface,Integer size,Integer color,Integer style,Integer charset)
    {
        setProperty(Prop.FONTNAME,typeface);
        setProperty(Prop.FONTSIZE,size);
        setProperty(Prop.FONTCOLOR,color);
        setProperty(Prop.FONTSTYLE,style);
        setProperty(Prop.FONTCHARSET,charset);
        return this;
    }
    
    public AbstractControl setColor(Integer color,Integer fore,Integer back) {
        setProperty(Prop.FILLCOLOR,color);
        setProperty(Prop.SELECTEDCOLOR,fore);
        setProperty(Prop.SELECTEDFILLCOLOR,back);
        return this;
    }
    
    public AbstractControl setHidden()
    {
        setProperty(Prop.HIDE,true);
        return this;
    }

    public AbstractControl setDisabled()
    {
        setProperty(Prop.DISABLE,true);
        return this;
    }

    public AbstractControl setSkip()
    {
        setProperty(Prop.SKIP,true);
        return this;
    }

    public AbstractControl setImmediate()
    {
        setProperty(Prop.IMM,true);
        return this;
    }

    public AbstractControl setTip(String tip)
    {
        setProperty(Prop.TIP,tip);
        return this;
    }

    public AbstractControl setHelp(String help)
    {
        setProperty(Prop.HLP,help);
        return this;
    }

    public AbstractControl setMsg(String help)
    {
        setProperty(Prop.MSG,help);
        return this;
    }

    public AbstractControl use(ClarionObject object)
    {
        setProperty(Prop.USE,object);
        return this;
    }
    
    public ClarionObject getUseObject()
    {
        return useObject;
    }
    
    public void update()
    {
    }

    public int getKey() {
        return 0;	
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        if (parent!=null) return parent;
        if (owner!=null) return owner;
        return null;
    }

    protected boolean canNotifyLocalChange(int indx)
    {
        return getComponent()!=null || (getOwner()!=null && !(getOwner() instanceof ClarionReport)) || indx==Prop.USE;
    }

    public boolean isSettable(int indx,ClarionObject value)
    {
    	switch(indx) {
    		case Prop.XPOS:
    		case Prop.YPOS:
    		case Prop.WIDTH:
    		case Prop.HEIGHT:
    		case Prop.DISABLE:
    		case Prop.HIDE:
    		case Prop.VSCROLLPOS:
    			int nv=0,ov=0;
    			if (value!=null) nv=value.intValue();
    			ClarionObject co = getRawProperty(indx,false);
    			if (co!=null) ov=co.intValue();
    			return ov!=nv;
    	}
        return true;
    }

    protected final void notifyLocalChange(final int indx,final ClarionObject value) 
    {
    	recordChange(indx,value);
    	if (canNotifyLocalChange(indx)) {
        	doNotifyLocalChange(indx,value);
        }
    }

    protected void doNotifyLocalChange(final int indx,final ClarionObject value) 
    {
        switch(indx) {
            case Prop.TEXT:
                picture=null;
                break;
            case Prop.USE:
                useObject=(ClarionObject)value.getLockedObject(Thread.currentThread());
                break;
            case Prop.HIDE:
                if (constructOnUnhide && indx==Prop.HIDE && !value.boolValue() && getOwner() instanceof AbstractWindowTarget) 
                {
                    opened();
                    AbstractWindowTarget awt = getWindowOwner();
                    awt.noteFullRepaint();
                }
                break;
        }
        if (isAWTChange(indx) && isOpened() && !SwingUtilities.isEventDispatchThread()) {
        	CWinImpl.run(this,NOTIFY_AWT_CHANGE,indx,value);
    	}
    }
    
    private void validateIfNecessary(Component c) {
        if (c instanceof Container && ((Container)c).getComponentCount()>0) {
            c.validate();
        }
    }
    
    private boolean forcedUpdate;
    
    protected boolean isAWTChange(int indx)
    {
    	switch(indx) {
    		case Prop.WIDTH:
    			if (!forcedUpdate) clearDim=(clearDim|1)-1;
    			return !forcedUpdate;
    		case Prop.HEIGHT:
    			if (!forcedUpdate) clearDim=(clearDim|2)-2;
    			return !forcedUpdate;
    		case Prop.XPOS:
    		case Prop.YPOS:
    			return !forcedUpdate;
			case Prop.HIDE:
			case Prop.DISABLE:
			case Prop.FONTNAME:
			case Prop.FONTSIZE:
			case Prop.FONTSTYLE:
			case Prop.FONTCOLOR:
			case Prop.BACKGROUND:
            return true;
    	}
    	return false;
    }
    
    
    @Override
	public CommandList getCommandList() {
    	return CommandList.create()
    		.add("NOTIFY_AWT_CHANGE",1)
    		.add("TOGGLE_MODE",2)
    		.add("REMOVE",3)
    		.add("SELECT",4)
    		.add("OBJECT_CHANGED",5)
    		.add("REFRESH",6)
    		.add("RUN_ACCEPT",7)
    		.add("GET_AWT_PROPERTY",8)
    		.add("ACCEPT",9)
    		.add("UPDATE_FROM_SCREENTEXT",10)
    		.add("ACTUAL_SIZE_NOTIFY",11)
			.add("NOP",12)
			.add("MD_USEID",0x2000)
			.add("MD_CONSTRUCT_ON_UNHIDE",0x2001)    
			.add("MD_ALERTS",0x2002)
			.add("MD_DRAGID",0x2003)    
			.add("MD_DROPID",0x2004)    
		;
	}

	public static final int NOTIFY_AWT_CHANGE=1;
    public static final int TOGGLE_MODE=2;
    public static final int REMOVE=3;
    public static final int SELECT=4;
    public static final int OBJECT_CHANGED=5;
    public static final int REFRESH=6;
    public static final int RUN_ACCEPT=7;
    public static final int GET_AWT_PROPERTY=8;
    public static final int ACCEPT=9;
    public static final int UPDATE_FROM_SCREENTEXT=10;
    public static final int ACTUAL_SIZE_NOTIFY=11;
    public static final int NOP=12;
    
    public static final int MD_USEID=0x2000;
    public static final int MD_CONSTRUCT_ON_UNHIDE=0x2001;    
    public static final int MD_ALERTS=0x2002;    
    public static final int MD_DRAGID=0x2003;    
    public static final int MD_DROPID=0x2004;    
    public final void runAccept()
    {
    	CWinImpl.run(this,RUN_ACCEPT);
    }
    
    public final void refresh()
    {
    	Object params[] = getRefreshParams();
    	if (params==null) {
    		CWinImpl.run(this,REFRESH);
    	} else {
    		CWinImpl.run(this,REFRESH,params);    		
    	}
    }
    
    protected Object[] getRefreshParams()
    {
    	return null;
    }
    
    public final void remove()
    {
    	CWinImpl.run(this,REMOVE);
    	GUIModel.getClient().dispose(this);
        removeAllListeners();
    }
    
    public void clean()
    {
        clearMetaData();
        removeAllListeners();
        for (AbstractControl child : getChildren()) {
            child.clean();
        }
    }
    
    public void select() {
    	CWinImpl.run(this,SELECT);    	
    }
    
    
    protected void handleObjectChanged(Object value)
    {
    }

    protected void handleRefresh(Object... params)
    {
    }
    
    protected void notifyObjectChanged(Object value)
    {
    	if (!isOpened()) return;
    	if (getWindowOwner().isClosed()) return;
    	CWinImpl.run(this,OBJECT_CHANGED,value);
    }

    @Override
    public boolean isModalCommand(int command)
    {
    	return false;
    }

    @Override
    public boolean isGuiCommand(int command)
    {
    	return true;
    }

    public void notifyActualSize()
    {
        Component c=  getComponent();
        if (c==null) return;    	
    	Insets i = getControlAdjustInsets();
    	GUIModel.getServer().send(this,ACTUAL_SIZE_NOTIFY,
    		getWindowOwner().widthPixelsToDialog(c.getWidth()- (i == null ? 0 : i.left + i.right),true),
    		getWindowOwner().heightPixelsToDialog(c.getHeight() - (i == null ? 0 : i.top + i.bottom),true));
    }
    
    private Runnable nopSync;
    
    public void triggerGuiSync()
    {
    	if (nopSync==null) {
    		nopSync=new Runnable() {
    			public void run() {
    				doGuiSync();
    			}
    		};
    	}
    	getWindowOwner().addAcceptTask(nopSync,nopSync);
    }
    
    private void doGuiSync()
    {
    	CWinImpl.run(this,NOP);
    }
    
    @Override
	public Object command(int command, Object... params) {
    	switch (command) {
    		case NOP:
    			return null;
    		case ACTUAL_SIZE_NOTIFY: {
    			try {
    				forcedUpdate=true;
    				setProperty(Prop.WIDTH,params[0]);
    				setProperty(Prop.HEIGHT,params[1]);
    			} finally {
    				forcedUpdate=false;
    			}
    			return null;
    		}
    		case GET_AWT_PROPERTY:
    			return getAWTProperty((Integer)params[0]);
    		case RUN_ACCEPT: {
                final SwingAccept accept = getAccept();
                if (accept != null) {
                	return accept.accept(false);
   				}
                return null;
    		}
    		case OBJECT_CHANGED : {
    			handleObjectChanged(params[0]);
    			return null;
    		}
    		case REFRESH : {
    			handleRefresh(params);
    			return null;
    		}
    		case SELECT: {
                Component c = getComponent();
                if (c == null) {
                    c = (Component) getParent().getComponent();
                }
                if (c==null) return null;
                
                Container win = (Container) getWindowOwner().getWindow();
                if (win == null) return null;
                
                if (!getWindowOwner().isGuiActive()) {
                	getWindowOwner().setCurrentFocus(this);
                	post(Event.SELECTED);
                	return null;
                }
                
            	ClarionFocusTraversalPolicy cftp = (ClarionFocusTraversalPolicy) win.getFocusTraversalPolicy();
                if (!cftp.accept(c, null)) {
                    Container base = c.getFocusCycleRootAncestor();
                    c = base.getFocusTraversalPolicy().getComponentAfter(base,c);
                }

                if (c != null) {
                    c.requestFocusInWindow();
                }
    			return null;
    		}
    		case REMOVE: {
                Component c = getComponent();
                if (c!=null) {
                    java.awt.Container container = c.getParent();
                    if (container!=null) {
                        container.remove(c);
                        container.repaint();
                    }
                }
            	GUIModel.getServer().dispose(this);
                clearMetaData();
                removeAllListeners();
    			return null;
    		}
    		case TOGGLE_MODE: {
    			boolean f_value = (Boolean)params[0];
    			int mode = (Integer)params[1];
    			boolean refocus = (Boolean)params[2];
    			
            	AbstractControl focus = getWindowOwner().getCurrentFocus();

                if (!refocus) {
                	doToggleMode(f_value,mode);
                	return null;
                }
                
               	Component f=null;
           		Container c = getWindowOwner().getWindow();
           		if (c==null) return null;
               	if (focus!=null) {
               		AbstractControl scan=focus;
               		while (scan!=null && scan!=this) {
               			scan=scan.getParent();
               		}
               		if (scan==null) {
                    	doToggleMode(f_value,mode);
               			return null; // focus is not descendant of control being modified
               		}
               		f=focus.getComponent();
               	} else {
                    if (c instanceof Window) {
                        f = ((Window)c).getFocusOwner();        
                    }
                    if (c instanceof JInternalFrame) {
                        f = ((JInternalFrame)c).getFocusOwner();
                    }
             	}
            
               	// check if object in question is already disabled
               	Component scan=f;
               	while ( true ) {
               		if (scan==null) break;
               		if (scan instanceof Container) {
               			Container fc = (Container)scan;
               			if (fc.isFocusCycleRoot()) break;
               		}
                    if (!(scan.isVisible() && scan.isDisplayable() && scan.isEnabled())) {
                    	refocus=false;
                    	break;
                    }
                    scan=scan.getParent();
               	}

               	doToggleMode(f_value,mode);
                ClarionFocusTraversalPolicy cftp = (ClarionFocusTraversalPolicy)c.getFocusTraversalPolicy();
                //Component base=f;
                if (f!=null) {
                	if (cftp.accept(f,null)) {
                		return null;
                	}
                }
                
                if (!refocus) {
                	return null;
                }
                
                if (f!=null) {
                	f = cftp.getComponentAfter(c,f);
                }
                if (f==null) {
                 	f=cftp.getFirstComponent(c);
                }
                if (f!=null) {
                    f.requestFocusInWindow();
                }
    			return null;
    		}
    	
    		case NOTIFY_AWT_CHANGE: {
    			int indx=(Integer)params[0];
    			ClarionObject value = (ClarionObject)params[1];
    			handleAWTChange(indx,value);
    			return null;
    		}
    	}
    	return null;
	}

	protected void handleAWTChange(int indx, ClarionObject value) {
        Insets i;
        if (constructOnUnhide && indx==Prop.HIDE && !value.boolValue() && getOwner() instanceof AbstractWindowTarget) 
        {
            AbstractWindowTarget awt = getWindowOwner();
            if (awt.getContentPane()!=null) {
                constructOnUnhide=false;
                //awt.noteFullRepaint();
                constructSwingComponent(awt.getContentPane());
                if (getUs() instanceof TabControl) {
                    getParent().getComponent().validate();
                }
            }
        }

        Component c = getComponent();
        AbstractWindowTarget t = getWindowOwner();
        
        if (c!=null && t!=null && value!=null) {
            switch (indx) {
                case Prop.HIDE:
                    toggleMode(!value.boolValue() ? getMode(Prop.HIDE) : false, Prop.HIDE,true);
                    return;
                case Prop.DISABLE:
                    toggleMode(!value.boolValue() ? getMode(Prop.DISABLE) : false, Prop.DISABLE,true);
                    return;
                case Prop.HEIGHT:
                    i=getControlAdjustInsets();
                    c.setSize(c.getWidth(),
                        t.heightDialogToPixels(
                        value.intValue())
                        +(i==null?0:i.top+i.bottom));
                    validateIfNecessary(c);
                    return;
                case Prop.WIDTH:
                    i=getControlAdjustInsets();
                    c.setSize(t.widthDialogToPixels(value.intValue())
                        , c.getHeight()
                        +(i==null?0:i.left+i.right));
                    validateIfNecessary(c);
                    return;
                case Prop.XPOS: {
                    i=getControlAdjustInsets();
                    int x = value.intValue();
                    x = t.widthDialogToPixels(x);
                    c.setLocation(x-(i==null?0:i.left), c.getY()); 
                    return;
                }
                case Prop.YPOS: {
                    i=getControlAdjustInsets();
                    int y = value.intValue();
                    y = t.heightDialogToPixels(y);
                    c.setLocation(c.getX(), y-(i==null?0:i.top));
                    return;
                }
            }
        }
        
        if (fontComponents!=null && fontComponents.size()>0) {
            switch(indx) {
                case Prop.FONTNAME:
                case Prop.FONTSIZE:
                case Prop.FONTSTYLE: {
                    for (Component fc : fontComponents ) {
                        changeFont(fc);
                    }
                }
            }
        }

        if (colorComponents!=null && colorComponents.size()>0) {
            switch(indx) {
                case Prop.FONTCOLOR:
                case Prop.BACKGROUND: {
                    for (Component fc : colorComponents ) {
                        setColor(fc);
                    }
                }
            }
        }
	}

    private Set<Integer>    alerts;
    private boolean         mouseAlerts;

    public boolean isAlertKey(int key)
    {
        if (alerts==null) return false;
        return alerts.contains(key);
    }
    
    public boolean isMouseAlert()
    {
        return mouseAlerts;
    }
    
    @Override
    public void setProperty(ClarionObject key, ClarionObject index,ClarionObject value) 
    {
        if (key.intValue()==Prop.DRAGID) {
        	drag=setDragDrop(drag,index.intValue()-1,value.toString());
        	recordChange(MD_DRAGID,drag); 
        	return;
        }
        if (key.intValue()==Prop.DROPID) {
        	drop=setDragDrop(drop,index.intValue()-1,value.toString());
        	recordChange(MD_DROPID,drop); 
        	return;
        }
        
        if (key.intValue()==Prop.ALRT) {
            int ivalue=value.intValue();
        	recordAlert(ivalue);
        	if (isOpened()) {
        		recordChange(MD_ALERTS,alerts);
        		triggerGuiSync();
        	}
            return;
        }
        
        super.setProperty(key, index, value);
    }

    
    
    private void recordAlert(int ivalue) {
        if (alerts==null) alerts= new HashSet<Integer>();
        alerts.add(ivalue);
        switch(ivalue) {
            case Constants.MOUSELEFT:
            case Constants.MOUSECENTER:
            case Constants.MOUSERIGHT:
            case Constants.MOUSELEFT2:
            case Constants.MOUSECENTER2:
            case Constants.MOUSERIGHT2:
                mouseAlerts=true;
        }
        // wake up any property listeners
        setProperty(Prop.ALRT,true);         
	}

	private String[] setDragDrop(String[] array, int indx, String value) {
    	if (indx<0) return array;
    	if (array==null) {
    		array=new String[indx+1];
    	} else if (indx>=array.length) {
    		String new_array[] = new String[indx+1];
    		System.arraycopy(array,0,new_array,0,array.length);
    		array=new_array;
    	}
    	array[indx]=value;
    	return array;
	}

	@Override
    public ClarionObject getProperty(ClarionObject key, ClarionObject index) {

        int ikey=key.intValue();

        if (ikey==Prop.DRAGID) {
        	int i = index.intValue()-1;
        	if (drag==null || i>=drag.length || drag[i]==null) {
        		return new ClarionString("");
        	} else {
        		return new ClarionString(drag[i]);
        	}
        }
        if (ikey==Prop.DROPID) {
        	int i = index.intValue()-1;
        	if (drop==null || i>=drop.length || drop[i]==null) {
        		return new ClarionString("");
        	} else {
        		return new ClarionString(drop[i]);
        	}
        }
        
        if (ikey==Prop.CHILDINDEX) {
            AbstractControl child = getOwner().getControl(index.intValue());
            if (child==null) return new ClarionNumber(0);
            if (child.getParent()!=this) return new ClarionNumber(0);
            return new ClarionNumber(this.getChildIndex(child)+1);
        }
        
        if (ikey==Prop.CHILD) {
            int iindex=index.intValue();
            if (iindex<1) return new ClarionNumber(0); 
            AbstractControl child = getChild(iindex-1);
            if (child==null) return new ClarionNumber(0);
            return new ClarionNumber(child.getUseID());
        }
        return super.getProperty(key, index);
    }

    public abstract boolean validateInput();
    
    public abstract boolean isAcceptAllControl();

    public ClarionObject getAWTProperty(int index)
    {
        Component c=  getComponent();
        if (c==null) return null;

        Insets i;

        switch (index) {

            case Prop.HEIGHT:
                i = getControlAdjustInsets();
                return new ClarionNumber(getWindowOwner().heightPixelsToDialog(
                    c.getHeight() - (i == null ? 0 : i.top + i.bottom)));
            case Prop.WIDTH:
                i = getControlAdjustInsets();
                return new ClarionNumber(getWindowOwner().widthPixelsToDialog(
                    c.getWidth()
                    - (i == null ? 0 : i.left + i.right)));
            case Prop.XPOS: {
                if (getRawProperty(Prop.XPOS, false) != null)
                    return null;

                i = getControlAdjustInsets();
                int x = c.getX();
                return new ClarionNumber(getWindowOwner().widthPixelsToDialog(
                    x + (i == null ? 0 : i.left)));
            }
            case Prop.YPOS: {
                if (getRawProperty(Prop.XPOS, false) != null)
                    return null;

                i = getControlAdjustInsets();
                int y = c.getY();
                return new ClarionNumber(getWindowOwner().heightPixelsToDialog(
                    y + (i == null ? 0 : i.top)));
            }
        }
        
        return null;
    }
    
    public boolean isAWTProperty(int index)
    {
        switch(index) {
            case Prop.HEIGHT: 
            case Prop.WIDTH: 
            case Prop.XPOS: 
            case Prop.YPOS:
    			return getRawProperty(index,false)==null;
        }
        return false;
    }

    @Override
    public ClarionObject getLocalProperty(int index) {
        
        switch(index) {
            case Prop.PARENT:   
                if (getParent()!=null) return new ClarionNumber(getParent().getUseID());
                return new ClarionNumber(0);
            case Prop.TYPE:
                return new ClarionNumber(getCreateType());
            case Prop.VISIBLE: {
                ControlIterator ci = new ControlIterator(this, true);
                ci.setScanDisabled(true);
                return new ClarionBool(ci.isAllowed(this));
            }

            case Prop.ENABLED: {
                ControlIterator ci = new ControlIterator(this, true);
                ci.setScanDisabled(false);
                ci.setScanHidden(false);
                ci.setScanSheets(true);
                return new ClarionBool(ci.isAllowed(this));
            }
        }

        if (isOpened() && isAWTProperty(index)) {
        	//long start = System.currentTimeMillis();
        	ClarionObject co = (ClarionObject)CWinImpl.runNow(this,GET_AWT_PROPERTY,index); 
        	//long end = System.currentTimeMillis();
        	//System.out.println("("+(end-start)+") for "+Prop.getPropString(index)+" = "+co);
        	return  co;
        }
        
        return super.getLocalProperty(index);
    }

    private List<Component>		colorComponents;
    private List<Component>     fontComponents;
    private boolean             mouseAlertsEnabled;
    private boolean             constructOnUnhide;
    private int clearDim=0;

    @Override
    public void clearMetaData() 
    {
    	colorComponents=null;
        fontComponents=null;
        mouseAlertsEnabled=false;
        constructOnUnhide=false;
        super.clearMetaData();

        if ((clearDim&1)==1) setProperty(Prop.WIDTH,null);
        if ((clearDim&2)==2) setProperty(Prop.HEIGHT,null);
        clearDim=0;
        
    }

    @Override
    protected void debugMetaData(StringBuilder sb) 
    {
        debugMetaData(sb,"fontComponents",null);
        debugMetaData(sb,"mouseAlerrsEnabled",null);
        debugMetaData(sb,"constructOnUngide",null);
    }
    
    public void setConstructOnUnhide()
    {
        constructOnUnhide=true;
    }
    
    public boolean canConstruct()
    {
        return !constructOnUnhide;
    }
    
    public SwingAccept getAccept()
    {
        return null; 
    }
    
    public boolean isAccept()
    {
    	return false;
    }
    
    public abstract Component getComponent();

    public Component getPopUpComponent()
    {
    	return getComponent();
    }
    
    
    public void constructSwingComponent(Container parent)
    {
        throw new IllegalStateException("Not Yet implemented");
    }

    public final void toggleMode(boolean value, int mode) 
    {
        toggleMode(value,mode,false);
    }

    public void toggleMode(boolean value, final int mode,final boolean refocus) 
    {
        if (value == true && mode==Prop.HIDE)  {
            ControlIterator ci = new ControlIterator(this);
            ci.setLoop(false);
            ci.setScanDisabled(true);
            ci.setScanHidden(false);
            ci.setScanSheets(false);
            if (!ci.isAllowed(this)) value=false;
        }
        
        CWinImpl.run(this,TOGGLE_MODE,value,mode,refocus);
    }
    
    public Component[] getToggleComponents()
    {
        return null;
    }

    protected void doToggleMode(boolean value, int mode) {
        if (value == true) {
            if (isProperty(mode)) value = false;
        }

        Component components[] = getToggleComponents();
        if (components!=null) {
            for (Component component: components ) {
                if (component==null) continue;
                switch (mode) {
                    case Prop.DISABLE:
                        component.setEnabled(value);
                        break;
                    case Prop.HIDE:
                        component.setVisible(value);
                        break;
                }
            }
        } else {
            Component component = getComponent();
            if (component != null) {
                switch (mode) {
                    case Prop.DISABLE:
                        component.setEnabled(value);
                        break;
                    case Prop.HIDE:
                        component.setVisible(value);
                        break;
                }
            }
        }
        
        if (value == true && mode == Prop.HIDE) {
            if (this instanceof TabControl) {
                if (this!=((SheetControl)getParent()).getSelectedTab()) {
                    value = false;
                }
            }
        }

        for (AbstractControl child : getChildren()) {
            child.doToggleMode(value, mode);
        }
    }

    public boolean getMode(int mode) {
        if (isProperty(mode)) return false;
        if (getParent()!=null) return getParent().getMode(mode);
        return true;
    }
    
    public void configureDnD(Component c)
    {
    	if (drag!=null) {
    		DragSource.getDefaultDragSource().createDefaultDragGestureRecognizer(
    			c,DnDConstants.ACTION_COPY_OR_MOVE,new ClarionDragGesture(this));
    	}
    	
    	if (drop!=null) {
    		try {
   				c.setDropTarget(new DropTarget());
    			c.getDropTarget().addDropTargetListener(new ClarionDropTargetListener(this));
    		} catch (TooManyListenersException e) {
    			e.printStackTrace();
    		}
    	}
    }

    protected boolean isCopy()
    {
    	return false;
    }
    
    protected boolean isPaste()
    {
    	return false;
    }
    
    protected void copy()
    {
    }

    protected void paste()
    {
    }

    public void openPopup(MouseEvent e)
    {
		
		JPopupMenu menu = new JPopupMenu();
		
		if (isCopy()) {
        	JMenuItem copy=new JMenuItem("Copy");
        	copy.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					copy();
				}
        	});
        	menu.add(copy);
		}
		if (isPaste()) {
        	JMenuItem paste=new JMenuItem("Paste");
        	paste.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					paste();
				}
        	});
        	if (!Toolkit.getDefaultToolkit().getSystemClipboard().isDataFlavorAvailable(DataFlavor.stringFlavor)) {
        		paste.setEnabled(false);
        	}
        	if (!e.getComponent().isEnabled()) {
        		paste.setEnabled(false);
        	}
        	menu.add(paste);    						
		}
		
   		Container c = getWindowOwner().getWindow();
   		Component focus=null;
        if (c instanceof Window) {
        	focus=((Window)c).getFocusOwner();
        }
        if (c instanceof JInternalFrame) {
        	focus=((JInternalFrame)c).getFocusOwner();
        }
		
        FocusTraversalPolicy ftp =  focus.getFocusCycleRootAncestor().getFocusTraversalPolicy();
        if (focus!=null && ftp!=null && ftp instanceof ClarionFocusTraversalPolicy) {
        	if (((ClarionFocusTraversalPolicy)ftp).accept(focus,null)) {
        		getWindowOwner().setRefocus(focus);
        	}
        }
        
        menu.show(e.getComponent(),e.getX(), e.getY());
        menu.setInvoker(e.getComponent());    	
    }
    
    protected void setPositionAndState() 
    {
        ClarionObject tip = getRawProperty(Prop.TIP,false);
        if (tip!=null) {
            ((JComponent)getComponent()).setToolTipText(tip.toString());
        }

        configureDnD(getComponent());
        
        if (isProperty(Prop.DISABLE)) {
            toggleMode(false, Prop.DISABLE);
        }
        if (isProperty(Prop.HIDE)) {
            toggleMode(false, Prop.HIDE);
        }

        
        getComponent().setSize(getPreferredSize());
        {
            Insets i = getControlAdjustInsets();
            
            ClarionObject x = getRawProperty(Prop.XPOS, false);
            ClarionObject y = getRawProperty(Prop.YPOS, false);

            if (x != null || y != null || i!=null) {

                /**
                 * AbstractControl scan = control.getParent(); if (scan!=null) {
                 * if (x!=null) { ClarionObject px =
                 * scan.getRawProperty(Prop.XPOS,false); if (px!=null) {
                 * x=x.subtract(px); } } if (y!=null) { ClarionObject py =
                 * scan.getRawProperty(Prop.YPOS,false); if (py!=null) {
                 * y=y.subtract(py); } } scan=scan.getParent(); }
                 */

                Point p = getComponent().getLocation();

                if (x != null) {
                    ClarionObject w = getRawProperty(Prop.WIDTH, false);
                    if (w != null && w.intValue() < 0)
                        x = x.add(w);
                    p.x = getWindowOwner().widthDialogToPixels(
                            x.intValue());
                }

                if (y != null) {
                    ClarionObject h = getRawProperty(Prop.HEIGHT, false);
                    if (h != null && h.intValue() < 0)
                        y = y.add(h);
                    p.y = getWindowOwner().heightDialogToPixels(
                            y.intValue());
                }
                
                if (i!=null) {
                    p.x=p.x-i.left;
                    p.y=p.y-i.top;
                }
                
                getComponent().setLocation(p);
            }

            ClarionObject w = getRawProperty(Prop.WIDTH, false);
            ClarionObject h = getRawProperty(Prop.HEIGHT, false);

            if (w != null || h != null || i != null) {
                
                Dimension p = getComponent().getSize();
                if (w != null)
                    p.width = getWindowOwner().widthDialogToPixels(
                            Math.abs(w.intValue()));
                if (h != null)
                    p.height = getWindowOwner().heightDialogToPixels(
                            Math.abs(h.intValue()));
                if (i!=null) {
                    p.width+=i.left+i.right;
                    p.height+=i.top+i.bottom;
                }
                getComponent().setSize(p);
            }
            
            if (w==null || h==null ) {
            	notifyActualSize();
            }
        }
        

        if (isProperty(Prop.FULL)) {
            
            AbstractControl parent = getParent();
            Component c;

            //final boolean window;
            
            if (parent!=null) {
                c=parent.getComponent();
                //window=false;
            } else {
                c=getWindowOwner().getContentPane();
                //window=true;
            }
            
            ComponentListener cl = new ComponentListener() {

                @Override
                public void componentHidden(ComponentEvent e) {
                }

                @Override
                public void componentMoved(ComponentEvent e) {
                    doResizeFull(e);
                }

                @Override
                public void componentResized(ComponentEvent e) {
                    doResizeFull(e);
                }

                @Override
                public void componentShown(ComponentEvent e) {
                }

                private void doResizeFull(ComponentEvent e) {

                    int width = e.getComponent().getWidth();
                    int height = e.getComponent().getHeight();

                    //int x = e.getComponent().getX();
                    //int y = e.getComponent().getY();

                    int my_x = getComponent().getX();
                    int my_y = getComponent().getY();

                    int new_width = width - my_x;
                    int new_height = height - my_y;

                    getComponent().setSize(new_width, new_height);
                    notifyActualSize();
                }
            };

            c.addComponentListener(cl);
            cl.componentResized(new ComponentEvent(c,0));
        }
        
        if (isCopy() || isPaste()) {
    		getPopUpComponent().addMouseListener(
    			new MouseListener() {
    				@Override
    				public void mouseClicked(MouseEvent e) {
    					if (e.isConsumed()) return;
    					if (e.getButton()!=3) return;
    					if (getWindowOwner().getRefocus()!=null) return;
				        e.consume();
    					if (getWindowOwner().getCurrentFocus()!=getUs() && isPaste() && e.getComponent().isEnabled()) {
    						getWindowOwner().popupOnFocusGain(getUs(),e);
    						e.getComponent().requestFocus();
    					} else {
    						openPopup(e);
    					}
    				}

					@Override
					public void mousePressed(MouseEvent e) {
					}

					@Override
					public void mouseReleased(MouseEvent e) {
					}

					@Override
					public void mouseEntered(MouseEvent e) {
					}

					@Override
					public void mouseExited(MouseEvent e) {
					}
    			});
        }
    }

    public Dimension getPreferredSize() {
        return getComponent().getPreferredSize();
    }

    public Color getColor(int property) 
    {
        return CWin.getInstance().getColor(this,property);
    }

    public Color getNestedColor(int property) 
    {
        return CWin.getInstance().getNestedColor(this,property);
    }
    
    public void configureColor(Component jw) 
    {
    	if (colorComponents==null) {
    		colorComponents=new ArrayList<Component>(3);
    	}
    	colorComponents.add(jw);    	
    	setColor(jw);
    }
    	
    public void setColor(Component jw) 
    {
        Color c;
        c = getNestedColor(Prop.FONTCOLOR);
        if (c != null) jw.setForeground(c);
        c = getNestedColor(Prop.BACKGROUND);
        if (c != null) jw.setBackground(c);
    }
    
    public void configureFont(Component component) 
    {
        if (fontComponents==null) {
            fontComponents=new ArrayList<Component>();
        }
        fontComponents.add(component);
        
        changeFont(component);
    }

    public void changeFont(Component component)
    {
        CWin.getInstance().changeFont(component,this);
    }

    public ClarionEvent post(int event) 
    {
    	return post(event,false);
    }

    public ClarionEvent post(int event,boolean frontOfQueue) 
    {
        ClarionEvent ce =new ClarionEvent(event, this, true); 
        getWindowOwner().post(ce,frontOfQueue);
        return ce;
    }

    public boolean postAndWait(int event) 
    {
        ClarionEvent ce = new ClarionEvent(event, this, true);
        ce.setNetworkSemaphore(true);
        getWindowOwner().post(ce);
        return ce.getConsumeResult();
    }
    
    
    /*
    public void clearRefocusOnEventQueue(final AbstractWindowTarget windowOwner, final Component field) 
    {
        Runnable r = new Runnable() {
            @Override
            public void run() {
                Object o = windowOwner.getRefocus();
                if (o == null) return;

                if (o == field) {
                    windowOwner.setRefocus(null);
                }
            }
        };

        CWinImpl.run(r);
    }
    */
    
    public void configureDefaults(JComponent comp) 
    {
        configureFont(comp);
        configureColor(comp);
        setPositionAndState();
        setFocus(comp);
        setKey(comp);
    }
 
    private AbstractControl getUs()
    {
        return this;
    }
    
    public void setFocus(final JComponent comp) 
    {
        comp.putClientProperty("clarion", this);
        if (isProperty(Prop.SKIP)) {
            comp.putClientProperty("clarionSkipFocus", true);
        }

        comp.addFocusListener(new FocusListener() {

            @Override
            public void focusGained(FocusEvent e) 
            {
                AbstractWindowTarget awt = getWindowOwner();
                Component c = awt.getRefocus();

                if (c != null) {
                    Container window = awt.getWindow();
                    Component scan = c;
                    while (scan!=null) {
                        if (scan==window) break;
                        scan=scan.getParent();
                    }
                    if (scan==null) {
                        getWindowOwner().setRefocus(null);
                        c=null;
                    }
                }
                
                if (c!=null) {
                    if (!c.isEnabled() || !c.isVisible() || !c.isDisplayable()) {
                        getWindowOwner().setRefocus(null);
                        c=null;
                    }
                }

                if (c!=null) {
                    
                    
                    Container root = c.getFocusCycleRootAncestor();
                    if (root==null) {
                        getWindowOwner().setRefocus(null);
                        c=null;
                    } else {
                        FocusTraversalPolicy ftp =  
                            c.getFocusCycleRootAncestor().getFocusTraversalPolicy();
                        if (ftp!=null && ftp instanceof ClarionFocusTraversalPolicy) {
                            if (!((ClarionFocusTraversalPolicy)ftp).accept(c,null)) {
                                getWindowOwner().setRefocus(null);
                                c=null;
                            }
                        } else {
                            getWindowOwner().setRefocus(null);
                            c=null;
                        }
                    }
                }

                if (c != null) {
                    if (c == comp) {
                        getWindowOwner().setRefocus(null);
                    } else {
                        c.requestFocusInWindow();
                        return;
                    }
                }

                if (!comp.isEnabled()) return;
                
                AbstractControl cf = getWindowOwner().getCurrentFocus(); 
                
                if (cf != getUs()) {
                    getWindowOwner().setCurrentFocus(getUs());
                    MouseEvent me = getWindowOwner().getPopupEvent(getUs());
                    if (me!=null) {
                    	openPopup(me);
                    }
                    post(Event.SELECTED);
                }
            }
            @Override
            public void focusLost(FocusEvent e) {
            }
        });
    }
    
    public void setKey(JComponent comp) {
        CWin.getInstance().setKey(
                getWindowOwner(),comp,this instanceof SimpleMnemonicAllowed,
                false,this);
    }

    public Icon getIcon(String name, int prefx, int prefy) {
        return CWin.getInstance().getIcon(name,prefx,prefy);
    }
    

    public void accept() 
    {
        if (getComponent()!=null) {
            getComponent().requestFocusInWindow();
            post(Event.ACCEPTED);
        }
    }
    
    public boolean isMouseAlertsEnabled()
    {
        return mouseAlertsEnabled;
    }

    public void setMouseAlertsEnabled(boolean mouseAlertsEnabled)
    {
        this.mouseAlertsEnabled=mouseAlertsEnabled;
    }
    
    public Insets getControlAdjustInsets()
    {
        return null;
    }

    
    
    
	@Override
	public Map<Integer, Object> getChangedMetaData() {
		Map<Integer, Object> result = null;
		synchronized(changeMonitor) {
			if (changes==null) {
				changes=new HashMap<Integer,Object>();
				changes.putAll(getProperties());
				changes.put(MD_USEID,getUseID());
				if (constructOnUnhide) {
					changes.put(MD_CONSTRUCT_ON_UNHIDE,constructOnUnhide);
				}
				if (alerts!=null) {
					changes.put(MD_ALERTS,alerts);					
				}
				if (drag!=null) {
					changes.put(MD_DRAGID,drag);
				}
				if (drop!=null) {
					changes.put(MD_DROPID,drop);
				}
				addInitialMetaData(changes);
			}
			if (changes.isEmpty()) return null;
			result = changes;
			changes=new HashMap<Integer,Object>();
		}
		return result;
	}

	protected void addInitialMetaData(Map<Integer, Object> changes) 
	{
	}

	private int			  ignoreChangeIndex;
	private ClarionObject ignoreChange;
	
	protected void recordChange(int index,Object value)
	{
		if (index==ignoreChangeIndex && value==ignoreChange) {
			ignoreChangeIndex=0;
			return;
		}

		synchronized(changeMonitor) {
			if (changes!=null) {
				changes.put(index,value);
			}
		}
	}

	@Override
	public Iterable<? extends RemoteWidget> getChildWidgets() {
		return getChildren();
	}

	private int id;
	private Object changeMonitor=new Object();
	private Map<Integer,Object> changes;
	
	@Override
	public final int getID() {
		return id;
	}

	@Override
	public final void setID(int id) {
		this.id=id;
	}

	@Override
	public void setMetaData(Map<Integer, Object> data) {
		for (Map.Entry<Integer,Object> e : data.entrySet()) {
			ignoreChangeIndex=e.getKey();
			if (!setMetaData(ignoreChangeIndex,e.getValue())) {
				ignoreChange=(ClarionObject)e.getValue();
				setProperty(ignoreChangeIndex,ignoreChange);
			}
		}
	}
	
	protected boolean setMetaData(int index, Object value) {
		switch(index) {
			case MD_DRAGID: {
				Object[] ids = (Object[])value;
				for (int scan=0;scan<ids.length;scan++) {
		        	drag=setDragDrop(drag,scan,(String)ids[scan]);					
				}
				return true;
			}
			case MD_DROPID: {
				Object[] ids = (Object[])value;
				for (int scan=0;scan<ids.length;scan++) {
		        	drop=setDragDrop(drop,scan,(String)ids[scan]);					
				}
				return true;
			}
			case MD_ALERTS:
				for (Object o : (Object[])value) {
					recordAlert((Integer)o);
				}
				return true;
			case MD_USEID:
				setUseID((Integer)value);
				return true;
			case MD_CONSTRUCT_ON_UNHIDE:
				constructOnUnhide=(Boolean)value;
				return true;
		}
		return false;
	}

	@Override
	public void disposeWidget() {
		synchronized(changeMonitor) {
			changes=null;
		}
		this.id=0;
	}

	@Override
	public RemoteWidget getParentWidget()
	{
		RemoteWidget parent = getParent();
		if (parent==null) parent=(AbstractWindowTarget)getOwner();
		return parent;
	}

	@Override
	public int getWidgetType() {
		return getCreateType();
	}

	@Override
	public void addWidget(RemoteWidget child) {
		addChild((AbstractControl)child);
	}

	public boolean isOpened()
	{
		if (getOwner()==null) return false;
		return getOwner().isOpened();
	}
	
	
	public void opened() 
	{
		if (getRawProperty(Prop.WIDTH,false)==null) clearDim+=1;
		if (getRawProperty(Prop.HEIGHT,false)==null) clearDim+=2;
	}
}
