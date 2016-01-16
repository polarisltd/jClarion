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
package org.jclarion.clarion.lang;

import java.io.CharArrayReader;

import org.jclarion.clarion.lang.LexStream;

import junit.framework.TestCase;

public class LexStreamTest extends TestCase {

    public void testCtrlZEOF()
    {
        CharArrayReader reader = new CharArrayReader("This is some \u001btext".toCharArray());
        
        LexStream ls = new LexStream(reader);
        
        assertFalse(ls.eof());
        assertFalse(ls.eof());
        assertEquals('T',ls.peek(0));
        assertEquals('h',ls.peek(1));
        assertEquals('i',ls.peek(2));
        assertEquals('T',ls.read());
        assertFalse(ls.eof());
        assertEquals('h',ls.read());
        assertEquals('i',ls.read());
        assertEquals('s',ls.peek(0));
        assertEquals(' ',ls.peek(1));
        assertFalse(ls.eof());
        assertEquals('s',ls.read());
        assertEquals(' ',ls.read());
        assertEquals('i',ls.read());
        assertEquals('s',ls.read());
        assertEquals(' ',ls.read());
        assertEquals('s',ls.read());
        assertEquals('o',ls.read());
        assertEquals('m',ls.read());
        assertEquals('e',ls.read());
        assertFalse(ls.eof());
        assertEquals(' ',ls.read());
        assertTrue(ls.eof());
        assertEquals(0,ls.read());
        assertTrue(ls.eof());
    }
    
    public void testLexStream()
    {
        CharArrayReader reader = new CharArrayReader("This is some text".toCharArray());
        
        LexStream ls = new LexStream(reader);
        
        assertFalse(ls.eof());
        assertFalse(ls.eof());
        assertEquals('T',ls.peek(0));
        assertEquals('h',ls.peek(1));
        assertEquals('i',ls.peek(2));
        assertEquals('T',ls.read());
        assertFalse(ls.eof());
        assertEquals('h',ls.read());
        assertEquals('i',ls.read());
        assertEquals('s',ls.peek(0));
        assertEquals(' ',ls.peek(1));
        assertFalse(ls.eof());
        assertEquals('s',ls.read());
        assertEquals(' ',ls.read());
        assertEquals('i',ls.read());
        assertEquals('s',ls.read());
        assertEquals(' ',ls.read());
        assertEquals('s',ls.read());
        assertEquals('o',ls.read());
        assertEquals('m',ls.read());
        assertEquals('e',ls.read());
        assertEquals(' ',ls.read());
        assertEquals('t',ls.read());
        assertEquals('e',ls.read());
        assertEquals('x',ls.read());
        assertFalse(ls.eof());
        assertEquals('t',ls.read());
        assertTrue(ls.eof());
        assertEquals(0,ls.read());
    }
    
    public void testMatchString()
    {
        CharArrayReader reader = new CharArrayReader("This is some text".toCharArray());
        LexStream ls = new LexStream(reader);

        assertTrue(ls.readString("This"));
        assertFalse(ls.readString("is"));
        assertEquals(' ',ls.read());
        assertTrue(ls.readString("is"));
        assertFalse(ls.readString(" some text long"));
        assertTrue(ls.readString(" some text"));
        assertFalse(ls.readString(" some text long"));
    }
    
    public void testLineCount()
    {
        CharArrayReader reader = new CharArrayReader("This\nis\nsome\ntext".toCharArray());
        LexStream ls = new LexStream(reader);
        assertEquals(1,ls.getLineCount());
        assertTrue(ls.readString("This"));
        assertEquals(1,ls.getLineCount());
        assertEquals('\n',ls.read());
        assertEquals(2,ls.getLineCount());
        assertTrue(ls.readString("is"));
        assertEquals('\n',ls.peek(0));
        assertEquals(2,ls.getLineCount());
        assertEquals('\n',ls.read());
        assertEquals(3,ls.getLineCount());
        assertTrue(ls.readString("some"));
        assertFalse(ls.readString("text"));
        assertEquals(3,ls.getLineCount());
        ls.skip(1);
        assertEquals(4,ls.getLineCount());
    }
}
