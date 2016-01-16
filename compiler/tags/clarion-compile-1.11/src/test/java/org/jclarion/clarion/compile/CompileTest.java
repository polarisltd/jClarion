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


import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.compile.java.ClassRepository;
public class CompileTest extends CompileTestHelper
{
    public void testBugWhereAbstractMethodsRemapToSystemFunctions()
    {
        ClassLoader cl =compile(
                "   program\n",
                "result string(20)\n",
                "abclass class\n",
                "update  procedure\n",
                ".\n",
                "coclass class(abclass)\n",
                "update  procedure\n",
                ".\n",
                "mclass &abclass\n",
                "  code\n",
                "  mclass &= new coclass\n",
                "  mclass.update()\n",
                "coclass.update procedure\n",
                "   code\n",
                "   result='working'\n",
                "");
        runClarionProgram(cl);
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("working",result.toString().trim());
        
    }
    
    public void testCarefulEncodingOfStrings()
    {
        ClassLoader cl =compile(
                "   program\n",
                "result string(20)\n",
                "ICON:Application  EQUATE ('<0FFH,01H,81H,01H,7FH>')\n",
                "   code\n",
                "   result=ICON:Application\n",
                "");
        runClarionProgram(cl);
        ClarionObject result = getMainVariable(cl,"result");
        String s = result.toString();
        assertEquals(255,s.charAt(0));
        assertEquals(1,s.charAt(1));
        assertEquals(129,s.charAt(2));
        assertEquals(1,s.charAt(3));
        assertEquals(127,s.charAt(4));
    }

    public void testMultiChar()
    {
        ClassLoader cl =compile(
                "   program\n",
                "result string(20)\n",
                "   code\n",
                "   result='ひらがな, 平仮名'\n",
                "");
        System.out.println(ClassRepository.get("Main").toJavaSource());
        runClarionProgram(cl);
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("ひらがな, 平仮名",result.toString().trim());
    }
    
    public void testAge()
    {
        ClassLoader cl =compile(
                "   program\n",
                "result string(10)\n",
                "   code\n",
                "   result=age(date(2,20,2010),date(2,24,2010))\n",
                "");
        runClarionProgram(cl);
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("4 DAYS",result.toString().trim());
        
    }
    
    public void testSystemParamBug()
    {
        ClassLoader cl =compile(
                "   program\n",
                "   map\n",
                "     SystemParametersInfo(LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni), LONG, RAW, PASCAL, DLL(TRUE), NAME('SystemParametersInfoA'),PROC\n",
                "   .\n",
                "   code\n",
                "   SystemParametersInfo (38, 0,1, 0)\n",
                "");
        runClarionProgram(cl);
    }
    
    public void testRefAssignWarning()
    {
        // code similar to this is in abfile.inc. Who knows what it is supposed to do
        // If I compile something like this on clarion 5.5, nothing of interest
        // happens to the IN variable from perspective of the caller, irrespective of 
        // whether IN is a primative or an ANY. Under some circumstances it even crashes
        //
        // who knows what it is for.
        //
        // Under clarion2java - compiler complains with a warning - because
        // IN is not itself a reference, it is merely passed by reference but it will
        // do something: it will setvalue. Which means that something of interest
        // does happen from perspective of the caller.
        
        compile(
                "   program\n",
                "val any\n",
                "   map\n",
                "myproc procedure(*?)\n",
                "   .\n",
                "   code\n",
                "myproc procedure(*? in)\n",
                "   code\n",
                "   val&=in\n",
                "   in&=val\n",
                "");
        
    }
    
    public void testDllModeFlagOnClass()
    {
        compile(
                "   program\n",
                "myclass class,dll(_abcdllmode_),link('myfile.clw',_abclinkmode_)",
                "  .\n",
                "   code\n",
                "");
    }

