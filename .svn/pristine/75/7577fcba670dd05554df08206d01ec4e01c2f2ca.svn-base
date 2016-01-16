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
package org.jclarion.clarion.compile.hook;

import junit.framework.TestCase;

public class HookEntryTest extends TestCase {

    public void testContents()
    {
        assertContents("hello world","hello world");
        assertContents("hello Andrew!","hello $name$!");
        assertContents("hello Andrew","hello $name$");
        assertContents("Andrew hello","$name$ hello");
        assertContents("he$llo Andrew!","he$llo $name$!");
        assertContents("he$llo Andrew!$","he$llo $name$!$");
        assertContents("he$llo Andrew!$from$","he$llo $name$!$from$");
    }

    
    public void assertContents(String out,String template)
    {
        HookEntry he = new HookEntry();
        he.setContents(template);
        
        assertEquals(out,he.getContents(new HookContentResolver() {

            @Override
            public String resolve(String key) {
                if (key.equals("name")) return "Andrew";
                return null;
            } } ));
    }
}
