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
package org.jclarion.clarion.view;

import org.jclarion.clarion.ClarionObject;

public class ViewProject implements ViewField 
{
    ClarionObject fields[];
    
    public ViewProject setFields(ClarionObject fields[]) {
        this.fields=fields;
        return this;
    }

    public ViewProject setField(ClarionObject field) {
        this.fields=new ClarionObject[] { field };
        return this;
    }

    @Override
    public ClarionObject getField() {
        return null;
    }

    @Override
    public Iterable<ViewField> getSubFields() {
        return new ViewFieldArray(fields);
    }
}
