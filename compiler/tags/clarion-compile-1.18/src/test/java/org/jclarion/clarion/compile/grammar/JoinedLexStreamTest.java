package org.jclarion.clarion.compile.grammar;

import java.io.StringReader;

import org.jclarion.clarion.lang.AbstractLexStream;
import org.jclarion.clarion.lang.LexStream;

import junit.framework.TestCase;

public class JoinedLexStreamTest extends TestCase {

    public void testGetEOFPosition() {
        JoinedLexStream jls = new JoinedLexStream(
                new LexStream(new StringReader("Hello ")),
                new LexStream(new StringReader("There You ")),
                new LexStream(new StringReader("Big")),
                new LexStream(new StringReader(" Wide World"))
        );
        
        String result = "Hello There You Big Wide World\u0000";
        for (int scan=0;scan<result.length();scan++) {
            assertEquals(result.charAt(scan),jls.peek(scan));
            assertTrue(jls.eof(result.length()));
            assertEquals(result.length()-1,jls.getEOFPosition(result.length()));
        }
        for (int scan=0;scan<result.length();scan++) {
            assertEquals(result.charAt(scan),jls.read());
            int test = result.length()-2-scan;
            if (test<0) test=0;
            assertEquals(test,jls.getEOFPosition(result.length()));
        }
    }

    public void testEofInt() {
        JoinedLexStream jls = new JoinedLexStream(
                new LexStream(new StringReader("Hello ")),
                new LexStream(new StringReader("There You ")),
                new LexStream(new StringReader("Big")),
                new LexStream(new StringReader(" Wide World"))
        );
        
        String result = "Hello There You Big Wide World\u0000";
        for (int scan=0;scan<result.length();scan++) {
            assertEquals(result.charAt(scan),jls.peek(scan));
            assertTrue(jls.eof(result.length()));
            assertTrue(jls.eof(result.length()-1));
            assertFalse(jls.eof(result.length()-2));
        }
        for (int scan=0;scan<result.length();scan++) {
            assertEquals(result.charAt(scan),jls.read());

            testEOF(jls,true,result.length()-scan-1);
            testEOF(jls,true,result.length()-scan-2);
            testEOF(jls,false,result.length()-scan-3);
        }
    }

    private void testEOF(JoinedLexStream jls, boolean b, int i) 
    {
        if (i<0) return;
        if (b) {
            assertTrue(jls.eof(i));
        } else {
            assertFalse(jls.eof(i));
        }
    }

    public void testPeek() {
        JoinedLexStream jls = new JoinedLexStream(
                new LexStream(new StringReader("Hello ")),
                new LexStream(new StringReader("There You ")),
                new LexStream(new StringReader("Big")),
                new LexStream(new StringReader(" Wide World"))
        );
        
        String result = "Hello There You Big Wide World\u0000";
        for (int scan=0;scan<result.length();scan++) {
            assertEquals(result.charAt(scan),jls.peek(scan));
        }
        for (int scan=0;scan<result.length();scan++) {
            assertEquals(result.charAt(scan),jls.read());
        }
    }

    public void testReadChar() 
    {
        JoinedLexStream jls = new JoinedLexStream(
                new LexStream(new StringReader("Hello ")),
                new LexStream(new StringReader("There You ")),
                new LexStream(new StringReader("Big")),
                new LexStream(new StringReader(" Wide World"))
        );
        
        String result = "Hello There You Big Wide World\u0000";
        for (int scan=0;scan<result.length();scan++) {
            assertEquals(result.charAt(scan),jls.read());
        }
    }

    public void testNameAndLineCount() 
    {
        JoinedLexStream jls = new JoinedLexStream(
                new LexStream(new StringReader("Line 1\nLine 2\n"),"File A"),
                new LexStream(new StringReader("Line A\nLine B\n"),"File B")
                );
        
        assertRead(jls,"Line 1",1,"File A");
        assertRead(jls,"\n",2,"File A");
        assertRead(jls,"Line 2",2,"File A");
        assertRead(jls,"\n",3,"File A");
        assertRead(jls,"Line A",1,"File B");
        assertRead(jls,"\n",2,"File B");
        assertRead(jls,"Line B",2,"File B");
        assertRead(jls,"\n",3,"File B");
    }

    private void assertRead(AbstractLexStream als, String string, int i, String name) {
        for (int scan=0;scan<string.length();scan++) {
            assertEquals(string.charAt(scan),als.read());
            assertEquals(i,als.getLineCount());
            assertEquals(name,als.getName());
        }
    }
    
}
