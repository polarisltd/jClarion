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
package org.jclarion.clarion.runtime.ref;

import org.jclarion.clarion.ClarionNumber;

import junit.framework.TestCase;

public class RefVariableTest extends TestCase {

    
    public void testThis()
    {
        RefVariable<ClarionNumber> cn = new RefVariable<ClarionNumber>();
        doRoutine(cn);
        assertNotNull(cn.get());
    }
    
    public void doRoutine(RefVariable<ClarionNumber> cn) 
    {
        cn.set(new ClarionNumber());
    }
    
}
