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
import java.io.FileWriter;
import java.io.IOException;

import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.util.SharedOutputStream;

import junit.framework.TestCase;

public class ClarionAsciiFileTest extends TestCase
{
    
    public class TestFile extends ClarionAsciiFile
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

    public void setUp()
    {
        (new File("test.out")).delete();
    }
    
    public void tearDown() throws IOException
    {
        if (file!=null) {
            file.close();
        }
    }

    public void testReadResourceFile()
    {
    	ClarionAsciiFile caf = new ClarionAsciiFile();
    	caf.setName("resource:/resources/schema.properties");
    	ClarionString l = new ClarionString(100);
    	caf.addVariable("l",l);
    	
    	caf.open();
    	assertEquals(0,CError.errorCode());
    	caf.set();
    	caf.next();
    	assertEquals(0,CError.errorCode());
    	assertEquals("encoding.mvntest_sqlascii=SQL_ASCII",l.toString().trim());    	    
    	caf.next();
    	assertEquals(33,CError.errorCode());
    	caf.close();
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
        
        testContents("Hello     Big       Wide      World\r\n");
    }

    public void testMultiByte() throws IOException
    {
        testOpen();
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("世界");
        file.add();
        file.f4.setValue("عالم");
        file.add();
        file.f4.setValue("мир");
        file.add();
        file.close();
        
        testContents(
                "Hello     Big       Wide      世界\r\n"+
                "Hello     Big       Wide      عالم\r\n"+
                "Hello     Big       Wide      мир\r\n"+
                "");
        
        file.open();
        
        file.clear();
        file.set();
        file.next();
        int p1=file.getPointer();
        assertEquals(1,p1);
        assertEquals("Hello     ",file.f1.toString());
        assertEquals("Big       ",file.f2.toString());
        assertEquals("Wide      ",file.f3.toString());
        assertEquals("世界        ",file.f4.toString());
        file.next();
        int p2=file.getPointer();
        assertEquals("Hello     ",file.f1.toString());
        assertEquals("Big       ",file.f2.toString());
        assertEquals("Wide      ",file.f3.toString());
        assertEquals("عالم      ",file.f4.toString());
        file.next();
        int p3=file.getPointer();
        assertEquals("Hello     ",file.f1.toString());
        assertEquals("Big       ",file.f2.toString());
        assertEquals("Wide      ",file.f3.toString());
        assertEquals("мир       ",file.f4.toString());
        
        assertTrue(file.eof());
     
        file.get(Clarion.newNumber(p2),null);
        assertEquals("Hello     ",file.f1.toString());
        assertEquals("Big       ",file.f2.toString());
        assertEquals("Wide      ",file.f3.toString());
        assertEquals("عالم      ",file.f4.toString());

        file.get(Clarion.newNumber(p1),null);
        assertEquals("Hello     ",file.f1.toString());
        assertEquals("Big       ",file.f2.toString());
        assertEquals("Wide      ",file.f3.toString());
        assertEquals("世界        ",file.f4.toString());
        
        file.get(Clarion.newNumber(p3),null);
        assertEquals("Hello     ",file.f1.toString());
        assertEquals("Big       ",file.f2.toString());
        assertEquals("Wide      ",file.f3.toString());
        assertEquals("мир       ",file.f4.toString());
        
        file.close();
    }
    
