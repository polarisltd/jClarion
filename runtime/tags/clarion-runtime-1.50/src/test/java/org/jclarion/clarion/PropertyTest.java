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

import junit.framework.TestCase;

public class PropertyTest extends TestCase
{
    public void testBoolProperty()
    {
        PropertyObject po = new PropertyObject() {

            @Override
            public PropertyObject getParentPropertyObject() {
                return null;
            }

            @Override
            protected void debugMetaData(StringBuilder sb) {
            } };
            
        po.setProperty(Prop.DISABLE,1);
        assertTrue(po.getProperty(Prop.DISABLE).boolValue());
        assertEquals("1",po.getProperty(Prop.DISABLE).toString());

        po.setProperty(Prop.DISABLE,0);
        assertFalse(po.getProperty(Prop.DISABLE).boolValue());
        assertEquals("0",po.getProperty(Prop.DISABLE).toString());
    }

}
