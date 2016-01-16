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

import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionObject;

public class GroupCompileTest extends CompileTestHelper 
{
    public void testCompileDefinitionOnly()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "    code\n");
        
        ClarionGroup o = (ClarionGroup)instantiate(cl,ClarionCompiler.BASE+".Mygroup");
        
        assertNotNull(o.getGroupParam("f1"));
        assertNotNull(o.getGroupParam("f2"));
        assertNotNull(o.getGroupParam("f3"));
    }

    public void testCompilePrefixSameName()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group,pre(mygroup)\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "    code\n");
        
        ClarionGroup o = (ClarionGroup)instantiate(cl,ClarionCompiler.BASE+".Mygroup");
        
        assertNotNull(o.getGroupParam("f1"));
        assertNotNull(o.getGroupParam("f2"));
        assertNotNull(o.getGroupParam("f3"));
    }
    
    public void testCompileDefinitionAndVariable()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mygroup.f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mygroup.f1+mygroup.f2+mygroup.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }
    
    public void testCompileEmptyGroup()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group()\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mygroup.f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mygroup.f1+mygroup.f2+mygroup.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }

    public void testPre1()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group(),pre\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mygroup.f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mygroup.f1+mygroup.f2+mygroup.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }

    public void testPre2()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group(),pre()\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mygroup.f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mygroup.f1+mygroup.f2+mygroup.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }

    public void testPre3()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group(),pre(mg)\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mygroup.f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mygroup.f1+mygroup.f2+mygroup.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals("mg",cg.getPrefix());
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }

    public void testPrebind()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group(),pre(mg)\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mygroup.f2=7\n",
                "    mygroup.f3=-5\n",
                "    bind(mygroup)\n",
                "    result=evaluate('mg:f1+mg:f2+mg:f3')\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals("mg",cg.getPrefix());
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }
    
    public void testPre4()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group(),pre(mg)\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mg:f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mg:f1+mygroup.f2+mg:f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }

    
    public void testColonCanBePreSubstitute()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  group(),pre(mg)\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mg:f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mg:f1+mygroup.f2+mg:f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }

    public void testNested()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mysuper group\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "myspecific group(mysuper)\n",
                "f4     long\n",
                "f5     long\n",
                ".\n",
                "    code\n",
                "    myspecific.f1=1\n",
                "    myspecific.f2=3\n",
                "    myspecific.f3=5\n",
                "    myspecific.f4=7\n",
                "    myspecific.f5=11\n",
                "    mysuper.f1=-5\n",
                "    mysuper.f2=10\n",
                "    mysuper.f3=15\n",
                "");
        
        runClarionProgram(cl);
        
        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"myspecific");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(3,cg.getGroupParam("f2").intValue());
        assertEquals(5,cg.getGroupParam("f3").intValue());
        assertEquals(7,cg.getGroupParam("f4").intValue());
        assertEquals(11,cg.getGroupParam("f5").intValue());

        cg = (ClarionGroup)getMainObject(cl,"mysuper");
        assertEquals(-5,cg.getGroupParam("f1").intValue());
        assertEquals(10,cg.getGroupParam("f2").intValue());
        assertEquals(15,cg.getGroupParam("f3").intValue());
    }

    public void testAssignToString()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup group\n",
                "f1     string(5)\n",
                "f2     string(5)\n",
                ".\n",
                "result string(10)\n",
                "    code\n",
                "    result=mygroup\n",
                "");

        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        ClarionObject result = getMainVariable(cl,"result");
        result.setValue("");
        cg.getGroupParam("f1").setValue("Hello");
        cg.getGroupParam("f2").setValue("World");
        
        runClarionProgram(cl);
        assertEquals("HelloWorld",result.toString());
    }

    public void testAssignFromString()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup group\n",
                "f1     string(5)\n",
                "f2     string(5)\n",
                ".\n",
                "result string(10)\n",
                "    code\n",
                "    mygroup=result\n",
                "");

        ClarionGroup cg = (ClarionGroup)getMainObject(cl,"mygroup");
        ClarionObject result = getMainVariable(cl,"result");
        result.setValue("HelloWorld");
        
        runClarionProgram(cl);
        assertEquals("Hello",cg.getGroupParam("f1").toString());
        assertEquals("World",cg.getGroupParam("f2").toString());
    }

    public void testGroupMerge()
    {
        ClassLoader cl = compile(
                "    program\n",
                "g1     group\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "g2     group\n",
                "f2     long\n",
                "f3     long\n",
                "f4     long\n",
                ".\n",
                "    code\n",
                "    g2 :=: g1\n",
                "");

        ClarionGroup g1 = (ClarionGroup)getMainObject(cl,"g1");
        ClarionGroup g2 = (ClarionGroup)getMainObject(cl,"g2");

        g1.getGroupParam("f1").setValue(5);
        g1.getGroupParam("f2").setValue(11);
        g1.getGroupParam("f3").setValue(19);
        
        runClarionProgram(cl);
        assertEquals(11,g2.getGroupParam("f2").intValue());
        assertEquals(19,g2.getGroupParam("f3").intValue());
        assertEquals(0,g2.getGroupParam("f4").intValue());
    }

    public void testComplexGroup()
    {
        ClassLoader cl = compile(
                "    program\n",
                "g1     group\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "g2     group\n",
                "f2     long\n",
                "f3     long\n",
                "f4     long\n",
                ".\n",
                ".\n",
                "    code\n",
                "    g1.f1=1\n",
                "    g1.f2=3\n",
                "    g1.f3=5\n",
                "    g1.g2.f2=7\n",
                "    g1.g2.f3=11\n",
                "    g1.g2.f4=13\n",
                "");

        runClarionProgram(cl);
        ClarionGroup g1 = (ClarionGroup)getMainObject(cl,"g1");
        
        assertEquals(1,g1.getGroupParam("f1").intValue());
        assertEquals(3,g1.getGroupParam("f2").intValue());
        assertEquals(5,g1.getGroupParam("f3").intValue());
        
        ClarionGroup g2 = (ClarionGroup)g1.getGroupObject("g2");
        assertEquals(7,g2.getGroupParam("f2").intValue());
        assertEquals(11,g2.getGroupParam("f3").intValue());
        assertEquals(13,g2.getGroupParam("f4").intValue());
    }

    public void testOverGroup()
    {
        ClassLoader cl = compile(
                "    program\n",

                "C8:Import:TextFile FILE,DRIVER('ASCII'),PRE(C8IMP)\n",
                "record  record,pre()\n",
                "line        string(1024)\n",
                "    .  . \n",
                
                "result string(20)\n",
                "g1 group,pre(g),over(C8IMP:line)\n",
                "f1     string(5)\n",
                "f2     string(5)\n",
                "f3     string(5)\n",
                "f4     string(5)\n",
                ".\n",
                "    code\n",
                "    g1.f1='Hello'\n",
                "    g1.f2='Big'\n",
                "    g1.f3='Wide'\n",
                "    g1.f4='World'\n",
                "    result=c8imp:line\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        assertEquals("                    ",r.toString());
        
        runClarionProgram(cl);
        assertEquals("HelloBig  Wide World",r.toString());
    }

    public void testGroupAssignableToString()
    {
        ClassLoader cl = compile(
                "    program\n",

                "result string(20)\n",
                "g1 group,pre(g)\n",
                "f1     string(5)\n",
                "f2     string(5)\n",
                "f3     string(5)\n",
                "f4     string(5)\n",
                ".\n",
                "    code\n",
                "    g1.f1='Hello'\n",
                "    g1.f2='Big'\n",
                "    g1.f3='Wide'\n",
                "    g1.f4='World'\n",
                "    result=g1\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        assertEquals("                    ",r.toString());
        
        runClarionProgram(cl);
        assertEquals("HelloBig  Wide World",r.toString());
        
    }

    public void testPassGroupToProcedure()
    {
        ClassLoader cl = compile(
                "    program\n",

                "result string(20)\n",
                "g1 group,pre(g)\n",
                "f1     string(5)\n",
                "f2     string(5)\n",
                "f3     string(5)\n",
                "f4     string(5)\n",
                ".\n",
                
                "    map\n",
                "init procedure(GROUP aGroup)\n",
                "    .\n",
                
                "    code\n",
                "    g1.f1='Hello'\n",
                "    g1.f2='Big'\n",
                "    g1.f3='Wide'\n",
                "    g1.f4='World'\n",
                "    init(g1)\n",
                "init procedure(GROUP aGroup)\n",
                "    code\n",
                "    result=aGroup\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        assertEquals("                    ",r.toString());
        
        runClarionProgram(cl);
        assertEquals("HelloBig  Wide World",r.toString());
        
    }
    
    
    public void testGroupCanBeAcceptedAsStringParameter()
    {
        ClassLoader cl = compile(
                "    program\n",

                "result string(20)\n",
                "g1 group,pre(g)\n",
                "f1     string(5)\n",
                "f2     string(5)\n",
                "f3     string(5)\n",
                "f4     string(5)\n",
                ".\n",
                
                "    map\n",
                "init procedure(String aGroup)\n",
                "    .\n",
                
                "    code\n",
                "    g1.f1='Hello'\n",
                "    g1.f2='Big'\n",
                "    g1.f3='Wide'\n",
                "    g1.f4='World'\n",
                "    init(g1)\n",
                "init procedure(String aGroup)\n",
                "    code\n",
                "    result=aGroup\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        assertEquals("                    ",r.toString());
        
        runClarionProgram(cl);
        assertEquals("HelloBig  Wide World",r.toString());
    }

    public void testMergeAnonymousGroupContentsIntoParentScope()
    {
        ClassLoader cl = compile(
                "    program\n",

                "result long\n",
                
                "h1 group,type\n",
                "f1     long\n",
                ".\n",
                
                "g1 group(h1),type\n",
                "f2     long\n",
                "f3     long\n",
                "f4     long\n",
                ".\n",

                "g2 group\n",
                "   group(g1).\n",
                ".\n",
                
                "    code\n",
                "    g2.f1=1\n",
                "    g2.f2=3\n",
                "    g2.f3=5\n",
                "    g2.f4=7\n",
                "    result=g2.f1+g2.f2+g2.f3+g2.f4\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(1+3+5+7,r.intValue());
        
        //System.out.println(ClassRepository.get("G2").toJavaSource());
    }

    public void testPassNullGroup()
    {
        ClassLoader cl = compile(
                "    program\n",

                "gr group,type\n",
                "f1     long\n",
                ".\n",
                
                "result long\n",
                
                "   map\n",
                "passgroup  procedure(<*gr agr>,long)\n",
                "   .\n",
                
                "gr1    gr\n",
                "gr2    gr\n",
        
                "    code\n",
                "    result=0\n",
                "    gr1.f1=7\n",
                "    gr2.f1=5\n",
                "    passgroup(,1)\n",
                "    passgroup(gr2,2)\n",
                "passgroup  procedure(<*gr agr>,long aval)\n",
                "    code\n",
                "    if ~omitted(1) then result+=agr.f1 .\n",
                "    result+=aval\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(8,r.intValue());
        
        //System.out.println(ClassRepository.get("G2").toJavaSource());
    }

    public void testAccessVarsOnAnonymousGroup()
    {
        ClassLoader cl = compile(
                "    program\n",

                "gr group,type\n",
                "f1     long\n",
                ".\n",
                
                "result long\n",
                
                "   map\n",
                "passgroup  procedure(group agr)\n",
                "   .\n",
                
                "gr1    gr\n",
                "gr2    gr\n",
        
                "    code\n",
                "    result=0\n",
                "    gr1.f1=7\n",
                "    gr2.f1=5\n",
                "    passgroup(gr2)\n",
                "passgroup  procedure(group agr)\n",
                "    code\n",
                "    result+=agr.f1\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(5,r.intValue());
        
        //System.out.println(ClassRepository.get("G2").toJavaSource());
    }

    public void testDeepAssignment()
    {
        ClassLoader cl = compile(
                "    program\n",

                "left group\n",
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

    public void testAssignCompletelyDifferentGroups1()
    {
        ClassLoader cl = compile(
                "    program\n",

                "g1 group,type\n",
                "f1     long(1)\n",
                "f2     long(2)\n",
                ".\n",

                "g2 group,type\n",
                "f1     long(8)\n",
                "f2     long(16)\n",
                "f3     long(32)\n",
                ".\n",
                
                "v1 &g1\n",
                "v2 &g2\n",
                
                "result long\n",
                
                "    code\n",
                "    if command(1)='create1' then v1&=new g1.\n",
                "    if command(1)='create2' then v2&=new g2.\n",
                "    if command(1)='1to2' then v2&=v1.\n",
                "    if command(1)='2to1' then v1&=v2.\n",
                "    if command(1)='set1' \n",
                "        v1.f1=command(2)\n",
                "        v1.f2=command(3)\n",
                "    .\n",
                "    if command(1)='set2' \n",
                "        v2.f1=command(2)\n",
                "        v2.f2=command(3)\n",
                "        v2.f3=command(4)\n",
                "    .\n",
                "    if command(1)='get1' then result=v1.f1+v1.f2.\n",
                "    if command(1)='get2' then result=v2.f1+v2.f2+v2.f3.\n",
                "");
        
        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(0,r.intValue());

        runClarionProgram(cl,"create1");
        runClarionProgram(cl,"set1","1","2");

        runClarionProgram(cl,"create2");
        runClarionProgram(cl,"set2","3","4","5");
        
        runClarionProgram(cl,"get1");
        assertEquals(3,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(12,r.intValue());

        runClarionProgram(cl,"1to2");
        
        runClarionProgram(cl,"get1");
        assertEquals(3,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(3+32,r.intValue());
        
        runClarionProgram(cl,"set1","3","4");

        runClarionProgram(cl,"get1");
        assertEquals(7,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(7+32,r.intValue());

        runClarionProgram(cl,"set2","5","6","7");

        runClarionProgram(cl,"get1");
        assertEquals(11,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(18,r.intValue());
    }

    public void testAssignCompletelyDifferentGroups2()
    {
        ClassLoader cl = compile(
                "    program\n",

                "g1 group,type\n",
                "f1     long(1)\n",
                "f2     long(2)\n",
                ".\n",

                "g2 group,type\n",
                "f1     long(8)\n",
                "f2     long(16)\n",
                "f3     long(32)\n",
                ".\n",
                
                "v1 &g1\n",
                "v2 &g2\n",
                
                "result long\n",
                
                "    code\n",
                "    if command(1)='create1' then v1&=new g1.\n",
                "    if command(1)='create2' then v2&=new g2.\n",
                "    if command(1)='1to2' then v2&=v1.\n",
                "    if command(1)='2to1' then v1&=v2.\n",
                "    if command(1)='set1' \n",
                "        v1.f1=command(2)\n",
                "        v1.f2=command(3)\n",
                "    .\n",
                "    if command(1)='set2' \n",
                "        v2.f1=command(2)\n",
                "        v2.f2=command(3)\n",
                "        v2.f3=command(4)\n",
                "    .\n",
                "    if command(1)='get1' then result=v1.f1+v1.f2.\n",
                "    if command(1)='get2' then result=v2.f1+v2.f2+v2.f3.\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals(0,r.intValue());

        runClarionProgram(cl,"create1");
        runClarionProgram(cl,"set1","1","2");

        runClarionProgram(cl,"create2");
        runClarionProgram(cl,"set2","3","4","5");
        
        runClarionProgram(cl,"get1");
        assertEquals(3,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(12,r.intValue());

        runClarionProgram(cl,"2to1");
        
        runClarionProgram(cl,"get1");
        assertEquals(7,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(12,r.intValue());
        
        runClarionProgram(cl,"set1","5","6");

        runClarionProgram(cl,"get1");
        assertEquals(11,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(16,r.intValue());

        runClarionProgram(cl,"set2","7","8","9");

        runClarionProgram(cl,"get1");
        assertEquals(15,r.intValue());
        runClarionProgram(cl,"get2");
        assertEquals(24,r.intValue());
    }

    public void testMultipleOver()
    {
        ClassLoader cl = compile(
                "    program\n",

                "result string(10)\n",

                "    map\n",
                "r1  procedure(string p1,string p2)\n",
                "r2  procedure(string p1,string p2)\n",
                "   .\n",

                "    code\n",
                "    result=''\n",
                "    if command(1)='1' r1(command(2),command(3)).\n",
                "    if command(1)='2' r2(command(2),command(3)).\n",

                "r1  procedure(string p1,string p2)\n",
                "map1 group,over(result)\n",
                "s1 string(5)\n",
                "s2 string(5)\n",
                ".\n",
                "    code\n",
                "     map1.s1='hello'\n",
                "     map1.s2='world'\n",
                
                "r2  procedure(string p1,string p2)\n",
                "map1 group,over(result)\n",
                "s1 string(6)\n",
                "s2 string(4)\n",
                ".\n",
                "    code\n",
                "     map1.s1='hello'\n",
                "     map1.s2='world'\n",
                "");

        ClarionObject r= getMainVariable(cl,"result");
        
        runClarionProgram(cl);
        assertEquals("          ",r.toString());

        runClarionProgram(cl,"1");
        assertEquals("helloworld",r.toString());

        runClarionProgram(cl,"2");
        assertEquals("hello worl",r.toString());
    }
    
}
