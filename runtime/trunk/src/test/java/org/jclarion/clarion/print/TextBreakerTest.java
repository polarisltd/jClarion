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
package org.jclarion.clarion.print;

import java.awt.image.BufferedImage;

import java.awt.Font;
import java.awt.Graphics2D;

import junit.framework.TestCase;

public class TextBreakerTest extends TestCase 
{
    private Graphics2D gr;
    private PrintContext g;

    public void setUp()
    {
        BufferedImage bi = new BufferedImage(200,200,BufferedImage.TYPE_INT_ARGB);
        Font f = new Font("Serif",Font.PLAIN,8);
        gr= (Graphics2D)bi.getGraphics();
        gr.setFont(f);
        gr.scale(10,10);
        g=new AWTPrintContext(gr);
    }
    
    public void testSimpleNonBreak()
    {
        String text = "The\nquick\nbrown\nfox\n";
        TextBreaker tb = new TextBreaker(text,g,100);
        
        assertEquals("The",tb.next());
        assertEquals("quick",tb.next());
        assertEquals("brown",tb.next());
        assertEquals("fox",tb.next());
        
        assertNull(tb.next());
        
    }
    
    public void testSimpleNonBreakWithTrimmings()
    {
        String text = "The\r\nquick \nbrown\r\nfox\r\n";
        TextBreaker tb = new TextBreaker(text,g,100);
        
        assertEquals("The",tb.next());
        assertEquals("quick",tb.next());
        assertEquals("brown",tb.next());
        assertEquals("fox",tb.next());
        
        assertNull(tb.next());
        
    }

    public void testExtraSpace()
    {
        String text = "The\nquick\n\nbrown\nfox\n";
        TextBreaker tb = new TextBreaker(text,g,100);
        
        assertEquals("The",tb.next());
        assertEquals("quick",tb.next());
        assertEquals("",tb.next());
        assertEquals("brown",tb.next());
        assertEquals("fox",tb.next());
        
        assertNull(tb.next());
        
    }

    public void testLeadingSpace()
    {
        String text = "The\n quick\n brown\nfox\n";
        TextBreaker tb = new TextBreaker(text,g,100);
        
        assertEquals("The",tb.next());
        assertEquals(" quick",tb.next());
        assertEquals(" brown",tb.next());
        assertEquals("fox",tb.next());
        
        assertNull(tb.next());
    }

    public void testWrap()
    {
        String text = "The quick brown fox\n";
        TextBreaker tb = new TextBreaker(text,g,50);
        
        assertEquals("The quick",tb.next());
        assertEquals("brown fox",tb.next());
        
        assertNull(tb.next());
        
    }

    public void testWrapTooTight()
    {
        String text = "The quick brown fox\n";
        TextBreaker tb = new TextBreaker(text,g,2);
        
        assertEquals("The",tb.next());
        assertEquals("quick",tb.next());
        assertEquals("brown",tb.next());
        assertEquals("fox",tb.next());
        
        assertNull(tb.next());
        
    }
    
}
