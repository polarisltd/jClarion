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
package org.jclarion;

import org.jclarion.clarion.swing.*;

import junit.framework.Test;
import junit.framework.TestSuite;

public class WindowSuite extends TestSuite
{
    public static Test suite() {
        TestSuite ts = new TestSuite();


        ts.addTestSuite(MenuTest.class);
        ts.addTestSuite(CheckTest.class);
        return ts;
    }
    
    
}
