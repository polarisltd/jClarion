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
package org.jclarion.clarion.compile;

import org.jclarion.clarion.lang.Constant;

import junit.framework.TestCase;

public class ConstantTest extends TestCase {

    public void testNumber()
    {
        assertEquals("16",Constant.number("16"));
        assertEquals("16",Constant.number("016"));
        assertEquals("0.16",Constant.number(".16"));
        assertEquals("0.16",Constant.number("00.16"));

        assertEquals("0x7fffffff",Constant.number("7fffffffh"));
        assertEquals("0x80000000",Constant.number("80000000h"));
        
        assertEquals("0x10",Constant.number("10h"));
        assertEquals("0x1f",Constant.number("1fh"));
        assertEquals("0x1f",Constant.number("1fH"));

        assertEquals("0x3f",Constant.number("77o"));
        assertEquals("0x3f",Constant.number("77O"));

        assertEquals("0x10",Constant.number("10000b"));
        assertEquals("0x10",Constant.number("10000B"));
    }
    
    public void testString()
    {
        assertEquals("\"hello\"",Constant.string("hello"));
        assertEquals("\"hel'lo\"",Constant.string("hel''lo"));
        assertEquals("\"hel\\\"lo\"",Constant.string("hel\"lo"));
        assertEquals("\"hel\\\\lo\"",Constant.string("hel\\lo"));
        assertEquals("\"hello\\r\"",Constant.string("hello\r"));
        assertEquals("\"hello\\n\"",Constant.string("hello\n"));
        assertEquals("\"hello\\u0009\"",Constant.string("hello<9>"));
        assertEquals("\"hello\\n\"",Constant.string("hello<10>"));
        assertEquals("\"hello\\r\\n\"",Constant.string("hello<13,10>"));

        assertEquals("\"helloo\"",Constant.string("hello{2}"));

        assertEquals("\"helloooo\"",Constant.string("hello{4}"));
        
        assertEquals("\"hello\\r\\n\\r\\n\\r\\n\\r\\n\"",Constant.string("hello<13,10>{4}"));
        
        assertEquals("\"<>\"",Constant.string("<>"));
        assertEquals("\"<stop>\"",Constant.string("<stop>"));
        assertEquals("\"<\"",Constant.string("<<"));

        assertEquals("\"{}\"",Constant.string("{}"));
        assertEquals("\"{\"",Constant.string("{{"));

        assertEquals("\"{{{{{\"",Constant.string("{{{5}"));
        assertEquals("\"{5}\"",Constant.string("{{5}"));

        assertEquals("\"<5>\"",Constant.string("<<5>"));
        assertEquals("\"A\"",Constant.string("<41h>"));
        assertEquals("\"A\"",Constant.string("<41H>"));
        assertEquals("\"A\"",Constant.string("<101o>"));
        assertEquals("\"A\"",Constant.string("<101O>"));
        assertEquals("\"A\"",Constant.string("<1000001b>"));
        assertEquals("\"A\"",Constant.string("<1000001B>"));
    }
}
