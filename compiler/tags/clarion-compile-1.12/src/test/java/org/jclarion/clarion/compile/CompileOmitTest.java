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

public class CompileOmitTest extends CompileTestHelper 
{
    public void testOmitRubbish()
    {
        ClassLoader cl = compile(
        "   program\n",
        "result long\n",
        "   code\n",
        "   omit('Some Crap')\n",
        "   A whole bunch of complete crap\n",
        "   A whole bunch more\n",
        "   SOME crap\n",
        "   result=1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    public void testOmitRubbishOptionally1()
    {
        ClassLoader cl = compile(
        "   program\n",
        "result long\n",
        "   code\n",
        "   omit('Some Crap',1)\n",
        "   A whole bunch of complete crap\n",
        "   A whole bunch more\n",
        "   SOME crap\n",
        "   result=1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    public void testOmitRubbishOptionally2()
    {
        ClassLoader cl = compile(
        "   program\n",
        "result long\n",
        "   code\n",
        "   omit('Some Crap',2)\n",
        "   A whole bunch of complete crap\n",
        "   A whole bunch more\n",
        "   SOME crap\n",
        "   result=1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }

    public void testOmitRubbishOptionally3()
    {
        ClassLoader cl = compile(
        "   program\n",
        "omitcrap  equate(2)\n",
        "result long\n",
        "   code\n",
        "   omit('Some Crap',omitcrap=2)\n",
        "   A whole bunch of complete crap\n",
        "   A whole bunch more\n",
        "   SOME crap\n",
        "   result=1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(1,result.intValue());
    }


    public void testOmitLegalCode1()
    {
        ClassLoader cl = compile(
        "   program\n",
        "omitcrap  equate(2)\n",
        "result long\n",
        "   code\n",
        "   result=1\n",
        "   omit('logic',omitcrap=2)\n",
        "   result=2\n",
        "   logic\n",
        "   result=result+1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }

    public void testOmitLegalCodeIsIncludedBecauseEquateFails()
    {
        ClassLoader cl = compile(
        "   program\n",
        "omitcrap  equate(2)\n",
        "result long\n",
        "   code\n",
        "   result=1\n",
        "   omit('logic',omitcrap=3)\n",
        "   result=2\n",
        "   logic\n",
        "   result=result+1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(3,result.intValue());
    }

    public void testCompileLegalCode1()
    {
        ClassLoader cl = compile(
        "   program\n",
        "omitcrap  equate(2)\n",
        "result long\n",
        "   code\n",
        "   result=1\n",
        "   compile('logic',omitcrap=2)\n",
        "   result=2\n",
        "   logic\n",
        "   result=result+1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(3,result.intValue());
    }

    public void testCompileLegalCodeIsIncludedBecauseEquateFails()
    {
        ClassLoader cl = compile(
        "   program\n",
        "omitcrap  equate(2)\n",
        "result long\n",
        "   code\n",
        "   result=1\n",
        "   compile('logic',omitcrap=3)\n",
        "   result=2\n",
        "   logic\n",
        "   result=result+1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(2,result.intValue());
    }
    

    public void testNestedIncludesWorkOk()
    {
        ClassLoader cl = compile(
        "   program\n",
        "omitcrap  equate(2)\n",
        "result long\n",
        "   code\n",
        "   result=1\n",
        "   compile('logic',omitcrap=2)\n",
        "   result=2\n",
        "   compile('block',omitcrap~=3)\n",
        "   result=result+1\n",
        "   block\n",
        "   logic\n",
        "   result=result+1\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        runClarionProgram(cl);
        assertEquals(4,result.intValue());
    }
    
}
