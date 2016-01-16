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

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

public class VariableParserTest extends TestCase {

    public void setUp()
    {
        ClarionCompiler.clean();
    }
    
    public void testSimpleByte()
    {
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.BYTE)","byte");

        assertVariable("ClarionNumber anon=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE)","byte(0)");

        assertVariable("ClarionNumber anon=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE)","byte(2)");

        assertVariable("ClarionNumber anon=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE)","byte(2),private,auto");

        assertVariable("ClarionNumber anon=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE)","BYte(2),private,auto");

        assertVariable("ClarionNumber anon=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE)","BYte(2)");

        assertVariable("ClarionNumber anon=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE).setName(\"bob\")","BYte(2),name('bob')");

        assertVariable("ClarionNumber[] anon=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE).dim(10)","BYte(2),dim(10)");
        
        assertVariable("ClarionNumber[][] anon=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE).dim(10,15/5)","BYte(2),dim(10),dim(15/5)");
    }

    public void testNumberTypes()
    {
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.BYTE)","byte");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.LONG)","long");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.SHORT)","short");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.ULONG)","ulong");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.USHORT)","ushort");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.TIME)","time");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.DATE)","date");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED)","signed");
        assertVariable("ClarionNumber anon=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED)","unsigned");

        assertVariable("ClarionReal anon=Clarion.newReal()","real");
        assertVariable("ClarionBool anon=Clarion.newBool()","bool");
    }

    public void testOver()
    {
        assertVariable2("v1","ClarionNumber v1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE)","v1 byte");
        assertVariable2("v2","ClarionNumber v2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).setOver(v1)","v2 byte,over(v1)");
    }
    
    public void testAny()
    {
        assertVariable("ClarionAny anon=Clarion.newAny()","any");
    }

    public void testString()
    {
        assertVariable("ClarionString anon=Clarion.newString()","string");
        assertVariable("ClarionString anon=Clarion.newString(10)","string(10)");
        assertVariable("ClarionString anon=Clarion.newString(\"hello\")","string('hello')");
        assertVariable("ClarionString anon=Clarion.newString(\"          \")","string(' {10}')");

        assertVariable("ClarionString anon=Clarion.newString().setEncoding(ClarionString.CSTRING)","CString");
        assertVariable("ClarionString anon=Clarion.newString().setEncoding(ClarionString.PSTRING)","pstring");
        assertVariable("ClarionString anon=Clarion.newString().setEncoding(ClarionString.ASTRING)","astring");
    }
    
    public void testDecimal()
    {
        assertVariable("ClarionDecimal anon=Clarion.newDecimal()","decimal");
        assertVariable("ClarionDecimal anon=Clarion.newDecimal(1,0)","decimal(1)");
        assertVariable("ClarionDecimal anon=Clarion.newDecimal(1,0)","decimal(1,0)");
        assertVariable("ClarionDecimal anon=Clarion.newDecimal(10,2)","decimal(10,2)");
        assertVariable("ClarionDecimal anon=Clarion.newDecimal(10,2,5)","decimal(10,2,5)");
        assertVariable("ClarionDecimal anon=Clarion.newDecimal(10,2,\"5.3\")","decimal(10,2,5.3)");

        assertVariable("ClarionDecimal anon=Clarion.newDecimal(10,2,\"5.3\").setEncoding(ClarionDecimal.PDECIMAL)","pdecimal(10,2,5.3)");
    }

    public void testLikePrimitive()
    {
        assertVariable2("v1","ClarionNumber v1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE)","v1 byte");
        assertVariable2("v2","ClarionNumber v2=v1.like()","v2 like(v1)");
    }

    public void testLikeDim()
    {
        Variable v1 = assertVariable2("v1","ClarionNumber[] v1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(1)","v1 byte,dim(1)");
        ScopeStack.getScope().addVariable(v1);
        assertVariable2("v2","ClarionNumber[] v2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(1)","v2 like(v1)");
    }
    
    
    public Variable assertVariable(String out,String in)
    {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        
        Variable result = p.var.dataDefinition();
        String r = result.generate();
        assertEquals(r,out,r);
        
        return result;
    }

    public Variable assertVariable2(String key,String out,String in)
    {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        
        assertTrue(p.var.getVariable());
        Variable result = ScopeStack.getScope().getVariable(key);
        String r = result.generate();
        assertEquals(r,out,r);
        
        return result;
    }
    
    
}
