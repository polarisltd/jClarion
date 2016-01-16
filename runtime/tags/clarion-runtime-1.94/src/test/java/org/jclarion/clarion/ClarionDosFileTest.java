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
package org.jclarion.clarion;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.util.SharedOutputStream;

import junit.framework.TestCase;

public class ClarionDosFileTest extends TestCase
{
    public class TestFile extends ClarionBinaryFile
    {
        public ClarionString f1=Clarion.newString(10);
        public ClarionString f2=Clarion.newString(10);
        public ClarionString f3=Clarion.newString(10);
        public ClarionString f4=Clarion.newString(10);
        
        public TestFile()
        {
            addVariable("f1",f1);
            addVariable("f2",f2);
            addVariable("f3",f3);
            addVariable("f4",f4);
        }
    }

    private TestFile file;

    public void tearDown() throws IOException
    {
        if (file!=null) {
            file.close();
        }
    }

    public void testCreateAbsolute()
    {
        file=new TestFile();
        file.setName((new File("test.out")).getAbsolutePath());
        file.create();
        
        File f=  new File("test.out");
        assertTrue(f.isFile());
        assertEquals(0,f.length());
        assertEquals(0,CError.errorCode());
    }
    
    public void testCreate()
    {
        file=new TestFile();
        file.setName("test.out");
        file.create();
        
        File f=  new File("test.out");
        assertTrue(f.isFile());
        assertEquals(0,f.length());
        assertEquals(0,CError.errorCode());
    }
    
    public void testOpen()
    {
        testCreate();
        file.open();
    }
    
    public void testAdd() throws IOException
    {
        testOpen();
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("World");
        file.add();
        file.close();
        
        testContents("Hello     Big       Wide      World     ");
    }

    public void testAddAbsolute() throws IOException
    {
        testCreateAbsolute();
        file.open();
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("World");
        file.add();
        file.close();
        
        testContents("Hello     Big       Wide      World     ");
    }
    

    
    public void testAdd2() throws IOException
    {
        testOpen();
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("World");
        file.add();
        file.f1.setValue("Testing");
        file.f2.setValue("One");
        file.f3.setValue("Two");
        file.f4.setValue("Three");
        file.add();
        file.close();
        
        testContents(
                "Hello     Big       Wide      World     "+
                "Testing   One       Two       Three     "
         );
    }

    public void testAddSmallLen() throws IOException
    {
        testOpen();
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("World");
        file.add();
        file.f1.setValue("Testing");
        file.f2.setValue("One");
        file.f3.setValue("Two");
        file.f4.setValue("Three");
        file.add(38);
        file.close();
        
        testContents(
                "Hello     Big       Wide      World     "+
                "Testing   One       Two       Three   "
         );
    }

    public void testAddBigLen() throws IOException
    {
        testOpen();
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("World");
        file.add();
        file.f1.setValue("Testing");
        file.f2.setValue("One");
        file.f3.setValue("Two");
        file.f4.setValue("Three");
        file.add(44);
        file.close();
        
        testContents(
                "Hello     Big       Wide      World     "+
                "Testing   One       Two       Three         "
         );
    }

    public void testAddMany() throws IOException
    {
        testOpen();
        
        for (int scan=0;scan<400;scan++) {
            file.f1.setValue("Hello:"+scan);
            file.f2.setValue("Big:"+scan);
            file.f3.setValue("Wide:"+scan);
            file.f4.setValue("World:"+scan);
            file.add();
        }
        
        StringBuilder big = new StringBuilder();
        for (int scan=0;scan<10;scan++) {
            big.append(
                "Hello:"+scan+"   Big:"+scan+"     Wide:"+scan+"    World:"+scan+"   ");
        }
        for (int scan=10;scan<100;scan++) {
            big.append(
                "Hello:"+scan+"  Big:"+scan+"    Wide:"+scan+"   World:"+scan+"  ");
        }
        for (int scan=100;scan<400;scan++) {
            big.append(
                "Hello:"+scan+" Big:"+scan+"   Wide:"+scan+"  World:"+scan+" ");
        }
        
        testContents(big.toString());
    }

