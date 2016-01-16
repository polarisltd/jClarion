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

import java.io.CharArrayReader;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

public class ExprParserTest extends TestCase 
{
    public void testNotWrapping()
    {
        assertExpression("!(1>0)","~1>0");
        
        loadVar("V1   long\n");
        
        assertExpression("!(v1.compareTo(0)>0)","~v1>0");
        assertExpression("!v1.equals(0)","~v1=0");
        assertExpression("!!v1.equals(0)","~v1~=0");
    }
    
    public void testClarionAndOrXor()
    {
        assertExpression("1!=0 && 1!=0","1 AND 1");
        assertExpression("1!=0 && 1!=0 && 1!=0","1 AND 1 AND 1");

        assertExpression("1!=0 || 1!=0","1 OR 1");
        assertExpression("1!=0 || 1!=0 || 1!=0","1 OR 1 OR 1");
        assertExpression("1!=0 || 1!=0 || 1!=0","1 OR (1 OR 1)");

        assertExpression("1!=0 || 1!=0 && 1!=0","1 OR 1 AND 1");
        assertExpression("1!=0 || 1!=0 && 1!=0 || 1!=0","1 OR 1 AND 1 OR 1");
        assertExpression("1!=0 && 1!=0 || 1!=0","1 AND 1 OR 1");

        assertExpression("1!=0 && 1!=0 || 1!=0 || 1!=0","1 AND 1 OR 1 OR 1");
        assertExpression("1!=0 && 1!=0 || 1!=0 && 1!=0","1 AND 1 OR 1 AND 1");
        
        assertExpression("1!=0 ^ 1!=0","1 XOR 1");
        assertExpression("1!=0 ^ (1!=0 && 1!=0)","1 XOR 1 AND 1");
        assertExpression("(1!=0 && 1!=0) ^ 1!=0","1 AND 1 XOR 1");
    }

    
    public void testClarionNot()
    {
        assertExpression("!(1!=0)","NOT 1");
        assertExpression("!(1!=0 && 1!=0)","NOT (1 AND 1)");
        assertExpression("!(1!=0) && 1!=0","(NOT 1) AND 1");
        assertExpression("!(1!=0) && 1!=0","NOT 1 AND 1");
        assertExpression("!(1!=0) && 1!=0","~ 1 AND 1");
    }

    public void testConditional()
    {
        assertExpression("1>0","1>0");
        assertExpression("1<0","1<0");
        
        assertExpression("1>=0","1>=0");
        assertExpression("1<=0","1<=0");
        
        assertExpression("1>=0","1=>0");
        assertExpression("1<=0","1=<0");
        
        assertExpression("1>=0","1 not< 0");
        assertExpression("1<=0","1 not> 0");

        assertExpression("1<0","1not>=0");
        assertExpression("1>0","1not<=0");

        assertExpression("1==0","1=0");
        assertExpression("1!=0","1not=0");
        assertExpression("1!=0","1<>0");
        assertExpression("1!=0","1~=0");
        assertExpression("1==0","1not~=0");

        assertExpression("Clarion.newDecimal(\"1.0\").compareTo(1)>0","1.0>1");

        assertExpression("Clarion.newDecimal(\"1.0\").equals(1)","1.0=1");

        assertExpression("!Clarion.newDecimal(\"1.0\").equals(1)","1.0~=1");
        assertExpression("!Clarion.newDecimal(\"1.0\").equals(1) && 1>3","1.0~=1 AND 1>3");
    }

    public void testConcat()
    {
        assertExpression("ClarionString.staticConcat(\"hello \",\"world\")","'hello ' & 'world'");
        assertExpression("ClarionString.staticConcat(\"hello\",\" \",\"world\")","'hello' & ' ' & 'world'");
        assertExpression("ClarionString.staticConcat(\"hello\",10)","'hello' & 10");
        assertExpression("ClarionString.staticConcat(\"hello\",10,\"world\")","'hello' & 10 & 'world'");
    }
    
    public void testClarionMultiply()
    {
        assertExpression("1*1","1*1");
        assertExpression("1/1","1/1");
        assertExpression("1%1","1%1");
        assertExpression("1*(10%5)","1*(10%5)");
        
        assertExpression("Clarion.newDecimal(\"1.4\").multiply(6)","1.4*6");
        assertExpression("Clarion.newNumber(4).multiply(\"1.6\")","4*1.6");

        assertExpression("Clarion.newNumber(18/4).multiply(\"1.6\")","18/4*1.6");

        assertExpression("Clarion.newNumber(18/4).multiply(\"1.6\")","18/4*'1.6'");
        
        assertExpression("Clarion.newNumber(18).divide(\"4\").multiply(\"1.6\")","18/'4'*1.6");

        assertExpression("Clarion.newNumber(18).divide(Clarion.newNumber(4).multiply(\"1.6\"))","18/(4*1.6)");
    }    

    public void testClarionAdd()
    {
        assertExpression("1+1-2","1+1-2");
        assertExpression("1+1*7-2","1+1*7-2");
        assertExpression("1+1*(7-2)","1+1*(7-2)");
        assertExpression("1+(1-2)","1+(1-2)");

        assertExpression("Clarion.newString(\"1\").add(1).subtract(2)","'1'+1-2");
        assertExpression("Clarion.newString(\"1\").add(1*7).subtract(2)","'1'+1*7-2");
        assertExpression("Clarion.newString(\"1\").add(1*(7-2))","'1'+1*(7-2)");
        assertExpression("Clarion.newString(\"1\").add(1-2)","'1'+(1-2)");
    }    

