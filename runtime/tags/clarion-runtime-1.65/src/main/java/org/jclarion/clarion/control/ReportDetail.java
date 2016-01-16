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

import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;

public class ReportDetail extends AbstractReportControl 
{
    public void print()
    {
        getReport().print(this);
    }
    
    public ReportDetail setWithPrior(int count)
    {
        setProperty(Prop.WITHPRIOR,count);
        return this;
    }

    public ReportDetail setAbsolute()
    {
        setProperty(Prop.ABSOLUTE,true);
        return this;
    }

    public ReportDetail setWithNext(int count)
    {
        setProperty(Prop.WITHNEXT,count);
        return this;
    }

    @Override
    public int getCreateType() {
        return Create.DETAIL;
    }
}
