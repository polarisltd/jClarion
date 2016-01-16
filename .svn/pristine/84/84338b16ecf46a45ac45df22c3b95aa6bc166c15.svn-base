package org.jclarion.clarion.ide.model;

import java.util.Calendar;

import junit.framework.TestCase;

import org.eclipse.jface.text.Document;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IRegion;

import org.jclarion.clarion.TestUtils;

public class ClarionIncContentTest extends TestCase {

	private IDocument document;
	private ClarionIncContent content;

	@Override
	protected void setUp() throws Exception {
		super.setUp();
		document = TestUtils.createDocument("test/res/simple-impl.inc");
		content = TestUtils.getFirstClarionIncContent(document);
	}

	/**
	 * The partitioner creates window content types that start at the
	 * <code>WINDOW</code> keyword, so the model has to expand this to include
	 * the name. Assert that this is done correctly
	 */
	public void testPositionIncludesName() throws Exception {
		ClarionIncContent content = TestUtils.getFirstClarionIncContent(new Document("Name WINDOW\nEND\n"));
		assertEquals(0, content.position.offset);
		assertEquals(15, content.position.length);
		assertTrue(content.sourceCode.startsWith("Name"));
	}

	public void testSetName() throws Exception {
		String newName = content.getName() + Calendar.getInstance().getTimeInMillis();
		content.setName(newName);

		// Assert model's name has changed
		ClarionIncContent newcontent = TestUtils.getFirstClarionIncContent(document);
		assertEquals(newName, newcontent.getName());

		// Assert underlying document has changed
		assertTrue(document.get().startsWith(newName + " WINDOW"));
	}

	public void testSetName_ShorterName() throws Exception {
		String newName = "Win";
		content.setName(newName);

		// Assert the window content type's position is preserved
		ClarionIncContent newcontent = TestUtils.getFirstClarionIncContent(document);
		assertEquals(content.position, newcontent.position);

		// Assert the document is updated and that the new name is padded out
		// with whitespace
		assertTrue(document.get().startsWith(newName + "    WINDOW"));
	}

	public void testSetName_LongerName() throws Exception {
		String newName = content.getName() + Calendar.getInstance().getTimeInMillis();
		int nameLengthDif = newName.length() - content.getName().length();
		content.setName(newName);

		// Assert the window content type's position is not preserved b/c the
		// longer names pushes out the length
		ClarionIncContent newcontent = TestUtils.getFirstClarionIncContent(document);
		assertEquals(content.position.offset, newcontent.position.offset);
		assertEquals(content.position.length + nameLengthDif, newcontent.position.length);

		// Assert the document is updated and that the new name should have only
		// one whitespace between it and the start of the WINDOW block
		assertTrue(document.get().startsWith(newName + " WINDOW"));
	}

	public void testOverlapsName() throws Exception {
		IDocument document = new Document("Window1 WINDOW\nEND\nWindow2 WINDOW\nEND\n");
		IRegion[] regions = TestUtils.getWindowContentTypes(document);		
		ClarionIncContent model1 = new ClarionIncContent(null,null,document, regions[0], null);
		ClarionIncContent model2 = new ClarionIncContent(null,null,document, regions[1], null);

		for (int offset = 0, n = document.getLength(); offset < n; offset++) {
			if (expectNameAt(offset, model1)) {
				assertTrue(model1.overlapsName(offset));
			} else if (expectNameAt(offset, model2)) {
				assertTrue(model2.overlapsName(offset));
			} else {
				assertFalse(model1.overlapsName(offset));
				assertFalse(model2.overlapsName(offset));
			}
		}
	}

	private boolean expectNameAt(int offset, ClarionIncContent content) {
		return content.position.overlapsWith(offset, 1) && (offset <= (content.position.offset + content.getName().length()));
	}

}
