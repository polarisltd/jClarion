package org.jclarion.clarion.ide.dialog;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.eclipse.core.runtime.Assert;

import org.jclarion.clarion.control.ListColumn;
import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.GenericTreeNode;
import org.jclarion.clarion.runtime.format.Formatter;

public class ColumnNode extends GenericTreeNode {

	/* Header */
	public static final String GROUP_HEADER = getGroupLabel("Header");
	public static final String PROPERTY_INDENT = getPropertyLabel("Indent");
	public static final String PROPERTY_JUSTIFICATION = getPropertyLabel("Justification");
	public static final String PROPERTY_SCROLLBAR = getPropertyLabel("ScrollBar");
	public static final String PROPERTY_TEXT = getPropertyLabel("Text");
	public static final String PROPERTY_WIDTH = getPropertyLabel("Width");

	/* Data */
	public static final String GROUP_DATA = getGroupLabel("Data");
	public static final String PROPERTY_DATAINDENT = getPropertyLabel("DataIndent");
	public static final String PROPERTY_DATAJUSTIFICATION = getPropertyLabel("DataJustification");
	public static final String PROPERTY_PICTURE = getPropertyLabel("Picture");

	/* Flags */
	public static final String GROUP_FLAGS = getGroupLabel("Flags");
	public static final String PROPERTY_FIXED = getPropertyLabel("Fixed");
	public static final String PROPERTY_HASCOLOR = getPropertyLabel("HasColor");
	public static final String PROPERTY_LASTONLINE = getPropertyLabel("LastOnLine");
	public static final String PROPERTY_LOCATOR = getPropertyLabel("Locator");
	public static final String PROPERTY_RESIZEABLE = getPropertyLabel("Resizeable");
	public static final String PROPERTY_STYLE = getPropertyLabel("Style");
	public static final String PROPERTY_UNDERLINE = getPropertyLabel("Underline");
	public static final String PROPERTY_VERTICAL = getPropertyLabel("Vertical");

	/* General */
	public static final String GROUP_GENERAL = getGroupLabel("General");
	public static final String PROPERTY_ICON = getPropertyLabel("Icon");
	static final String ICON_NONE = Messages.getString(ColumnNode.class, "Values.Icon.None.label");
	static final String ICON_NORMAL = Messages.getString(ColumnNode.class, "Values.Icon.Normal.label");
	static final String ICON_TRANSPARENT = Messages.getString(ColumnNode.class, "Values.Icon.Transparent.label");
	public static final List<String> VALUES_ICON = new ArrayList<String>(Arrays.asList(
			ICON_NONE, ICON_NORMAL, ICON_TRANSPARENT));

	/* Style */
	public static final String GROUP_STYLE = getGroupLabel("Style");
	public static final String PROPERTY_DEFAULTSTYLE = getPropertyLabel("DefaultStyle");

	/* Tree */
	public static final String GROUP_TREE = getGroupLabel("Tree");
	public static final String PROPERTY_SHOWBOXES = getPropertyLabel("ShowBoxes");
	public static final String PROPERTY_SHOWLEVEL = getPropertyLabel("ShowLevel");
	public static final String PROPERTY_SHOWLINES = getPropertyLabel("ShowLines");
	public static final String PROPERTY_SHOWROOT = getPropertyLabel("ShowRoot");
	public static final String PROPERTY_TREE = getPropertyLabel("Tree");

	

	private int index;

	public static List<ColumnNode> toColumns(String format) {
		return toColumns(format,null);
	}

	public static List<ColumnNode> toColumns(String format,String fields[]) {
		List<ColumnNode> columns = new ArrayList<ColumnNode>();
		int ofs=0;
		for (ListColumn lc : ListColumn.construct(format)) {

			ColumnNode column = new ColumnNode(lc);
			if (fields!=null && fields.length>ofs) {
				column.setFieldName(fields[ofs++]);
			}

			if (lc.getChildren() != null) {
				for (ListColumn child : lc.getChildren()) {
					column.addChild(new ColumnNode(child));
				}
			}

			columns.add(column);
		}
		return columns;
	}

	private static String getGroupLabel(String group) {
		return Messages.getString(ColumnNode.class, "Group." + group + ".label");
	}

	private static String getPropertyLabel(String property) {
		return Messages.getString(ColumnNode.class, "Property." + property + ".label");
	}

	private String fieldName=null;
	
	public ColumnNode() {
		this(new ListColumn());
	}

	public ColumnNode(ListColumn column) {
		super(column);
	}

	public ListColumn getListColumn() {
		return (ListColumn) value;
	}

	public void propertyChanged(String propertyName, boolean value) {
		if (PROPERTY_FIXED.equals(propertyName)) {
			getListColumn().setColumnFixed(value);
		} else if (PROPERTY_HASCOLOR.equals(propertyName)) {
			getListColumn().setColor(value);
		} else if (PROPERTY_LASTONLINE.equals(propertyName)) {
			getListColumn().setLastOnLine(value);
		} else if (PROPERTY_LOCATOR.equals(propertyName)) {
			getListColumn().setLocator(value);
		} else if (PROPERTY_RESIZEABLE.equals(propertyName)) {
			getListColumn().setResizable(value);
		} else if (PROPERTY_STYLE.equals(propertyName)) {
			getListColumn().setStyle(value);
		} else if (PROPERTY_UNDERLINE.equals(propertyName)) {
			getListColumn().setUnderline(value);
		} else if (PROPERTY_VERTICAL.equals(propertyName)) {
			getListColumn().setVerticalLine(value);
		} else if (PROPERTY_SHOWBOXES.equals(propertyName)) {
			getListColumn().setTreeBoxes(value);
		} else if (PROPERTY_SHOWLEVEL.equals(propertyName)) {
			getListColumn().setTreeIndent(value);
		} else if (PROPERTY_SHOWLINES.equals(propertyName)) {
			getListColumn().setTreeLines(value);
		} else if (PROPERTY_SHOWROOT.equals(propertyName)) {
			getListColumn().setTreeRootLines(value);
		} else if (PROPERTY_TREE.equals(propertyName)) {
			getListColumn().setTree(value);
		}
	}

