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

import javax.swing.JProgressBar;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;

public class ProgressControl extends AbstractControl {

    public ProgressControl setSmooth()
    {
        return this;
    }
    
    public ProgressControl setRange(int lo,int hi)
    {
        setProperty(Prop.RANGELOW,lo);
        setProperty(Prop.RANGEHIGH,hi);
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
        return Create.PROGRESS;
    }
    
    private class ChangeListener implements ClarionMemoryChangeListener
    {
        public void objectChanged(ClarionMemoryModel _model) 
        {
            getWindowOwner().addAcceptTask(getUseID(),refresh);
        }
    }

    private JProgressBar bar;
    private Runnable     refresh;
    private ChangeListener listener;
    
    @Override
    public void clearMetaData() {
        bar=null;
        refresh=null;
        listener=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"bar",bar);
        debugMetaData(sb,"refresh",refresh);
        debugMetaData(sb,"listener",listener);
    }
    
    @Override
    public void constructSwingComponent(Container parent) {
    	if (bar!=null) return;
        bar = new JProgressBar();
        addComponent(parent,bar);
        
        ClarionObject co = getRawProperty(Prop.RANGELOW, false);
        bar.setMinimum(co!=null?co.intValue():0);
        co = getRawProperty(Prop.RANGEHIGH, false);
        bar.setMaximum(co!=null?co.intValue():0);

        handleRefresh();
        
        configureDefaults(bar);
    }

    @Override
    public void opened()
    {
        if (getUseObject()!=null) {
            listener=new ChangeListener();
            getUseObject().addChangeListener(listener);
        }
	if (refresh==null) {    	
	        refresh=new Refresh();
	}
    }
    
    
    @Override
	protected Object[] getRefreshParams() {
    	if (getUseObject()==null) return null;
    	return new Object[] { getUseObject() };
	}

	@Override
	protected void handleRefresh(Object... params) {
        JProgressBar b  = bar;
        if (b==null) return;
        if (params.length==1) {
            b.setValue(((ClarionObject)params[0]).intValue());
            return;
        }
        if (getUseObject()==null) {
            b.setValue(getProperty(Prop.PROGRESS).intValue());
        } else {
            b.setValue(getUseObject().intValue());
        }
	}

	@Override
	protected void handleAWTChange(int indx, ClarionObject value) {
        switch (indx) {
        	case Prop.RANGELOW: {
                JProgressBar b =bar;
                if (b!=null) b.setMinimum(value.intValue());
            }
        	case Prop.RANGEHIGH: {
                JProgressBar b =bar;
                if (b!=null) b.setMaximum(value.intValue());
                return;
        	}
        }
        super.handleAWTChange(indx, value);
	}

	@Override
	protected boolean isAWTChange(int indx) {
        switch (indx) {
        	case Prop.RANGELOW:
        	case Prop.RANGEHIGH:
        		return true;
        }
		return super.isAWTChange(indx);
	}

	@Override
    protected void doNotifyLocalChange(int indx, final ClarionObject value) {
		if (indx==Prop.PROGRESS) {
            getWindowOwner().addAcceptTask(getUseID(), refresh);
            return;
        }
        super.doNotifyLocalChange(indx, value);
    }

    @Override
    public Component getComponent() {
        return bar;
    }
}
