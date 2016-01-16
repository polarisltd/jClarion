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
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.constants.Prop;

public abstract class AbstractReportControl extends AbstractControl implements ReportComponent
{
    private List<AbstractControl> controls=new ArrayList<AbstractControl>();
    
    public AbstractReportControl setPageBefore(int before)
    {
    	setProperty(Prop.PAGEBEFORE,true);
    	setProperty(Prop.PAGEBEFORENUM,before);
    	return this;
    }

    public AbstractReportControl setPageAfter(int after)
    {
    	setProperty(Prop.PAGEAFTER,true);
    	setProperty(Prop.PAGEAFTERNUM,after);
    	return this;
    }
    
    
    public AbstractReportControl add(AbstractControl control)
    {
        controls.add(control);
        control.setParent(this);
        return this;
    }

    public AbstractReportControl add(AbstractControl control,int offset)
    {
        controls.add(offset,control);
        control.setParent(this);
        return this;
    }
    
    @Override
    public List<AbstractControl> getChildren()
    {
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
    public ClarionReport getReport() {
        return (ClarionReport)getOwner();
    }

    @Override
    public ReportContainer getContainer() {
        return (ReportContainer)getParent();
    }

    @Override
    public void addChild(AbstractControl control) {
        this.add(control);
    }


    @Override
    public void addChild(AbstractControl control,int offset) {
        this.add(control,offset);
    }
    
    @Override
    public void removeChild(AbstractControl control) {
        controls.remove(control);
    }

    @Override
    public Component getComponent() {
        return null;
    }

    @Override
    public int getCreateType() {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        // TODO Auto-generated method stub
        
    }
    
    
    
}