	public void propertyChanged(String propertyName, int value) {
		if (PROPERTY_INDENT.equals(propertyName)) {
			getListColumn().setHeaderIndent(value);
		} else if (PROPERTY_SCROLLBAR.equals(propertyName)) {
			getListColumn().setColumnScroll(value);
		} else if (PROPERTY_WIDTH.equals(propertyName)) {
			getListColumn().setWidth(value);
		} else if (PROPERTY_DATAINDENT.equals(propertyName)) {
			getListColumn().setIndent(value);
		} else if (PROPERTY_DEFAULTSTYLE.equals(propertyName)) {
			getListColumn().setDefaultStyle(value);
		}
	}

	public void propertyChanged(String propertyName, String value) {
		if (PROPERTY_TEXT.equals(propertyName)) {
			getListColumn().setHeader(value);
		} else if (PROPERTY_PICTURE.equals(propertyName)) {
			if ((value != null) && !value.isEmpty()) {
				try {
					getListColumn().setPicture(value);
				} catch (RuntimeException ex) { }
			}
		} else if (PROPERTY_ICON.equals(propertyName)) {
			getListColumn().setIcon(ICON_NORMAL.equals(value) || ICON_TRANSPARENT.equals(value));
			getListColumn().setTransparantIcon(ICON_TRANSPARENT.equals(value));
		}
	}

	public void propertyChanged(String propertyName, ListColumn.Justify value) {
		if (PROPERTY_JUSTIFICATION.equals(propertyName)) {
			getListColumn().setHeaderJustification(value);
		} else if (PROPERTY_DATAJUSTIFICATION.equals(propertyName)) {
			getListColumn().setJustification(value);
		}
	}

	public int getIndent() {
		return getListColumn().getHeaderIndent();
	}

	public String getJustification() {
		return getSafe(getListColumn().getHeaderJustification());
	}

	public int getScrollbar() {
		return getListColumn().getColumnScroll();
	}

	public String getText() {
		return getSafe(getListColumn().getHeader());
	}

	public int getWidth() {
		return getListColumn().getWidth();
	}

	public int getDataIndent() {
		return getListColumn().getIndent();
	}

	public String getDataJustification() {
		return getSafe(getListColumn().getJustification());
	}

	public String getPicture() {
		Formatter formatter = getListColumn().getPicture();
		if (formatter != null) {
			return formatter.picture;
		}
		return "";
	}

	public boolean isFixed() {
		return getListColumn().isColumnFixed();
	}

	public boolean hasColor() {
		return getListColumn().isColor();
	}

	public boolean isLastOnLine() {
		return getListColumn().isLastOnLine();
	}

	public boolean isLocator() {
		return getListColumn().isLocator();
	}

	public boolean isResizeable() {
		return getListColumn().isResizable();
	}

	public boolean isStyle() {
		return getListColumn().isStyle();
	}

	public boolean isUnderline() {
		return getListColumn().isUnderline();
	}

	public boolean isVertical() {
		return getListColumn().isVerticalLine();
	}

	public String getIcon() {
		ListColumn lc = getListColumn();
		String icon;
		if (lc.isTransparantIcon()) {
			icon = ICON_TRANSPARENT;
		} else if (lc.isIcon()) {
			icon = ICON_NORMAL;
		} else {
			icon = ICON_NONE;
		}
		return icon;
	}

	public int getDefaultStyle() {
		return getListColumn().getDefaultStyle();
	}

	public boolean isShowBoxes() {
		return getListColumn().isTreeBoxes();
	}

	public boolean isShowLevel() {
		return getListColumn().isTreeIndent();
	}

	public boolean isShowLines() {
		return getListColumn().isTreeLines();
	}

	public boolean isShowRoot() {
		return getListColumn().isTreeRootLines();
	}

	public boolean isTree() {
		return getListColumn().isTree();
	}

	public ListColumn[] toListColumns() {
		List<ListColumn> listColumns = new ArrayList<ListColumn>();
		for (GenericTreeNode node : getKids()) {
			Assert.isTrue(node instanceof ColumnNode);
			listColumns.add(((ColumnNode) node).getListColumn());
		}
		return (ListColumn[]) listColumns.toArray(new ListColumn[listColumns.size()]);
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	@Override
	public String toString() {
		return fieldName==null ? "UNKNOWN" : fieldName;
	}
	
	public void setFieldName(String name)
	{
		this.fieldName=name;
	}
	
	public String getFieldName()
	{
		return this.fieldName;
	}

	private String getSafe(Object o) {
		return (o != null) ? o.toString() : "";
	}

}