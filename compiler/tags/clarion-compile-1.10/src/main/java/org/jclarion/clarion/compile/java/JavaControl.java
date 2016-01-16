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
package org.jclarion.clarion.compile.java;

public enum JavaControl {
    BREAK,          // break control flow       (in loops etc)
    CONTINUE,       // continue control flow    (in loops etc)
    RETURN,         // return control flow
    END,            // control statement cannot 'fall through' to subsequent statements
}
