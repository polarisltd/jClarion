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

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ControlIterator;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

/**
 *  Model property target - a window, application or report
 * @author barney
 *
 */
public abstract class AbstractTarget extends PropertyObject
{
    private List<AbstractControl> controls = new ArrayList<AbstractControl>();
    private Map<Integer,AbstractControl> idlist=new HashMap<Integer, AbstractControl>();
    
    private int lastID;
    
    /** 
     * Add a control - a string, textbox, line etc
     * @param child
     * @return
     */
    public AbstractControl add(AbstractControl child) {
        controls.add(child);
        child.setOwner(this);
        return child;
    }

    public void remove(AbstractControl ac) {
        idlist.remove(ac.getUseID());
        controls.remove(ac);
    }
    
    
    
    public Collection<AbstractControl> getControls()
    {
        return controls;
    }

    /**
     * Register a control and return a use integer number. Use numbers
     * are how clarion models tracking of control entities.
     *  
     * @param control
     * @return
     */
    public int register(AbstractControl control) {
        while ( true ) {
            lastID++;
            if (!idlist.containsKey(lastID)) break;
        }
        control.setUseID(lastID);
        idlist.put(lastID,control);
        return lastID;
    }
    
    public int register(AbstractControl control,String val)
    {
        int result = this.register(control);
        control.setId(val);
        return result;
    }

    public int getLastID()
    {
        return lastID;
    }
    
    /**
     *  Return a given control object knowing its control number
     * @param control
     * @return
     */
    public AbstractControl getControl(int control) {
        return idlist.get(control);
    }

    /**
     * Return given control object knowing its control number 
     * @param control
     * @return
     */
    public AbstractControl getControl(ClarionNumber control) {
        return idlist.get(control.intValue());
    }
    
    /**
     * Register a control but force use number to a specific value
     * @param control
     * @param value
     * @return
     */
    public int register(AbstractControl control, int value) {
        lastID = value; 
        control.setUseID(lastID);
        idlist.put(lastID,control);
        return lastID;
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        return null;
    }

    @Override
    public ClarionObject getProperty(ClarionObject key,ClarionObject index) 
    {
        int ikey=key.intValue();

        if (ikey==Prop.CHILD) {
            int iindex=index.intValue();
            if (iindex<1 || iindex>controls.size()) return new ClarionString("0");
            return new ClarionNumber(controls.get(iindex-1).getUseID());
        }

        if (ikey==Prop.CHILDINDEX) {
            AbstractControl child = getControl(index.intValue());
            if (child==null) return new ClarionNumber(0);
            if (child.getParent()!=null) return new ClarionNumber(0);
            
            int count=0;
            for ( AbstractControl scan  : controls ) {
                count++;
                if (scan==child) {
                    return new ClarionNumber(count);
                }
            }
            return new ClarionNumber(0);
        }
        
        
        if (ikey==Prop.NEXTFIELD) {
            
            ControlIterator ci;
            int iindex=index.intValue();
            if (iindex==0) {
                ci=new ControlIterator(this);
            } else {
                AbstractControl c = getControl(iindex);
                if (c==null) {
                    // try forcing use ids for everything
                    
                    ci=new ControlIterator(this);
                    ci.setLoop(false);
                    ci.setScanDisabled(true);
                    ci.setScanHidden(true);
                    ci.setScanSheets(true);
                    while (ci.hasNext()) {
                        ci.next().getUseID();
                    }
                }
                c = getControl(iindex);
                if (c==null) return new ClarionNumber(0);
                ci=new ControlIterator(c,false);
            }
            ci.setLoop(false);
            ci.setScanDisabled(true);
            ci.setScanHidden(true);
            ci.setScanSheets(true);
            
            int result=0;
            if (ci.hasNext()) {
                result = ci.next().getUseID();
            }
            return new ClarionNumber(result);
        }
        
        // TODO Auto-generated method stub
        return super.getProperty(key,index);
    }
    
    private boolean isOpened;
    
    public boolean isOpened()
    {
    	return isOpened;
    }

	public void opened() {
		for (AbstractControl ac : controls) {
			opened(ac);
		}
		isOpened=true;
	}
	
	public void setClosed()
	{
		isOpened=false;
	}

	private void opened(AbstractControl ac) 
	{
		ac.opened();
		for (AbstractControl k : ac.getChildren() ) {
			opened(k);
		}
	}

	@Override
	public void clearMetaData() {
		isOpened=false;
		super.clearMetaData();
	}

	@Override
	protected void debugMetaData(StringBuilder sb) {
		// TODO Auto-generated method stub
		
	}

	
}