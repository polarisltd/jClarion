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
package org.jclarion.clarion.runtime;

import java.io.File;
import java.io.IOException;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

import junit.framework.TestCase;

public class CFileTest extends TestCase {

    public void testGetPath() {
        assertNotNull(CFile.getPath());
    }

    private class FileQueueA extends ClarionQueue
    {
        public ClarionString name=new ClarionString(13);
        public ClarionNumber date=new ClarionNumber();
        public ClarionNumber time=new ClarionNumber();
        public ClarionNumber size=new ClarionNumber();
        public ClarionNumber attrib=new ClarionNumber();
        
        public FileQueueA()
        {
            addVariable("name",name);
            addVariable("date",date);
            addVariable("time",time);
            addVariable("size",size);
            addVariable("attrib",attrib);
        }
    }

    private class FileQueueB extends ClarionQueue
    {
        public ClarionString longname=new ClarionString(13);
        public ClarionString name=new ClarionString(13);
        public ClarionNumber date=new ClarionNumber();
        public ClarionNumber time=new ClarionNumber();
        public ClarionNumber size=new ClarionNumber();
        public ClarionNumber attrib=new ClarionNumber();
        
        public FileQueueB()
        {
            addVariable("longname",longname);
            addVariable("name",name);
            addVariable("date",date);
            addVariable("time",time);
            addVariable("size",size);
            addVariable("attrib",attrib);
        }
    }
    
    public void clean()
    {
        File td = new File("testdir");
        if (td.isDirectory()) {
            File kids[] = td.listFiles();
            for ( File kid : kids ) {
                kid.delete();
            }
            td.delete();
        }
    }
    
    public void testGetDirectoryListing_A_all() throws IOException 
    {
        clean();
        
        (new File("testdir")).mkdir();
        (new File("testdir","test.txt")).createNewFile();
        (new File("testdir","hello.txt")).createNewFile();
        (new File("testdir","world.txt")).createNewFile();
        (new File("testdir","subdir")).mkdir();
        
        FileQueueA cq = new FileQueueA(); 
        CFile.getDirectoryListing(cq,"testdir",-1);
        
        assertEquals(6,cq.records());
        cq.sort(new ClarionString("+name"));
        
        cq.get(1);
        assertEquals(".",cq.name.toString().trim());
        cq.get(2);
        assertEquals("..",cq.name.toString().trim());
        cq.get(3);
        assertEquals("hello.txt",cq.name.toString().trim());
        cq.get(4);
        assertEquals("subdir",cq.name.toString().trim());
        cq.get(5);
        assertEquals("test.txt",cq.name.toString().trim());
        cq.get(6);
        assertEquals("world.txt",cq.name.toString().trim());
    }

    public void testGetDirectoryListing_B_all() throws IOException 
    {
        clean();
        
        (new File("testdir")).mkdir();
        (new File("testdir","test.txt")).createNewFile();
        (new File("testdir","hello.txt")).createNewFile();
        (new File("testdir","world.txt")).createNewFile();
        (new File("testdir","subdir")).mkdir();
        
        FileQueueB cq = new FileQueueB(); 
        CFile.getDirectoryListing(cq,"testdir",-1);
        
        assertEquals(6,cq.records());
        cq.sort(new ClarionString("+name"));
        
        cq.get(1);
        assertEquals(".",cq.name.toString().trim());
        assertEquals(".",cq.longname.toString().trim());
        cq.get(2);
        assertEquals("..",cq.name.toString().trim());
        assertEquals("..",cq.longname.toString().trim());
        cq.get(3);
        assertEquals("hello.txt",cq.name.toString().trim());
        assertEquals("hello.txt",cq.longname.toString().trim());
        cq.get(4);
        assertEquals("subdir",cq.name.toString().trim());
        assertEquals("subdir",cq.longname.toString().trim());
        cq.get(5);
        assertEquals("test.txt",cq.name.toString().trim());
        assertEquals("test.txt",cq.longname.toString().trim());
        cq.get(6);
        assertEquals("world.txt",cq.name.toString().trim());
        assertEquals("world.txt",cq.longname.toString().trim());
    }
    
    public void testGetDirectoryListing_A_normal() throws IOException 
    {
        clean();
        
        (new File("testdir")).mkdir();
        (new File("testdir","test.txt")).createNewFile();
        (new File("testdir","hello.txt")).createNewFile();
        (new File("testdir","world.txt")).createNewFile();
        (new File("testdir","subdir")).mkdir();
        
        FileQueueA cq = new FileQueueA(); 
        CFile.getDirectoryListing(cq,"testdir",0);
        
        assertEquals(3,cq.records());
        cq.sort(new ClarionString("+name"));
        
        cq.get(1);
        assertEquals("hello.txt",cq.name.toString().trim());
        cq.get(2);
        assertEquals("test.txt",cq.name.toString().trim());
        cq.get(3);
        assertEquals("world.txt",cq.name.toString().trim());
    }
    
    /*
    public void testGetPath() {
        fail("Not yet implemented");
    }

    public void testGetShortPath() {
        fail("Not yet implemented");
    }

    public void testSetPath() {
        fail("Not yet implemented");
    }

    public void testDeleteFile() {
        fail("Not yet implemented");
    }

    public void testIsFile() {
        fail("Not yet implemented");
    }

     */
}
