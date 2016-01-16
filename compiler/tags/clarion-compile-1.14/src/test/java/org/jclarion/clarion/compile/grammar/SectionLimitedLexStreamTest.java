package org.jclarion.clarion.compile.grammar;

import java.io.StringReader;

import org.jclarion.clarion.lang.AbstractLexStream;
import org.jclarion.clarion.lang.LexStream;

import junit.framework.TestCase;

public class SectionLimitedLexStreamTest extends TestCase 
{
    public void testSimpleRead()
    {
        for (int scan=0;scan<3;scan++) {
            AbstractLexStream base = new LexStream(new StringReader(
                " section('section a')\n"+
                "content for a\n"+
                " section('section b')\n"+
                "content for b\n"+
                " section('section c')\n"+
                "content for c"+
            ""),"testfile");
        
            char c = "abc".charAt(scan);
            
            SectionLimitedLexStream s = new SectionLimitedLexStream(base,"section "+c);
            
            assertRead(s,"\n",2*scan+2,"testfile");
            assertRead(s,"content for ",2*scan+2,"testfile");
            assertRead(s,""+c,2*scan+2,"testfile");
            assertTrue(s.eof());
        }
        
    }

    public void testSimpleRead2()
    {
        for (int scan=0;scan<3;scan++) {
            AbstractLexStream base = new LexStream(new StringReader(
                "section('section a')\n"+
                "content for a\n"+
                " section   ('section b')\n"+
                "content for b\n"+
                " section(   'section c'    )\n"+
                "content for c"+
            ""),"testfile");
        
            char c = "abc".charAt(scan);
            
            SectionLimitedLexStream s = new SectionLimitedLexStream(base,"section "+c);
            
            assertRead(s,"\n",2*scan+2,"testfile");
            assertRead(s,"content for ",2*scan+2,"testfile");
            assertRead(s,""+c,2*scan+2,"testfile");
            assertTrue(s.eof());
        }
    }
    
    public void testLotsOfData()
    {
        StringBuilder sections[]=new StringBuilder[] { 
                new StringBuilder(),
                new StringBuilder(),
                new StringBuilder()
        };

        StringBuilder total=new StringBuilder();
        
        for (int s2=0;s2<=512*3*2+128;s2++) {
            
            char c = (char)s2;
            if (c==0) c=1;
            if (c==27) c=28;
            sections[s2%3].append(c);
            
            total.setLength(0);
            total.append("junk");
            total.append("\nsection('section a')");
            total.append(sections[0]);
            total.append("\nsection('section b')");
            total.append(sections[1]);
            total.append("\nsection('section c')");
            total.append(sections[2]);
            
            for (int scan=0;scan<3;scan++) {
                AbstractLexStream base = new LexStream(new StringReader(total.toString()));
            
                c = "abc".charAt(scan);
                SectionLimitedLexStream s = new SectionLimitedLexStream(base,"section "+c);

                for (int s3=0;s3<sections[scan].length();s3++) {
                    assertEquals(s2+":"+scan+":"+s3,sections[scan].charAt(s3),s.read());
                }
                assertTrue(s.eof());
            }
            
        }
    }

    public void testEOF()
    {
        AbstractLexStream base = new LexStream(new StringReader(
                "section('section a')\n"+
                "content for a\n"+
                " section   ('section b')\n"+
                "content for b\n"+
                " section(   'section c'    )\n"+
                "content for c"+
            ""),"testfile");
        
            SectionLimitedLexStream s = new SectionLimitedLexStream(base,"section b");
        int size=14;
        for (int scan=0;scan<14;scan++) {
            assertTrue(s.eof(size+1));
            assertTrue(s.eof(size));
            if (size>0) {
                assertFalse(s.eof(size-1));
            }
            assertEquals("\ncontent for b".charAt(scan),s.read());
            size--;
        }
    }
    
    public void testEOFPosition()
    {
        AbstractLexStream base = new LexStream(new StringReader(
                "section('section a')\n"+
                "content for a\n"+
                " section   ('section b')\n"+
                "content for b\n"+
                " section(   'section c'    )\n"+
                "content for c"+
            ""),"testfile");
        
            SectionLimitedLexStream s = new SectionLimitedLexStream(base,"section b");
        assertTrue(s.eof(30));
        int size=14;
        for (int scan=0;scan<14;scan++) {
            assertEquals(size,s.getEOFPosition(size+1));
            assertEquals(size,s.getEOFPosition(size));
            if (size>0) {
                assertEquals(-1,s.getEOFPosition(size-1));
            }
            assertEquals("\ncontent for b".charAt(scan),s.read());
            size--;
        }
    }
    
    public void testPeek()
    {
        AbstractLexStream base = new LexStream(new StringReader(
                "section('section a')\n"+
                "content for a\n"+
                " section   ('section b')\n"+
                "content for b\n"+
                " section(   'section c'    )\n"+
                "content for c"+
            ""),"testfile");
        
            SectionLimitedLexStream s = new SectionLimitedLexStream(base,"section b");
        assertTrue(s.eof(30));
        for (int scan=0;scan<14-3;scan++) {
            for (int s2=0;s2<3;s2++) {
                assertEquals("\ncontent for b".charAt(scan+s2),s.peek(s2));
            }
            assertEquals("\ncontent for b".charAt(scan),s.read());
        }
        
    }
    
    private void assertRead(AbstractLexStream als, String string, int i,String name) {
        for (int scan = 0; scan < string.length(); scan++) {
            assertEquals(string.charAt(scan), als.read());
            assertEquals(i, als.getLineCount());
            assertEquals(name, als.getName());
        }
    }
        
}
