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

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.Create;

public class ReportBreak extends AbstractReportControl implements ReportContainer
{
    public ReportBreak setVariable(ClarionObject object)
    {
        use(object);
        return this;
    }

    @Override
    public ReportFooter getFooter() {
        for (AbstractControl ac : getChildren() ) {
            if (ac instanceof ReportFooter) {
                return (ReportFooter)ac;
            }
        }
        return null;
    }

    @Override
    public ReportHeader getHeader() {
        for (AbstractControl ac : getChildren() ) {
            if (ac instanceof ReportHeader) {
                return (ReportHeader)ac;
            }
        }
        return null;
    }

    @Override
    public int getCreateType() {
        return Create.BREAK;
    }
}
