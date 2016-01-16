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

import org.jclarion.clarion.ClarionString;

public class SimpleClass {

    public ClarionString myString=new ClarionString("Hello");
    public SimpleClass   myClass;
    
    public String getString()
    {
        return "Hello";
    }
    
    public ClarionString getClarionString()
    {
        return new ClarionString("World");
    }
    
    public void setString(ClarionString in)
    {
        in.setValue("Blah");
    }

}
