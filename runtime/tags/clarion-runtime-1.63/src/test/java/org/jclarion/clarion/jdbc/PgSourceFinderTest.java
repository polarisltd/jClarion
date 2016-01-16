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
package org.jclarion.clarion.jdbc;

import junit.framework.TestCase;

public class PgSourceFinderTest extends TestCase {

    public void testGetHostData() {
        
        String s[]= PgSourceFinder.getHostData("test:ab:cd:1234");
        assertEquals(4,s.length);
        assertEquals("test",s[0]);
        assertEquals("ab",s[1]);
        assertEquals("cd",s[2]);
        assertEquals("1234",s[3]);
    }

}
