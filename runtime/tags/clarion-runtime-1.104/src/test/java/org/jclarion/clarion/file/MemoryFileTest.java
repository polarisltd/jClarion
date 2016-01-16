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
package org.jclarion.clarion.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CFile;

import junit.framework.TestCase;

public class MemoryFileTest extends TestCase 
{
    public void testNormalFileFunctions() throws IOException
    {
        assertEquals(0,MemoryFileSystem.totalSize());
        
        ClarionFile cf = new ClarionAsciiFile();
        ClarionString line = new ClarionString(100);
        cf.addVariable("line",line);
        
        cf.setName("memory:/test.txt");
        cf.create();
        assertEquals(0,MemoryFileSystem.totalSize());
        
        cf.open();
        line.setValue("hello");
        cf.add();
        line.setValue("there");
        cf.add();
        line.setValue("world");
        cf.add();
        
        cf.close();
        assertEquals(21,MemoryFileSystem.totalSize());
        
        MemoryFile mf = new MemoryFile("memory:/test.txt",true);
        assertEquals(21,mf.length());

        CFile.deleteFile("memory:/test.txt");
        assertEquals(0,MemoryFileSystem.totalSize());
    }

    public void testNormalFileFunctions2() throws IOException
    {
        assertEquals(0,MemoryFileSystem.totalSize());
        
        ClarionFile cf = new ClarionAsciiFile();
        ClarionString line = new ClarionString(100);
        cf.addVariable("line",line);
        
        cf.setName("memory:/test.txt");
        cf.create();
        assertEquals(0,MemoryFileSystem.totalSize());
        
        cf.open();
        line.setValue("hello");
        cf.add();
        line.setValue("there");
        cf.add();
        line.setValue("world");
        cf.add();
        
        cf.close();
        assertEquals(21,MemoryFileSystem.totalSize());
        
        MemoryFile mf = new MemoryFile("memory:/test.txt",true);
        assertEquals(21,mf.length());

        cf.remove();
        assertEquals(0,MemoryFileSystem.totalSize());
    }
    
    public void testCopyIntoMemory() throws IOException
    {
        assertEquals(0,MemoryFileSystem.totalSize());
        File f = new File("b.txt");
        FileOutputStream fos = new FileOutputStream(f);
        fos.write("Yabba Dabba Doo!\nYeah\n".getBytes());
        fos.close();
        
        assertEquals(0,MemoryFileSystem.totalSize());
        String name = MemoryFile.copyFileIntoMemory("b.txt");
        assertEquals(22,MemoryFileSystem.totalSize());
        
        f.delete();
        assertEquals(22,MemoryFileSystem.totalSize());
        
        assertNotNull(name);
        assertTrue(name.length()>0);

        ClarionFile cf = new ClarionAsciiFile();
        ClarionString line = new ClarionString(100);
        cf.addVariable("line",line);
        
        cf.setName(name);
        cf.open();
        
        cf.next();
        assertEquals(0,CError.errorCode());
        assertTrue(line.equals("Yabba Dabba Doo!"));
        cf.next();
        assertEquals(0,CError.errorCode());
        assertTrue(line.equals("Yeah"));
        
        cf.next();
        assertEquals(33,CError.errorCode());
        
        cf.close();
        
        assertEquals(22,MemoryFileSystem.totalSize());
        cf.create();
        assertEquals(0,MemoryFileSystem.totalSize());
        cf.open();
        cf.next();
        assertEquals(33,CError.errorCode());
    }
}