    public void testRecords() throws IOException
    {
        testOpen();
        
        for (int scan=0;scan<400;scan++) {
            file.f1.setValue("Hello:"+scan);
            file.f2.setValue("Big:"+scan);
            file.f3.setValue("Wide:"+scan);
            file.f4.setValue("World:"+scan);
            assertEquals(scan,file.records());
            file.add();
            assertEquals(scan+1,file.records());
        }
        
        StringBuilder big = new StringBuilder();
        for (int scan=0;scan<10;scan++) {
            big.append(
                "Hello:"+scan+"   Big:"+scan+"     Wide:"+scan+"    World:"+scan+"   ");
        }
        for (int scan=10;scan<100;scan++) {
            big.append(
                "Hello:"+scan+"  Big:"+scan+"    Wide:"+scan+"   World:"+scan+"  ");
        }
        for (int scan=100;scan<400;scan++) {
            big.append(
                "Hello:"+scan+" Big:"+scan+"   Wide:"+scan+"  World:"+scan+" ");
        }
        
        testContents(big.toString());
    }

    public void testSetAndScan() throws IOException
    {
        testAddMany();
        file.close();
        file.setName("test.out   ");
        file.open();
        file.set();

        int len=1;
        
        for (int scan=0;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            
            assertEquals(len,file.getPointer());
            
            String bits = file.getPosition().toString();
            assertEquals((len>>24)&0xff,bits.charAt(0));
            assertEquals((len>>16)&0xff,bits.charAt(1));
            assertEquals((len>>8)&0xff,bits.charAt(2));
            assertEquals((len)&0xff,bits.charAt(3));
            
            
            len+=40;
            assertEquals(0,CError.errorCode());
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        assertTrue(file.eof());
        
        file.next();
        assertEquals(33,CError.errorCode());
        file.next();
        assertEquals(33,CError.errorCode());
        
        
    }
    
    public void testReset() throws IOException
    {
        testAddMany();
        
        testAddMany();
        file.set();

        ClarionString pos=null;
        
        for (int scan=0;scan<300;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==200) pos=file.getPosition();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        file.reset(pos);

        for (int scan=200;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        assertTrue(file.eof());
        
        file.next();
        assertEquals(33,CError.errorCode());
        file.next();
        assertEquals(33,CError.errorCode());
        
        
    }
    
    public void testSetPointer() throws IOException
    {
        testAddMany();
        file.set();

        int pos=0;
        
        for (int scan=0;scan<300;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==200) pos=file.getPointer();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        file.set(pos);

        for (int scan=200;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        assertTrue(file.eof());
        
        file.next();
        assertEquals(33,CError.errorCode());
        file.next();
        assertEquals(33,CError.errorCode());
        
        
    }
    
    public void testPut() throws IOException
    {
        testAddMany();
        file.set();
    
        for (int scan=0;scan<5;scan++) {
            assertFalse(file.eof());
            file.next();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        file.f1.setValue("Testing");
        file.f2.setValue("One");
        file.f3.setValue("Two");
        file.f4.setValue("Three:X");
        file.put();

        for (int scan=5;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        file.set();
        
        for (int scan=0;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==4) {
                assertEquals("Testing",file.f1.toString().trim());
                assertEquals("One",file.f2.toString().trim());
                assertEquals("Two",file.f3.toString().trim());
                assertEquals("Three:X",file.f4.toString().trim());
            } else {
                assertEquals("Hello:"+scan,file.f1.toString().trim());
                assertEquals("Big:"+scan,file.f2.toString().trim());
                assertEquals("Wide:"+scan,file.f3.toString().trim());
                assertEquals("World:"+scan,file.f4.toString().trim());
            }
        }
        
        assertTrue(file.eof());
        
        file.next();
        assertEquals(33,CError.errorCode());
        file.next();
        assertEquals(33,CError.errorCode());
        
        
    }
    
    public void testReget() throws IOException
    {
        testAddMany();
        file.set();

        ClarionString pos=null;
        
        for (int scan=0;scan<200;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==100) pos=file.getPosition();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        file.reget(pos);
        assertEquals(0,CError.errorCode());
        assertEquals("Hello:100",file.f1.toString().trim());
        assertEquals("Big:100",file.f2.toString().trim());
        assertEquals("Wide:100",file.f3.toString().trim());
        assertEquals("World:100",file.f4.toString().trim());

        for (int scan=200;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==300) pos=file.getPosition();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        assertTrue(file.eof());
        
        file.next();
        assertEquals(33,CError.errorCode());
        file.next();
        assertEquals(33,CError.errorCode());
        
        
    }

    public void testSetAndScanTwice() throws IOException
    {
        testAddMany();
        
        for (int sc=0;sc<2;sc++) {
        
        file.set();

        int len=1;
        
        for (int scan=0;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            assertEquals(len,file.getPointer());
            
            String bits = file.getPosition().toString();
            assertEquals((len>>24)&0xff,bits.charAt(0));
            assertEquals((len>>16)&0xff,bits.charAt(1));
            assertEquals((len>>8)&0xff,bits.charAt(2));
            assertEquals((len)&0xff,bits.charAt(3));
            
            
            len+=40;
            assertEquals(0,CError.errorCode());
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        assertTrue(file.eof());
        file.next();
        assertEquals(33,CError.errorCode());
        }
    }

    public void testGet() throws IOException
    {
        testAddMany();
        file.set();

        ClarionString pos=null;
        
        for (int scan=0;scan<200;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==100) pos=file.getPosition();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        file.get(pos,null);
        assertEquals(0,CError.errorCode());
        assertEquals("Hello:100",file.f1.toString().trim());
        assertEquals("Big:100",file.f2.toString().trim());
        assertEquals("Wide:100",file.f3.toString().trim());
        assertEquals("World:100",file.f4.toString().trim());

        for (int scan=200;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==300) pos=file.getPosition();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        assertTrue(file.eof());
        
        file.next();
        assertEquals(33,CError.errorCode());
        file.next();
        assertEquals(33,CError.errorCode());
    }
    
    public void testGetSize() throws IOException
    {
        testAddMany();
        file.set();

        ClarionString pos=null;
        
        for (int scan=0;scan<200;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==100) pos=file.getPosition();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        file.get(pos,22);
        assertEquals(0,CError.errorCode());
        assertEquals("Hello:100",file.f1.toString().trim());
        assertEquals("Big:100",file.f2.toString().trim());
        assertEquals("Wi",file.f3.toString().trim());
        assertEquals("",file.f4.toString().trim());

        for (int scan=200;scan<400;scan++) {
            assertFalse(file.eof());
            file.next();
            if (scan==300) pos=file.getPosition();
            assertEquals("Hello:"+scan,file.f1.toString().trim());
            assertEquals("Big:"+scan,file.f2.toString().trim());
            assertEquals("Wide:"+scan,file.f3.toString().trim());
            assertEquals("World:"+scan,file.f4.toString().trim());
        }
        
        assertTrue(file.eof());
        
        file.next();
        assertEquals(33,CError.errorCode());
        file.next();
        assertEquals(33,CError.errorCode());
    }
    
    
    private void testContents(String string) throws IOException 
    {
        
        FileInputStream fis = new FileInputStream("test.out");
        SharedOutputStream sos = new SharedOutputStream();
        byte buffer[]=new byte[128];
        while ( true ) {
            int len = fis.read(buffer,0,128);
            if (len<0) break;
            sos.write(buffer,0,len);
        }
        fis.close();
        
        assertEquals(string,new String(sos.toByteArray()));
    }
    
}
