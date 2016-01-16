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

import junit.framework.TestCase;

public class ExprCasterTest extends TestCase {

    // 11 * 11 = 121 possible combos
    
    public void testRawInt()
    {
        assertCast("10",ExprType.rawint,ExprType.rawint,"10");
        assertCast("10",ExprType.rawint,ExprType.rawstring,"String.valueOf(10)");
        assertCast("10",ExprType.rawint,ExprType.rawdecimal,"String.valueOf(10)");
        assertCast("10",ExprType.rawint,ExprType.rawboolean,"10!=0");
        assertCast("10",ExprType.rawint,ExprType.string,"Clarion.newString(String.valueOf(10))");
        assertCast("10",ExprType.rawint,ExprType.number,"Clarion.newNumber(10)");
        assertCast("10",ExprType.rawint,ExprType.decimal,"Clarion.newDecimal(10)");
        assertCast("10",ExprType.rawint,ExprType.bool,"Clarion.newBool(10)");
        assertCast("10",ExprType.rawint,ExprType.any,"Clarion.newNumber(10)");

        assertCast("\"hi\"",ExprType.rawstring,ExprType.rawint,"Clarion.newNumber(\"hi\").intValue()");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.rawstring,"\"hi\"");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.rawdecimal,"\"hi\"");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.rawboolean,"\"hi\".length()!=0");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.string,"Clarion.newString(\"hi\")");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.number,"Clarion.newNumber(\"hi\")");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.decimal,"Clarion.newDecimal(\"hi\")");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.bool,"Clarion.newBool(\"hi\")");
        assertCast("\"hi\"",ExprType.rawstring,ExprType.any,"Clarion.newString(\"hi\")");

        assertCast("\"10\"",ExprType.rawdecimal,ExprType.rawint,"Clarion.newDecimal(\"10\").intValue()");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.rawstring,"\"10\"");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.rawdecimal,"\"10\"");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.rawboolean,"Clarion.newDecimal(\"10\").boolValue()");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.string,"Clarion.newString(\"10\")");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.number,"Clarion.newNumber(\"10\")");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.decimal,"Clarion.newDecimal(\"10\")");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.bool,"Clarion.newBool(\"10\")");
        assertCast("\"10\"",ExprType.rawdecimal,ExprType.any,"Clarion.newDecimal(\"10\")");

        assertCast("true",ExprType.rawboolean,ExprType.rawint,"true?1:0");
        assertCast("true",ExprType.rawboolean,ExprType.rawstring,"true?\"1\":\"\"");
        assertCast("true",ExprType.rawboolean,ExprType.rawdecimal,"true?\"1\":\"0\"");
        assertCast("true",ExprType.rawboolean,ExprType.rawboolean,"true");
        assertCast("true",ExprType.rawboolean,ExprType.string,"Clarion.newString(true)");
        assertCast("true",ExprType.rawboolean,ExprType.number,"Clarion.newNumber(true)");
        assertCast("true",ExprType.rawboolean,ExprType.decimal,"Clarion.newDecimal(true)");
        assertCast("true",ExprType.rawboolean,ExprType.bool,"Clarion.newBool(true)");
        assertCast("true",ExprType.rawboolean,ExprType.any,"Clarion.newBool(true)");

        assertCast("v",ExprType.string,ExprType.rawint,"v.intValue()");
        assertCast("v",ExprType.string,ExprType.rawstring,"v.toString()");
        assertCast("v",ExprType.string,ExprType.rawdecimal,"v.toString()");
        assertCast("v",ExprType.string,ExprType.rawboolean,"v.boolValue()");
        assertCast("v",ExprType.string,ExprType.string,"v");
        assertCast("v",ExprType.string,ExprType.number,"v.getNumber()");
        assertCast("v",ExprType.string,ExprType.decimal,"v.getDecimal()");
        assertCast("v",ExprType.string,ExprType.bool,"v.getBool()");
        assertCast("v",ExprType.string,ExprType.any,"v");

        assertCast("v",ExprType.number,ExprType.rawint,"v.intValue()");
        assertCast("v",ExprType.number,ExprType.rawstring,"v.toString()");
        assertCast("v",ExprType.number,ExprType.rawdecimal,"v.toString()");
        assertCast("v",ExprType.number,ExprType.rawboolean,"v.boolValue()");
        assertCast("v",ExprType.number,ExprType.string,"v.getString()");
        assertCast("v",ExprType.number,ExprType.number,"v");
        assertCast("v",ExprType.number,ExprType.decimal,"v.getDecimal()");
        assertCast("v",ExprType.number,ExprType.bool,"v.getBool()");
        assertCast("v",ExprType.number,ExprType.any,"v");

        assertCast("v",ExprType.decimal,ExprType.rawint,"v.intValue()");
        assertCast("v",ExprType.decimal,ExprType.rawstring,"v.toString()");
        assertCast("v",ExprType.decimal,ExprType.rawdecimal,"v.toString()");
        assertCast("v",ExprType.decimal,ExprType.rawboolean,"v.boolValue()");
        assertCast("v",ExprType.decimal,ExprType.string,"v.getString()");
        assertCast("v",ExprType.decimal,ExprType.number,"v.getNumber()");
        assertCast("v",ExprType.decimal,ExprType.decimal,"v");
        assertCast("v",ExprType.decimal,ExprType.bool,"v.getBool()");
        assertCast("v",ExprType.decimal,ExprType.any,"v");

        assertCast("v",ExprType.bool,ExprType.rawint,"v.intValue()");
        assertCast("v",ExprType.bool,ExprType.rawstring,"v.toString()");
        assertCast("v",ExprType.bool,ExprType.rawdecimal,"v.toString()");
        assertCast("v",ExprType.bool,ExprType.rawboolean,"v.boolValue()");
        assertCast("v",ExprType.bool,ExprType.string,"v.getString()");
        assertCast("v",ExprType.bool,ExprType.number,"v.getNumber()");
        assertCast("v",ExprType.bool,ExprType.decimal,"v.getDecimal()");
        assertCast("v",ExprType.bool,ExprType.bool,"v");
        assertCast("v",ExprType.bool,ExprType.any,"v");
        
        assertCast("v",ExprType.any,ExprType.rawint,"v.intValue()");
        assertCast("v",ExprType.any,ExprType.rawstring,"v.toString()");
        assertCast("v",ExprType.any,ExprType.rawdecimal,"v.toString()");
        assertCast("v",ExprType.any,ExprType.rawboolean,"v.boolValue()");
        assertCast("v",ExprType.any,ExprType.string,"v.getString()");
        assertCast("v",ExprType.any,ExprType.number,"v.getNumber()");
        assertCast("v",ExprType.any,ExprType.decimal,"v.getDecimal()");
        assertCast("v",ExprType.any,ExprType.bool,"v.getBool()");
        assertCast("v",ExprType.any,ExprType.any,"v");
    }
    
    public void assertCast(String in,ExprType from,ExprType to,String out)
    {
        SimpleExpr se = new SimpleExpr(JavaPrec.LABEL,from,in);
        assertEquals(out,to.cast(se).toJavaString());
    }
    
}
