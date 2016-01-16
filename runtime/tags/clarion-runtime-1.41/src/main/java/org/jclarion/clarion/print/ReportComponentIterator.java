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
package org.jclarion.clarion.print;

import java.util.Iterator;

import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.AbstractReportControl;

public class ReportComponentIterator implements Iterator<AbstractReportControl> 
{
    private AbstractReportControl base;
    private AbstractReportControl scan;
    
    public ReportComponentIterator(AbstractReportControl base)
    {
        this.base=base;
        this.scan=base;
    }

    @Override
    public boolean hasNext() 
    {
        return scan!=null;
    }

    @Override
    public AbstractReportControl next() 
    {
        if (scan==null) throw new IllegalStateException("Iterator Exhausted");
        AbstractReportControl result = scan;
        
        AbstractReportControl next = null;
        
        // go into child first
        AbstractControl contender = result.getChild(0);
        if (contender!=null && (contender instanceof AbstractReportControl) ) {
            next=(AbstractReportControl)contender;
        }
        
        // scan through parents looking for a sibling
        while ( scan!=null && next==null && scan!=base ) {
            AbstractControl parent = scan.getParent();
            if (parent==null) break;
            
            Iterator<? extends AbstractControl> siblingScan = parent.getChildren().iterator();
            while ( siblingScan.hasNext() ) {
                if (siblingScan.next()==scan) break;
            }
            
            if (siblingScan.hasNext()) {
                AbstractControl c_next = siblingScan.next(); 
                if (c_next instanceof AbstractReportControl) {
                    next = (AbstractReportControl)c_next;
                }
            }
            
            if (next==null) {
                scan=(AbstractReportControl) parent;
            }
        }
        
        scan=next;
        return result;
    }

    @Override
    public void remove() 
    {
    }

}
