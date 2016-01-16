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
package org.jclarion.clarion.lang;


public class Lex 
{
    public LexType     type;
    public String   value;
    
    
    public Lex(LexType type,String value)
    {
        this.type=type;
        this.value=value;
    }
    
    public String toString()
    {
        return type+":"+value;
    }
}
