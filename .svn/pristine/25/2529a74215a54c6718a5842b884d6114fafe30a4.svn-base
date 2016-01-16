package org.jclarion.clarion.ide.dialog;

import java.util.List;

import junit.framework.TestCase;

import org.jclarion.clarion.control.ListColumn.Justify;

public class ColumnNodeTest extends TestCase {

	public void testToColumns_DefaultFieldProps() {
		List<ColumnNode> columns = ColumnNode.toColumns("20L(2)|M");
		assertEquals(1, columns.size());
		assertFieldDefaults(columns.get(0));

		columns = ColumnNode.toColumns("20L(2)|M20L(2)|M");
		assertEquals(2, columns.size());

		assertFieldDefaults(columns.get(0));
		assertFieldDefaults(columns.get(1));
	}

	public void testToColumns_NonDefaultFieldHeaderProps() {
		/*
		 * indent: 5
		 * justification: center
		 * scrollbar: 4
		 * text: "Name"
		 * width: 35
		 */
		List<ColumnNode> columns = ColumnNode.toColumns("35L(2)|M~Name~C(5)S(4)");
		assertEquals(1, columns.size());

		ColumnNode column = columns.get(0);
		assertFieldHeaderProps(column, 5, Justify.CENTER.toString(), 4, "Name", 35);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		/*
		 * Add another column:
		 * indent: 10
		 * justification: decimal
		 * scrollbar: 8
		 * text: "Another"
		 * width: 40
		 */
		columns = ColumnNode.toColumns("35L(2)|M~Name~C(5)S(4)40L(2)|M~Another~D(10)S(8)");
		assertEquals(2, columns.size());

		column = columns.get(0);
		assertFieldHeaderProps(column, 5, Justify.CENTER.toString(), 4, "Name", 35);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		column = columns.get(1);
		assertFieldHeaderProps(column, 10, Justify.DECIMAL.toString(), 8, "Another", 40);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);
	}

	public void testToColumns_NonDefaultFieldDataProps() {
		/*
		 * indent: 5
		 * justification: right
		 * picture: @S20
		 */
		List<ColumnNode> columns = ColumnNode.toColumns("20R(5)|M@S20@");
		assertEquals(1, columns.size());

		ColumnNode column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataProps(column, 5, Justify.RIGHT.toString(), "@S20");
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		/*
		 * Add another column:
		 * indent: 10
		 * justification: decimal
		 * picture: @N40
		 */
		columns = ColumnNode.toColumns("20R(5)|M@S20@20D(10)|M@N40@");
		assertEquals(2, columns.size());

		column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataProps(column, 5, Justify.RIGHT.toString(), "@S20");
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		column = columns.get(1);
		assertFieldHeaderDefaults(column);
		assertFieldDataProps(column, 10, Justify.DECIMAL.toString(), "@N40");
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);
	}

	public void testToColumns_NonDefaultFieldFlagProps() {
		/*
		 * fixed: true
		 * has color: true
		 * last on line: true
		 * locator: true
		 * resizeable: false
		 * style: true
		 * underline: true
		 */
		List<ColumnNode> columns = ColumnNode.toColumns("20L(2)|_F*YP/?");
		assertEquals(1, columns.size());

		ColumnNode column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsProps(column, true, true, true, true, false, true, true);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		// Add the same again
		columns = ColumnNode.toColumns("20L(2)|_F*Y/?20L(2)|_F*Y/?");
		assertEquals(2, columns.size());

		column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsProps(column, true, true, true, true, false, true, true);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		column = columns.get(1);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsProps(column, true, true, true, true, false, true, true);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);
	}

	public void testToColumns_NonDefaultFieldGeneralProps() {
		/*
		 * icon: normal
		 */
		List<ColumnNode> columns = ColumnNode.toColumns("20L(2)|MI");
		assertEquals(1, columns.size());

		ColumnNode column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralProps(column, ColumnNode.ICON_NORMAL);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		/*
		 * Add another column:
		 * icon: transparent
		 */
		columns = ColumnNode.toColumns("20L(2)|MI20L(2)|MJ");
		assertEquals(2, columns.size());

		column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralProps(column, ColumnNode.ICON_NORMAL);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);

		column = columns.get(1);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralProps(column, ColumnNode.ICON_TRANSPARENT);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);
	}

	public void testToColumns_NonDefaultFieldStyleProps() {
		/*
		 * default style: 5
		 */
		List<ColumnNode> columns = ColumnNode.toColumns("20L(2)|MZ(5)E(00404040H,00E0E0E0H,00808080H,00C0C0C0H)");
		assertEquals(1, columns.size());

		ColumnNode column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleProps(column, 5);
		assertFieldTreeDefaults(column);

		/*
		 * Add another column:
		 * default style: 10
		 */
		columns = ColumnNode.toColumns("20L(2)|MZ(5)E(00404040H,00E0E0E0H,00808080H,00C0C0C0H)20L(2)|MZ(10)E(8000000CH,8000000AH,80000009H,80000002H)");
		assertEquals(2, columns.size());

		column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleProps(column, 5);
		assertFieldTreeDefaults(column);

		column = columns.get(1);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleProps(column, 10);
		assertFieldTreeDefaults(column);
	}

	public void testToColumns_NonTreeDataProps() {
		/*
		 * show boxes: false
		 * show level: false
		 * show lines: false
		 * show root: false
		 * tree: true
		 */
		List<ColumnNode> columns = ColumnNode.toColumns("20L(2)|MT(LRBI)");
		assertEquals(1, columns.size());

		ColumnNode column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeProps(column, false, false, false, false, true);

		// Add the same again
		columns = ColumnNode.toColumns("20L(2)|MT(LRBI)20L(2)|MT(LRBI)");
		assertEquals(2, columns.size());

		column = columns.get(0);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeProps(column, false, false, false, false, true);

		column = columns.get(1);
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeProps(column, false, false, false, false, true);
	}

	private void assertFieldHeaderProps(
			ColumnNode column,
			int indent,
			String justification,
			int scrollbar,
			String text,
			int width) {
		assertEquals("indent", indent, column.getIndent());
		assertEquals("justification", justification, column.getJustification());
		assertEquals("scrollbar", scrollbar, column.getScrollbar());
		assertEquals("text", text, column.getText());
		assertEquals("width", width, column.getWidth());
	}

	private void assertFieldDataProps(
			ColumnNode column,
			int dataIndent,
			String dataJustification,
			String picture) {
		assertEquals("dataIndent", dataIndent, column.getDataIndent());
		assertEquals("dataJustification", dataJustification, column.getDataJustification());
		assertEquals("picture", picture, column.getPicture());
	}

	private void assertFieldFlagsProps(
			ColumnNode column,
			boolean fixed,
			boolean hasColor,
			boolean lastOnLine,
			boolean locator,
			boolean resizeable,
			boolean style,
			boolean underline) {
		assertEquals("fixed", fixed, column.isFixed());
		assertEquals("hasColor", hasColor, column.hasColor());
		assertEquals("lastOnLine", lastOnLine, column.isLastOnLine());
		assertEquals("locator", locator, column.isLocator());
		assertEquals("resizeable", resizeable, column.isResizeable());
		assertEquals("style", style, column.isStyle());
		assertEquals("underline", underline, column.isUnderline());
	}

	private void assertFieldGeneralProps(
			ColumnNode column,
			String icon) {
		assertEquals("icon", icon, column.getIcon());
	}

	private void assertFieldStyleProps(
			ColumnNode column,
			int defaultStyle) {
		assertEquals("defaultStyle", defaultStyle, column.getDefaultStyle());
	}

	private void assertFieldTreeProps(
			ColumnNode column,
			boolean showBoxes,
			boolean showLevel,
			boolean showLines,
			boolean showRoot,
			boolean tree) {
		assertEquals("showBoxes", showBoxes, column.isShowBoxes());
		assertEquals("showLevel", showLevel, column.isShowLevel());
		assertEquals("showLines", showLines, column.isShowLines());
		assertEquals("showRoot", showRoot, column.isShowRoot());
		assertEquals("tree", tree, column.isTree());
	}

	private void assertFieldDefaults(ColumnNode column) {
		assertFieldHeaderDefaults(column);
		assertFieldDataDefaults(column);
		assertFieldFlagsDefaults(column);
		assertFieldGeneralDefaults(column);
		assertFieldStyleDefaults(column);
		assertFieldTreeDefaults(column);
	}

	private void assertFieldHeaderDefaults(ColumnNode column) {
		assertFieldHeaderProps(column, 0, "", 0, "", 20);
	}

	private void assertFieldDataDefaults(ColumnNode column) {
		assertFieldDataProps(column, 2, Justify.LEFT.toString(), "");
	}

	private void assertFieldFlagsDefaults(ColumnNode column) {
		assertFieldFlagsProps(column, false, false, false, false, true, false, false);
	}

	private void assertFieldGeneralDefaults(ColumnNode column) {
		assertFieldGeneralProps(column, ColumnNode.ICON_NONE);
	}

	private void assertFieldStyleDefaults(ColumnNode column) {
		assertFieldStyleProps(column, 0);
	}

	private void assertFieldTreeDefaults(ColumnNode column) {
		assertFieldTreeProps(column, false, false, false, false, false);
	}

}
