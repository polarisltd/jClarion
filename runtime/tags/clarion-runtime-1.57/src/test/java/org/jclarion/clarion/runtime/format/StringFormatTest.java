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
package org.jclarion.clarion.runtime.format;

import junit.framework.TestCase;

public class StringFormatTest extends TestCase 
{
    
    public void testSimpleStringFormat()
    {
        StringFormat s = new StringFormat("@s20");
        assertEquals(20,s.getMaxLen());
        assertEquals("$$$$$$$$$$$$$$$$$$$$",s.getPictureRepresentation());
        
        
        assertEquals("Hello World!",s.deformat("Hello World!       "));
        
        assertEquals("Hello World!        ",s.format("Hello World!"));
        assertFalse(s.isError());

        assertEquals("Hello World!        ",s.format("Hello World!                            "));
        assertFalse(s.isError());

        assertEquals(" Hello World!       ",s.format(" Hello World!                            "));
        assertFalse(s.isError());

        assertEquals(" Hello World!       ",s.format(" Hello World!                            x"));
        assertFalse(s.isError());

        s.setStrictMode();
        assertEquals("$$$$$$$$$$$$$$$$$$$$",s.format(" Hello World!                            x"));
        assertTrue(s.isError());
    }

}