    public void testDllModeFlagOnProcedure()
    {
        ClassLoader cl =compile(
                "   program\n",
                "result long\n",
                "   map\n",
                "myproc procedure,dll(_abcdllmode_)\n",
                "  .\n",
                "   code\n",
                "   myproc\n",
                "myproc procedure\n",
                "   code\n",
                "   result=5\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }

    public void testDllModeFlagOnProcedure2()
    {
        ClassLoader cl =compile(
                "   program\n",
                "result long\n",
                "   map\n",
                "myproc procedure,dll\n",
                "  .\n",
                "   code\n",
                "   myproc\n",
                "myproc procedure\n",
                "   code\n",
                "   result=5\n",
                "");
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }
    
    public void testSFBug2984055()
    {
        getSource().addLexer("equates.clw",
                "false equate(0)\n",
                "");
        
        compile(
                "   program\n",
                "myclass class\n",
                "ResizeCalled BYTE(False),PRIVATE\n",
                ".\n",
                "   code\n"
                );
    }
    
    public void testOverdoneParameters()
    {
        ClassLoader cl = compile(
                "   program\n",
                "result long\n",
                "   map\n",
                "myfunc  procedure(long a),long\n",
                "  .\n",
                "   code\n",
                "   result=myfunc(1,,)\n",
                "myfunc procedure(long a)\n",
                "   code\n",
                "   return a\n"
                );

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
        
    }

    
    public void testSimpleJavaCode()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result=10\n",
                "    @java-code '$.setValue(12);'(result)\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(12,result.intValue());
    }

    public void testLongStaticConcat()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result string(40)\n",
                "    code\n",
                "    result=10&' hello '&' there '&' world '\n",
                "");
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals("10 hello  there  world",result.toString().trim());
    }

    public void testLongConcat()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result string(40)\n",
                "    code\n",
                "    result=10\n",
                "    result=clip(result)&' hello '&' there '&' world '\n",
                "");
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals("10 hello  there  world",result.toString().trim());
    }

    public void testLongConcat2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "iresult long\n",
                "result string(40)\n",
                "    code\n",
                "    iresult=10\n",
                "    result=iresult&' hello '&' there '&' world '\n",
                "");
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals("10 hello  there  world",result.toString().trim());
    }
    
    public void testCallingMainMultipletimesResets()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result+=1\n",
                "");
        
        runMainClarionProgram(cl);
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(1,result.intValue());

        runMainClarionProgram(cl);
        assertEquals(1,result.intValue());
        result = getMainVariable(cl,"result");

        runMainClarionProgram(cl);
        assertEquals(1,result.intValue());
        result = getMainVariable(cl,"result");
    }
    
    public void testReturningJavaCode()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n " +
                " getresult procedure(long),long\n",
                "    .\n",
                "result long\n",
                "    code\n",
                "    result=getResult(6)\n",
                "getResult procedure(long in)\n",
                "    code\n",
                "    @java-code 'return Clarion.newNumber($.intValue()*2);'(in),RETURN\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(12,result.intValue());
    }
    
    public void testDependentJavaCode()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result=10\n",
                "    @java-dependency 'org.jclarion.clarion.ClarionDecimal'\n",
                "    @java-code '$.setValue(new ClarionDecimal(12));'(result)\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(12,result.intValue());
    }

    public void testComplexJavaCode()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result=10\n",
                "    @java-dependency 'org.jclarion.clarion.ClarionDecimal'\n",
                "    @java-code '$.setValue(new ClarionDecimal(\"12\"));'(result)\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(12,result.intValue());
    }
    
    public void testAddFont()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    code\n",
                "    @java-load 'org.jclarion.clarion.compile.ext.Font\n",
                "    addFont('3of9.ttf')\n");
        runClarionProgram(cl);
    }

    public void testLogCrash()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    code\n",
                "    @java-load 'org.jclarion.clarion.compile.ext.Crash'\n",
                "    @java-load 'org.jclarion.clarion.compile.ext.Crash'\n",
                "    crashLog('Some Crap')\n");
        runClarionProgram(cl);
    }
    
    public void testRandom()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result=random(10000,20000)\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        int r1 = result.intValue();
        runClarionProgram(cl);
        int r2 = result.intValue();
        assertTrue(r1>=10000);
        assertTrue(r1<20000);
        assertTrue(r2>=10000);
        assertTrue(r2<20000);
        assertTrue(r1!=r2); 
    }
    
    
    public void testDivideNumberWithNumberYieldsDecimal()
    {
        ClassLoader cl = compile(
                "    program\n",
                "low long\n",
                "high  long\n",
                "p   byte\n",
                "result long\n",
                "   code\n",
                "   result=Low + (High - Low) * (P / 100)\n",
                "");

        ClarionObject low = getMainVariable(cl,"low"); 
        ClarionObject high = getMainVariable(cl,"high"); 
        ClarionObject p = getMainVariable(cl,"p"); 
        ClarionObject result = getMainVariable(cl,"result");
        
        low.setValue(100);
        high.setValue(500);
        p.setValue(50);
        
        runClarionProgram(cl);
        assertEquals(300,result.intValue());
    }
    
    public void testABFileIDTypeCodeSegment()
    {
        ClassLoader cl = compile(
                "    program\n",
                "tfile file,driver('DOS')\n",
                "record record\n",
                "line   string(20)\n",
                " . . \n",
                "tfile2 file,driver('DOS')\n",
                "record record\n",
                "line   string(20)\n",
                " . . \n",
                "mygroup group\n",
                "t   &file\n",
                ".\n",
                "myid long,over(mygroup)\n",
                "   code\n",
                
                "   mygroup.t&=tfile\n",
                "   assert(myid <> 0,'#1')\n",
                "   assert(myid = address(tfile),'#2')\n",

                "   mygroup.t&=tfile2\n",
                "   assert(myid <> 0,'#3')\n",
                "   assert(myid = address(tfile2),'#4')\n",
                "   assert(myid <> address(tfile),'#5')\n",
                
                "");
        
        runClarionProgram(cl);
    }

    public void testOverReference()
    {
        ClassLoader cl = compile(
                "    program\n",
                "s1 &string\n",
                "s2 long,over(s1)\n",
                "s3 string('hello')\n",
                "s4 string('world')\n",
                "   code\n",
                "   assert(0=s2,'#1')\n",
                
                "   s1&=s3\n",
                "   assert(address(s3)=s2,'#2')\n",

                "   s1&=s4\n",
                "   assert(address(s4)=s2,'#3')\n",

                "   s2=0\n",
                "   assert(s1&=null,'#4')\n",
                
                "   s2=address(s3)\n",
                "   assert(s1&=s3,'#4')\n",
                
                "");
        
        runClarionProgram(cl);
    }
    
    public void testCompileWithVariable()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "test  byte\n",
                "    code\n"));

        ClarionObject co = getMainVariable(cl,"test");
        assertEquals(0,co.intValue());
    }

    
    public void testCompileWithVariableDefault()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "test  byte(1)\n",
                "    code\n"));

        ClarionObject co = getMainVariable(cl,"test");
        assertEquals(1,co.intValue());
    }

    public void testCompileWithMultiVariables()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "test   byte(1)\n",
                "test2  byte(1)\n",
                "    code\n"));

        ClarionObject co1 = getMainVariable(cl,"test");
        ClarionObject co2 = getMainVariable(cl,"test2");
        assertEquals(1,co1.intValue());
        assertEquals(1,co2.intValue());
        
        co1.setValue(2);

        assertEquals(2,co1.intValue());
        assertEquals(1,co2.intValue());
    }
    
    public void testCompileWithLike()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "test   byte(1)\n",
                "test2  like(test)\n",
                "    code\n"));

        ClarionObject co1 = getMainVariable(cl,"test");
        ClarionObject co2 = getMainVariable(cl,"test2");
        assertEquals(1,co1.intValue());
        assertEquals(1,co2.intValue());
        
        co1.setValue(2);

        assertEquals(2,co1.intValue());
        assertEquals(1,co2.intValue());
    }
    
    public void testCompileWithOver()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "test   byte(1)\n",
                "test2  byte,over(test)\n",
                "    code\n"));

        ClarionObject co1 = getMainVariable(cl,"test");
        ClarionObject co2 = getMainVariable(cl,"test2");
        assertNotSame(co1,co2);
        assertEquals(1,co1.intValue());
        assertEquals(1,co2.intValue());
        
        co1.setValue(2);

        assertEquals(2,co1.intValue());
        assertEquals(2,co2.intValue());
    }

    public void testImplicitNumber()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "result   byte\n",
                "    code\n",
                "    x#=2\n",
                "    y#=3\n",
                "    z#=x#+y#\n",
                "    result=z#\n",
                ""));

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
        
    }

    public void testImplicitTypes()
    {
        ClassLoader cl = compile(
                "    program\n",
                "iresult   byte\n",
                "dresult   decimal\n",
                "sresult   pstring(20)\n",
                "    code\n",
                "    x#=2\n",
                "    x$=13.2\n",
                "    x\"='hello'\n",
                "    iresult=x#\n",
                "    dresult=x$\n",
                "    sresult=x\"\n",
                "");

        runClarionProgram(cl);
        assertEquals("2",getMainVariable(cl,"iresult").toString());
        assertEquals("13.2",getMainVariable(cl,"dresult").toString());
        assertEquals("hello",getMainVariable(cl,"sresult").toString());
        
    }

    
    public void testArraySet()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result   byte,dim(5)\n",
                "    code\n",
                "    result[1]=13\n",
                "    result[2]=11\n",
                "    result[3]=7\n",
                "    result[4]=5\n",
                "    result[5]=3\n",
                "");

        ClarionObject o[] = getMainArrayVariable(cl,"result");

        assertEquals(6,o.length);
        assertNull(o[0]);
        assertEquals(0,o[1].intValue());
        assertEquals(0,o[2].intValue());
        assertEquals(0,o[3].intValue());
        assertEquals(0,o[4].intValue());
        assertEquals(0,o[5].intValue());
        
        runClarionProgram(cl);
        assertNull(o[0]);
        assertEquals(13,o[1].intValue());
        assertEquals(11,o[2].intValue());
        assertEquals( 7,o[3].intValue());
        assertEquals( 5,o[4].intValue());
        assertEquals( 3,o[5].intValue());
        
    }

    public void testArraySetFromConstant()
    {
        ClassLoader cl = compile(
                "    program\n",
                "len      long(5)\n",
                "result   byte,dim(len)\n",
                "    code\n",
                "    result[1]=13\n",
                "    result[2]=11\n",
                "    result[3]=7\n",
                "    result[4]=5\n",
                "    result[5]=3\n",
                "");

        ClarionObject o[] = getMainArrayVariable(cl,"result");

        assertEquals(6,o.length);
        assertNull(o[0]);
        assertEquals(0,o[1].intValue());
        assertEquals(0,o[2].intValue());
        assertEquals(0,o[3].intValue());
        assertEquals(0,o[4].intValue());
        assertEquals(0,o[5].intValue());
        
        runClarionProgram(cl);
        assertNull(o[0]);
        assertEquals(13,o[1].intValue());
        assertEquals(11,o[2].intValue());
        assertEquals( 7,o[3].intValue());
        assertEquals( 5,o[4].intValue());
        assertEquals( 3,o[5].intValue());
        
    }
    
    public void testArrayInExpression()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result   byte,dim(5)\n",
                "    code\n",
                "    result[1]=13\n",
                "    result[2]=11\n",
                "    result[3]=7\n",
                "    result[4]=5\n",
                "    result[5]=result[3]+result[4]\n",
                "");

        ClarionObject o[] = getMainArrayVariable(cl,"result");

        assertEquals(6,o.length);
        assertNull(o[0]);
        assertEquals(0,o[1].intValue());
        assertEquals(0,o[2].intValue());
        assertEquals(0,o[3].intValue());
        assertEquals(0,o[4].intValue());
        assertEquals(0,o[5].intValue());
        
        runClarionProgram(cl);
        assertNull(o[0]);
        assertEquals(13,o[1].intValue());
        assertEquals(11,o[2].intValue());
        assertEquals( 7,o[3].intValue());
        assertEquals( 5,o[4].intValue());
        assertEquals(12,o[5].intValue());
    }

    public void testSimpleProcedureCallNotDefined()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure\n",
                "    .\n",
                "result   byte\n",
                "    code\n",
                "    testproc()\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        assertNotNull(result);
        try {
            runClarionProgram(cl);
            fail("Expected runtime exception");
        } catch (RuntimeException ex) { }
    }

    public void testSimpleImplementedProcedureCall()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure\n",
                "    .\n",
                "result   byte\n",
                "    code\n",
                "    testproc()\n",
                "testproc    procedure\n",
                "    code\n",
                "    result=1\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");

        runClarionProgram(cl);
        assertEquals(1,result.intValue());
        
        result.setValue(10);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    
    public void testCallPassVar()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long aVal)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc(pass)\n",
                "testproc    procedure(long aVal)\n",
                "    code\n",
                "    result=aVal*2\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(4,result.intValue());
    }

    public void testCallPassRawIsCastedCorrectly()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long aVal)\n",
                "    .\n",
                "result   byte\n",
                "    code\n",
                "    testproc(2)\n",
                "testproc    procedure(long aVal)\n",
                "    code\n",
                "    result=aVal*2\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");

        runClarionProgram(cl);
        assertEquals(4,result.intValue());
    }
    
    
    public void testCallPassOptVar1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(<long aVal>)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc(pass)\n",
                "testproc    procedure(long aVal)\n",
                "    code\n",
                "    result=aVal*2\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(4,result.intValue());
    }

    public void testCallPassOptVar2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long aVal=10)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc(pass)\n",
                "testproc    procedure(long aVal)\n",
                "    code\n",
                "    result=aVal*2\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(4,result.intValue());
    }

    public void testCallPassOptVar3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long aVal=10)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc()\n",
                "testproc    procedure(long aVal)\n",
                "    code\n",
                "    result=aVal*2\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(20,result.intValue());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(20,result.intValue());
    }

    
    public void testCallPassOptVar4()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long bVal,long aVal=10)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc(pass,pass)\n",
                "testproc    procedure(long bVal,long aVal)\n",
                "    code\n",
                "    result=aVal+bVal\n",
                "");


        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(4,result.intValue());
    }

    public void testCallPassOptVar5()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long bVal,long aVal=10)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc(pass)\n",
                "testproc    procedure(long bVal,long aVal)\n",
                "    code\n",
                "    if bVal=0 then result=-1 else result=aVal%bVal.\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(-1,result.intValue());
        
        pass.setValue(3);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    public void testCallPassOptVar5b()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long bVal=10,long aVal)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc(pass)\n",
                "testproc    procedure(long bVal,long aVal)\n",
                "    code\n",
                "    if bVal=0 then result=-1 else result=aVal%bVal.\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        
        pass.setValue(3);
        runClarionProgram(cl);
        assertEquals(3,result.intValue());
    }
    
    public void testCallPassOptVar6()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long bVal=5,long aVal=10)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc(pass)\n",
                "testproc    procedure(long bVal,long aVal)\n",
                "    code\n",
                "    result=aVal+bVal\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(12,result.intValue());
    }

    public void testCallPassOptVar7()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long bVal=5,long aVal=10)\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    testproc()\n",
                "testproc    procedure(long bVal,long aVal)\n",
                "    code\n",
                "    result=aVal+bVal\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals(15,result.intValue());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(15,result.intValue());
    }

    public void testReturn()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long in),string\n",
                "    .\n",
                "result   string(10)\n",
                "pass     byte\n",
                "    code\n",
                "    result=testproc(pass)\n",
                "testproc    procedure(long in)\n",
                "    code\n",
                "    return 'Hello:'&in\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals("Hello:0   ",result.toString());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals("Hello:2   ",result.toString());
    }

    public void testReturnMissing()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long in),string\n",
                "    .\n",
                "result   string(10)\n",
                "pass     byte\n",
                "    code\n",
                "    result=testproc(pass)\n",
                "testproc    procedure(long in)\n",
                "    code\n",
                "    if in>0\n",
                "        return 'Hello:'&in\n",
                "    .\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals("          ",result.toString());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals("Hello:2   ",result.toString());

        pass.setValue(0);
        runClarionProgram(cl);
        assertEquals("          ",result.toString());
    }

    
    public void testReturnRecasted()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "testproc  procedure(long in),string\n",
                "    .\n",
                "result   string(10)\n",
                "pass     byte\n",
                "    code\n",
                "    result=testproc(pass)\n",
                "testproc    procedure(long in)\n",
                "    code\n",
                "    if in>0\n",
                "        return in+5\n",
                "    .\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        runClarionProgram(cl);
        assertEquals("          ",result.toString());
        
        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals("7         ",result.toString());

        pass.setValue(0);
        runClarionProgram(cl);
        assertEquals("          ",result.toString());
    }

    public void testRecursiveFibonacciImplementation()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "fib  procedure(long in),long\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    result=fib(pass)\n",
                "fib    procedure(long in)\n",
                "    code\n",
                "    if in<0 then return 0.\n",
                "    if in<=1 then return 1.\n",
                "    return fib(in-1)+fib(in-2)\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        pass.setValue(0);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        pass.setValue(1);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        pass.setValue(2);
        runClarionProgram(cl);
        assertEquals(2,result.intValue());

        pass.setValue(3);
        runClarionProgram(cl);
        assertEquals(3,result.intValue());

        pass.setValue(4);
        runClarionProgram(cl);
        assertEquals(5,result.intValue());

        pass.setValue(5);
        runClarionProgram(cl);
        assertEquals(8,result.intValue());

        pass.setValue(6);
        runClarionProgram(cl);
        assertEquals(13,result.intValue());

        pass.setValue(20);
        runClarionProgram(cl);
        assertEquals(10946,result.intValue());
    }

    
    public void testPassByValueDoesNotMutateOriginalVar()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "test  procedure(long in),long\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    result=test(pass)\n",
                "test    procedure(long in)\n",
                "    code\n",
                "    in+=1\n",
                "    return in\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        pass.setValue(0);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
        assertEquals(0,pass.intValue());

        pass.setValue(5);
        runClarionProgram(cl);
        assertEquals(6,result.intValue());
        assertEquals(5,pass.intValue());
    }

    public void testProcedureWithLocalParams()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "test  procedure(long in),long\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    result=test(pass)\n",
                "test    procedure(long in)\n",
                "temp long\n",
                "    code\n",
                "    temp=in+1\n",
                "    return temp\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        pass.setValue(0);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
        assertEquals(0,pass.intValue());

        pass.setValue(5);
        runClarionProgram(cl);
        assertEquals(6,result.intValue());
        assertEquals(5,pass.intValue());
    }

    public void testProcedureWithImplicit()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "test  procedure(long in),long\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    result=test(pass)\n",
                "test    procedure(long in)\n",
                "    code\n",
                "    temp#=in+1\n",
                "    return temp#\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        pass.setValue(0);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
        assertEquals(0,pass.intValue());

        pass.setValue(5);
        runClarionProgram(cl);
        assertEquals(6,result.intValue());
        assertEquals(5,pass.intValue());
    }

    
    public void testPassByReference()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "test  procedure(*long in),long\n",
                "    .\n",
                "result   byte\n",
                "pass     byte\n",
                "    code\n",
                "    result=test(pass)\n",
                "test    procedure(long in)\n",
                "    code\n",
                "    in+=1\n",
                "    return in+1\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        ClarionObject pass = getMainVariable(cl,"pass");

        pass.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,result.intValue());
        assertEquals(1,pass.intValue());

        pass.setValue(5);
        runClarionProgram(cl);
        assertEquals(7,result.intValue());
        assertEquals(6,pass.intValue());
    }

    public void testEquate()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result2   byte\n",
                "accepted    equate(1)\n",
                "result   byte\n",
                "    code\n",
                "    result=ACCEPTED\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");

        result.setValue(0);
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    public void testEquate2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "selected    equate(1)\n",
                "accepted    equate(2)\n",
                "result   byte\n",
                "    code\n",
                "    result=ACCEPTED\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");

        result.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }

    public void testEquate3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "selected    equate(1)\n",
                "accepted    equate(selected+1)\n",
                "result   byte\n",
                "    code\n",
                "    result=ACCEPTED\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");

        result.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }

    public void testEquate4()
    {
        ClassLoader cl = compile(
                "    program\n",
                "event:selected    equate(1)\n",
                "event:accepted    equate(event:selected+1)\n",
                "result   byte\n",
                "    code\n",
                "    result=event:ACCEPTED\n",
                "");

        assertNotNull(ClassRepository.get("Event"));
        
        ClarionObject result = getMainVariable(cl,"result");

        result.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }

    public void testEquate5()
    {
        ClassLoader cl = compile(
                "    program\n",
                "event:selected    equate(1)\n",
                "event:accepted    equate(event:selected&' hello')\n",
                "result   string(10)\n",
                "    code\n",
                "    result=event:ACCEPTED\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");

        result.setValue("");
        runClarionProgram(cl);
        assertEquals("1 hello   ",result.toString());
    }
    
    public void testItemizedEquateSimple()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    itemize\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Constants";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
    }

    public void testItemizedEquateWithSeed()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    itemize(0-1)\n",
                "negone    equate\n",
                "zero      equate\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Constants";
        assertEquals(-1,getOtherRawInt(cl,l,"NEGONE"));
        assertEquals(0,getOtherRawInt(cl,l,"ZERO"));
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
    }

    public void testItemizedEquateWithEmptyPre1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    itemize,pre\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Constants";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
    }

    public void testItemizedEquateWithEmptyPre2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    itemize,pre()\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Constants";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
    }

    public void testItemizedEquateWithPre()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    itemize,pre(event)\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Event";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
        
        assertNull(ClassRepository.get("Constants"));
    }

    public void testItemizedEquateWithLabel()
    {
        ClassLoader cl = compile(
                "    program\n",
                "event    itemize\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Constants";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
        
        //assertNull(ClassRepository.get("Constants"));
    }

    public void testItemizedEquateWithLabel2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "event    itemize,pre()\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Event";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
        
        assertNull(ClassRepository.get("Constants"));
    }

    public void testItemizedEquateWithLabelPreOverrides()
    {
        ClassLoader cl = compile(
                "    program\n",
                "color    itemize,pre(event)\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Event";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(3,getOtherRawInt(cl,l,"THREE"));
        assertEquals(4,getOtherRawInt(cl,l,"FOUR"));
        
        assertNull(ClassRepository.get("Constants"));
    }

    public void testItemizedEquateWithResetSeed()
    {
        ClassLoader cl = compile(
                "    program\n",
                "        itemize,pre(event)\n",
                "one      equate\n",
                "two      equate\n",
                "three    equate(10.0/2)\n",
                "four     equate\n",
                "    .\n",
                "    code\n",
                "");

        String l = ClarionCompiler.BASE+".equates.Event";
        assertEquals(1,getOtherRawInt(cl,l,"ONE"));
        assertEquals(2,getOtherRawInt(cl,l,"TWO"));
        assertEquals(5,getOtherRawInt(cl,l,"THREE"));
        assertEquals(6,getOtherRawInt(cl,l,"FOUR"));
        
        assertNull(ClassRepository.get("Constants"));
    }

    public void testItemizedEquateComplex()
    {
        ClassLoader cl = compile(
                "    program\n",
                "        itemize\n",
                "false   equate(0)\n",
                "true   equate\n",
                "    end\n",
                "\n",
                "color        itemize(0),pre\n",
                "red      equate\n",
                "white      equate\n",
                "blue    equate\n",
                "pink     equate(5)\n",
                "green     equate\n",
                "last     equate\n",
                "    end\n",
                "\n",
                "stuff        itemize(color:last+1),pre(my)\n",
                "x    equate\n",
                "y    equate\n",
                "z    equate\n",
                "    end\n",
                "\n",
                "    code\n",
                "");

        String b = ClarionCompiler.BASE+".equates.Constants";
        String c = ClarionCompiler.BASE+".equates.Color";
        String m = ClarionCompiler.BASE+".equates.My";
        
        assertEquals(0,getOtherRawInt(cl,b,"FALSE"));
        assertEquals(1,getOtherRawInt(cl,b,"TRUE"));

        assertEquals(0,getOtherRawInt(cl,c,"RED"));
        assertEquals(1,getOtherRawInt(cl,c,"WHITE"));
        assertEquals(2,getOtherRawInt(cl,c,"BLUE"));
        assertEquals(5,getOtherRawInt(cl,c,"PINK"));
        assertEquals(6,getOtherRawInt(cl,c,"GREEN"));
        assertEquals(7,getOtherRawInt(cl,c,"LAST"));

        assertEquals(8,getOtherRawInt(cl,m,"X"));
        assertEquals(9,getOtherRawInt(cl,m,"Y"));
        assertEquals(10,getOtherRawInt(cl,m,"Z"));
    }
    
    public void testCompileWithModifiers1()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "test  byte,private\n",
                "    code\n"));

        ClarionObject co = getMainVariable(cl,"test");
        assertEquals(0,co.intValue());
    }

    public void testCompileWithModifiers2()
    {
        compile(get(
                "    program\n",
                "test  &byte,private\n",
                "    code\n"));
    }

    public void testCompileAnyOp()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "      map\n",
                "inc   procedure(*? field)\n",
                "      .\n",
                "result  long\n",
                "    code\n",
                "    inc(result)\n",
                "inc   procedure(field)\n",
                "    code\n",
                "    field+=1\n",
                ""));

        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());

        runClarionProgram(cl);
        assertEquals(1,co.intValue());

        runClarionProgram(cl);
        assertEquals(2,co.intValue());
    }

    public void testCompileAnyOp2()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "      map\n",
                "inc   procedure(*? field)\n",
                "      .\n",
                "result  any\n",
                "    code\n",
                "    inc(result)\n",
                "inc   procedure(field)\n",
                "    code\n",
                "    field+=1\n",
                ""));

        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());

        runClarionProgram(cl);
        assertEquals(1,co.intValue());

        runClarionProgram(cl);
        assertEquals(2,co.intValue());
    }

    public void testCompileAnyOp3()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "      map\n",
                "inc   procedure(*? field)\n",
                "      .\n",
                "result  any\n",
                "    code\n",
                "    if ~result then result=6.\n",
                "    inc(result)\n",
                "inc   procedure(field)\n",
                "    code\n",
                "    field+=1\n",
                ""));

        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());

        runClarionProgram(cl);
        assertEquals(7,co.intValue());

        runClarionProgram(cl);
        assertEquals(8,co.intValue());
    }


    public void testLikeCanRefComplexVars1()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "mygroup queue,pre(mg),static\n",
                "val     long\n",
                ".\n",
                "result like(mygroup.val)\n",
                "    code\n",
                ""));

        ClarionObject co = getMainVariable(cl,"result");
        assertTrue(co instanceof ClarionNumber);
    }

    public void testSizeExpr()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "test string(500)\n",
                "result long\n",
                "    code\n",
                "    result=size(test)\n",
                ""));

        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());
        
        runClarionProgram(cl);
        assertEquals(500,co.intValue());
        
    }

    public void testSizeExprPrototype()
    {
        ClassLoader cl = compile(get(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result=size(decimal(command(1),command(2)))\n",
                ""));

        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());
        
        runClarionProgram(cl,"9","2");
        assertEquals(5,co.intValue());

        runClarionProgram(cl,"10","2");
        assertEquals(6,co.intValue());

        runClarionProgram(cl,"11","2");
        assertEquals(6,co.intValue());

        runClarionProgram(cl,"12","2");
        assertEquals(7,co.intValue());
        
    }

    public void testZeroedGroup()
    {
        compile(get(
                "    program\n",
                "sockaddr   group,private.\n",
                "    code\n",
                ""));
    }

    public void testAccessPrinter()
    {
        compile(get(
                "    program\n",
                "result  string(20)\n",
                "    code\n",
                "    result=PRINTER{1}\n",
                ""));
    }
    

    public void testOmittedProcedure()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  long\n",
                "    map\n",
                "test  procedure(<LONG>,<LONG>)\n",
                "     .\n",
                "    code\n",
                "    result=0\n",
                "    if command(1)='t1' then test()\n.",
                "    if command(1)='t2' then test(1)\n.",
                "    if command(1)='t3' then test(1,2)\n.",
                "test  procedure(p1,p2)\n",
                "   code\n",
                "   if omitted(1) then result+=1.\n",
                "   if omitted(2) then result+=2.\n",
                "   result+=4\n",
                "");

        ClarionObject co = getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(0,co.intValue());

        runClarionProgram(cl,"t1");
        assertEquals(7,co.intValue());

        runClarionProgram(cl,"t2");
        assertEquals(6,co.intValue());

        runClarionProgram(cl,"t3");
        assertEquals(4,co.intValue());
    }
    
    public void testImplicitBasedOnReservedWord()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  long\n",
                "    code\n",
                "    loop#=command(1)\n",
                "    result=loop#\n",
                "");

        ClarionObject co = getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(0,co.intValue());

        runClarionProgram(cl,"5");
        assertEquals(5,co.intValue());
    }

    public void testBindChangingObject()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  long\n",
                "    code\n",
                "    bind('result',result)\n",
                "    result=0\n",
                "    assert( evaluate('result')='0','#1' )\n",
                "    result=3\n",
                "    assert( evaluate('result')='3','#2' )\n",
                "");

        runClarionProgram(cl);
    }
    
    public void testBindNullableObject()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  &long\n",
                "    code\n",
                "    bind('result',result)\n",
                "    result&=new long(0)\n",
                "    assert( evaluate('result')='0','#1' )\n",
                "    result&=new long(3)\n",
                "    assert( evaluate('result')='3','#2' )\n",
                "");

        runClarionProgram(cl);
    }

    public void testBindComplexNullableObject1()
    {
        ClassLoader cl= compile(
                "    program\n",
                "mc class,type\n",
                "result  long\n",
                " .\n",
                
                "myclass &mc\n",
                
                "    code\n",
                "    bind('result',myclass.result)\n",
                "    myclass&=new mc;myclass.result=0\n",
                "    assert( evaluate('result')='0','#1' )\n",
                "    myclass&=new mc;myclass.result=3\n",
                "    assert( evaluate('result')='3','#2' )\n",
                "");
        
        runClarionProgram(cl);
    }
    
    public void testBindNullableObjectWhenNull()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  &long\n",
                "    code\n",
                "    bind('result',result)\n",
                "    assert( evaluate('result')='0','#1' )\n",
                "    result&=new long(3)\n",
                "    assert( evaluate('result')='3','#2' )\n",
                "");

        runClarionProgram(cl);
    }

    public void testSystemBind()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  string(10)\n",
                "    code\n",
                "    bind('result',result)\n",
                "    result='hello'\n",
                "    assert(evaluate('upper(result)')='HELLO')\n");
        runClarionProgram(cl);
    }
    
    
    public void testBindProcedure()
    {
        ClassLoader cl= compile(
                "    program\n",
                "    map\n",
                "fib  procedure(long),string\n",
                "    .\n",
                "result  long\n",
                "    code\n",
                "    bind('fib',Fib)\n",
                "    result=evaluate('fib(5)+7')\n",
                "fib procedure(aVal)\n",
                "v1  long(0)\n",
                "v2  long(1)\n",
                "t   long\n",
                "    code\n",
                "    loop while aVal>=0\n",
                "       t=v2\n",
                "       v2=v2+v1\n",
                "       v1=t\n",
                "       aVal-=1\n",
                "    .\n",
                "    return v2\n",
                "");

        ClarionObject co = getMainVariable(cl,"result");
        
        assertEquals(0,co.intValue());

        runClarionProgram(cl);
        assertEquals(20,co.intValue());
    }

    public void testBindSystemProcedure1()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  long\n",
                "    code\n",
                "    bind('band',band)\n",
                "    bind('bor',bor)\n",
                "    bind('bshift',bshift)\n",
                "    result=evaluate('band(15,6)+bor(1,2)+bshift(16,4)')\n",
                "");

        ClarionObject co = getMainVariable(cl,"result");
        
        assertEquals(0,co.intValue());

        runClarionProgram(cl);
        assertEquals(6+3+256,co.intValue());
        
    }

    public void testBindSystemProcedure2()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  string(10)\n",
                "    code\n",
                "    bind('right',right)\n",
                "    bind('result',result)\n",
                "    result=evaluate('right(result,10)')\n",
                "");

        ClarionObject co = getMainVariable(cl,"result");
        
        assertEquals("          ",co.toString());

        co.setValue("Boggie");
        runClarionProgram(cl);
        assertEquals("    Boggie",co.toString());
        
    }

    public void testSomePointerStuff()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result &String\n",
                "    map\n",
                "cloneString procedure(String),*string\n",
                "    .\n",
                "    code\n",
                "    result&=cloneString(command(1))\n",
                "cloneString procedure(aString)\n",
                "sSize   short\n",
                "newStr  &STRING\n",
                "    code\n",
                "    sSize=len(aString)\n",
                "    loop while sSize>0 and aString[sSize]=' '\n",
                "        sSize-=1\n",
                "    .\n",
                "",
                "    newStr &= new STRING(choose(sSize=0,1,sSize))\n",
                "    newStr=aString\n",
                "    return newStr\n",
                "");

        assertNull(getMainVariable(cl,"result"));
        
        runClarionProgram(cl,"Boogie");
        assertEquals("Boogie",getMainVariable(cl,"result").toString());

        runClarionProgram(cl,"Boogie      ");
        assertEquals("Boogie",getMainVariable(cl,"result").toString());

        runClarionProgram(cl,"  Boogie      ");
        assertEquals("  Boogie",getMainVariable(cl,"result").toString());
        
    }

    public void testClearArray()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result long,dim(5)\n",
                "    code\n",
                "    if command(1)='set'\n",
                "      loop i#=1 to 5;result[i#]=6-i# .\n",
                "    .\n",
                "    if command(1)='clear'\n",
                "      clear(result)\n",
                "    .\n",
                "");

        ClarionObject[] co = getMainArrayVariable(cl,"result");
        
        runClarionProgram(cl,"set");
        assertEquals(5,co[1].intValue());
        assertEquals(4,co[2].intValue());
        assertEquals(3,co[3].intValue());
        assertEquals(2,co[4].intValue());
        assertEquals(1,co[5].intValue());

        runClarionProgram(cl,"clear");
        assertEquals(0,co[1].intValue());
        assertEquals(0,co[2].intValue());
        assertEquals(0,co[3].intValue());
        assertEquals(0,co[4].intValue());
        assertEquals(0,co[5].intValue());
        
    }

    public void testClear2DArray()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result long,dim(2),dim(5)\n",
                "    code\n",
                "    if command(1)='set'\n",
                "      loop j#=1 to 2\n",
                "          loop i#=1 to 5;result[j#][i#]=(6-i#)*((j#-1)*2-1) .\n",
                "       .\n",
                "    .\n",
                "    if command(1)='clear'\n",
                "      clear(result)\n",
                "    .\n",
                "");

        ClarionObject[][] co = (ClarionObject[][])getMainObject(cl,"result");
        
        runClarionProgram(cl,"set");
        assertEquals(-5,co[1][1].intValue());
        assertEquals(-4,co[1][2].intValue());
        assertEquals(-3,co[1][3].intValue());
        assertEquals(-2,co[1][4].intValue());
        assertEquals(-1,co[1][5].intValue());
        assertEquals(5,co[2][1].intValue());
        assertEquals(4,co[2][2].intValue());
        assertEquals(3,co[2][3].intValue());
        assertEquals(2,co[2][4].intValue());
        assertEquals(1,co[2][5].intValue());

        runClarionProgram(cl,"clear");
        assertEquals(0,co[1][1].intValue());
        assertEquals(0,co[1][2].intValue());
        assertEquals(0,co[1][3].intValue());
        assertEquals(0,co[1][4].intValue());
        assertEquals(0,co[1][5].intValue());
        assertEquals(0,co[2][1].intValue());
        assertEquals(0,co[2][2].intValue());
        assertEquals(0,co[2][3].intValue());
        assertEquals(0,co[2][4].intValue());
        assertEquals(0,co[2][5].intValue());
        
    }

    public void testPrototypeAddress()
    {
        compile(
                "    program\n",
                "result long\n",
                "    map\n",
                "myproc procedure(long)\n",
                "   .\n",
                "    code\n",
                "    result=address(myproc)\n",
                "myproc procedure(val)\n",
                "    code\n",
                "");

    }

    public void testComplexAddress()
    {
        compile(
                "    program\n",
                "result long\n",
                "myclass class\n",
                "myproc procedure(long)\n",
                ".\n",
                "    code\n",
                "    result=address(myclass.myproc)\n",
                "myclass.myproc procedure(val)\n",
                "    code\n",
                "");

    }

    public void testComplexAddress2()
    {
        compile(
                "    program\n",
                "result long\n",
                "myclass class,type\n",
                "myproc procedure(long)\n",
                ".\n",
                "    code\n",
                "    result=address(myclass.myproc)\n",
                "myclass.myproc procedure(val)\n",
                "    code\n",
                "");

    }
    
    public void testInlist()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result=inlist(command(1),'hello','big','wide','world')",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"wide");
        assertEquals(3,result.intValue());

        runClarionProgram(cl,"big");
        assertEquals(2,result.intValue());

        runClarionProgram(cl,"world");
        assertEquals(4,result.intValue());

        runClarionProgram(cl,"hello");
        assertEquals(1,result.intValue());

        runClarionProgram(cl,"lolwut?");
        assertEquals(0,result.intValue());
        
    }

    public void testChoose()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result String\n",
                "    code\n",
                "    result=choose(command(1),'hello','big','wide','world')",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals("hello",result.toString());

        runClarionProgram(cl,"3");
        assertEquals("wide",result.toString());

        runClarionProgram(cl,"2");
        assertEquals("big",result.toString());

        runClarionProgram(cl,"4");
        assertEquals("world",result.toString());

        runClarionProgram(cl,"2");
        assertEquals("big",result.toString());

        runClarionProgram(cl,"5");
        assertEquals("world",result.toString());
    }
    
    public void testPreDistinction()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "gr  group,pre(orc)\n",
                "header long(2)\n",
                ".\n",
                
                "myclass class,type\n",
                "header long(3)\n",
                ".\n",
                
                "  map\n",
                "doit  procedure\n",
                "  .\n",
                
                "result long\n",
                "    code\n",
                "    doit\n",
                "doit  procedure\n",
                "orc myclass\n",
                "    code\n",
                "    result=orc:header + orc.header\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }

    public void testBand()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    if band(7,4) = 4 and bor(15,16)=31\n",
                "      result=1\n",
                "    .\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    public void testBand2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    if ~band(7,8) and bor(15,16)=31\n",
                "      result=1\n",
                "    .\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }
    
    public void testOptParams()
    {
        ClassLoader cl = compile(
                "    program\n",
                "    map\n",
                "tp  procedure(long,<long>,<long>),long\n",
                "    .\n",
                "result long\n",
                "    code\n",
                "    if command(1)=1 then result=tp(command(2)).\n",
                "    if command(1)=2 then result=tp(command(2),command(3)).\n",
                "    if command(1)=3 then result=tp(command(2),command(3),command(4)).\n",
                "tp  procedure(p1,p2,p3)\n",
                "ret long\n",
                "    code\n",
                "    if ~omitted(1) ret+=p1*4.\n",
                "    if ~omitted(2) ret+=p2*2.\n",
                "    if ~omitted(3) ret+=p3.\n",
                "    return ret\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1","3");
        assertEquals(12,result.intValue());

        runClarionProgram(cl,"2","3","2");
        assertEquals(12+4,result.intValue());

        runClarionProgram(cl,"3","3","2","1");
        assertEquals(12+4+1,result.intValue());
    }

    public void testReferenceRawInts()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass class\n",
                "    .\n",
                "robj  &myclass\n",
                "    code\n",
                "    if command(1)='create'\n",
                "       robj &= new myclass\n",
                "       tie('crap',command(2),address(robj))\n",
                "    .\n",
                "    if command(1)='get'\n",
                "       robj &= tied('crap',command(2))\n",
                "    .\n",
                "");

        Object bits[]=new Object[5];
        
        for (int scan=0;scan<5;scan++) {
            runClarionProgram(cl,"create",""+(scan+1));
            bits[scan]=getMainObject(cl,"robj");
        }

        for (int scan=0;scan<5;scan++) {
            assertNotNull(bits[scan]);
            for ( int s2=scan+1;s2<5;s2++) {
                assertNotSame(bits[scan],bits[s2]);
            }
        }

        for (int scan=0;scan<5;scan++) {
            runClarionProgram(cl,"get",""+(scan+1));
            assertSame(bits[scan],getMainObject(cl,"robj"));
        }
    }

    public void testReferenceNumbers()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass class\n",
                "    .\n",
                "nums  long,dim(5)\n",
                "robj  &myclass\n",
                "anchor &myclass,dim(5)\n",
                "    code\n",
                "    if command(1)='create'\n",
                "       robj &= new myclass\n",
                "       anchor[command(2)] &= robj\n", // trick GC
                "       nums[command(2)]=address(robj)\n",
                "    .\n",
                "    if command(1)='get'\n",
                "       robj &= nums[command(2)]\n",
                "    .\n",
                "");

        Object bits[]=new Object[5];
        
        for (int scan=0;scan<5;scan++) {
            runClarionProgram(cl,"create",""+(scan+1));
            bits[scan]=getMainObject(cl,"robj");
        }

        for (int scan=0;scan<5;scan++) {
            assertNotNull(bits[scan]);
            for ( int s2=scan+1;s2<5;s2++) {
                assertNotSame(bits[scan],bits[s2]);
            }
        }

        for (int scan=0;scan<5;scan++) {
            runClarionProgram(cl,"get",""+(scan+1));
            assertSame(bits[scan],getMainObject(cl,"robj"));
        }
    }

    public void testReferenceNumbers2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass class\n",
                "    .\n",
                "nums  string,dim(5)\n",
                "robj  &myclass\n",
                "anchor &myclass,dim(5)\n",
                "    code\n",
                "    if command(1)='create'\n",
                "       robj &= new myclass\n",
                "       anchor[command(2)] &= robj\n", // trick GC
                "       nums[command(2)]=address(robj)\n",
                "    .\n",
                "    if command(1)='get'\n",
                "       robj &= nums[command(2)]+0\n",
                "    .\n",
                "");

        Object bits[]=new Object[5];
        
        for (int scan=0;scan<5;scan++) {
            runClarionProgram(cl,"create",""+(scan+1));
            bits[scan]=getMainObject(cl,"robj");
        }

        for (int scan=0;scan<5;scan++) {
            assertNotNull(bits[scan]);
            for ( int s2=scan+1;s2<5;s2++) {
                assertNotSame(bits[scan],bits[s2]);
            }
        }

        for (int scan=0;scan<5;scan++) {
            runClarionProgram(cl,"get",""+(scan+1));
            assertSame(bits[scan],getMainObject(cl,"robj"));
        }
    }

    public void testAssignArray()
    {
        ClassLoader cl = compile(
                "    program\n",
                "n1  long,dim(5)\n",
                "n2  long,dim(5)\n",
                "result long\n",
                "    code\n",
                "    if command(1)='set1' then n1[command(2)]=command(3).\n",
                "    if command(1)='set2' then n2[command(2)]=command(3).\n",
                "    if command(1)='get1' then result=n1[command(2)].\n",
                "    if command(1)='get2' then result=n2[command(2)].\n",
                "    if command(1)='1=2' then n1 :=: n2. \n",
                "    if command(2)='2=1' then n2 :=: n1. \n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        for (int scan=1;scan<=5;scan++) {
            runClarionProgram(cl,"set1",""+scan,""+(scan*3));
            runClarionProgram(cl,"set2",""+scan,""+(scan*5));
        }

        for (int scan=1;scan<=5;scan++) {
            runClarionProgram(cl,"get1",""+scan);
            assertEquals(scan*3,result.intValue());
            runClarionProgram(cl,"get2",""+scan);
            assertEquals(scan*5,result.intValue());
        }

        runClarionProgram(cl,"1=2");

        for (int scan=1;scan<=5;scan++) {
            runClarionProgram(cl,"get1",""+scan);
            assertEquals(scan*5,result.intValue());
            runClarionProgram(cl,"get2",""+scan);
            assertEquals(scan*5,result.intValue());
        }
    }

    public void testAssignArrayDiffSize1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "n1  long,dim(8)\n",
                "n2  long,dim(5)\n",
                "result long\n",
                "    code\n",
                "    if command(1)='set1' then n1[command(2)]=command(3).\n",
                "    if command(1)='set2' then n2[command(2)]=command(3).\n",
                "    if command(1)='get1' then result=n1[command(2)].\n",
                "    if command(1)='get2' then result=n2[command(2)].\n",
                "    if command(1)='1=2' then n1 :=: n2. \n",
                "    if command(2)='2=1' then n2 :=: n1. \n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        for (int scan=1;scan<=8;scan++) {
            runClarionProgram(cl,"set1",""+scan,""+(scan*3));
        }

        for (int scan=1;scan<=5;scan++) {
            runClarionProgram(cl,"set2",""+scan,""+(scan*5));
        }

        runClarionProgram(cl,"1=2");

        for (int scan=1;scan<=8;scan++) {
            runClarionProgram(cl,"get1",""+scan);
            assertEquals(scan*(scan<=5 ? 5 : 3),result.intValue());
        }

    }

    public void testAssignArrayDiffSize2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "n1  long,dim(5)\n",
                "n2  long,dim(8)\n",
                "result long\n",
                "    code\n",
                "    if command(1)='set1' then n1[command(2)]=command(3).\n",
                "    if command(1)='set2' then n2[command(2)]=command(3).\n",
                "    if command(1)='get1' then result=n1[command(2)].\n",
                "    if command(1)='get2' then result=n2[command(2)].\n",
                "    if command(1)='1=2' then n1 :=: n2. \n",
                "    if command(2)='2=1' then n2 :=: n1. \n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        
        for (int scan=1;scan<=5;scan++) {
            runClarionProgram(cl,"set1",""+scan,""+(scan*3));
        }

        for (int scan=1;scan<=8;scan++) {
            runClarionProgram(cl,"set2",""+scan,""+(scan*5));
        }

        runClarionProgram(cl,"1=2");

        for (int scan=1;scan<=5;scan++) {
            runClarionProgram(cl,"get1",""+scan);
            assertEquals(scan*5,result.intValue());
        }

        for (int scan=1;scan<=8;scan++) {
            runClarionProgram(cl,"get2",""+scan);
            assertEquals(scan*5,result.intValue());
        }

    }

    public void testAmbigiousDefaultProcs()
    {
        compile(
                "    program\n",
                "   map\n",
                "p1 procedure(<long av>)\n",
                "p1 procedure(string av)\n",
                "   .\n",
                "    code\n",
                "    p1()\n",
                "p1 procedure(<long av>)\n",
                "    code\n",
                "p1 procedure(string av)\n",
                "    code\n",
                "");
    }

    public void testStatic()
    {
        ClassLoader cl = compile(
                "    program\n",
                "   map\n",
                "p1 procedure()\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "     p1()\n",
                "p1 procedure()\n",
                "v1  long,static\n",
                "v2  long\n",
                "    code\n",
                "    v1+=1\n",
                "    v2+=2\n",
                "    result=v1+v2\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(3,result.intValue());

        runClarionProgram(cl);
        assertEquals(4,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }

    public void testStaticInClassScope()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass class\n",
                "value long,static\n",
                "doit procedure,long\n",
                ".\n",
                "result long\n",
                "mc &myclass\n",
                "    code\n",
                "    mc &= new myclass\n",
                "    result=mc.doit()\n",
                "myclass.doit procedure\n",
                "   code\n",
                "   self.value+=1\n",
                "   return myclass.value\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        runClarionProgram(cl);
        assertEquals(2,result.intValue());

        runClarionProgram(cl);
        assertEquals(3,result.intValue());

    }
    
    public void testStaticLike()
    {
        ClassLoader cl = compile(
                "    program\n",
                "   map\n",
                "p1 procedure()\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "     p1()\n",
                "p1 procedure()\n",
                "v2  long\n",
                "v1  like(v2),static\n",
                "    code\n",
                "    v1+=1\n",
                "    v2+=2\n",
                "    result=v1+v2\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(3,result.intValue());

        runClarionProgram(cl);
        assertEquals(4,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }

    public void testStaticLikeResolveNamespaceClash()
    {
        ClassLoader cl = compile(
                "    program\n",
                "   map\n",
                "p1 procedure()\n",
                "p2 procedure()\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "     if command(1)=1 then p1().\n",
                "     if command(1)=2 then p2().\n",
                "p1 procedure()\n",
                "v2  long\n",
                "v1  like(v2),static\n",
                "    code\n",
                "    v1+=1\n",
                "    v2+=2\n",
                "    result=v1+v2\n",
                "p2 procedure()\n",
                "v2  long\n",
                "v1  like(v2),static\n",
                "    code\n",
                "    v1+=1\n",
                "    v2+=2\n",
                "    result=v1+v2\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"1");
        assertEquals(3,result.intValue());

        runClarionProgram(cl,"1");
        assertEquals(4,result.intValue());
        
        runClarionProgram(cl,"1");
        assertEquals(5,result.intValue());

        runClarionProgram(cl,"2");
        assertEquals(3,result.intValue());

        runClarionProgram(cl,"2");
        assertEquals(4,result.intValue());
        
        runClarionProgram(cl,"2");
        assertEquals(5,result.intValue());
    
    }

    public void testExternal()
    {
        ClassLoader cl = compile(
                "    program\n",
                "   map\n",
                "p1 procedure()\n",
                "   .\n",
                "result long\n",
                "v1     long\n",
                "    code\n",
                "     p1()\n",
                "p1 procedure()\n",
                "v2  long\n",
                "v1  long,external\n",
                "    code\n",
                "    v1+=1\n",
                "    v2+=2\n",
                "    result=v1+v2\n",
                "");
        
        System.out.println(ClassRepository.get("Main").toJavaSource());

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(3,result.intValue());

        runClarionProgram(cl);
        assertEquals(4,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());

    }

    public void testPassNullToLong()
    {
        compile(
                "    program\n",
                "   map\n",
                "p1 procedure(LONG a=0,LONG b=0)\n",
                "   .\n",
                "    code\n",
                "    p1(,)\n",
                "p1 procedure(LONG a=0,LONG b=0)\n",
                "    code\n",
                "");
    }

    public void testLocalEquates()
    {
        compile(
                "    program\n",
                "   map\n",
                "p1 procedure\n",
                "   .\n",
                "    code\n",
                "p1 procedure\n",
                "ff:normal equate(1)\n",
                "ff2:normal equate(2)\n",
                "k long\n",
                "    code\n",
                "    k=ff:normal+ff2:normal\n",
                "");
        
    }
    
    public void testReturnInLoop()
    {
        compile(
                "    program\n",
                "   map\n",
                "p1 procedure,long\n",
                "   .\n",
                "    code\n",
                "p1 procedure\n",
                "    code\n",
                "    loop\n",
                "       return 1\n",
                "    .\n",
                "");
        
    }

    public void testReturnInLoopConstant()
    {
        compile(
                "    program\n",
                "   map\n",
                "p1 procedure,long\n",
                "   .\n",
                "    code\n",
                "p1 procedure\n",
                "    code\n",
                "    loop while 1\n",
                "       return 1\n",
                "    .\n",
                "");
        
    }

    public void testReturnInPartialLoopConstant()
    {
        compile(
                "    program\n",
                "   map\n",
                "p1 procedure(long aVal),long\n",
                "   .\n",
                "    code\n",
                "p1 procedure(long aVal)\n",
                "    code\n",
                "    loop while 1\n",
                "       if aVal>0\n",
                "         break\n",
                "       .\n",
                "    .\n",
                "");
        
    }

    public void testConflictedDefaults()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(long aVal),long\n",
                "p1 procedure(long aVal,long aval2=0),long\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "    result=p1(1)+p1(2,3)\n",
                "p1 procedure(long aVal)\n",
                "    code\n",
                "    return -aVal\n",
                "p1 procedure(long aVal,long aval2)\n",
                "    code\n",
                "    return aVal*4+aval2*2\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(-1+2*4+3*2,result.intValue());
    }

    public void testConflictedDefaults2()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(long aVal),long\n",
                "p1 procedure(long aVal,long aval2=0,long aval3),long\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "    result=p1(1)+p1(2,3)+p1(4,5,6)\n",
                "p1 procedure(long aVal)\n",
                "    code\n",
                "    return -aVal\n",
                "p1 procedure(long aVal,long aval2,long aval3)\n",
                "    code\n",
                "    return aVal*4+aval2*2+aval3\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(-1+2*4+3+4*4+5*2+6,result.intValue());
    }

    public void testConflictedDefaults3()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(long aVal,long aVal2),long\n",
                "p1 procedure(long aVal,long aval2=0,long aval3=8),long\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "    result=p1(1)+p1(7,3)+p1(4,5,6)\n",
                "p1 procedure(long aVal,long aVal2)\n",
                "    code\n",
                "    return -aVal*aVal2\n",
                "p1 procedure(long aVal,long aval2,long aval3)\n",
                "    code\n",
                "    return aVal*4+aval2*2+aval3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(
                4*1+8 +
                -(7*3)
                +4*4+5*2+6*1,
                result.intValue());
        
//        "    result=p1(1)+p1(2,3)+p1(4,5,6)\n",
        
    }

    public void testConflictedDefaults4()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(long aVal,long aVal2),long\n",
                "p1 procedure(long aVal,long aval2=0,long aval3=8,long aval4=6),long\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "    result=p1(1)+p1(7,3)+p1(4,5,6)+p1(7,8,9,10)\n",
                "p1 procedure(long aVal,long aVal2)\n",
                "    code\n",
                "    return -aVal*aVal2\n",
                "p1 procedure(long aVal,long aval2,long aval3,long aval4)\n",
                "    code\n",
                "    return aVal*4+aval2*2+aval3+aval4*8\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(
                4*1+8 + 6*8
                -(7*3)
                +4*4+5*2+6*1+ 6*8
                +7*4+8*2+9*1+ 10*8,
                result.intValue());
        
    }

    public void testConflictedDefaults5()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(long aVal,long aVal2),long\n",
                "p1 procedure(long aVal,long aVal2,long aVal3),long\n",
                "p1 procedure(long aVal,long aval2=0,long aval3=8,long aval4=6),long\n",
                "   .\n",
                "result long\n",
                "    code\n",
                "    result=p1(1)+p1(7,3)+p1(4,5,6)+p1(7,8,9,10)\n",
                "p1 procedure(long aVal,long aVal2)\n",
                "    code\n",
                "    return -aVal*aVal2\n",
                "p1 procedure(long aVal,long aVal2,long aVal3)\n",
                "    code\n",
                "    return -aVal*aVal2*aVal3\n",
                "p1 procedure(long aVal,long aval2,long aval3,long aval4)\n",
                "    code\n",
                "    return aVal*4+aval2*2+aval3+aval4*8\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(
                4*1+8 + 6*8
                -(7*3)
                -(4*5*6)
                +7*4+8*2+9*1+ 10*8,
                result.intValue());
        
    }

    public void testHardcodedNullInProcCall()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(long aVal=-1,long aVal2),long\n",
                "   .\n",
                "result long\n",
                "   code\n",
                "   result=p1(,5)\n",
                "p1 procedure(long aVal=-1,long aVal2)\n",
                "   code\n",
                "   return aVal+aVal2\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(4,result.intValue());
    }
    
    public void testRemoteRoutineCalls()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(),long\n",
                "   .\n",
                "result long\n",
                "   code\n",
                "   result=p1\n",
                "p1 procedure\n",
                "ret long\n",
                "myclass class\n",
                "doit procedure\n",
                ".\n",
                "   code\n",
                "   myclass.doit\n",
                "   return ret\n",
                "myroutine routine\n",
                "   ret=1\n",
                "myclass.doit procedure\n",
                "   code\n",
                "   do myroutine\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    public void testReturningPassByReference()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(),*long\n",
                "   .\n",
                "result long\n",
                "tresult &long\n",
                "   code\n",
                "   tresult&=p1\n",
                "   tresult+=1\n",
                "p1 procedure()\n",
                "   code\n",
                "   return result\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }
    
    public void testReturningPassByValue()
    {
        ClassLoader cl =compile(
                "    program\n",
                "   map\n",
                "p1 procedure(),long\n",
                "   .\n",
                "result long\n",
                "tresult &long\n",
                "   code\n",
                "   tresult&=p1\n",
                "   tresult+=1\n",
                "p1 procedure()\n",
                "   code\n",
                "   return result\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(0,result.intValue());

        runClarionProgram(cl);
        assertEquals(0,result.intValue());
    }

    public void testAssertCanBeUsedForUnitTesting1()
    {
        ClassLoader cl =compile(
                "    program\n",
                "    code\n",
                "    assert(1,'ok')\n"
                );
        runClarionProgram(cl);
    }
    
    public void testAssertCanBeUsedForUnitTesting2()
    {
        ClassLoader cl =compile(
                "    program\n",
                "    code\n",
                "    assert(0,'bad')\n"
                );
        try {
            runClarionProgram(cl);
            fail("Expected exception");
        } catch (RuntimeException ex ) {
            assertEquals("Assertion Error:bad",ex.getMessage());
        }
    }

    public void testAny()
    {
        ClassLoader cl =compile(
                "    program\n",
                "t   string(20)\n",
                "u   string(20)\n",
                "any1  any\n",
                "any2  any\n",
                "any3  any\n",
                "any4  any\n",
                "\n",
                "   code\n",
                "    t='hello'\n",
                "    any1=t\n",
                "   any2&=t\n",
                
                "   assert(t='hello','1')\n",
                "   assert(any1='hello','2')\n",
                "   assert(any2='hello','3')\n",

                "   t='world'\n",

                "   assert(t='world','4')\n",
                "   assert(any1='hello','5')\n",
                "   assert(any2='world','6')\n",
                
                "   t='!!!'\n",
                "   assert(t='!!!','7')\n",
                "   assert(any1='hello','8')\n",
                "   assert(any2='!!!','9')\n",
                
                
                "   any1='a1'\n",
                "   any2='a2'\n",
                "   assert(t='a2','10')\n",
                "   assert(any1='a1','11')\n",
                "   assert(any2='a2','12')\n",

                "   any3=13\n",
                "   assert(any3='13','13')\n",

                "   any3='00014'\n",
                "   assert(any3='00014','14')\n",

                "   assert( ~(any1&=any2),'15')\n",

                "   any1&=t\n",
                "   assert( (any1&=any2),'16')\n",

                "   any4&=any2\n",
                "   t='waa!'\n",
                "   assert( any4='waa!','17')\n",
                "   assert( (any4&=any2),'16')\n",

                "   any2&=u\n",
                "   u='wee!'\n",
                "   assert( any4='waa!','17')\n",
                "   assert( any2='wee!','18')\n",
                "   assert( ~(any4&=any2),'19')\n",

                "   any2='some'\n",
                "   any4='where'\n",
                "   assert( any2='some','20')\n",
                "   assert( u='some','21')\n",
                "   assert( any4='where','22')\n",
                "   assert( t='where','23')\n",
                
        "");
        
        runClarionProgram(cl);
    }

    
    public void testIsStringAndAnyPlayNice()
    {
        ClassLoader cl =compile(
                "    program\n",
                "t   string(20)\n",
                "u   long\n",
                "any1  any\n",
                "any2  any\n",
                "\n",
                "   code\n",
                "    t='hello'\n",
                "   assert(isstring(t),'1')\n",

                "    any1='hello'\n",
                "   assert(isstring(any1),'2')\n",
                
                "    any1=123\n",
                "   assert(~isstring(any1),'3')\n",

                "    any1&=t\n",
                "   assert(isstring(any1),'4')\n",

                "    any1&=u\n",
                "   assert(~isstring(any1),'4')\n",

                "    any1&=t\n",
                "    any2=any1\n",
                "   assert(isstring(any2),'5')\n",

                "    any1&=u\n",
                "    any2=any1\n",
                "   assert(~isstring(any2),'6')\n",

                "    any1&=t\n",
                "    any2&=any1\n",
                "   assert(isstring(any2),'7')\n",
                "    any1&=u\n",
                "    any2&=any1\n",
                "   assert(~isstring(any2),'8')\n",
                
        "");
        
        
        runClarionProgram(cl);
    }

    public void testClear()
    {
        ClassLoader cl =compile(
                "    program\n",
                "l   long\n",
                "q   queue\n",
                "a   any\n",
                ".\n",
                "\n",
                "   code\n",
                "   l=5\n",
                "   q.a&=l\n",
                "   clear(q.a)\n",
                "   assert(~q.a,1)\n",
                "   assert(l=0,2)\n",

                "   l=5\n",
                "   q.a&=l\n",
                "   q.a=4\n",
                "   assert(q.a=4,3)\n",
                "   assert(l=4,4)\n",

                "   l=5\n",
                "   q.a&=l\n",
                "   clear(q)\n",
                "   assert(~q.a,'5:'&q.a)\n",
                "   assert(l=5,6)\n",
        "");
        
        runClarionProgram(cl);
    }

    public void testChooseMostSimple()
    {
        ClassLoader cl =compile(
                "    program\n",
                "result  long\n",
                "   code\n",
                "   result=choose(command(1)=1)\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl,"1");
        assertEquals(1,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(0,result.intValue());
    }

    public void testChooseBoolDoesNoPreEvaluateInt()
    {
        ClassLoader cl =compile(
                "    program\n",
                "l  long\n",                
                "result  long\n",
                "   map\n",
                "p  procedure(long),long\n",
                "   .\n",
                "   code\n",
                "   l=0\n",
                "   result=choose(command(1)=1,p(1),p(2))\n",
                "p procedure(long aVal)\n",
                "   code\n",
                "   l+=aVal\n",
                "   return l\n",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals(1,result.intValue());

        runClarionProgram(cl,"2");
        assertEquals(2,result.intValue());
    }
    
    
    public void testChooseDoesNoPreEvaluateInt()
    {
        ClassLoader cl =compile(
                "    program\n",
                "l  long\n",                
                "l2  long\n",                
                "result  long\n",
                "   map\n",
                "p  procedure(long),long\n",
                "get  procedure(long),long\n",
                "   .\n",
                "   code\n",
                "   l=0\n",
                "   l2=0\n",
                "   result=choose(get(command(1)),p(1),p(2),p(4))\n",
                "p procedure(long aVal)\n",
                "   code\n",
                "   l+=aVal*2\n",
                "   return l\n",
                "get procedure(long aVal)\n",
                "   code\n",
                "   assert(l2=0)\n",
                "   l2+=1\n",
                "   return aVal",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals(2,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(4,result.intValue());
        runClarionProgram(cl,"3");
        assertEquals(8,result.intValue());

        runClarionProgram(cl,"1");
        assertEquals(2,result.intValue());
        runClarionProgram(cl,"4");
        assertEquals(8,result.intValue());

        runClarionProgram(cl,"1");
        assertEquals(2,result.intValue());
        runClarionProgram(cl,"0");
        assertEquals(8,result.intValue());
    }

    public void testChooseMixedType()
    {
        ClassLoader cl =compile(
                "    program\n",
                "result  pstring(20)\n",
                "   code\n",
                "   result=choose(command(1),10,'select')\n",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals("10",result.toString());
        runClarionProgram(cl,"2");
        assertEquals("select",result.toString());
    }

    public void testChooseMixedTypeWithPrimitive()
    {
        ClassLoader cl =compile(
                "    program\n",
                "result  pstring(20)\n",
                "rs  long(10)\n",
                "   code\n",
                "   result=choose(command(1),rs,thread)\n",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals("10",result.toString());
        runClarionProgram(cl,"2");
        assertEquals("1",result.toString());
    }

    public void testChooseMixedTypeWithPrimitiveOutside()
    {
        ClassLoader cl =compile(
                "    program\n",
                "result  pstring(20)\n",
                "rs  long(10)\n",
                "   code\n",
                "   result=choose(command(1),10,thread)+rs\n",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals("20",result.toString());
        runClarionProgram(cl,"2");
        assertEquals("11",result.toString());
    }

    public void testChooseMixedTypeWithPrimitiveOutsideCompare()
    {
        ClassLoader cl =compile(
                "    program\n",
                "result  long(20)\n",
                "   code\n",
                "   result=choose(command(1),thread,thread=0)\n",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals(1,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(0,result.intValue());
    }

    public void testChooseOutsideScopePrecedence()
    {
        ClassLoader cl =compile(
                "    program\n",
                "r1  long(2)\n",
                "r2  long(5)\n",
                "result long\n",
                "   code\n",
                "   if choose(command(1),r1,r2)>3\n",
                "       result=1\n",
                "   else\n",
                "       result=0\n",
                "   .\n",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(1,result.intValue());
    }

    public void testChooseOutsideScopePrecedenceBooleanType()
    {
        ClassLoader cl =compile(
                "    program\n",
                "r1  long(2)\n",
                "r2  long(5)\n",
                "result long\n",
                "   code\n",
                "   if choose(command(1)>0,r1,r2)>3\n",
                "       result=1\n",
                "   else\n",
                "       result=0\n",
                "   .\n",
        "");
        
        
        ClarionObject result = getMainVariable(cl,"result");
        
        runClarionProgram(cl,"1");
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"0");
        assertEquals(1,result.intValue());
    }

    public void testChooseMixedType2()
    {
        compile(
                "    program\n",
                "accepted equate(2)\n",
                "r2  long(5)\n",
                "result long\n",
                "   code\n",
                "   clear(r2,choose(command(1)=1,accepted,r2))\n",
        "");

        
    }

    public void testEndianMode()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "bits   byte,dim(4),over(result)\n",
                "   code\n",
        "");

        ClarionObject result = getMainVariable(cl,"result"); 
        ClarionObject bits[] = getMainArrayVariable(cl,"bits");
        
        assertEquals(0,result.intValue());
        assertEquals(0,bits[1].intValue());
        assertEquals(0,bits[2].intValue());
        assertEquals(0,bits[3].intValue());
        assertEquals(0,bits[4].intValue());
        
        result.setValue(0x12345678);
        assertEquals(0x12345678,result.intValue());
        assertEquals(0x78,bits[1].intValue());
        assertEquals(0x56,bits[2].intValue());
        assertEquals(0x34,bits[3].intValue());
        assertEquals(0x12,bits[4].intValue());
        
        bits[1].setValue(0x12);
        bits[2].setValue(0x34);
        bits[3].setValue(0x56);
        bits[4].setValue(0x78);
        assertEquals(0x78563412,result.intValue());
        assertEquals(0x12,bits[1].intValue());
        assertEquals(0x34,bits[2].intValue());
        assertEquals(0x56,bits[3].intValue());
        assertEquals(0x78,bits[4].intValue());

        result.setValue(-1);
        assertEquals(-1,result.intValue());
        assertEquals(0xff,bits[1].intValue());
        assertEquals(0xff,bits[2].intValue());
        assertEquals(0xff,bits[3].intValue());
        assertEquals(0xff,bits[4].intValue());

        result.setValue(-2);
        assertEquals(-2,result.intValue());
        assertEquals(0xfe,bits[1].intValue());
        assertEquals(0xff,bits[2].intValue());
        assertEquals(0xff,bits[3].intValue());
        assertEquals(0xff,bits[4].intValue());
    }

    public void testRawIntToStringCast()
    {
        ClassLoader cl =compile(
                "    program\n",
                "calc long\n",
                "result pstring(10)\n",
                "   code\n",
                "   calc=date(8,1,2009)\n",
                "   result=format(year(calc)%100,@n02)\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals("09",result.toString());
    }
    
    public void testRawIntToStringCastInNonMain()
    {
        ClassLoader cl =compile(
                "    program\n",
                "result pstring(10)\n",
                "myclass class\n",
                "calc procedure(long),string\n",
                ".\n",
                "   code\n",
                "   result=myclass.calc(date(8,1,2009))\n",
                "myclass.calc procedure(long calc)\n",
                "   code\n",
                "   return format(year(calc)%100,@n02)\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals("09",result.toString());
    }

    public void testManipulateScopePassedReference()
    {
        ClassLoader cl =compile(
                "    program\n",
                "    map\n",
                "myproc procedure\n",
                "    .\n",
                "    code\n",
                "    myproc\n",
                "myproc procedure\n",
                "myval &long\n",
                "    code\n",
                "    do myroutine\n",
                "    assert( ~(myval &= NULL ) )\n",
                "    assert( myval=3 )\n",
                "myroutine routine\n",
                "    myval &= new long\n",
                "    myval=3\n",
        "");
        
        runClarionProgram(cl);
    }

    public void testPassByReferenceIsNotConfusedByDeepScopes()
    {
        ClassLoader cl =compile(
                "    program\n",
                "    map\n",
                "myproc procedure(*LONG aLong)\n",
                "    .\n",
                "myval long\n",
                "    code\n",
                "    myproc(myval)\n",
                "    assert( myval=3 )\n",
                "myproc procedure(*LONG aLong)\n",
                "    code\n",
                "    do myroutine\n",
                "myroutine routine\n",
                "    aLong=3\n",
        "");
        
        runClarionProgram(cl);
    }
    
    public void testManipulateScopePassedReferenceDeepScope()
    {
        ClassLoader cl =compile(
                "    program\n",
                "    map\n",
                "myproc procedure\n",
                "    .\n",
                "    code\n",
                "    myproc\n",
                "myproc procedure\n",
                "myval &long\n",
                "myclass class\n",
                "doit   procedure\n",
                "   .\n",
                "    code\n",
                "    myclass.doit()\n",
                "    assert( ~(myval &= NULL ),'#1' )\n",
                "    assert( myval=3,'#2' )\n",
                "myroutine routine\n",
                "    myval &= new long\n",
                "myclass.doit procedure\n",
                "    code\n",
                "    do myroutine\n",
                "    myval=3\n",
        "");
        
        runClarionProgram(cl);
    }

    
    public void testManipulateScopePassedReferenceComplex()
    {
        ClassLoader cl =compile(
                "    program\n",
                "    map\n",
                "myproc procedure\n",
                "    .\n",
                "    code\n",
                "    myproc\n",
                "myproc procedure\n",
                "v1 &long\n",
                "v2 &long\n",
                "v3 &long\n",
                "v4 &long\n",
                "    code\n",
                "    do myroutine\n",
                "    assert( ~(v1 &= NULL ) ,'#1')\n",
                "    assert( ~(v2 &= NULL ) ,'#2')\n",
                "    assert( ~(v3 &= NULL ) ,'#3')\n",
                "    assert( v4 &= NULL ,'#4')\n",
                "    assert( ~ (v1 &= v2 ) ,'#5')\n",
                "    assert( (v1 &= v3 ) ,'#6')\n",
                "    assert( v1=1 ,'#7')\n",
                "    assert( v2=2 ,'#8')\n",
                "    assert( v3=1 ,'#9')\n",
                "     v2 &= v1\n",
                "    assert( (v1 &= v2 ) ,'#10')\n",
                "    assert( v2=1 ,'#11')\n",
                "    v4 &= new long(4)\n",
                "    assert( ~(v4 &= NULL) ,'#12')\n",
                "    assert( v4=4,'#13')\n",
                "    v1=5\n",
                "    assert( v1=5 ,'#14')\n",
                "    assert( v2=5 ,'#15')\n",
                "    assert( v3=5 ,'#16')\n",
                "    assert( v4=4 ,'#17')\n",
                
                "myroutine routine\n",
                "    v1 &= new long(1)\n",
                "    v2 &= new long(2)\n",
                "    v3 &= v1\n",
        "");
        
        runClarionProgram(cl);
    }
    
}