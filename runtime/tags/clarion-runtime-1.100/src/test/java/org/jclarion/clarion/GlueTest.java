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

import junit.framework.TestCase;

public class GlueTest extends TestCase
{
    public void testRepeatedGluesTriggersOutofMemory() throws InterruptedException
    {
        ClarionString cs = new ClarionString(1048576);
        cs.setValue("Hello");
        
        for (int scan=0;scan<100;scan++) {
            ClarionString base;
            base = new ClarionString(1048576);
            base.setOver(cs);
        }

        int last=101;
        
        while (true) {
            System.gc();
            Thread.yield();
            Thread.sleep(100);
            
            int now = cs.getListenerCount();
            if (now==0) break;
            assertFalse(last==now);
            last=now;
        }
       
    }
}
