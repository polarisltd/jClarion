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

public class IncludeCompileTest extends CompileTestHelper
{
    public void testDataInclude()
    {
        getSource().addLexer("data.inc",
                "r1 long(1)\n",
                "r2 long(2)\n",
        "");
        
        ClassLoader cl = compile(
          "   program\n",
          "result long\n",
          "   include('data.inc')\n",
          "   code\n",
          "   result=r1+r2\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(3,result.intValue());
    }
    
    public void testDataIncludeTwiceResultIsCached()
    {
        testDataInclude();
     
        // drop lexer source - force memory cache include
        getSource().empty();
        
        getSource().addLexer("data.inc",
                "r1 long(1)\n",
                "r2 long(2)\n",
        "");
        
        ClassLoader cl = compile(
          "   program\n",
          "result long\n",
          "   include('data.inc')\n",
          "   code\n",
          "   result=r1+r2\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(3,result.intValue());
    }

    public void testMapInclude()
    {
        getSource().addLexer("data.inc",
                "myproc   procedure,long\n",
        "");
        
        ClassLoader cl = compile(
          "   program\n",
          "result long\n",
          "   map\n",
          "   include('data.inc')\n",
          "   .\n",
          "   code\n",
          "   result=myproc\n",
          "myproc procedure\n",
          "    code\n",
          "    return 5\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }

    public void testProcInclude()
    {
        getSource().addLexer("data.inc",
                "myproc procedure\n",
                "    code\n",
                "    return 5\n",
        "");
        
        ClassLoader cl = compile(
          "   program\n",
          "result long\n",
          "   map\n",
          "myproc   procedure,long\n",
          "   .\n",
          "   code\n",
          "   result=myproc\n",
          "   include('data.inc')\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }
    
    public void testMapAndProcInclude()
    {
        getSource().addLexer("data.inc",
                "myproc   procedure,long\n",
        "");

        getSource().addLexer("data.clw",
                "myproc procedure\n",
                "    code\n",
                "    return 5\n",
        "");
        
        ClassLoader cl = compile(
          "   program\n",
          "result long\n",
          "   map\n",
          "   include('data.inc')\n",
          "   .\n",
          "   code\n",
          "   result=myproc\n",
          "   include('data.clw')\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }

    public void testMapAndProcLoadedTwice()
    {
        testMapAndProcInclude();
        
        // drop lexer source - force memory cache include
        getSource().empty();

        ClassLoader cl = compile(
          "   program\n",
          "result long\n",
          "   map\n",
          "   include('data.inc')\n",
          "   .\n",
          "   code\n",
          "   result=myproc\n",
          "   include('data.clw')\n",
        "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(5,result.intValue());
    }
    
    
}
