package org.jclarion.clarion;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;

import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.util.SharedOutputStream;

import junit.framework.TestCase;

public class ClarionBasicFileTest extends TestCase {

    TestFile file;

    public void setUp()
    {
        File f= new File("test.csv");
        f.delete();
    }
    
    public void tearDown()
    {
        if (file!=null) {
            file.close();
        }
    }
    
    private class TestFile extends ClarionBasicFile
    {
        public ClarionString  id=new ClarionString(20);
        public ClarionString  name=new ClarionString(40);
        public ClarionDecimal cost=new ClarionDecimal(7,2);
        public ClarionNumber  postcode=new ClarionNumber();
        public ClarionBool    active=new ClarionBool();
        
        public TestFile()
        {
            addVariable("id",id);
            addVariable("name",name);
            addVariable("cost",cost);
            addVariable("postcode",postcode);
            addVariable("active",active);
        }
    }
    
    public void testOpenWithoutCreateFails() 
    {
        File f = new File("test.csv");
        assertFalse(f.exists());
        
        file = new TestFile();
        file.setName("test.csv");
        file.open();
        assertEquals(2,CError.errorCode());

        assertFalse(f.exists());
    }
    
    public void testCreate() 
    {
        File f = new File("test.csv");
        assertFalse(f.exists());
        
        file = new TestFile();
        file.setName("test.csv");
        file.create();

        assertTrue(f.exists());
    }
    
    
    public void testRemove() 
    {
        testCreate();
        file.remove();
        assertFalse( (new File("test.csv")).exists());
    }

    public void testOpen() {
        testCreate();
        file.open();
        assertEquals(0,CError.errorCode());
    }

    public void testClose() {
        testCreate();
        file.open();
        assertEquals(0,CError.errorCode());
        file.close();
        assertEquals(0,CError.errorCode());
    }

    public void testAdd() throws IOException {
        
        testOpen();
        
        file.id.setValue("123456");
        file.name.setValue("Andrew Barnham");
        file.cost.setValue("123");
        file.postcode.setValue("3000");
        file.active.setValue(1);
        file.add();
        assertEquals(0,CError.errorCode());
        file.close();
        
        testContents("\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n");
    }

    public void testMultiByte() throws IOException
    {
        testOpen();

        String bits[][]=new String[][] {
                new String[] { "123456", "ひらがな, 平仮名" , "123", "3000", "1" },
        };
        
        for (String bit[] : bits ) {
            file.id.setValue(bit[0]);
            file.name.setValue(bit[1]);
            file.cost.setValue(bit[2]);
            file.postcode.setValue(bit[3]);
            file.active.setValue(bit[4]);
            file.add();
            assertEquals(0,CError.errorCode());
        }
        file.close();
        
        testContents(
                "\"123456\",\"ひらがな, 平仮名\",123.00,3000,1\r\n"+
                ""
        );
        
        file.clear();
        file.open();
        file.set();
        file.next();
        assertEquals(0,CError.errorCode());
        
        assertEquals("123456",file.id.toString().trim());
        assertEquals("ひらがな, 平仮名",file.name.toString().trim());
        assertEquals("123.00",file.cost.toString());
        assertEquals("3000",file.postcode.toString());
    }

    public void testMultiByteSegment() throws IOException
    {
        testOpen();
        writeAndRead(
            new String[][] {
               new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
               new String[] { "123-456", "Andrew\t Barnham" , "-4.2", "3000", "" },
               new String[] { "123-456", "ひらがな, 平仮名" , "-4.2", "3000", "" },
               new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
            },
            new String[][] {
                    new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                    new String[] { "123-456", "Andrew\t Barnham" , "-4.20", "3000", "" },
                    new String[] { "123-456", "ひらがな, 平仮名" , "-4.20", "3000", "" },
                    new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                 }
            );
    };
    
    public void testAddMany() throws IOException {
        
        testOpen();

        String bits[][]=new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
        };
        
