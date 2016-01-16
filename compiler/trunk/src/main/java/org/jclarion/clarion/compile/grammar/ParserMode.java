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
package org.jclarion.clarion.compile.grammar;

public enum ParserMode 
{
    DATA,       // parser is in a data block
    MAP,        // parser is in a map block
    MODULE,     // parser is in a module block (inside a map block)
    PROCEDURE,  // parser is in procedure definition scope
}