    public void testAddWithLength() throws IOException
    {
        testOpen();
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("World");
        file.add(6);
        file.add(40);
        file.add(50);
        file.add(38);
        file.close();
        
        testContents(
                "Hello \r\n"+
                "Hello     Big       Wide      World     \r\n"+
                "Hello     Big       Wide      World               \r\n"+
                "Hello     Big       Wide      World   \r\n"
        );
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
        
        testContents("Hello     Big       Wide      World\r\n");
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
                "Hello     Big       Wide      World\r\n"+
                "Testing   One       Two       Three\r\n"
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
                "Hello:"+scan+"   Big:"+scan+"     Wide:"+scan+"    World:"+scan+"\r\n");
        }
        for (int scan=10;scan<100;scan++) {
            big.append(
                "Hello:"+scan+"  Big:"+scan+"    Wide:"+scan+"   World:"+scan+"\r\n");
        }
        for (int scan=100;scan<400;scan++) {
            big.append(
                "Hello:"+scan+" Big:"+scan+"   Wide:"+scan+"  World:"+scan+"\r\n");
        }
        
        testContents(big.toString());
    }

    public void testSetAndScan() throws IOException
    {
        testAddMany();
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
            
            
            len+=40-3+2;
            if (scan>=10) len++;
            if (scan>=100) len++;
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
            
            
            len+=40-3+2;
            if (scan>=10) len++;
            if (scan>=100) len++;
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
    
    public void testScanUnixFiles() throws IOException
    {
        write(
                "Hello     Big       Wide      World\n"+
                "Testing   One       Two       Three\n");
        
        file=new TestFile();
        file.setName("test.out");
        
        file.open();
        file.set();

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Hello",file.f1.toString().trim());
        assertEquals("Big",file.f2.toString().trim());
        assertEquals("Wide",file.f3.toString().trim());
        assertEquals("World",file.f4.toString().trim());

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Testing",file.f1.toString().trim());
        assertEquals("One",file.f2.toString().trim());
        assertEquals("Two",file.f3.toString().trim());
        assertEquals("Three",file.f4.toString().trim());

        assertTrue(file.eof());
        file.next();
        assertEquals(33,CError.errorCode());
    }

    public void testReadTabs() throws IOException
    {
        write(
                "Hello\tBig\tWide\tWorld\n"+
                "Testing\tOne\tTwo\tThree\n");
        
        file=new TestFile();
        file.setName("test.out");
        file.send("/tab=10");
        
        file.open();
        file.set();

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Hello",file.f1.toString().trim());
        assertEquals("Big",file.f2.toString().trim());
        assertEquals("Wide",file.f3.toString().trim());
        assertEquals("World",file.f4.toString().trim());

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Testing",file.f1.toString().trim());
        assertEquals("One",file.f2.toString().trim());
        assertEquals("Two",file.f3.toString().trim());
        assertEquals("Three",file.f4.toString().trim());

        assertTrue(file.eof());
        file.next();
        assertEquals(33,CError.errorCode());
    }

    public void testReadTabsDefault() throws IOException
    {
        write(
                "Hello\tBig\tWide\tWorld\n"+
                "Testing\tOne\tTwo\tThree\n");
        
        file=new TestFile();
        file.setName("test.out");
        
        file.open();
        file.set();

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Hello   Bi",file.f1.toString());
        assertEquals("g     Wide",file.f2.toString());
        assertEquals("    World ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        
        assertEquals("Testing On",file.f1.toString());
        assertEquals("e     Two ",file.f2.toString());
        assertEquals("    Three ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertTrue(file.eof());
        file.next();
        assertEquals(33,CError.errorCode());
    }

    public void testReadTabsFixed() throws IOException
    {
        write(
                "Hello\tBig\tWide\tWorld\n"+
                "Testing\tOne\tTwo\tThree\n");
        
        file=new TestFile();
        file.setName("test.out");
        file.send("/tab=-2");
        
        file.open();
        file.set();

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Hello  Big",file.f1.toString());
        assertEquals("  Wide  Wo",file.f2.toString());
        assertEquals("rld       ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        
        assertEquals("Testing  O",file.f1.toString());
        assertEquals("ne  Two  T",file.f2.toString());
        assertEquals("hree      ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertTrue(file.eof());
        file.next();
        assertEquals(33,CError.errorCode());
    }

    public void testReadTabsNone() throws IOException
    {
        write(
                "Hello\tBig\tWide\tWorld\n"+
                "Testing\tOne\tTwo\tThree\n");
        
        file=new TestFile();
        file.setName("test.out");
        file.send("/tab=0");
        
        file.open();
        file.set();

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("HelloBigWi",file.f1.toString());
        assertEquals("deWorld   ",file.f2.toString());
        assertEquals("          ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        
        assertEquals("TestingOne",file.f1.toString());
        assertEquals("TwoThree  ",file.f2.toString());
        assertEquals("          ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertTrue(file.eof());
        file.next();
        assertEquals(33,CError.errorCode());
    }

    public void testReadTabsKeep() throws IOException
    {
        write(
                "Hello\tBig\tWide\tWorld\n"+
                "Testing\tOne\tTwo\tThree\n");
        
        file=new TestFile();
        file.setName("test.out");
        file.send("/tab=-100");
        
        file.open();
        file.set();

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Hello\tBig\t",file.f1.toString());
        assertEquals("Wide\tWorld",file.f2.toString());
        assertEquals("          ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertFalse(file.eof());
        file.next();
        assertEquals(0,CError.errorCode());
        
        assertEquals("Testing\tOn",file.f1.toString());
        assertEquals("e\tTwo\tThre",file.f2.toString());
        assertEquals("e         ",file.f3.toString());
        assertEquals("          ",file.f4.toString());

        assertTrue(file.eof());
        file.next();
        assertEquals(33,CError.errorCode());
    }

    
    public void testReadWithUnboundedString() throws IOException
    {
        write(
                "Part number,Description,Some Other\n"+
                "01234567890,\"12\\\" Thingo\",\"This\\\\That\"\n"+
                "ABC 123,\"Other , thing\"\n"+
                "123456,,10.12,20.16,30.4,10\n"+
                "123456789012345\n"+
                "0.0001,0.001,0.01,0.1,1\n"+
                "1.1111,10.1111,100.1111,1000.1111,10000.1111,100000.1111,1000000.1111,10000000.1111,100000000.1111,1000000000.1111\n"+
                "10000000000.111,100000000000.11,1000000000000.1,10000000000000\n"+
                "3 Cell Merge,,,More stuff\n"+
                "");
        
        ClarionAsciiFile caf = new ClarionAsciiFile();
        ClarionString line = new ClarionString();
        caf.setName("test.out   ");
        caf.addVariable("line",line);
        
        caf.open();
        assertEquals(0,CError.errorCode());
        
        caf.set();

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Part number,Description,Some Other",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("01234567890,\"12\\\" Thingo\",\"This\\\\That\"",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("ABC 123,\"Other , thing\"",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("123456,,10.12,20.16,30.4,10",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("123456789012345",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("0.0001,0.001,0.01,0.1,1",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("1.1111,10.1111,100.1111,1000.1111,10000.1111,100000.1111,1000000.1111,10000000.1111,100000000.1111,1000000000.1111",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("10000000000.111,100000000000.11,1000000000000.1,10000000000000",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("3 Cell Merge,,,More stuff",line.toString().trim());

        caf.next();
        assertEquals(33,CError.errorCode());
    }

    public void testReadOnlyFile() throws IOException
    {
        write(
                "Part number,Description,Some Other\n"+
                "01234567890,\"12\\\" Thingo\",\"This\\\\That\"\n"+
                "ABC 123,\"Other , thing\"\n"+
                "123456,,10.12,20.16,30.4,10\n"+
                "123456789012345\n"+
                "0.0001,0.001,0.01,0.1,1\n"+
                "1.1111,10.1111,100.1111,1000.1111,10000.1111,100000.1111,1000000.1111,10000000.1111,100000000.1111,1000000000.1111\n"+
                "10000000000.111,100000000000.11,1000000000000.1,10000000000000\n"+
                "3 Cell Merge,,,More stuff\n"+
                "");
        
        ClarionAsciiFile caf = new ClarionAsciiFile();
        ClarionString line = new ClarionString();
        
        File f = new File("test.out");
        f.setReadOnly();
        
        caf.setName("test.out   ");
        caf.addVariable("line",line);
        
        caf.open();
        assertEquals(0,CError.errorCode());
        
        caf.set();

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Part number,Description,Some Other",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("01234567890,\"12\\\" Thingo\",\"This\\\\That\"",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("ABC 123,\"Other , thing\"",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("123456,,10.12,20.16,30.4,10",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("123456789012345",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("0.0001,0.001,0.01,0.1,1",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("1.1111,10.1111,100.1111,1000.1111,10000.1111,100000.1111,1000000.1111,10000000.1111,100000000.1111,1000000000.1111",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("10000000000.111,100000000000.11,1000000000000.1,10000000000000",line.toString().trim());

        caf.next();
        assertEquals(0,CError.errorCode());
        assertEquals("3 Cell Merge,,,More stuff",line.toString().trim());

        caf.next();
        assertEquals(33,CError.errorCode());
    }
    
    private void write(String string) throws IOException
    {
        FileWriter fos = new FileWriter("test.out",false);
        fos.write(string);
        fos.close();
    }

    public void testAdd2NoClip() throws IOException
    {
        testOpen();
        file.send("/clip=off");
        file.f1.setValue("Hello");
        file.f2.setValue("Big");
        file.f3.setValue("Wide");
        file.f4.setValue("World");
        file.add();
        
        file.send("/clip=on");
        file.f1.setValue("Testing");
        file.f2.setValue("One");
        file.f3.setValue("Two");
        file.f4.setValue("Three");
        file.add();
        file.close();
        
        testContents(
                "Hello     Big       Wide      World     \r\n"+
                "Testing   One       Two       Three\r\n"
         );
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
        sos.close();
        
        assertEquals(string,new String(sos.toByteArray()));
    }
}
