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

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.swing.gui.NetworkMetaData;

public class ListStyleProperty extends PropertyObject implements NetworkMetaData
{
    private AbstractListControl control;

    public ListStyleProperty(AbstractListControl control)
    {
        this.control=control;
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        return control;
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
    }

	@Override
	public Object getMetaData() {
		return getProperties();
	}
}
