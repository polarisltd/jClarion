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
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.SwingTask;

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

    private class Refresh implements Runnable
    {
        @Override
        public void run() {
            JProgressBar b  = bar;
            if (b==null) return;
            if (getUseObject()==null) {
                b.setValue(getProperty(Prop.PROGRESS).intValue());
            } else {
                b.setValue(getUseObject().intValue());
            }
        }
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
        bar = new JProgressBar();
        parent.add(bar);
        
        ClarionObject co = getRawProperty(Prop.RANGELOW, false);
        bar.setMinimum(co!=null?co.intValue():0);
        co = getRawProperty(Prop.RANGEHIGH, false);
        bar.setMaximum(co!=null?co.intValue():0);

        refresh=new SwingTask(new Refresh());
        refresh.run();

        if (getUseObject()!=null) {
            listener=new ChangeListener();
            getUseObject().addChangeListener(listener);
        }

        configureDefaults(bar);
    }

    @Override
    protected void notifyLocalChange(int indx, final ClarionObject value) {
        switch (indx) {
            case Prop.RANGELOW:
                CWinImpl.run(new Runnable() {
                    public void run()
                    {
                        JProgressBar b =bar;
                        if (b!=null) b.setMinimum(value.intValue());
                    }
                });
                break;
            case Prop.RANGEHIGH:
                CWinImpl.run(new Runnable() {
                    public void run()
                    {
                        JProgressBar b =bar;
                        if (b!=null) b.setMaximum(value.intValue());
                    }
                });
                break;
            case Prop.PROGRESS:
                getWindowOwner().addAcceptTask(getUseID(), refresh);
                break;
        }
        super.notifyLocalChange(indx, value);
    }

    @Override
    public Component getComponent() {
        return bar;
    }
}
