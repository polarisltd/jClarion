package org.jclarion.clarion.ide.model;

import java.io.IOException;

import org.eclipse.jface.text.ILineTracker;
import org.jclarion.clarion.appgen.template.prompt.EmbeditorBlock;

import junit.framework.TestCase;

public class EmbeditorTextStoreTest extends TestCase
{
	public void testSimple() throws Exception
	{
		EmbeditorBlock block = createTestBlock(
				"foo\nbar\n",
				"baz\n",
				"\n",
				"bing\nboo\n"
				);
		
		
		EmbeditorTextStore store=  new EmbeditorTextStore(block);
		
		ILineTracker line = store.getLineTracker();
		
		assertEquals(22,store.getLength());
		assertEquals(6,line.getNumberOfLines());
		
		assertEquals(0,line.getLineOffset(0));
		assertEquals(4,line.getLineOffset(1));
		assertEquals(8,line.getLineOffset(2));
		assertEquals(12,line.getLineOffset(3));
		assertEquals(13,line.getLineOffset(4));
		assertEquals(18,line.getLineOffset(5));
		
		assertEquals("\n",line.getLineDelimiter(2));
		assertEquals(1,line.getLineLength(3));
		assertEquals(4,line.getLineLength(2));
		assertEquals(4,line.getLineLength(1));
		assertEquals(4,line.getLineLength(0));
		assertEquals(13,line.getLineInformation(4).getOffset());
		assertEquals(4,line.getLineInformation(4).getLength());
	}

	private EmbeditorBlock createTestBlock(String... bits) 
	{
		EmbeditorBlock first=null;
		EmbeditorBlock last=null;
		
		for (String next : bits) {
			EmbeditorBlock n = new EmbeditorBlock();
			try {
				n.getWriter().append(next);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			if (last==null) {
				first=n;				
			} else {
				last.add(n);
			}
			last=n;
		}
		return first;
	}
}
