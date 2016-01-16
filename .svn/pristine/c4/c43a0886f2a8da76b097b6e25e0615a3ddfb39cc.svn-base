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

import java.io.IOException;
import java.io.FileOutputStream;

import org.jclarion.clarion.ClarionObject;

public class CompileDosFileTest extends CompileTestHelper
{
    public void testGetByInt() throws IOException
    {
        ClassLoader cl = compile(
                
                "   program\n",
                "testfile  file,driver('DOS'),name('test.txt')\n",
                "record  record\n",
                "line    string(20)\n",
                " . .\n",
                "pos long\n",
                "d1 string(20)\n",
                "d2 string(20)\n",
                "   code\n",
                "   open(testfile)\n",
                "   pos=1\n",
                "   get(testfile,pos,10)\n",
                "   d1=testfile.line\n",
                "   pos+=20\n",
                "   get(testfile,pos,15)\n",
                "   d2=testfile.line\n",
                "");

        FileOutputStream fos = new FileOutputStream("test.txt");
        fos.write("Bouncy Bouncy, Oh ..".getBytes());
        fos.write("Twist him up, Twist+".getBytes());
        fos.close();

        runClarionProgram(cl);
        
        ClarionObject cs;
        
        cs = getMainVariable(cl,"d1");
        assertEquals("Bouncy Bou          ",cs.toString());

        cs = getMainVariable(cl,"d2");
        assertEquals("Twist him up, T     ",cs.toString());
        
        
    }
    
    public void testGetByString() throws IOException
    {
        ClassLoader cl = compile(
                
                "   program\n",
                "testfile  file,driver('DOS'),name('test.txt')\n",
                "record  record\n",
                "line    string(20)\n",
                " . .\n",
                "pos string(4)\n",
                "d1 string(20)\n",
                "d2 string(20)\n",
                "   code\n",
                "   open(testfile)\n",
                "   pos='<0><0><0><1>'\n",
                "   get(testfile,pos,10)\n",
                "   d1=testfile.line\n",
                "   pos='<0><0><0><21>'\n",
                "   get(testfile,pos,15)\n",
                "   d2=testfile.line\n",
                "");

        FileOutputStream fos = new FileOutputStream("test.txt");
        fos.write("Bouncy Bouncy, Oh ..".getBytes());
        fos.write("Twist him up, Twist+".getBytes());
        fos.close();

        runClarionProgram(cl);
        
        ClarionObject cs;
        
        cs = getMainVariable(cl,"d1");
        assertEquals("Bouncy Bou          ",cs.toString());

        cs = getMainVariable(cl,"d2");
        assertEquals("Twist him up, T     ",cs.toString());
        
        
    }
    
}