    public void testClarionPower()
    {
        assertExpression("Clarion.newNumber(1).power(6)","1^6");
    }

    public void testArithmeticUnary()
    {
        assertExpression("-1","-1");
        assertExpression("1","+1");
        assertExpression("1*6","+(1*6)");
        assertExpression("-(1*6)","-(1*6)");

        assertExpression("Clarion.newDecimal(\"1.0\").negate()","-1.0");
        assertExpression("Clarion.newDecimal(\"1.0\").negate().multiply(6)","-1.0*6");
        assertExpression("Clarion.newDecimal(\"1.0\").multiply(6).negate()","-(1.0*6)");
    }
    
    public void testClarionInterestingPrecedenceFiddles()
    {
        assertExpression("4*8!=0 && 1!=0","4*8 AND 1");

        assertExpression("Clarion.newDecimal(\"1.0\").multiply(6).add(\"2.0\").negate()","-(1.0*6+2.0)");
        
        assertExpression("Clarion.newDecimal(\"1.0\").multiply(Clarion.newNumber(6).add(\"2.0\")).negate()","-(1.0*(6+2.0))");
    }
    
    public void testGetProperty()
    {
        assertExpression("Clarion.getControl(0).getProperty(1)","0{1}");
        assertExpression("Clarion.getControl(0).getProperty(1,2)","0{1,2}");
        assertExpression("Clarion.getControl(0).getProperty(1,2+1)","0{1,2+1}");
        assertExpression("Clarion.newNumber(0).add(Clarion.getControl(1).getProperty(1,2+1))","0+1{1,2+1}");
        assertExpression("Clarion.getControl(0+1).getProperty(1,2+1)","(0+1){1,2+1}");
    }

    public void testGetArraySplice()
    {
        assertExpression("Clarion.newString(\"hello\").stringAt(1)","'hello'[1]");
        assertExpression("Clarion.newString(\"hello\").stringAt(1*5,2)","'hello'[1*5:2]");
    }
    
    public void testExpressionList()
    {
        assertList("1)",LexType.rparam,"1");
        assertList("1",LexType.rparam,"1");
        assertList(")",LexType.rparam);
        assertList("",LexType.rparam,"null");

        assertList("'hello','world')",LexType.rparam,"\"hello\"","\"world\"");
        assertList("1,2)",LexType.rparam,"1","2");
        assertList("1,,2)",LexType.rparam,"1","null","2");
        assertList(",1,,2)",LexType.rparam,"null","1","null","2");
        assertList(",1,,2,)",LexType.rparam,"null","1","null","2","null");

        assertList("1,2",LexType.rparam,"1","2");
        assertList("1,,2",LexType.rparam,"1","null","2");
        assertList(",1,,2",LexType.rparam,"null","1","null","2");
        assertList(",1,,2,",LexType.rparam,"null","1","null","2","null");

        assertList(",)",LexType.rparam,"null","null");
        assertList(")",LexType.rparam);
        assertList(",",LexType.rparam,"null","null");
        assertList("",LexType.rparam,"null");
        
        Parser p = assertList(",)",LexType.rparam,"null","null");
        assertEquals(")",p.getLexer().next().value);

        p = assertList(",)",LexType.rcurl,"null","null");
        assertEquals(")",p.getLexer().next().value);

        p = assertList(",",LexType.rcurl,"null","null");
        assertSame(LexType.eof,p.getLexer().next().type);
            
    }

    public void testImplicitVariable()
    {
        assertExpression("_x_number.equals(1)","x#=1");
    }

    public void testEquateDefs()
    {
        loadVar("V1   equate(1)\n");
        loadVar("V2   equate(2)\n");
        loadVar("V3   equate(V1+V2)\n");
        loadVar("V4   equate(V2*2)\n");
        loadVar("V8   equate(0)\n");

        assertTrue(equateDef("1"));
        assertFalse(equateDef("0"));
        assertFalse(equateDef("V5"));
        assertTrue(equateDef("V1"));
        assertTrue(equateDef("2"));
        assertFalse(equateDef("V8"));
        assertTrue(equateDef("~V5"));
        assertFalse(equateDef("~V1"));
        assertTrue(equateDef("~V8"));
        assertTrue(equateDef("java"));

        assertTrue(equateDef("V3"));
        assertTrue(equateDef("V3=3"));
        assertFalse(equateDef("V3=4"));
        assertFalse(equateDef("~V3"));
    }
    
    public boolean equateDef(String in)
    {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        return p.equateDefinition();
    }

    private void loadVar(String var)
    {
        Lexer l = new Lexer(new CharArrayReader(var.toCharArray()));
        Parser p = new Parser(l);
        assertTrue(p.var.getVariable());
    }
    
    public Parser assertList(String in,LexType end,String... match)
    {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        l.setIgnoreWhitespace(true);
        
        Expr[] e = p.expressionList(end);
        assertEquals(e.length,match.length);
        for (int scan=0;scan<e.length;scan++) {
            assertEquals(match[scan],e[scan].toJavaString());
        }
        
        return p;
    }
    
    public void assertExpression(String out,String in)
    {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        l.setIgnoreWhitespace(true);
        
        String result = p.expression().toJavaString();
        assertEquals(result,out,result);
    }
    
}
