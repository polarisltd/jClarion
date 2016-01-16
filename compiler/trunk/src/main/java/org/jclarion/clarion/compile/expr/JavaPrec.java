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
package org.jclarion.clarion.compile.expr;

/**
 * Java precedence constants
 * 
 * @author barney
 */

public class JavaPrec {
    public static final int POSTFIX=15;    // [] . () expr++, expr--
    public static final int UNARY=14;      // ++expr, --expr, +expr, -expr ~ !
    public static final int CREATE=13;     // new (type)expr
    public static final int MULTIPLY=12;   //
    public static final int ADD=11;        //
    public static final int SHIFT=10;      //
    public static final int RELATIONAL=9;  // < > etc
    public static final int EQUALITY=8;    // == != etc
    public static final int BAND=7;        // &
    public static final int BXOR=6;        // ^
    public static final int BOR=5;         // |
    public static final int AND=4;         // &&
    public static final int OR=3;          // ^^
    public static final int TERNARY=2;     // : ?
    public static final int ASSIGNMENT=1;  // = ?=

    public static final int LABEL=0;      // special type of precedence. Doesn't actually have a precedence
    
}
