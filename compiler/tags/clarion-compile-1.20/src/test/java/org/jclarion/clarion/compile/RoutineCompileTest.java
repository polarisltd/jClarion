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

public class RoutineCompileTest extends CompileTestHelper
{
    public void testCompileOnly()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure\n",
            "    .\n",
            "    code\n",
            "    testproc\n",
            "testproc procedure\n",
            "    code\n",
            "    result=5\n",
            "myroutine routine\n",
            "    result=10\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }
    
    public void testCall()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long)\n",
            "    .\n",
            "    code\n",
            "    testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "    code\n",
            "    do myroutine\n",
            "    result=result+pass\n",
            "myroutine routine\n",
            "    result=10\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(14,result.intValue());
    }

    public void testImplicitsOperateOnHigherScope()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long,long)\n",
            "    .\n",
            "    code\n",
            "    testproc(command(1),command(2))\n",
            "testproc procedure(p1,p2)\n",
            "    code\n",
            "    do myr1\n",
            "    do myr2\n",
            "myr1 routine\n",
            "    x#=p1\n",
            "myr2 routine\n",
            "    x#+=p2\n",
            "    result=x#\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4","6");
        assertEquals(10,result.intValue());

        runClarionProgram(cl,"2","3");
        assertEquals(5,result.intValue());
        
    }
    
    
    public void testCallAccessLocalVariable()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long)\n",
            "    .\n",
            "    code\n",
            "    testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "    code\n",
            "    do myroutine\n",
            "myroutine routine\n",
            "    result=10+pass\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(14,result.intValue());
    }

    public void testCallAccessLocalVariableIndirectly()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long)\n",
            "    .\n",
            "    code\n",
            "    testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "    code\n",
            "    do myroutine\n",
            "myroutine routine\n",
            "    do myroutine2\n",
            "myroutine2 routine\n",
            "    result=10+pass\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(14,result.intValue());
    }

    public void testCallAccessLocalVariableIndirectly2()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long),long\n",
            "    .\n",
            "    code\n",
            "    result=testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "r   long\n",
            "    code\n",
            "    do myroutine\n",
            "    return r\n",
            "myroutine routine\n",
            "    do myroutine2\n",
            "myroutine2 routine\n",
            "    r=10+pass\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(14,result.intValue());
    }
    
    
    public void testExit()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long)\n",
            "    .\n",
            "    code\n",
            "    testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "    code\n",
            "    do myroutine\n",
            "myroutine routine\n",
            "    do myroutine2\n",
            "myroutine2 routine\n",
            "    result=10+pass\n",
            "    exit\n",
            "    result=result+1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(14,result.intValue());
    }

    public void testReturn()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long),long\n",
            "    .\n",
            "    code\n",
            "    result=testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "r   long\n",
            "    code\n",
            "    do myroutine\n",
            "    r=r+1\n",
            "    return r\n",
            "myroutine routine\n",
            "    do myroutine2\n",
            "    if r>15 then return 3.\n",
            "myroutine2 routine\n",
            "    r=10+pass\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(15,result.intValue());

        runClarionProgram(cl,"6");
        assertEquals(3,result.intValue());
    }

    public void testReturnIndirect()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long),long\n",
            "    .\n",
            "    code\n",
            "    result=testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "r   long\n",
            "    code\n",
            "    do myroutine\n",
            "    r=r+1\n",
            "    return r\n",
            "myroutine routine\n",
            "    do myroutine2\n",
            "myroutine2 routine\n",
            "    r=10+pass\n",
            "    if r>15 then return 3.\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(15,result.intValue());

        runClarionProgram(cl,"6");
        assertEquals(3,result.intValue());
    }

    public void testReturnVoid()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long)\n",
            "    .\n",
            "    code\n",
            "    result=0;testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "    code\n",
            "    do myroutine\n",
            "    result=result+1\n",
            "myroutine routine\n",
            "    do myroutine2\n",
            "myroutine2 routine\n",
            "    result=10+pass\n",
            "    if result>15\n",
            "       result=3\n",
            "       return\n",
            "    .\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(15,result.intValue());

        runClarionProgram(cl,"6");
        assertEquals(3,result.intValue());
    }
    
    public void testIndirectedOrderingOfDefinitionTransmitsRoutineProperties()
    {
        ClassLoader cl = compile(
            "    program\n",
            "result long\n",
            "    map\n",
            "testproc procedure(long),long\n",
            "    .\n",
            "    code\n",
            "    result=testproc(command(1))\n",
            "testproc procedure(pass)\n",
            "r   long\n",
            "    code\n",
            "    do myroutine\n",
            "    r=r+1\n",
            "    return r\n",
            "myroutine2 routine\n",
            "    r=10+pass\n",
            "    if r>15 then return 3.\n",
            "myroutine routine\n",
            "    do myroutine2\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"4");
        assertEquals(15,result.intValue());

        runClarionProgram(cl,"6");
        assertEquals(3,result.intValue());
    }

    
}
