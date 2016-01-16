package org.jclarion.clarion.ide.editor;

import junit.framework.TestCase;

import org.eclipse.jface.text.Document;
import org.eclipse.jface.text.ITypedRegion;

import org.jclarion.clarion.TestUtils;

public class ClarionIncPartitionScannerTest extends TestCase {

	public void testEmptyDocument() throws Exception {
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document());
		assertEquals(0, regions.length);
	}

	public void testWindowKeywordCaseInsensitivity() throws Exception {
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(
				TestUtils.readFile("test/res/example-project/window-keyword-insensitivity-test.inc")));
		assertEquals(64, regions.length);
	}

	public void testGroupKeywordCaseInsensitivity() throws Exception {
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(
				TestUtils.readFile("test/res/example-project/group-keyword-insensitivity-test.inc")));
		assertEquals(32, regions.length);
	}

	public void testEndKeywordCaseInsensitivity() throws Exception {
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(
				TestUtils.readFile("test/res/example-project/end-keyword-insensitivity-test.inc")));
		assertEquals(8, regions.length);
	}

	public void testCommentedOutWindows() throws Exception {
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(
				TestUtils.readFile("test/res/example-project/commented-out-windows-test.inc")));
		assertEquals(1, regions.length);
	}

	public void testExcessiveWhitespace() throws Exception {
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(
				TestUtils.readFile("test/res/example-project/excessive-whitespace-test.inc")));
		assertEquals(3, regions.length);
	}

	public void testComplexWindowNesting() throws Exception {
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(
				TestUtils.readFile("test/res/example-project/complex-window-nesting-test.inc")));
		assertEquals(1, regions.length);
	}

	public void testEmptyWindowsWithMinimalWhitespace() throws Exception {
		String content = "Window WINDOW\nEND";
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 10, regions[0]); // Includes \n

		content = "Window WINDOW\nEND\nWindow WINDOW\nEND";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(2, regions.length);
		assertOffsetAndLength(7, 10, regions[0]); // Includes \n
		assertOffsetAndLength(25, 10, regions[1]); // Includes \n

		content = "Window WINDOW\nEND\nWindow WINDOW\nEND\nWindow WINDOW\nEND";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(3, regions.length);
		assertOffsetAndLength(7, 10, regions[0]); // Includes \n
		assertOffsetAndLength(25, 10, regions[1]); // Includes \n
		assertOffsetAndLength(43, 10, regions[2]); // Includes \n
	}

	public void testEmptyWindowsWithExcessiveTabs() throws Exception {
		String content = "Window\t\t\tWINDOW\n\t\t\tEND";
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(9, 13, regions[0]); // Includes \t and \n

		content = "Window\t\t\tWINDOW\n" +
				"\t\t\tEND\n" +
				"Window\t\t\t\tWINDOW\n" +
				"\t\t\t\tEND";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(2, regions.length);
		assertOffsetAndLength(9, 13, regions[0]); // Includes \t and \n
		assertOffsetAndLength(33, 14, regions[1]); // Includes \t and \n

		content = "Window\t\t\tWINDOW\n" +
				"\t\t\tEND\n" +
				"Window\t\t\t\tWINDOW\n" +
				"\t\t\t\tEND\n" +
				"Window\t\t\t\t\tWINDOW\n" +
				"\t\t\t\t\tEND";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(3, regions.length);
		assertOffsetAndLength(9, 13, regions[0]); // Includes \t and \n
		assertOffsetAndLength(33, 14, regions[1]); // Includes \t and \n
		assertOffsetAndLength(59, 15, regions[2]); // Includes \t and \n
	}

	public void testEmptyWindownWithExcessiveNewLines() throws Exception {
		String content = "Window WINDOW\n\n\nEND";
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 12, regions[0]); // Includes \n

		content = "Window WINDOW\n" +
				"\n\n" +
				"END\n" +
				"\n\n\n" +
				"Window WINDOW\n" +
				"\n\n\n\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(2, regions.length);
		assertOffsetAndLength(7, 12, regions[0]); // Includes \n
		assertOffsetAndLength(30, 14, regions[1]); // Includes \n

		content = "Window WINDOW\n" +
				"\n\n" +
				"END\n" +
				"\n\n\n" +
				"Window WINDOW\n" +
				"\n\n\n\n" +
				"END\n" +
				"\n\n\n\n\n" +
				"Window WINDOW\n" +
				"\n\n\n\n\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(3, regions.length);
		assertOffsetAndLength(7, 12, regions[0]); // Includes \n
		assertOffsetAndLength(30, 14, regions[1]); // Includes \n
		assertOffsetAndLength(57, 15, regions[2]); // Includes \n
	}

	public void testWindowsWithGroups() throws Exception {
		String content = "Window WINDOW\n" +
				"    GROUP\n" +
				"    END\n" +
				"END";
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 28, regions[0]); // Includes ' ' and \n

		// Same again, but with mixed case
		content = "Window WINDOW\n" +
				"    gRouP\n" +
				"    end\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 28, regions[0]); // Includes ' ' and \n

		content = "Window WINDOW\n" +
				"    GROUP\n" +
				"    END\n" +
				"    GROUP\n" +
				"    END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 46, regions[0]); // Includes ' ' and \n

		// Same again, but with mixed case
		content = "Window WINDOW\n" +
				"    GRouP\n" +
				"    EnD\n" +
				"    group\n" +
				"    eNd\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 46, regions[0]); // Includes ' ' and \n
	}

	public void testWindowsWithNestedGroups() throws Exception {
		String content = "Window WINDOW\n" +
				"    GROUP\n" +
				"        GROUP\n" +
				"        END\n" +
				"        GROUP\n" +
				"        END\n" +
				"    END\n" +
				"END";
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 80, regions[0]); // Includes ' ' and \n

		content = "Window WINDOW\n" +
				"    GROUP\n" +
				"        GROUP\n" +
				"            GROUP\n" +
				"            END\n" +
				"        END\n" +
				"        GROUP\n" +
				"        END\n" +
				"    END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 114, regions[0]); // Includes ' ' and \n

		content = "Window WINDOW\n" +
				"    GROUP\n" +
				"        GROUP\n" +
				"            GROUP\n" +
				"                GROUP\n" +
				"                END\n" +
				"            END\n" +
				"        END\n" +
				"        GROUP\n" +
				"        END\n" +
				"    END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 156, regions[0]); // Includes ' ' and \n
	}

	public void testWindowsWithSheetsAndTabs() throws Exception {
		String content = "Window WINDOW\n" +
				"    SHEET\n" +
				"    END\n" +
				"END";
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 28, regions[0]); // Includes ' ' and \n

		// Same again, but with mixed case
		content = "Window WINDOW\n" +
				"    Sheet\n" +
				"    enD\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 28, regions[0]); // Includes ' ' and \n

		content = "Window WINDOW\n" +
				"    SHEET\n" +
				"        TAB\n" +
				"        END\n" +
				"    END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 52, regions[0]); // Includes ' ' and \n

		// Same again, but with mixed case
		content = "Window WINDOW\n" +
				"    shEEt\n" +
				"        tab\n" +
				"        End\n" +
				"    eNd\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 52, regions[0]); // Includes ' ' and \n

		content = "Window WINDOW\n" +
				"    SHEET\n" +
				"        TAB\n" +
				"        END\n" +
				"        TAB\n" +
				"        END\n" +
				"    END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 76, regions[0]); // Includes ' ' and \n

		content = "Window WINDOW\n" +
				"    SHEET\n" +
				"        TAB\n" +
				"            GROUP\n" +
				"            END\n" +
				"            GROUP\n" +
				"            END\n" +
				"            GROUP\n" +
				"            END\n" +
				"        END\n" +
				"        TAB\n" +
				"        END\n" +
				"    END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 178, regions[0]); // Includes ' ' and \n

		// Same again, but with mixed case
		content = "Window WINDOW\n" +
				"    Sheet\n" +
				"        tAB\n" +
				"            GrOuP\n" +
				"            EnD\n" +
				"            gRoUp\n" +
				"            eNd\n" +
				"            grouP\n" +
				"            eND\n" + // Bizarre failure in testPartitioning() when 'N' changed to 'n'
				"        eND\n" +
				"        tab\n" +
				"        end\n" +
				"    End\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 178, regions[0]); // Includes ' ' and \n
	}

	public void testWindowWithComments() throws Exception {
		String content = "Window WINDOW\n" +
				"    ! Single line comment\n" +
				"END";
		ITypedRegion[] regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 36, regions[0]); // Includes \n

		content = "Window WINDOW\n" +
				"    !GROUP\n" +
				"    !END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 30, regions[0]); // Includes \n

		content = "Window WINDOW\n" +
				"    !GROUP\n" +
				"        !GROUP\n" +
				"        !END\n" +
				"    !END\n" +
				"END";
		regions = TestUtils.getWindowContentTypes(new Document(content));
		assertEquals(1, regions.length);
		assertOffsetAndLength(7, 58, regions[0]); // Includes \n
	}

	private void assertOffsetAndLength(int offset, int length, ITypedRegion region) {
		assertEquals("offset", offset, region.getOffset());
		assertEquals("length", length, region.getLength());
	}

}
