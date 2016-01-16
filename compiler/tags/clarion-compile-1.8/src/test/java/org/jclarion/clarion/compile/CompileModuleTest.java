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
import org.jclarion.clarion.compile.java.ClassRepository;

public class CompileModuleTest extends CompileTestHelper
{
    public void testModuleVariableClears()
    {
        getSource().addLexer("module.clw",
        "   member\n",
        "myresult long\n",
        "myfunc  procedure\n",
        "   code\n",
        "   myresult+=1\n",
        "   return myresult\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "myfunc procedure,long\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");
        
        System.out.println(ClassRepository.get("Module").toJavaSource());

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runMainClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(1, result.intValue());

        runMainClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(1, result.intValue());
        
        runMainClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(1, result.intValue());
        
    }
    
    
    public void testSimple()
    {
        getSource().addLexer("module.clw",
        "   member\n",
        "myfunc  procedure\n",
        "   code\n",
        "   return 2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "myfunc procedure,long\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(2, result.intValue());
    }

    public void testWithRedundantMap()
    {
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "myfunc procedure,long\n",
        "     .\n",
        "myfunc  procedure\n",
        "   code\n",
        "   return 2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "myfunc procedure,long\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(2, result.intValue());
    }

    public void testIncludeStyleMapping()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "   code\n",
        "   return 2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(2, result.intValue());
    }

    public void testIncludeSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testIncludeDoubleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    
    public void testIncludeSingleProcedureClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    public void testIncludeSingleProcedureDeepClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testIncludeSingleProcedureDeepClassScopeTraversal2()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");
        
        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    
    
    public void testIncludeDoubleProcedureClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    public void testIncludeDoubleProcedureDeepClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testIncludeDoubleProcedureDeepClassScopeTraversal2()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    public void testDeepRoutineCall()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r long\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   myclass.mymethod\n",
        "   return r\n",
        "myproc routine\n",
        "   r=1\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        
        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(1, result.intValue());
        
    }

    
    public void testIncludeSingleProcedureDeepClassWindowComboA()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        "myfield long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "mydata long\n",
        "mywindow window\n",
        "    string(@s10),use(mydata)\n",
        "    string(@s10),use(r1)\n",
        "    string(@s10),use(myclass.myfield)\n",
        "    string(@s10),use(SELF.myfield)\n",
        ".\n",
        "    code\n",
        "   return r1+r2+SELF.myfield\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }
    
    
    public void testIncludeSingleProcedureDeepClassWindowCombo()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        "myfield long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "mydata long\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "    data\n",
        "mywindow window\n",
        "    string(@s10),use(mydata)\n",
        "    string(@s10),use(r1)\n",
        "    string(@s10),use(myclass.myfield)\n",
        "    string(@s10),use(SELF.myfield)\n",
        ".\n",
        "    code\n",
        "   return r1+r2+?mydata+SELF.myfield\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(4, result.intValue());
    }
    
    
    public void testIncludeSingleProcedureModeWithGlobal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myglobal long(5)\n",
        
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   myglobal+=1\n",
        "   return r1+r2+myglobal\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(9, result.intValue());

        runClarionProgram(cl);
        assertEquals(10, result.intValue());
    }

    public void testDodgyName()
    {
        compile("   program\n",
        "        MAP\n",
        "        MODULE('C runtime')\n",
        "    FNSplit   PROCEDURE(*CSTRING Path, *CSTRING Drv, *CSTRING Dir, *CSTRING Nme, *CSTRING Ext),SIGNED,PROC,RAW,NAME('_fnsplit')\n",
        "    FNMerge   PROCEDURE(*CSTRING Path, *CSTRING Drv, *CSTRING Dir, *CSTRING Nme, *CSTRING Ext),RAW,NAME('_fnmerge')\n",
        "        END\n",
        "      END\n",
        "   code\n",
        
        "");        
    }
    
    public void testIncludeSingleProcedureWithPassedVariable()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   return r1+r2+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());

    }

    public void testIncludeSingleProcedureWithPassedVariable2()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        
        "myclass class\n",
        "doit   procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.doit\n",
        "myclass.doit   procedure\n",
        "   code\n",
        "   return r1+r2+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());

    }

    public void testLikeSymbolFromMainScope()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "t2 like(ptp:record),static\n",
        "   code\n",
        "   return 2+t1.val+t2.val\n",
        "");

        ClassLoader cl = compile(
          "   program\n",
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "t1 file,driver('DOS'),pre(ptp)\n",
          "   record,pre()\n",
          "val  long(3)\n",
          "   . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        System.out.println(ClassRepository.get("Module").toJavaSource());
        
        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(8, result.intValue());
    }

    public void testLocalEquates()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "ff:normal equate(1)\n",
        "ff2:normal equate(2)\n",
        "    code\n",
        "    return ff:normal+ff2:normal\n",
        "");

        ClassLoader cl = compile(
          "   program\n",
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testStolenDangler()
    {
        getSource().addLexer("q1.inc",
        "q1 class,module('q1.clw')\n",
        "run procedure\n",
        "Fields &FieldQueue\n",
        ".\n",
        "");

        getSource().addLexer("q2.inc",
        "q2 class,module('q2.clw')\n",
        "run procedure\n",
        ".\n",
        "");
        
        getSource().addLexer("q1.clw",
        "   member\n",
        "FieldQueue group,type\n",
        "f2 long\n",
        ".\n",
        "q1.run   procedure\n",
        "    code\n",
        "    self.fields.f2=1\n",
        "");

        getSource().addLexer("q2.clw",
        "   member\n",
        "q2.run   procedure\n",
        "FieldQueue group\n",
        "f1 long\n",
        ".\n",
        "    code\n",
        "    FieldQueue.f1=1\n",    
        "");

        compile(
          "   program\n",
          "   include('test/q1.inc')\n",
          "   include('test/q2.inc')\n",
          "   code\n", 
          "");
    }

    public void testIncludeSingleProcedureWithConstructedObjectInRoutineScope()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   do calldoit\n",
        "calldoit routine\n",
        "   data\n",
        "mw  window\n",
        "   string(@n10),use(r1)\n",
        "   string(@n10),use(r2)\n",
        ".\n",
        "   code\n",
        "");

        compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");
    }

    public void testIncludeInsideQueue()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "mq   queue\n",
        "r1   like(r1)\n",
        "r2   like(r2)\n",
        ".\n",
        "   code\n",
        "   return mq.r1+mq.r2+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());
    }

    public void testClashingNamesInSingleProcMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "orcq queue,pre(orc)\n",
        "x long(2)\n",
        ".\n",
        "    code\n",
        "    do callit\n",
        "callit routine\n",
        "   data\n",
        "orc &onroadcost\n",
        "   code\n",
        "   orc&=new onroadcost\n",
        "   return orc.val+ORC:x+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n",
          "onroadcost class,type\n",
          "val long(1)\n",
          ".\n",
          "orcline group,pre(orc)\n",
          "gx long(2)\n",
          ".\n",
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());
    }
    
    public void testSelfReferencingClassSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        
        "myclass class\n",
        "p1  procedure,long\n",
        "p2  procedure,long\n",
        ".\n",
        "r1 long(1)\n",
        "r2 long(2)\n",
        "   code\n",
        "   return myclass.p1()\n",
        "myclass.p1 procedure\n",
        "   code\n",
        "   return myclass.p2()\n",
        "myclass.p2 procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testSelfReferencingClassNotSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        
        "myclass class\n",
        "p1  procedure,long\n",
        "p2  procedure,long\n",
        ".\n",
        "r1 long(1)\n",
        "r2 long(2)\n",
        "   code\n",
        "   return myclass.p1()\n",
        "myclass.p1 procedure\n",
        "   code\n",
        "   return myclass.p2()\n",
        "myclass.p2 procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    
    public void testVariableUsedInTargetInSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(myclass),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "       include('test/module.inc')\n",
        "   .\n",
        "myfunc  procedure(myclass aclass)\n",
        "mywindow window\n",
        "     string(@n10),use(aclass.val)\n",
        "   .\n",
        "    code\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "          include('test/module.inc')\n",
          "     . .\n",
          "myclass class,type\n",
          "val  long\n",
          ".\n",
          "mc  &myclass\n",
          "   code\n",
          "   mc &= new myclass\n",
          "   myfunc(mc)\n",
          "");
        
        runClarionProgram(cl);
    }

    public void testVariableUsedInTarget2InSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(myclass),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "       include('test/module.inc')\n",
        "   .\n",
        "myfunc  procedure(myclass aclass)\n",
        "mywindow window\n",
        "     string(@n10),at(aclass.val,),use(?string)\n",
        "   .\n",
        "    code\n",
        "    open(mywindow)\n",
        "    assert(?string{7c02h}=10)\n", // = Prop.XPOS   
        "    close(mywindow)\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "          include('test/module.inc')\n",
          "     . .\n",
          "myclass class,type\n",
          "val  long\n",
          ".\n",
          "mc  &myclass\n",
          "   code\n",
          "   mc &= new myclass\n",
          "   mc.val=10\n",
          "   myfunc(mc)\n",
          "");
        
        runClarionProgram(cl);
    }
    
}
