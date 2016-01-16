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
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

/**
 * Test statements. Tests preferentially go for compilation of java and
 * testing resultant java. What code does is (slightly) more important than how
 * it looks
 * 
 * @author barney
 *
 */

public class StatementParserTest extends TestCase 
{
    public void setUp()
    {
        ClarionCompiler.clean();
    }
    
    public void testVariableAssignment()
    {
        Lexer l = new Lexer(new CharArrayReader(get(
                "test    byte\n",
                "    test=1\n").toCharArray()));
        
        Parser p = new Parser(l);
        
        p.var.getVariable();
        
        JavaCode ja = p.stmt.code();
        
        assertSame(LexType.eof,l.next().type);
        
        assertEquals("test.setValue(1);\n",ja.write(0,false));
    }
    
    public void testVariableAssignmentInCodeContext()
    {
        compileProgram(get(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test=1\n"));
        
        String source = ClassRepository.get("Main").toJavaSource();
        
        assertEquals(source,get(
                "package clarion;\n",
                "\n",
                "import org.jclarion.clarion.Clarion;\n",
                "import org.jclarion.clarion.ClarionNumber;\n",
                "import org.jclarion.clarion.crash.Crash;\n",
                "import org.jclarion.clarion.runtime.CRun;\n",
                "\n",
                "public class Main\n",
                "{\n",
                "\tpublic static ClarionNumber test;\n",
                "\n",
                "\tpublic static void init()\n",
                "\t{\n",
                "\t\tCRun.shutdown();\n",
                "\t\ttest=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);\n",
                "\t}\n",
                "\tstatic { init(); }\n",
                "\n",
                "\tpublic static void destroy()\n",
                "\t{\n",
                "\t}\n",
                "\tpublic static void main(String[] args)\n",
                "\t{\n",
                "\t\ttry { init(); begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { destroy(); }\n",
                "\t}\n",
                "\tpublic static void begin(String[] args)\n",
                "\t{\n",
                "\t\tCRun.init(args);\n",
                "\t\ttest.setValue(1);\n",
                "\t}\n",
                "}\n"),source);
        
    }

    public void testCompileAssignment()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test=1\n");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(1,test.intValue());
    }

    public void testCompileAssignmentWithPrecedenceExceedingConditional()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "t2  byte(1)\n",
                "    code\n",
                "    test=1+t2\n");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
    }
    
    
    public void testCompileReference()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  &byte\n",
                "    code\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertNull(test);
    }

    public void testAssignReferenceNulls()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test1  &byte\n",
                "test2  &byte\n",
                "    code\n",
                "    test1 &= test2\n",
                "");
        
        ClarionObject test1 = getMainVariable(cl,"test1");
        ClarionObject test2 = getMainVariable(cl,"test2");
        assertNull(test1);
        assertNull(test2);
        runClarionProgram(cl);
        assertNull(test1);
        assertNull(test2);
    }
    
    
    public void testCompileNew()
    {
        ClassLoader cl = compile(
                "    program\n",
                "t1    &byte\n",
                "t2    &byte\n",
                "    code\n",
                "    t1&=new byte\n",
                "    t2&=new byte\n",
                "    t1=2\n",
                "    t2=t1+4\n",
                "");
        
        ClarionObject t1,t2;
        
        t1= getMainVariable(cl,"t1");
        t2= getMainVariable(cl,"t2");
        assertNull(t1);
        assertNull(t2);
        runClarionProgram(cl);
        t1= getMainVariable(cl,"t1");
        t2= getMainVariable(cl,"t2");
        assertNotNull(t1);
        assertNotNull(t2);
        assertNotSame(t1,t2);
        assertEquals(2,t1.intValue());
        assertEquals(6,t2.intValue());
        
        ClarionObject ot1,ot2;
        ot1=t1;
        ot2=t2;
        
        runClarionProgram(cl);
        t1= getMainVariable(cl,"t1");
        t2= getMainVariable(cl,"t2");
        assertNotNull(t1);
        assertNotNull(t2);
        assertNotSame(t1,t2);
        assertEquals(2,t1.intValue());
        assertEquals(6,t2.intValue());
        assertNotSame(ot1,t1);
        assertNotSame(ot2,t2);
    }

    public void testCompileNewAndAssign()
    {
        ClassLoader cl = compile(
                "    program\n",
                "t1    &byte\n",
                "t2    &byte\n",
                "    code\n",
                "    t1&=new byte\n",
                "    t1=2\n",
                "    t2&=t1\n",
                "");
        
        ClarionObject t1,t2;
        
        t1= getMainVariable(cl,"t1");
        t2= getMainVariable(cl,"t2");
        assertNull(t1);
        assertNull(t2);
        runClarionProgram(cl);
        t1= getMainVariable(cl,"t1");
        t2= getMainVariable(cl,"t2");
        assertNotNull(t1);
        assertNotNull(t2);
        assertSame(t1,t2);
        assertEquals(2,t1.intValue());
    }

    public void testCompileVariousSizes()
    {
        ClassLoader cl = compile(
                "    program\n",
                "size  long\n",
                "result &string\n",
                "    code\n",
                "    result&=new string(size)\n",
                "");
        
        ClarionObject size;
        ClarionObject result;
        
        size= getMainVariable(cl,"size");
        result= getMainVariable(cl,"result");
        assertNull(result);

        size.setValue(5);
        runClarionProgram(cl);
        result= getMainVariable(cl,"result");
        assertNotNull(result);
        assertEquals(5,result.getString().len());

        size.setValue(16);
        runClarionProgram(cl);
        result= getMainVariable(cl,"result");
        assertNotNull(result);
        assertEquals(16,result.getString().len());
        
    }
    

    public void testCompileVariousSizes2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "size  long\n",
                "result &string\n",
                "    code\n",
                "    result&=new ( string(size+1) )\n",
                "");
        
        ClarionObject size;
        ClarionObject result;
        
        size= getMainVariable(cl,"size");
        result= getMainVariable(cl,"result");
        assertNull(result);

        size.setValue(5);
        runClarionProgram(cl);
        result= getMainVariable(cl,"result");
        assertNotNull(result);
        assertEquals(6,result.getString().len());

        size.setValue(16);
        runClarionProgram(cl);
        result= getMainVariable(cl,"result");
        assertNotNull(result);
        assertEquals(17,result.getString().len());
    }
    
    public void testCompileExpression()
    {
        assertCompileExpression("hello     ","'hello'");
        assertCompileExpression("20.6      ","10.3*2");
        assertCompileExpression("1         ","(1>0)");
        assertCompileExpression("          ","(1<0)");
    }
    
    public void testSimpleIfOk()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test=1\n", 
                "    if test=1\n",
                "        test=2\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
    }

    public void testIncAssignment()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test+=1\n");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(1,test.intValue());
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
    }

    public void testDecAssignment()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test-=1\n");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(-1,test.intValue());
        runClarionProgram(cl);
        assertEquals(-2,test.intValue());
        runClarionProgram(cl);
        assertEquals(-3,test.intValue());
    }

    public void testMulAssignment()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    test*=3\n");
        
        ClarionObject test = getMainVariable(cl,"test");
        
        assertEquals(1,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(9,test.intValue());
        runClarionProgram(cl);
        assertEquals(27,test.intValue());
        runClarionProgram(cl);
        assertEquals(81,test.intValue());
        runClarionProgram(cl);
        assertEquals(243,test.intValue());
    }
    
    
    
    public void testSimpleIfNotOk()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test=1\n", 
                "    if test~=1\n",
                "        test=2\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(1,test.intValue());
    }

    public void testSimpleIfElse()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test=1\n", 
                "    if test=1\n",
                "        test=2\n",
                "    else\n",
                "        test=3\n",
                "    end\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
    }
    
    public void testSimpleIfElse2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte\n",
                "    code\n",
                "    test=1\n", 
                "    if test~=1\n",
                "        test=2\n",
                "    else\n",
                "        test=3\n",
                "    end\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        assertEquals(0,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
    }

    public void testPacked1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test=1 then test=2\n",
                "    else\n",
                "        test=3\n",
                "    end\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
    }
    
    public void testPacked2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test=1 then test=2 else test=3\n",
                "    end\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
    }

    public void testPacked3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test=1 then test=2 else test=3 end\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
    }

    public void testPacked4()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test=1 then test=2 else test=3 .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
    }

    public void testPacked5()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test=1 then test=2 else test=3.\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
    }

    public void testElsIf()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test=1\n",
                "       test=2\n",
                "    elsif test=2\n",
                "       test=3\n",
                "    else\n",
                "       test=5\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(5,test.intValue());
        runClarionProgram(cl);
        assertEquals(5,test.intValue());
        runClarionProgram(cl);
        assertEquals(5,test.intValue());
    }

    
    public void testElsIf2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test=1\n",
                "       test=2\n",
                "    elsif test=2\n",
                "       test=3\n",
                "    elsif test=3\n",
                "       test=4\n",
                "    else\n",
                "       test=5\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(4,test.intValue());
        runClarionProgram(cl);
        assertEquals(5,test.intValue());
        runClarionProgram(cl);
        assertEquals(5,test.intValue());
    }
    

    public void testReturn()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    return\n",
                "    test=2\n",
                "");

        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(1,test.intValue());
    }

    public void testIncrement()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    test=test+1\n",
                "");

        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(4,test.intValue());
    }
    
    public void testIfStatement()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if command(1)='1'\n",
                "       test=1\n",
                "    elsif command(1)='2'\n",
                "       test=2\n",
                "    else\n",
                "       test=3\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl,"1");
        assertEquals(1,test.intValue());
        runClarionProgram(cl,"2");
        assertEquals(2,test.intValue());
        runClarionProgram(cl,"3");
        assertEquals(3,test.intValue());
        runClarionProgram(cl,"4");
        assertEquals(3,test.intValue());
    }

    public void testIfReturnCombo()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test>5\n",
                "       return\n",
                "    .\n",
                "    test=test+1\n",
                "");

        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(4,test.intValue());
        runClarionProgram(cl);
        assertEquals(5,test.intValue());
        runClarionProgram(cl);
        assertEquals(6,test.intValue());
        runClarionProgram(cl);
        assertEquals(6,test.intValue());
        runClarionProgram(cl);
        assertEquals(6,test.intValue());
    }

    public void testIfReturnComboWithUnreachableCode()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "    code\n",
                "    if test>5\n",
                "       return\n",
                "    else\n",
                "       test=test+1\n",
                "       return\n",
                "    .\n",
                "    test=test+2\n",
                "    return\n",
                "");

        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(2,test.intValue());
        runClarionProgram(cl);
        assertEquals(3,test.intValue());
        runClarionProgram(cl);
        assertEquals(4,test.intValue());
        runClarionProgram(cl);
        assertEquals(5,test.intValue());
        runClarionProgram(cl);
        assertEquals(6,test.intValue());
        runClarionProgram(cl);
        assertEquals(6,test.intValue());
        runClarionProgram(cl);
        assertEquals(6,test.intValue());
    }

    public void testSimpleCaseStatement()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "    code\n",
                "    case test\n",
                "       of 1\n",
                "           out=1\n",
                "       of 2\n",
                "           out=2\n",
                "       of 3\n",
                "           out=3\n",
                "       of 4\n",
                "           out=5\n",
                "       of 5\n",
                "           out=7\n",
                "       of 6\n",
                "           out=11\n",
                "       of 7\n",
                "           out=13\n",
                "       of 8\n",
                "           out=17\n",
                "    .\n",
                "    test=test+1\n",
                "");

        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
    
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());

        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());

        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(3,out.intValue());

        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(5,out.intValue());

        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(7,out.intValue());

        test.setValue(6);
        runClarionProgram(cl);
        assertEquals(11,out.intValue());

        test.setValue(7);
        runClarionProgram(cl);
        assertEquals(13,out.intValue());

        test.setValue(8);
        out.setValue(-1);
        runClarionProgram(cl);
        assertEquals(17,out.intValue());

        test.setValue(9);
        out.setValue(-1);
        runClarionProgram(cl);
        assertEquals(-1,out.intValue());
    }

    
    public void testSimpleCaseStatementPacked()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "    code\n",
                "    case test\n",
                "       of 1 ; out=1\n",
                "       of 2 ; out=2\n",
                "       of 3 ; out=3\n",
                "       of 4 ; out=5\n",
                "       of 5 ; out=7\n",
                "       of 6 ; out=11\n",
                "       of 7 ; out=13\n",
                "       of 8 ; out=17\n",
                "    .\n",
                "    test=test+1\n",
                "");

        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
    
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());

        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());

        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(3,out.intValue());

        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(5,out.intValue());

        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(7,out.intValue());

        test.setValue(6);
        runClarionProgram(cl);
        assertEquals(11,out.intValue());

        test.setValue(7);
        runClarionProgram(cl);
        assertEquals(13,out.intValue());

        test.setValue(8);
        out.setValue(-1);
        runClarionProgram(cl);
        assertEquals(17,out.intValue());

        test.setValue(9);
        out.setValue(-1);
        runClarionProgram(cl);
        assertEquals(-1,out.intValue());
    }

    
    public void testCaseStatementElse()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "    code\n",
                "    case test\n",
                "       of 1 ; out=1\n",
                "       of 2 ; out=2\n",
                "       else\n",
                "          out=99\n",
                "    .\n",
                "    test=test+1\n",
                "");

        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
    
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());

        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());

        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(99,out.intValue());
    }

    
    public void testCaseStatementRange()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "    code\n",
                "    case test\n",
                "       of 1 to 5 ; out=1\n",
                "       of 6 to 10 ; out=2\n",
                "       else\n",
                "          out=99\n",
                "    .\n",
                "    test=test+1\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
    
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());

        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());

        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());

        test.setValue(6);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());

        test.setValue(10);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());

        test.setValue(11);
        runClarionProgram(cl);
        assertEquals(99,out.intValue());

        test.setValue(-1);
        runClarionProgram(cl);
        assertEquals(99,out.intValue());
    }

    
    public void testOrOfFallThrough()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "out2  byte\n",
                "    code\n",
                "    case test\n",
                "       of 1 ; out=1\n",
                "       orof 2 ; out2=1\n",
                "       of 3 ; out=2\n",
                "       orof 4 ; out2=2\n",
                "       else\n",
                "          out=99\n",
                "    .\n",
                "    test=test+1\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
        ClarionObject out2 = getMainVariable(cl,"out2");
    
        out.setValue(0);out2.setValue(0);
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(99,out.intValue());
        assertEquals(0,out2.intValue());
    }


    
    public void testCaseReturnBreaks()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "out2  byte\n",
                "    code\n",
                "    case test\n",
                "       of 1 ; out=1\n",
                "       orof 2 ; out2=1\n",
                "           return;\n",
                "       of 3 ; out=2\n",
                "       orof 4 ; out2=2\n",
                "           return;\n",
                "       else\n",
                "          out=99\n",
                "          return;\n",
                "    .\n",
                "    test=test+1\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
        ClarionObject out2 = getMainVariable(cl,"out2");
    
        out.setValue(0);out2.setValue(0);
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(99,out.intValue());
        assertEquals(0,out2.intValue());
    }
    
    public void testCaseReturnBreaks2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "out2  byte\n",
                "    code\n",
                "    case test\n",
                "       of 1 ; out=1\n",
                "       orof 2 ; out2=1\n",
                "           return;\n",
                "       of 3 ; out=2\n",
                "           return;\n",
                "       orof 4 ; out2=2\n",
                "           return;\n",
                "       else\n",
                "          out=99\n",
                "          return;\n",
                "    .\n",
                "    test=test+1\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
        ClarionObject out2 = getMainVariable(cl,"out2");
    
        out.setValue(0);out2.setValue(0);
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());
        assertEquals(0,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(99,out.intValue());
        assertEquals(0,out2.intValue());
    }

    public void testCaseOrRange()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  byte(1)\n",
                "out   byte\n",
                "out2  byte\n",
                "    code\n",
                "    case test\n",
                "       of 1 to 2 ; out=1\n",
                "       orof 3 to 4 ; out2=1\n",
                "       of 5 to 6 ; out=2\n",
                "       orof 7 to 8 ; out2=2\n",
                "       else\n",
                "          out=99\n",
                "          return;\n",
                "    .\n",
                "    test=test+1\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject out = getMainVariable(cl,"out");
        ClarionObject out2 = getMainVariable(cl,"out2");
    
        out.setValue(0);out2.setValue(0);
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(1,out.intValue());
        assertEquals(1,out2.intValue());
        
        
        out.setValue(0);out2.setValue(0);
        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(1,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(1,out2.intValue());
        
        
        out.setValue(0);out2.setValue(0);
        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(6);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(7);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(2,out2.intValue());

        out.setValue(0);out2.setValue(0);
        test.setValue(8);
        runClarionProgram(cl);
        assertEquals(0,out.intValue());
        assertEquals(2,out2.intValue());
        
        out.setValue(0);out2.setValue(0);
        test.setValue(9);
        runClarionProgram(cl);
        assertEquals(99,out.intValue());
        assertEquals(0,out2.intValue());
    }
    
    
    
    public void testCaseRaw()
    {
        ClassLoader cl = compile(
                "    program\n",
                "out   byte\n",
                "out2  byte\n",
                "    code\n",
                "    case 3\n",
                "       of 1 ; out=1\n",
                "       orof 2 ; out2=1\n",
                "       of 3 ; out=2\n",
                "       orof 4 ; out2=2\n",
                "       else\n",
                "          out=99\n",
                "    .\n",
                "");
        
        
        ClarionObject out = getMainVariable(cl,"out");
        ClarionObject out2 = getMainVariable(cl,"out2");
    
        out.setValue(0);out2.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,out.intValue());
        assertEquals(2,out2.intValue());
    }

    public void testLoopWhile()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "    code\n",
                "    loop while test%5~=0\n",
                "       test=test+7\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
    
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(15,test.intValue());
        
    }

    public void testLoopUntil()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "    code\n",
                "    loop until test%5=0\n",
                "       test=test+7\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
    
        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(15,test.intValue());
        
    }

    public void testLoopEndWhile()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "    code\n",
                "    loop\n",
                "       test=test+7\n",
                "    while test%5~=0\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
    
        test.setValue(0);
        runClarionProgram(cl);
        assertEquals(35,test.intValue());
    }

    public void testLoopEndWhile2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "    code\n",
                "    loop\n",
                "       test=test+7\n",
                "    while test%5=0\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
    
        test.setValue(0);
        runClarionProgram(cl);
        assertEquals(7,test.intValue());
    }

    public void testLoopEndUntil()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "    code\n",
                "    loop\n",
                "       test=test+7\n",
                "    until test%5~=0\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
    
        test.setValue(0);
        runClarionProgram(cl);
        assertEquals(7,test.intValue());
    }

    public void testLoopEndUntil2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "    code\n",
                "    loop\n",
                "       test=test+7\n",
                "    until test%5=0\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
    
        test.setValue(0);
        runClarionProgram(cl);
        assertEquals(35,test.intValue());
    }

    public void testLoopTimes()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "last   byte\n",
                "result byte\n",
                "tlast byte\n",
                "    code\n",
                "    last=0\n",
                "    result=1\n",
                "    loop test times\n",
                "       tlast=last\n",
                "       last=result\n",
                "       result=result+tlast\n",
                "    .\n",
                "");
        
        ClarionObject test = getMainVariable(cl,"test");
        ClarionObject result = getMainVariable(cl,"result");
    
        test.setValue(0);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(2,result.intValue());

        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(3,result.intValue());

        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(5,result.intValue());

        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(8,result.intValue());

        test.setValue(6);
        runClarionProgram(cl);
        assertEquals(13,result.intValue());

        test.setValue(7);
        runClarionProgram(cl);
        assertEquals(21,result.intValue());

        test.setValue(8);
        runClarionProgram(cl);
        assertEquals(34,result.intValue());

        test.setValue(9);
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }

    public void testLoopForInc1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop test=1 to 10\n",
                "       result+=test",
                "    .\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }    

    public void testLoopForMovingTarget()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "tar byte(10)\n",
                "    code\n",
                "    result=0\n",
                "    loop test=1 to tar\n",
                "       result+=test\n",
                "		tar-=1\n",
                "    .\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }    

    public void testLoopForMovingTarget2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "tar byte(5)\n",
                "    code\n",
                "    result=0\n",
                "    loop test=1 to tar+5\n",
                "       result+=test\n",
                "		tar-=1\n",
                "    .\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }    

    public void testLoopForMovingTarget3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "		map\n" +
                "getuntil	procedure,long\n",
                "      .\n",
                "test   byte\n",
                "result byte\n",
                "xtar    byte(10)\n",
                "    code\n",
                "    result=0\n",
                "    loop test=1 to getuntil\n",
                "       result+=test\n",
                "    .\n",
                "getuntil procedure\n",
                "r  long\n",
                "   code\n",
                "   r=xtar\n",
                "   xtar-=1\n",
                "   return r\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }    
    
    public void testLoopForInc2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop test=1 to 10 by 1\n",
                "       result+=test",
                "    .\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }    

    public void testLoopMixedConditionOneWins()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop while test<=10",
                "       result+=test",
                "       test+=1\n",
                "    until test>15\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }    

    public void testLoopMixedConditionTwoWins()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop while test<=20",
                "       result+=test",
                "       test+=1\n",
                "    until test>10\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(55,result.intValue());
    }    
    
    public void testLoopForInc3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop test=1 to 10 by 2\n",
                "       result+=test",
                "    .\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(25,result.intValue());
    }    

    public void testLoopForInc4()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop test=1 to 10 by test\n",
                "       result+=test",
                "    .\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(1+2+4+8,result.intValue());
    }    

    public void testLoopForDec()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop test=10 to 1 by -3\n",
                "       result+=test",
                "    .\n",
                "");
        
        assertNotNull(getMainVariable(cl,"test"));
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(10+7+4+1,result.intValue());
    }    

    public void testBreak()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop test=10 to 1 by -3\n",
                "       result+=test\n",
                "       if test=7 then break.\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(10+7,result.intValue());
    }    

    public void testLabelledBreak()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "main    loop test=10 to 1 by -3\n",
                "       result+=test\n",
                "       if test=7 then break main.\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(10+7,result.intValue());
    }    

    public void testLabelledBreak2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    test=10\n",
                "main    loop \n",
                "       result+=test\n",
                "       if test=7 then break main.\n",
                "       test=test-3\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(10+7,result.intValue());
    }    
    
    
    public void testCycle()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    loop test=10 to 1 by -3\n",
                "       if test=7 then cycle.\n",
                "       result+=test\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(10+4+1,result.intValue());
    }    

    public void testLabelledCycle()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "main  loop test=10 to 1 by -3\n",
                "       if test=7 then cycle main.\n",
                "       result+=test\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(10+4+1,result.intValue());
    }    

    public void testInfiniteLoop()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    test=10\n",
                "    loop\n",
                "       if test<1 then break.\n",
                "       result+=test\n",
                "       test-=3\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(10+7+4+1,result.intValue());
    }    

    public void testDeeplyBrokenLoop1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    test=10\n",
                "    loop\n",
                "       loop\n",
                "          if test<1 then break.\n",
                "          result+=test\n",
                "          test-=3\n",
                "        .\n",
                "        result=-result\n",
                "        break\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(-22,result.intValue());
    }    

    public void testDeeplyBrokenLoop2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    test=10\n",
                "    loop\n",
                "main  loop\n",
                "          if test<1 then break main.\n",
                "          result+=test\n",
                "          test-=3\n",
                "        .\n",
                "        result=-result\n",
                "        break\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(-22,result.intValue());
    }    
    
    public void testDeeplyBrokenLoop3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    test=10\n",
                "main loop\n",
                "       loop\n",
                "          if test<1 then break main.\n",
                "          if test<1 then break.\n", 
                "          result+=test\n",
                "          test-=3\n",
                "        .\n",
                "        result=-result\n",
                "        break\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(22,result.intValue());
    }    

    public void testBegin()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    result=0\n",
                "    test=10\n",
                "    begin\n",
                "main loop\n",
                "       loop\n",
                "          if test<1 then break main.\n",
                "          if test<1 then break.\n", 
                "          result+=test\n",
                "          test-=3\n",
                "        .\n",
                "        result=-result\n",
                "        break\n",
                "    .\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
    
        runClarionProgram(cl);
        assertEquals(22,result.intValue());
    }    

    
    public void testExecute()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    execute test\n",
                "        result=1\n",
                "        result=7\n",
                "        result=11\n",
                "        begin\n",
                "            result=13\n",
                "            result=-13\n",
                "            return\n",
                "        .\n",
                "        result=17\n",
                "    else\n",
                "        result=19\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject test = getMainVariable(cl,"test");

        test.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        test.setValue(2);
        runClarionProgram(cl);
        assertEquals(7,result.intValue());

        test.setValue(3);
        runClarionProgram(cl);
        assertEquals(11,result.intValue());

        test.setValue(4);
        runClarionProgram(cl);
        assertEquals(-13,result.intValue());

        test.setValue(5);
        runClarionProgram(cl);
        assertEquals(17,result.intValue());

        test.setValue(6);
        runClarionProgram(cl);
        assertEquals(19,result.intValue());

        test.setValue(10);
        result.setValue(0);
        runClarionProgram(cl);
        assertEquals(19,result.intValue());

        test.setValue(0);
        result.setValue(0);
        runClarionProgram(cl);
        assertEquals(19,result.intValue());

        test.setValue(-10);
        result.setValue(0);
        runClarionProgram(cl);
        assertEquals(19,result.intValue());
    }    
    
    public void testAcceptLoopCompiles()
    {
        compile(
                "    program\n",
                "test   byte\n",
                "result byte\n",
                "    code\n",
                "    accept\n",
                "    .\n",
                "");
        
        // TODO - add actual window tests. Cannot do this until we got window
        // structures etc mapping through
    }

    public void testAssignFromSplitString1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   string(20)\n",
                "result string(10)\n",
                "    code\n",
                "    result=test[1]\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject test = getMainVariable(cl,"test");
        
        test.setValue("Hello");
        runClarionProgram(cl);
        assertEquals("H         ",result.toString());

        test.setValue("apple");
        runClarionProgram(cl);
        assertEquals("a         ",result.toString());
    }

    
    public void testAssignFromSplitString2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   string(20)\n",
                "result string(10)\n",
                "    code\n",
                "    result=test[2:4]\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject test = getMainVariable(cl,"test");
        
        test.setValue("Hello");
        runClarionProgram(cl);
        assertEquals("ell       ",result.toString());

        test.setValue("apple");
        runClarionProgram(cl);
        assertEquals("ppl       ",result.toString());
    }
    
    public void testAssignToSplitString1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   string(20)\n",
                "result string(10)\n",
                "    code\n",
                "    result[1]=test[1]\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject test = getMainVariable(cl,"test");
        
        test.setValue("Hello");
        runClarionProgram(cl);
        assertEquals("H         ",result.toString());

        test.setValue("apple");
        runClarionProgram(cl);
        assertEquals("a         ",result.toString());
        
    }
    
    public void testAssignToSplitString2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   string(20)\n",
                "result string(10)\n",
                "    code\n",
                "    result[2]=test[3]\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject test = getMainVariable(cl,"test");
        
        test.setValue("Hello");
        runClarionProgram(cl);
        assertEquals(" l        ",result.toString());

        test.setValue("apPle");
        runClarionProgram(cl);
        assertEquals(" P        ",result.toString());
    }

    public void testAssignToSplitString3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   string(20)\n",
                "result string(10)\n",
                "    code\n",
                "    result[2:4]=test[3:5]\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject test = getMainVariable(cl,"test");
        
        test.setValue("Hello");
        runClarionProgram(cl);
        assertEquals(" llo      ",result.toString());

        test.setValue("apPle");
        runClarionProgram(cl);
        assertEquals(" Ple      ",result.toString());
    }

    public void testAssignToSplitStringInAnArray()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test   string(10),dim(2)\n",
                "    code\n",
                "    test[2][2:4]=test[1][3:5]\n",
                "");
        
        ClarionArray<ClarionString> test = getMainVariableArray(cl,"test");
        assertEquals("          ",test.get(1).toString());
        assertEquals("          ",test.get(2).toString());
        
        test.get(1).setValue("Hello");
        runClarionProgram(cl);
        assertEquals(" llo      ",test.get(2).toString());

        test.get(1).setValue("apPle");
        runClarionProgram(cl);
        assertEquals(" Ple      ",test.get(2).toString());
    }

    public void testInvokeThread()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "child  procedure(long)\n",
                "    .\n",
                "result long\n",
                "    code\n",
                "    start(child,25000,command(1))\n",
                "child procedure(val)\n",
                "    code\n",
                "    result=val\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"5");
        
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        assertEquals(5,result.intValue());
        
    }

    public void testInvokeThreadInRoutine()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "child  procedure(long)\n",
                "parent  procedure()\n",
                "    .\n",
                "result long\n",
                "    code\n",
                "    parent\n",
                "parent procedure\n",
                "    code\n",
                "    do runthread\n",
                "runthread routine\n",
                "    start(child,25000,command(1))\n",
                "child procedure(val)\n",
                "    code\n",
                "    result=val\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"5");
        
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        assertEquals(5,result.intValue());
        
    }
    
    public void testInvokeProcedureWhenSymbolTableIsConfused()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "units  procedure()\n",
                "    .\n",
                "result long\n",
                "units  long\n",
                "    code\n",
                "    units\n",
                "units procedure()\n",
                "    code\n",
                "    result=1\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
        
    }
    
    
    public void assertCompileExpression(String out,String expression)
    {
        ClarionCompiler.clean();
        
        ClassLoader cl = compile(
                "    program\n",
                "test  string(10)\n",
                "    code\n",
                "    test="+expression+"\n");
        
        ClarionObject test = getMainVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals(out,test.toString());
    }

    public ClassLoader compile(String... source)
    {
        return compile(get(source));
    }

    public ClassLoader compile(String source)
    {
        System.setProperty("clarion.compile.forceHardAssert","1");
        try {
            compileProgram(source);
            return ClarionCompiler.compile();
        } finally {
            System.clearProperty("clarion.compile.forceHardAssert");
        }
    }
    
    public void compileProgram(String source)
    {
        Lexer l  = new Lexer(new CharArrayReader(source.toCharArray()));
        Parser p = new Parser(l);
        p.compileProgram();
    }
    
    public String get(String... merge)
    {
        StringBuilder r=new StringBuilder();
        for (int scan=0;scan<merge.length;scan++) {
            r.append(merge[scan]);
        }
        return r.toString();
    }

    public void runClarionProgram(ClassLoader cl,String... params)
    {
        try {
            Class<?> c = cl.loadClass("clarion.Main");
            assertNotNull(c);
            Method m = c.getMethod("begin",params.getClass());
            Object arg = params;
            m.invoke(null,arg);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchMethodException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        } catch (InvocationTargetException e) {
            e.printStackTrace();
            fail(e.getTargetException().getMessage());
        }
    }
    
    public ClarionObject getMainVariable(ClassLoader cl,String name)
    {
        try {
            Class<?> c = cl.loadClass("clarion.Main");
            assertNotNull(c);
            
            Field f = c.getField(name);
            return (ClarionObject)f.get(null);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchFieldException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        }
        return null;
    }

    @SuppressWarnings("unchecked")
	public ClarionArray<ClarionString> getMainVariableArray(ClassLoader cl,String name)
    {
        try {
            Class<?> c = cl.loadClass("clarion.Main");
            assertNotNull(c);
            
            Field f = c.getField(name);
            return (ClarionArray<ClarionString>)f.get(null);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchFieldException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        }
        return null;
    }
    
    
}
