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

/**
 * Non-exhaustive testing of all system calls (approx 300 of them in clarion)
 * @author barney
 *
 */
public class SysCallTest extends CompileTestHelper
{
    public void testCommand()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    if command('/miner') then result=1.\n",
                "    if command('/spares') then result=2.\n",
                "    if command('/workshop') then result=3.\n",
                "    if command('/units') then result=4.\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl,"/units");
        assertEquals(4,result.intValue());

        runClarionProgram(cl,"/spares");
        assertEquals(2,result.intValue());

        runClarionProgram(cl,"/miner");
        assertEquals(1,result.intValue());

        runClarionProgram(cl,"/workshop");
        assertEquals(3,result.intValue());

        runClarionProgram(cl,"junk");
        assertEquals(3,result.intValue());
    }

    public void testBindingOperations()
    {
        ClassLoader cl = compile(
                "    program\n",
                "p1  long\n",
                "p2  long\n",
                "result long\n",
                "    code\n",
                "    pushBind()\n",
                "    bind('p1',p1)\n",
                "    bind('p2',p2)\n",
                "    result=evaluate(command(1))\n",
                "    POPBIND()\n",
        "");
        
        ClarionObject p1 = getMainVariable(cl,"p1");
        ClarionObject p2 = getMainVariable(cl,"p2");
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        p1.setValue(10);
        p2.setValue(4);
        runClarionProgram(cl,"p1+p2");
        assertEquals(14,result.intValue());

        runClarionProgram(cl,"p1-p2");
        assertEquals(6,result.intValue());

        runClarionProgram(cl,"p1*p2");
        assertEquals(40,result.intValue());

        runClarionProgram(cl,"p1/p2");
        assertEquals(2,result.intValue());

        runClarionProgram(cl,"p1%p2");
        assertEquals(2,result.intValue());

        runClarionProgram(cl,"p1^p2");
        assertEquals(10000,result.intValue());
    }
    
    public void testCompileStringArray()
    {
        ClassLoader cl = compile(
                "    program\n",
                "test  string(10),dim(3)\n",
                "    code\n",
                "    test[1]='hello'\n",
                "    test[2]='world'\n",
                "    test[3][1:3]=test[1][3:5]\n",
                "    test[1]='hell'\n",
                "");

        ClarionObject co[] = getMainArrayVariable(cl,"test");
        runClarionProgram(cl);
        assertEquals("hell      ",co[1].toString());
        assertEquals("world     ",co[2].toString());
        assertEquals("llo       ",co[3].toString());
        
    }

    public void testInstring()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    code\n",
                "    result=instring('world','hello world',1,1)\n",
                "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(7,result.intValue());
    }
    
}
