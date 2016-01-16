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

import org.jclarion.clarion.ClarionObject;

public class ClarionClassCompileTest extends CompileTestHelper
{
    public void testCompileDefinitionOnly()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "    code\n");
        
        Object o = (Object)instantiate(cl,ClarionCompiler.BASE+".Myclass");
        assertNotNull(o);
        
        assertNull(getMainObject(cl,"myclass"));
    }

    public void testCompileDefinitionAndVariable()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    myclass.f1=1\n",
                "    myclass.f2=7\n",
                "    myclass.f3=-5\n",
                "    result=myclass.f1+myclass.f2+myclass.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        Object cg = (Object)getMainObject(cl,"myclass");
        assertNotNull(cg);
    }

    
    public void testCompileUndefinedMethod()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "\n",
                "someMethod procedure,long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    myclass.f1=1\n",
                "    myclass.f2=7\n",
                "    myclass.f3=-5\n",
                "    result=myclass.f1+myclass.f2+myclass.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        Object cg = (Object)getMainObject(cl,"myclass");
        assertNotNull(cg);
    }

    public void testCompileUndefinedAndCalledMethod1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "\n",
                "someMethod procedure,long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    myclass.f1=1\n",
                "    myclass.f2=7\n",
                "    myclass.f3=-5\n",
                "    result=myclass.f1+myclass.f2+myclass.f3+myclass.someMethod\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        Object cg = (Object)getMainObject(cl,"myclass");
        assertNotNull(cg);

        try {
            runClarionProgram(cl);
            fail("Expected exception");
        } catch (RuntimeException ex) {
        }

        assertEquals(0,getMainVariable(cl,"result").intValue());
    }

    
    public void testCompileCalledMethodSimple()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "\n",
                "someMethod procedure,long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    myclass.f1=1\n",
                "    myclass.f2=7\n",
                "    myclass.f3=-5\n",
                "    result=myclass.f1+myclass.f2+myclass.f3+myclass.someMethod\n",
                "myclass.somemethod procedure\n",
                "    code\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        Object cg = (Object)getMainObject(cl,"myclass");
        assertNotNull(cg);

        runClarionProgram(cl);

        assertEquals(3,getMainVariable(cl,"result").intValue());
    }

    public void testCompileCalledMethodSimple2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "\n",
                "someMethod procedure,long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    myclass.f1=1\n",
                "    myclass.f2=7\n",
                "    myclass.f3=-5\n",
                "    result=myclass.f1+myclass.f2+myclass.f3+myclass.someMethod\n",
                "myclass.somemethod procedure\n",
                "    code\n",
                "    return 1\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        Object cg = (Object)getMainObject(cl,"myclass");
        assertNotNull(cg);

        runClarionProgram(cl);

        assertEquals(4,getMainVariable(cl,"result").intValue());
    }

    public void testCompilePrototypeDefined()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "\n",
                "someMethod procedure,long\n",
                ".\n",
                "myclass  myclass\n",
                "result   long\n",
                "    code\n",
                "    myclass.f1=1\n",
                "    myclass.f2=7\n",
                "    myclass.f3=-5\n",
                "    result=myclass.f1+myclass.f2+myclass.f3+myclass.someMethod\n",
                "myclass.somemethod procedure\n",
                "    code\n",
                "    return SELF.f2\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        Object cg = (Object)getMainObject(cl,"myclass");
        assertNotNull(cg);

        runClarionProgram(cl);

        assertEquals(10,getMainVariable(cl,"result").intValue());
    }

    public void testCompilePrototypeInstantiationAware()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "\n",
                "someMethod procedure(long aName),long\n",
                ".\n",
                "m1  myclass\n",
                "m2  myclass\n",
                "result   long\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m1.f3=-5\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    result=m1.somemethod(1)+m2.somemethod(2)\n",
                "myclass.somemethod procedure(aval)\n",
                "    code\n",
                "    return aVal+self.f1+SELF.f2+SELF.f3\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        runClarionProgram(cl);

        assertEquals(19,getMainVariable(cl,"result").intValue());
    }

    public void testCompileInherit()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "m1  class\n",
                "f1     long\n",
                "f2     long\n",
                "someMethod procedure(long aName),long\n",
                ".\n",

                "m2  class(m1)\n",
                "f3     long\n",
                "someMethod procedure(long aName),long\n",
                ".\n",
                
                "result   long\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    result=m1.somemethod(1)+m2.somemethod(2)\n",
                "m1.somemethod procedure(aval)\n",
                "    code\n",
                "    return aVal+self.f1+SELF.f2\n",
                "m2.somemethod procedure(aval)\n",
                "    code\n",
                "    return -aVal+self.f1+SELF.f2+SELF.f3\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        runClarionProgram(cl);

        assertEquals(20,getMainVariable(cl,"result").intValue());
    }
    
    public void testCompileInheritCallProc()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "m1  class\n",
                "f1     long\n",
                "f2     long\n",
                "someMethod procedure(long aName),long\n",
                ".\n",

                "m2  class(m1)\n",
                "f3     long\n",
                "someMethod procedure(long aName),long\n",
                "someMethod2 procedure(long aName),long\n",
                ".\n",
                
                "result   long\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    result=m1.somemethod(1)+m2.somemethod2(2)\n",
                "m1.somemethod procedure(aval)\n",
                "    code\n",
                "    return aVal+self.f1+SELF.f2\n",
                "m2.somemethod procedure(aval)\n",
                "    code\n",
                "    return -aVal+self.f1+SELF.f2+SELF.f3\n",
                "m2.somemethod2 procedure(aval)\n",
                "    code\n",
                "    return self.somemethod(aval)\n",
                "    return 0\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        runClarionProgram(cl);

        assertEquals(20,getMainVariable(cl,"result").intValue());
    }

    public void testCompileInheritAccessParent()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "m1  class\n",
                "f1     long\n",
                "f2     long\n",
                "someMethod procedure(long aName),long\n",
                ".\n",

                "m2  class(m1)\n",
                "f3     long\n",
                "someMethod procedure(long aName),long\n",
                "someMethod2 procedure(long aName),long\n",
                ".\n",
                
                "result   long\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    result=m1.somemethod(1)+m2.somemethod2(2)\n",
                "m1.somemethod procedure(aval)\n",
                "    code\n",
                "    return aVal+self.f1+SELF.f2\n",
                "m2.somemethod procedure(aval)\n",
                "    code\n",
                "    return -aVal+self.f1+SELF.f2+SELF.f3\n",
                "m2.somemethod2 procedure(aval)\n",
                "    code\n",
                "    return parent.somemethod(aval)\n",
                "    return 0\n",
                "");
        
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        runClarionProgram(cl);

        assertEquals(39,getMainVariable(cl,"result").intValue());
    }

    public void testCompileDanglingType()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "myclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "combine procedure(myclass),long\n",
                ".\n",

                "m1  myclass\n",
                "m2  myclass\n",
                
                "result   long,dim(3)\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m1.f3=-5\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    m1.combine(m2)\n",
                "    result[1]=m1.f1\n",
                "    result[2]=m1.f2\n",
                "    result[3]=m1.f3\n",
                "myclass.combine procedure(other)\n",
                "    code\n",
                "    self.f1+=other.f1\n",
                "    self.f2+=other.f2\n",
                "    self.f3+=other.f3\n",
                "");
        
        ClarionObject result[]=getMainArrayVariable(cl,"result");
        
        runClarionProgram(cl);

        assertEquals(12,result[1].intValue());
        assertEquals(24,result[2].intValue());
        assertEquals(-20,result[3].intValue());
    }

    public void testCompileDanglingType2()
    {
        ClassLoader cl = compile(
                "    program\n",
    
                "m1  myclass\n",
                "m2  myclass\n",
                
                "myclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "combine procedure(myclass),long\n",
                ".\n",

                
                "result   long,dim(3)\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m1.f3=-5\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    m1.combine(m2)\n",
                "    result[1]=m1.f1\n",
                "    result[2]=m1.f2\n",
                "    result[3]=m1.f3\n",
                "myclass.combine procedure(other)\n",
                "    code\n",
                "    self.f1+=other.f1\n",
                "    self.f2+=other.f2\n",
                "    self.f3+=other.f3\n",
                "");
        
        ClarionObject result[]=getMainArrayVariable(cl,"result");
        
        runClarionProgram(cl);

        assertEquals(12,result[1].intValue());
        assertEquals(24,result[2].intValue());
        assertEquals(-20,result[3].intValue());
    }

    public void testConstruct()
    {
        ClassLoader cl = compile(
                "    program\n",

                "m1  &myclass\n",
    
                "myclass  class,type\n",
                "construct procedure()\n",
                ".\n",
                
                "result   long\n",
                "    code\n",
                "    m1 &= new myclass\n",
                "myclass.construct procedure\n",
                "    code\n",
                "    result+=1\n",
                "");
        
        ClarionObject result=getMainVariable(cl,"result");

        assertEquals(0,result.intValue());
        runClarionProgram(cl);

        assertEquals(1,result.intValue());
        runClarionProgram(cl);
        
        assertEquals(2,result.intValue());
        runClarionProgram(cl);
    }

    /*
    public void testDestruct()
    {
        ClassLoader cl = compile(
                "    program\n",

                "m1  &myclass\n",
    
                "myclass  class,type\n",
                "destruct procedure()\n",
                ".\n",
                
                "result   long\n",
                "    code\n",
                "    if command(1) = 'construct'\n",
                "         m1 &= new myclass\n",
                "    .\n",
                "    if command(1) = 'destruct'\n",
                "         dispose(m1)\n",
                "         m1 &= null\n",
                "    .\n",
                "myclass.destruct procedure\n",
                "    code\n",
                "    result+=1\n",
                "");
        
        ClarionObject result=getMainVariable(cl,"result");

        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"construct");
        gc();
        assertEquals(0,result.intValue());

        runClarionProgram(cl,"destruct");
        gc();
        assertEquals(1,result.intValue());

        runClarionProgram(cl,"destruct");
        gc();
        assertEquals(1,result.intValue());
        
        runClarionProgram(cl,"construct");
        gc();
        assertEquals(1,result.intValue());

        runClarionProgram(cl,"construct");
        gc();
        assertEquals(2,result.intValue());
    
        runClarionProgram(cl,"destruct");
        gc();
        assertEquals(3,result.intValue());
        
    }
    */

    
    public void testCallProcedureToMethod()
    {
        ClassLoader cl = compile(
                "    program\n",

                "myclass  class\n",
                "inc procedure()\n",
                ".\n",
                
                "result   long\n",
                "    code\n",
                "    inc(myclass)\n",
                "myclass.inc procedure\n",
                "    code\n",
                "    result+=1\n",
                "");
        
        ClarionObject result=getMainVariable(cl,"result");

        assertEquals(0,result.intValue());

        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }

    public void testCallMethodToProcedure()
    {
        ClassLoader cl = compile(
                "    program\n",

                "myclass  class\n",
                "inc procedure()\n",
                ".\n",
                "",
                "    map\n",
                "inc2 procedure(myclass)\n",
                " .\n",
                "result   long\n",
                "    code\n",
                "    myclass.inc()\n",
                "myclass.inc procedure\n",
                "    code\n",
                "    SELF.inc2()\n",
                "inc2  procedure(self)\n",
                "    code\n",
                "    result+=1\n",
                "");
        
        ClarionObject result=getMainVariable(cl,"result");

        assertEquals(0,result.intValue());

        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }

    public void testCallMethodToProcedureMappedAsProcedureButImplementedAsMethod()
    {
        ClassLoader cl = compile(
                "    program\n",

                "myclass  class\n",
                "inc procedure()\n",
                ".\n",
                "",
                "    map\n",
                "inc2 procedure(myclass)\n",
                " .\n",
                "result   long\n",
                "    code\n",
                "    myclass.inc()\n",
                "myclass.inc procedure\n",
                "    code\n",
                "    SELF.inc2()\n",
                "myclass.inc2  procedure\n",
                "    code\n",
                "    result+=1\n",
                "");
        
        ClarionObject result=getMainVariable(cl,"result");

        assertEquals(0,result.intValue());

        runClarionProgram(cl);
        assertEquals(1,result.intValue());

        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }
    

    public void testCompileTypeLike()
    {
        ClassLoader cl = compile(
                "    program\n",
    
                "myclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "combine procedure(myclass),long\n",
                ".\n",

                "m1  myclass\n",
                "m2  like(myclass)\n",
                
                "result   long,dim(3)\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m1.f3=-5\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    m1.combine(m2)\n",
                "    result[1]=m1.f1\n",
                "    result[2]=m1.f2\n",
                "    result[3]=m1.f3\n",
                "myclass.combine procedure(other)\n",
                "    code\n",
                "    self.f1+=other.f1\n",
                "    self.f2+=other.f2\n",
                "    self.f3+=other.f3\n",
                "");
        
        ClarionObject result[]=getMainArrayVariable(cl,"result");
        
        runClarionProgram(cl);

        assertEquals(12,result[1].intValue());
        assertEquals(24,result[2].intValue());
        assertEquals(-20,result[3].intValue());
    }
    
    public void testCompileTypeLikeWithBaggage()
    {
        ClassLoader cl = compile(
                "    program\n",
    
                "myclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "combine procedure(myclass),long\n",
                ".\n",

                "m1  myclass\n",
                "m2  like(myclass),private\n",
                
                "result   long,dim(3)\n",
                "    code\n",
                "    m1.f1=1\n",
                "    m1.f2=7\n",
                "    m1.f3=-5\n",
                "    m2.f1=11\n",
                "    m2.f2=17\n",
                "    m2.f3=-15\n",
                "    m1.combine(m2)\n",
                "    result[1]=m1.f1\n",
                "    result[2]=m1.f2\n",
                "    result[3]=m1.f3\n",
                "myclass.combine procedure(other)\n",
                "    code\n",
                "    self.f1+=other.f1\n",
                "    self.f2+=other.f2\n",
                "    self.f3+=other.f3\n",
                "");
        
        ClarionObject result[]=getMainArrayVariable(cl,"result");
        
        runClarionProgram(cl);

        assertEquals(12,result[1].intValue());
        assertEquals(24,result[2].intValue());
        assertEquals(-20,result[3].intValue());
    }

    
    public void testOmittedProcedure()
    {
        ClassLoader cl= compile(
                "    program\n",
                "result  long\n",
                "myclass class\n",
                "test  procedure(<LONG>,<LONG>)\n",
                "     .\n",
                "    code\n",
                "    result=0\n",
                "    if command(1)='t1' then myclass.test()\n.",
                "    if command(1)='t2' then myclass.test(1)\n.",
                "    if command(1)='t3' then myclass.test(1,2)\n.",
                "myclass.test  procedure(p1,p2)\n",
                "   code\n",
                "   if omitted(1) then result+=1.\n",
                "   if omitted(2) then result+=2.\n",
                "   if omitted(3) then result+=4.\n",
                "   result+=8\n",
                "");

        ClarionObject co = getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(0,co.intValue());

        runClarionProgram(cl,"t1");
        assertEquals(14,co.intValue());

        runClarionProgram(cl,"t2");
        assertEquals(12,co.intValue());

        runClarionProgram(cl,"t3");
        assertEquals(8,co.intValue());
    }

    public void testPassInterfaceByItsType()
    {
        compile(
                "    program\n",
                "myinterface interface\n",
                ".\n",
                "myclass class\n",
                "m1 procedure(*myinterface mi)\n",
                "m2 procedure(*myinterface mi)\n",
                "  .\n",
                "    code\n",
                "myclass.m1 procedure(*myinterface mi)\n",
                "   code\n",
                "   self.m2(myinterface)\n",
                "myclass.m2 procedure(*myinterface mi)\n",
                "   code\n",
                "");
    }

    public void testCallMethodPassedVarNamesDiffer()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass  class\n",
                "mymethod procedure(long aVar1,long aVar2),long\n",
                ".\n",
                "result long\n",
                "    code\n",
                "    result=myclass.mymethod(command(1),command(2))\n",
                "myclass.mymethod procedure(long tVar1,long tVar2)\n",
                "    code\n",
                "    return tVar1+tVar2\n",
        "");
        

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"2","9");
        assertEquals(11,result.intValue());
    }

    public void testCallInterfacePassedVarNamesDiffer()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myint interface\n",
                "mymethod procedure(long aVar1,long aVar2),long\n",
                ".\n",
                
                "myclass  class,implements(myint)\n",
                ".\n",
                "result long\n",
                "    code\n",
                "    result=myclass.myint.mymethod(command(1),command(2))\n",
                "myclass.myint.mymethod procedure(long tVar1,long tVar2)\n",
                "    code\n",
                "    return tVar1+tVar2\n",
        "");
        

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"2","9");
        assertEquals(11,result.intValue());
    }

    public void testCallInterfaceDifferentPrototypesInClarionButSameInJava()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myint interface\n",
                "mymethod procedure(long aVar1,long aVar2),long\n",
                "mymethod procedure(byte xVar1,byte xVar2),byte\n",
                 ".\n",
                
                "myclass  class,implements(myint)\n",
                ".\n",
                "result long\n",
                "    code\n",
                "    result=myclass.myint.mymethod(command(1),command(2))\n",
                "myclass.myint.mymethod procedure(long tVar1,long tVar2)\n",
                "    code\n",
                "    return tVar1+tVar2\n",
                "myclass.myint.mymethod procedure(byte yVar1,byte yVar2)\n",
                "    code\n",
                "    return yVar1-yVar2\n",
        "");
        

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(0,result.intValue());
        runClarionProgram(cl,"2","9");
        assertEquals(-7,result.intValue());
    }

    public void testDeepAssignment()
    {
        ClassLoader cl = compile(
                "    program\n",

                "left class\n",
                "f1     long(1)\n",
                "f2     long(2)\n",
                "f3     long(4)\n",
                ".\n",

                "right class\n",
                "f1     long(8)\n",
                "f3     long(16)\n",
                "f4     long(32)\n",
                ".\n",
                
                "result long\n",
                
                "    code\n",
                "    left :=: right\n",
                "    result=left.f1+left.f2+left.f3\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(8+16+2,r.intValue());
    }

    public void testDeepAssignmentFromGroup()
    {
        ClassLoader cl = compile(
                "    program\n",

                "left class\n",
                "f1     long(1)\n",
                "f2     long(2)\n",
                "f3     long(4)\n",
                ".\n",

                "right group\n",
                "f1     long(8)\n",
                "f3     long(16)\n",
                "f4     long(32)\n",
                ".\n",
                
                "result long\n",
                
                "    code\n",
                "    left :=: right\n",
                "    result=left.f1+left.f2+left.f3\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(8+16+2,r.intValue());
    }

    public void testDeepAssignmentPolyMorphic()
    {
        ClassLoader cl = compile(
                "    program\n",

                "base class\n",
                "f1     long\n",
                ".\n",
                
                "left class(base)\n",
                "f2     long(2)\n",
                "f3     long(4)\n",
                ".\n",

                "right class(base)\n",
                "f3     long(16)\n",
                "f4     long(32)\n",
                ".\n",
                
                "result long\n",
                
                "    code\n",
                "    left.f1=1;right.f1=8;\n",
                "    left :=: right\n",
                "    result=left.f1+left.f2+left.f3\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(8+16+2,r.intValue());
    }
    
    
    public void testDeepAssignmentToGroup()
    {
        ClassLoader cl = compile(
                "    program\n",

                "left group\n",
                "f1     long(1)\n",
                "f2     long(2)\n",
                "f3     long(4)\n",
                ".\n",

                "right class\n",
                "f1     long(8)\n",
                "f3     long(16)\n",
                "f4     long(32)\n",
                ".\n",
                
                "result long\n",
                
                "    code\n",
                "    left :=: right\n",
                "    result=left.f1+left.f2+left.f3\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(8+16+2,r.intValue());
    }
    
    public void testDeepAssignmentCloneStyle()
    {
        ClassLoader cl = compile(
                "    program\n",

                "left class\n",
                "f1     long(1)\n",
                "f2     long(2)\n",
                "f3     long(4)\n",
                "clone  procedure(left from)\n",
                ".\n",

                "right left\n",
                
                "result long\n",
                
                "    code\n",
                
                "    right.f1=8\n",
                "    right.f2=16\n",
                "    right.f3=32\n",
                
                "    if command(1)='clone' left.clone(right).\n",
                
                "    result=left.f1+left.f2+left.f3\n",
                "left.clone  procedure(left from)\n",
                "   code\n",
                "   SELF :=: from\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(1+2+4,r.intValue());
        runClarionProgram(cl,"clone");
        assertEquals(8+16+32,r.intValue());
    }
    

    /*
    private void gc()
    {
        System.gc();
        System.runFinalization();
        Thread.yield();
        System.gc();
        Thread.yield();
        System.runFinalization();
    }
    */
    
    
}
