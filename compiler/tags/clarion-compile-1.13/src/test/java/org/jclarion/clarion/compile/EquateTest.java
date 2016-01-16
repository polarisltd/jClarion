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

public class EquateTest extends CompileTestHelper
{
    
    public void testSimpleRedefinePrimitive()
    {
        ClassLoader cl = compile(
            "    program\n",
            "wnd equate(long)\n",
            "result wnd(1)\n",
            "    code\n",
        "");
        
        ClarionNumber cn = (ClarionNumber)getMainVariable(cl,"result");
        assertEquals(1,cn.intValue());
        assertEquals(ClarionNumber.LONG,cn.getEncoding());
    }
    
    public void testSimpleRedefinePrimitiveAndPass()
    {
        ClassLoader cl = compile(
            "    program\n",
            "wnd equate(long)\n",
            "    map\n",
            "doit  procedure(wnd)\n",
            "    .\n",
            "result wnd(1)\n",
            "    code\n",
            "    doit(3)\n",
            "doit procedure(aval)\n",
            "    code\n",
            "    result=result+aval\n",
        "");
        
        ClarionNumber cn = (ClarionNumber)getMainVariable(cl,"result");
        assertEquals(1,cn.intValue());
        assertEquals(ClarionNumber.LONG,cn.getEncoding());
        
        runClarionProgram(cl);
        assertEquals(4,cn.intValue());
        
        runClarionProgram(cl);
        assertEquals(7,cn.intValue());
    }

    public void testSimpleRedefineIndirect()
    {
        ClassLoader cl = compile(
            "    program\n",
            "hwnd equate(long)\n",
            "wnd equate(hwnd)\n",
            "    map\n",
            "doit  procedure(wnd)\n",
            "    .\n",
            "result wnd(1)\n",
            "    code\n",
            "    doit(3)\n",
            "doit procedure(aval)\n",
            "    code\n",
            "    result=result+aval\n",
        "");
        
        ClarionNumber cn = (ClarionNumber)getMainVariable(cl,"result");
        assertEquals(1,cn.intValue());
        assertEquals(ClarionNumber.LONG,cn.getEncoding());
        
        runClarionProgram(cl);
        assertEquals(4,cn.intValue());
        
        runClarionProgram(cl);
        assertEquals(7,cn.intValue());
    }

    public void testNonSystem()
    {
        ClassLoader cl = compile(
            "    program\n",
            "myclass  class,type\n",
            "doit     procedure(long)\n",
            "    .\n",
            "wnd equate(myclass)\n",
            "mc       wnd\n",
            "result long(1)\n",
            "    code\n",
            "    mc.doit(3)\n",
            "myclass.doit procedure(aval)\n",
            "    code\n",
            "    result=result+aval\n",
        "");
        
        ClarionNumber cn = (ClarionNumber)getMainVariable(cl,"result");
        assertEquals(1,cn.intValue());
        
        runClarionProgram(cl);
        assertEquals(4,cn.intValue());
        
        runClarionProgram(cl);
        assertEquals(7,cn.intValue());
    }
    
    public void testItemize()
    {
        compile(
        "   program\n",
        "MsgEventCodes           ITEMIZE(1)\n",
        "Msg:Connected             EQUATE\n",
        "Msg:ErrorConnecting       EQUATE\n",
        "Msg:LastWriteCompleted    EQUATE\n",
        "Msg:SocketClosed          EQUATE\n",
        "Msg:ConnectionLost        EQUATE\n",
        "Msg:Last                  EQUATE\n",
        "                        END\n",
        "result long\n",
        "   code\n",
        "   result=Msg:Last\n",
        "");
    }

    public void testNumeric()
    {
        compile(
        "   program\n",
        "Msg:300             EQUATE(2)\n",
        "result long\n",
        "   code\n",
        "   result=Msg:300\n",
        "");
    }
    
}
