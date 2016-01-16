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

public class ReportFooter extends AbstractReportControl
{
    public ReportFooter setWithPrior(int count)
    {
        setProperty(Prop.WITHPRIOR,count);
        return this;
    }

    @Override
    public int getCreateType() {
        return Create.FOOTER;
    }
}