        for (String bit[] : bits ) {
            file.id.setValue(bit[0]);
            file.name.setValue(bit[1]);
            file.cost.setValue(bit[2]);
            file.postcode.setValue(bit[3]);
            file.active.setValue(bit[4]);
            file.add();
            assertEquals(0,CError.errorCode());
        }
        file.close();
        
        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew, Barnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }
    
    public void testNext() throws IOException 
    {
        testAddMany();
     
        file.close();
        file.open();
        
        String bits[][]=new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
        };
        
        file.set();
        for (String bit[] : bits ) {
            file.next();
            assertEquals(0,CError.errorCode());
            assertEquals(bit[0],file.id.clip().toString());
            assertEquals(bit[1],file.name.clip().toString());
            assertEquals(bit[2],file.cost.toString());
            assertEquals(bit[3],file.postcode.toString());
            assertEquals(file.active,bit[4]);
        }
    }

    public void testNextTooFewParams() throws IOException
    {
        write("1234,Andrew\n");
        file=new TestFile();
        file.setName("test.csv");
        file.open();
        assertEquals(0,CError.errorCode());
        file.set();
        assertEquals(0,CError.errorCode());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("1234                ",file.id.toString());
        assertEquals("Andrew                                  ",file.name.toString());
        assertEquals("0.00",file.cost.toString());
        assertEquals(0,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        file.next();
        assertEquals(33,CError.errorCode());
    }

    public void testNextTooManyParams() throws IOException
    {
        write("1234,Andrew,10,4,1,Hello\n");
        file=new TestFile();
        file.setName("test.csv");
        file.open();
        assertEquals(0,CError.errorCode());
        file.set();
        assertEquals(0,CError.errorCode());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("1234                ",file.id.toString());
        assertEquals("Andrew                                  ",file.name.toString());
        assertEquals("10.00",file.cost.toString());
        assertEquals(4,file.postcode.intValue());
        assertTrue(file.active.boolValue());
        file.next();
        assertEquals(33,CError.errorCode());
    }
    
    public void testPut() throws IOException {
        testAddMany();
        
        file.open();
        file.next();
        file.next();
        
        file.name.setValue("Andy, C Barnham");
        file.put();
        assertEquals(0,CError.errorCode());
        file.close();
        
        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andy, C Barnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }

    public void testEof() throws IOException {
        testAddMany();
        file.open();
        file.set();
        assertFalse(file.eof());
        file.next();
        assertFalse(file.eof());
        file.next();
        assertFalse(file.eof());
        file.next();
        assertTrue(file.eof());
    }

    public void testTabDelimited() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("comma=9");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { "123-456", "Andrew\t Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { "123-456", "Andrew\t Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\"\t\"Andrew Barnham\"\t123.00\t3000\t1\r\n"+
                "\"123-456\"\t\"Andrew, Barnham\"\t-4.20\t3000\t\r\n"+
                "\"123-456\"\t\"Andrew\t Barnham\"\t-4.20\t3000\t\r\n"+
                "\" 123456\"\t\"Andrew \"\"Barnham\"\"\"\t-4.20\t3000\t\r\n"+
                ""
        );
    }

    public void testNormal() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew, Barnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }

    public void testQuote() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("/quote = 33");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "!123456!,!Andrew Barnham!,123.00,3000,1\r\n"+
                "!123-456!,!Andrew, Barnham!,-4.20,3000,\r\n"+
                "! 123456!,!Andrew \"Barnham\"!,-4.20,3000,\r\n"+
                ""
        );
    }
    
    public void testCtrlZIsEOF_a() throws IOException {
        file= new TestFile();
        file.setName("test.csv");

        write(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew, Barnham\",-4.20,3000,"+
                "\u001b\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
        
        read(
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                  }
        );

    }

    public void testDisableCtrlZIsEOF() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("ctrlziseof=off");

        write(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew, Barnham\",-4.20,3000,\r\n"+
                "\u001b\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
        
        read(
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { "\u001b", "" , "0.00", "0", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

    }
    
    public void testCtrlZIsEOF_b() throws IOException {
        file= new TestFile();
        file.setName("test.csv");

        write(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew, Barnham\",-4.20,3000,\r\n"+
                "\u001b\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
        
        read(
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                  }
        );

    }
    
    public void testEndOfRecord() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("endofrecord=1,10");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\n"+
                "\"123-456\",\"Andrew, Barnham\",-4.20,3000,\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\n"+
                ""
        );
    }

    public void testEndOfRecordInQuote_A() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew\n Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew\n Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew\n Barnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }

    public void testEndOfRecordInQuote_B() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew\r Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew\r Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew\r Barnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }

    public void testEndOfRecordInQuote_C() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew\r\n Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew\r\n Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew\r\n Barnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }

    public void testDisableEndOfRecordInQuote() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("endOfRecordInQuote=off");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew\r\n Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew Barnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }

    public void testDisableEndOfRecordInQuote_B() throws IOException {

        write(
                "\"123456\",\"Andrew Barnham\",123.00,3000,1\r\n"+
                "\"123-456\",\"Andrew\r\nBarnham\",-4.20,3000,\r\n"+
                "\" 123456\",\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
        
        file= new TestFile();
        file.setName("test.csv");
        file.send("endOfRecordInQuote=off");
        
        read(
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew","0.00","0",""},
                     new String[] { "Barnham\"", "-4.20","3000.00","0",""},
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );
    }
    
    public void testDisableAlwaysQuote() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("alwaysquote=off");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "123456,Andrew Barnham,123.00,3000,1\r\n"+
                "123-456,\"Andrew, Barnham\",-4.20,3000,\r\n"+
                " 123456,\"Andrew \"\"Barnham\"\"\",-4.20,3000,\r\n"+
                ""
        );
    }
    
    public void testTabDelimited2() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("fielddelimiter=1,9");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { "123-456", "Andrew\t Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { "123-456", "Andrew\t Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\"\t\"Andrew Barnham\"\t123.00\t3000\t1\r\n"+
                "\"123-456\"\t\"Andrew, Barnham\"\t-4.20\t3000\t\r\n"+
                "\"123-456\"\t\"Andrew\t Barnham\"\t-4.20\t3000\t\r\n"+
                "\" 123456\"\t\"Andrew \"\"Barnham\"\"\"\t-4.20\t3000\t\r\n"+
                ""
        );
    }

    public void testDelimited3() throws IOException {
        file= new TestFile();
        file.setName("test.csv");
        file.send("fielddelimiter=2,122,122");
        
        writeAndRead(
             new String[][] {
                new String[] { "123456", "Andrew Barnham" , "123", "3000", "1" },
                new String[] { "123-456", "Andrew, Barnham" , "-4.2", "3000", "" },
                new String[] { "123-456", "Andrew\t Barnham" , "-4.2", "3000", "" },
                new String[] { " 123456", "Andrew \"Barnham\"" , "-4.2", "3000", "" }
             },
             new String[][] {
                     new String[] { "123456", "Andrew Barnham" , "123.00", "3000", "1" },
                     new String[] { "123-456", "Andrew, Barnham" , "-4.20", "3000", "" },
                     new String[] { "123-456", "Andrew\t Barnham" , "-4.20", "3000", "" },
                     new String[] { " 123456", "Andrew \"Barnham\"" , "-4.20", "3000", "" }
                  }
        );

        testContents(
                "\"123456\"zz\"Andrew Barnham\"zz123.00zz3000zz1\r\n"+
                "\"123-456\"zz\"Andrew, Barnham\"zz-4.20zz3000zz\r\n"+
                "\"123-456\"zz\"Andrew\t Barnham\"zz-4.20zz3000zz\r\n"+
                "\" 123456\"zz\"Andrew \"\"Barnham\"\"\"zz-4.20zz3000zz\r\n"+
                ""
        );
    }
    
    private void writeAndRead(String bits[][],String fbits[][])
    {
        file.create();
        file.open();
        for (String bit[] : bits ) {
            file.id.setValue(bit[0]);
            file.name.setValue(bit[1]);
            file.cost.setValue(bit[2]);
            file.postcode.setValue(bit[3]);
            file.active.setValue(bit[4]);
            file.add();
            assertEquals(0,CError.errorCode());
        }
        
        file.set();
        for (String bit[] : fbits ) {
            file.next();
            assertEquals(0,CError.errorCode());
            assertEquals(bit[0],file.id.clip().toString());
            assertEquals(bit[1],file.name.clip().toString());
            assertEquals(bit[2],file.cost.toString());
            assertEquals(bit[3],file.postcode.toString());
            assertEquals(file.active,bit[4]);
        }
        assertEquals(true,file.eof());
        file.close();
    }

    private void read(String fbits[][])
    {
        file.open();
        file.set();
        for (String bit[] : fbits ) {
            file.next();
            assertEquals(0,CError.errorCode());
            assertEquals(bit[0],file.id.clip().toString());
            assertEquals(bit[1],file.name.clip().toString());
            assertEquals(bit[2],file.cost.toString());
            assertEquals(bit[3],file.postcode.toString());
            assertEquals(bit[4],file.active.toString());
        }
        assertEquals(true,file.eof());
        file.close();
    }
    
    public void testGetDriver() {
        testOpen();
        assertEquals("Basic",file.getDriver());
    }

    public void testGetPosition() throws IOException 
    {
        testAddMany();

        file.open();

        file.id.setValue("End");
        file.name.setValue("Last Record");
        file.cost.setValue("123.45");
        file.postcode.setValue(42);
        file.active.setValue(1);
        file.add();
        
        file.set();
        file.next();
        file.next();
        
        assertEquals("123-456             ",file.id.toString());
        assertEquals("Andrew, Barnham                         ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        ClarionString pos = file.getPosition();
        
        file.next();

        assertEquals(" 123456             ",file.id.toString());
        assertEquals("Andrew \"Barnham\"                        ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        file.get(pos,null);
        assertEquals("123-456             ",file.id.toString());
        assertEquals("Andrew, Barnham                         ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        file.next();
        assertEquals("End                 ",file.id.toString());
        assertEquals("Last Record                             ",file.name.toString());
        assertEquals("123.45",file.cost.toString());
        assertEquals(42,file.postcode.intValue());
        assertTrue(file.active.boolValue());
    }

    
    public void testSetAndReset() throws IOException 
    {
        testAddMany();

        file.open();

        file.id.setValue("End");
        file.name.setValue("Last Record");
        file.cost.setValue("123.45");
        file.postcode.setValue(42);
        file.active.setValue(1);
        file.add();
        
        file.set();
        file.next();
        file.next();
        
        assertEquals("123-456             ",file.id.toString());
        assertEquals("Andrew, Barnham                         ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        ClarionString pos = file.getPosition();
        
        file.next();

        assertEquals(" 123456             ",file.id.toString());
        assertEquals("Andrew \"Barnham\"                        ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        file.next();
        assertEquals("End                 ",file.id.toString());
        assertEquals("Last Record                             ",file.name.toString());
        assertEquals("123.45",file.cost.toString());
        assertEquals(42,file.postcode.intValue());
        assertTrue(file.active.boolValue());
        
        file.reset(pos);
        
        file.next();
        assertEquals("123-456             ",file.id.toString());
        assertEquals("Andrew, Barnham                         ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());

        file.next();
        assertEquals(" 123456             ",file.id.toString());
        assertEquals("Andrew \"Barnham\"                        ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        file.next();
        assertEquals("End                 ",file.id.toString());
        assertEquals("Last Record                             ",file.name.toString());
        assertEquals("123.45",file.cost.toString());
        assertEquals(42,file.postcode.intValue());
        assertTrue(file.active.boolValue());
        
    }
    
    public void testGetPointer() throws IOException 
    {
        testAddMany();

        file.open();

        file.id.setValue("End");
        file.name.setValue("Last Record");
        file.cost.setValue("123.45");
        file.postcode.setValue(42);
        file.active.setValue(1);
        file.add();
        
        file.set();
        file.next();
        file.next();
        
        assertEquals("123-456             ",file.id.toString());
        assertEquals("Andrew, Barnham                         ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        int pos = file.getPointer();
        
        file.next();

        assertEquals(" 123456             ",file.id.toString());
        assertEquals("Andrew \"Barnham\"                        ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        file.get(new ClarionNumber(pos),null);
        assertEquals("123-456             ",file.id.toString());
        assertEquals("Andrew, Barnham                         ",file.name.toString());
        assertEquals("-4.20",file.cost.toString());
        assertEquals(3000,file.postcode.intValue());
        assertFalse(file.active.boolValue());
        
        file.next();
        assertEquals("End                 ",file.id.toString());
        assertEquals("Last Record                             ",file.name.toString());
        assertEquals("123.45",file.cost.toString());
        assertEquals(42,file.postcode.intValue());
        assertTrue(file.active.boolValue());
    }

    protected String getCharSetName()
    {
        return Charset.defaultCharset().name();
    }
    
    private void testContents(String string) throws IOException 
    {
        
        FileInputStream fis = new FileInputStream("test.csv");
        SharedOutputStream sos = new SharedOutputStream();
        byte buffer[]=new byte[128];
        while ( true ) {
            int len = fis.read(buffer,0,128);
            if (len<0) break;
            sos.write(buffer,0,len);
        }
        fis.close();
        sos.close();        
        
        assertEquals(string,new String(sos.toByteArray(),getCharSetName()));
    }

    private void write(String string) throws IOException
    {
        FileOutputStream fos = new FileOutputStream("test.csv",false);
        fos.write(string.getBytes(getCharSetName()));
        fos.close();
    }
    
}
