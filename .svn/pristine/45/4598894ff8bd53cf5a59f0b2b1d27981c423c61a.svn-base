package org.jclarion.clarion.ide.dialog;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.commands.operations.AbstractOperation;
import org.eclipse.core.runtime.Assert;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.jface.dialogs.TrayDialog;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.ISelectionChangedListener;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.viewers.SelectionChangedEvent;
import org.eclipse.jface.viewers.TreeNode;
import org.eclipse.jface.viewers.TreePath;
import org.eclipse.jface.viewers.TreeSelection;
import org.eclipse.jface.viewers.TreeViewer;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CCombo;
import org.eclipse.swt.custom.TableCursor;
import org.eclipse.swt.events.ControlEvent;
import org.eclipse.swt.events.ControlListener;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.layout.FormLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.ExpandBar;
import org.eclipse.swt.widgets.ExpandItem;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Spinner;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableColumn;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.widgets.ToolBar;
import org.eclipse.swt.widgets.ToolItem;
import org.eclipse.ui.ISharedImages;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.forms.widgets.FormToolkit;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetWidgetFactory;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ListColumn;
import org.jclarion.clarion.control.ListColumn.Justify;
import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.model.GenericTreeNode;
import org.jclarion.clarion.ide.model.GenericTreeNodeContentProvider;
import org.jclarion.clarion.ide.model.JavaSwingProvider;
import org.jclarion.clarion.ide.model.manager.PropertyManager;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;

public class ListFormatDialog extends TrayDialog {

	private static final int INDENT = 10;
	private static final int PROPERTY_LABEL_INDENT = 20;

	private GenericTreeNodeContentProvider columnProvider;

	private String format;

	private ColumnNode selectedColumn;

	private Table table;
	private TreeViewer columnTree;
	private Composite fieldPropertiesEditor;

	private ToolItem deleteToolItem;
	private ToolItem moveLeftToolItem;
	private ToolItem moveRightToolItem;

	/* General */
	private Spinner indent;
	private CCombo justification;
	private Spinner scrollbar;
	private Text text;
	private Spinner width;

	/* Data */
	private Spinner dataIndent;
	private CCombo dataJustification;
	private Text picture;

	/* Flags */
	private Button fixed;
	private Button hasColor;
	private Button lastOnLine;
	private Button locator;
	private Button resizeable;
	private Button style;
	private Button underline;
	private Button vertical;

	/* General */
	private CCombo icon;

	/* Style */
	private Spinner defaultStyle;

	/* Tree */
	private Button showBoxes;
	private Button showLevel;
	private Button showLines;
	private Button showRoot;
	private Button tree;
	private AbstractClarionEditor editor;
	private String fields[];
	private TableItem tableitem;
	private AbstractTarget owner;
	private TableCursor cursor;

	public ListFormatDialog(Shell shell) {
		super(shell);
		setHelpAvailable(false);
		setShellStyle(SWT.APPLICATION_MODAL | SWT.RESIZE);
	}

	/**
	 * Set the format to display
	 */
	public void setFormat(String format) {
		this.format = format;
	}
	
	public void setFields(String ...fields) {
		this.fields=fields;
	}
	
	public void setEditor(AbstractClarionEditor editor)
	{
		this.editor=editor;
	}

	/**
	 * Opens the dialog and returns the format, or <code>null</code> if
	 * cancelled
	 */
	public String openAndWait() {
		String newFormat = null;

		int returnCode = open();
		if (returnCode == ListFormatDialog.OK) {

			List<ColumnNode> columns = new ArrayList<ColumnNode>();

			if (columnProvider.root.hasChildren()) {
				for (TreeNode node : columnProvider.root.getChildren()) {
					columns.add((ColumnNode) node);
				}
				newFormat = columnsToFormat();
			}
		} else {
			newFormat = format; // Return the existing format unchanged
		}

		return newFormat;
	}
	
	private static class ListBoxOperation extends AbstractOperation
	{
		
		private PropertyObject po;
		private String oldFormat;
		private String newFormat;
		private String[] oldPragma;
		private String[] newPragma;

		public ListBoxOperation(PropertyObject po,String oldFormat,String[] oldPragma,String newFormat,String[] newPragma) {
			super("List Box Format");
			this.po=po;
			this.oldFormat=oldFormat;
			this.newFormat=newFormat;
			this.oldPragma=oldPragma;
			this.newPragma=newPragma;
		}

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info)
				throws ExecutionException {
			return apply(newFormat,newPragma);
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info)
				throws ExecutionException {
			return apply(newFormat,newPragma);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info)
				throws ExecutionException {
			return apply(oldFormat,oldPragma);
		}

		private IStatus apply(String format, String[] fields) 
		{			 
			po.setProperty(Prop.FORMAT,format);
			ExtendProperties.get(po).addPragma("FIELDS", fields!=null && fields.length>0 ? fields : null);
			return Status.OK_STATUS;
		}
		
	}

	/**
	 * Opens the dialog and returns the format, or <code>null</code> if
	 * cancelled
	 */
	public AbstractOperation openAndWait(PropertyObject target) {

		ExtendProperties ep =ExtendProperties.get(target);
		String originalFormat=target.getProperty(Prop.FORMAT).toString();
		String[] originalPragma=ep.getPragma("FIELDS");
		setFields(originalPragma);
		setFormat(originalFormat);
		this.owner=((AbstractControl)target).getOwner();
		
		int returnCode = open();
		if (returnCode == ListFormatDialog.OK) {

			List<ColumnNode> columns = new ArrayList<ColumnNode>();

			String newFormat=null;
			List<String> newPragma=new ArrayList<String>();
			if (columnProvider.root.hasChildren()) {
				for (TreeNode node : columnProvider.root.getChildren()) {
					ColumnNode n = (ColumnNode)node;
					if (n.getFieldName()!=null) {
						newPragma.add(n.getFieldName());
					}
					columns.add(n);
				}
				newFormat = columnsToFormat();
			} 
			return new ListBoxOperation(target, originalFormat, originalPragma, newFormat, newPragma.toArray(new String[newPragma.size()]));
		}

		return null;
	}
	
	@Override
	protected Control createDialogArea(Composite parent) {
		TabbedPropertySheetWidgetFactory toolkit = new TabbedPropertySheetWidgetFactory();

		Composite composite = (Composite) super.createDialogArea(parent);
		composite.setLayout(new FormLayout());

		GridData dialogData = new GridData();
		dialogData.minimumWidth = 500;
		dialogData.minimumHeight = 400;
		dialogData.grabExcessHorizontalSpace = true;
		dialogData.grabExcessVerticalSpace = true;
		dialogData.horizontalAlignment = SWT.FILL;
		dialogData.verticalAlignment = SWT.FILL;
		composite.setLayoutData(dialogData);

		Composite tableComposite = createInnerComposite(toolkit, composite);
		table = createTable(toolkit, tableComposite);

	    Composite columnComposite = createInnerComposite(toolkit, composite);
	    columnTree = createColumnTree(toolkit, columnComposite);

	    columnProvider = new GenericTreeNodeContentProvider();
	    columnTree.setContentProvider(columnProvider);
		columnTree.setInput(columnProvider.root);

		Composite propertiesComposite = createInnerComposite(toolkit, composite);
	    fieldPropertiesEditor = createFieldPropertiesEditor(toolkit, propertiesComposite);
	    fieldPropertiesEditor.setVisible(false);

	    FormData data = new FormData();
	    data.top = new FormAttachment(0);
	    data.left = new FormAttachment(0, INDENT);
	    data.right = new FormAttachment(100, -INDENT);
	    tableComposite.setLayoutData(data);

	    data = new FormData();
	    data.top = new FormAttachment(tableComposite, INDENT);
	    data.left = new FormAttachment(0, INDENT);
	    data.bottom = new FormAttachment(100);
	    data.right = new FormAttachment(35, -INDENT);
	    columnComposite.setLayoutData(data);

	    data = new FormData();
	    data.top = new FormAttachment(tableComposite, INDENT);
	    data.left = new FormAttachment(columnComposite, INDENT);
	    data.bottom = new FormAttachment(100);
	    data.right = new FormAttachment(100, -INDENT);
	    propertiesComposite.setLayoutData(data);

	    // Pre-populate with existing format
		if (format != null) {
			List<ColumnNode> columns = ColumnNode.toColumns(format,this.fields);
			for (ColumnNode column : columns) {
				columnProvider.root.addChild(column);
			}
		}

		update(columnProvider.hasContent() ? columnProvider.getFirstChild(): null);

		return composite;
	}

	private Composite createInnerComposite(TabbedPropertySheetWidgetFactory toolkit, Composite parent) {
		return createInnerComposite(toolkit, parent, 0);
	}

	private Composite createInnerComposite(TabbedPropertySheetWidgetFactory toolkit, Composite parent, int style) {
		Composite inner = toolkit.createComposite(parent, SWT.BORDER | style);
		inner.setLayout(new FormLayout());
		return inner;
	}

	private Table createTable(TabbedPropertySheetWidgetFactory toolkit, Composite parent) {
		Table table = toolkit.createTable(parent, SWT.SINGLE |SWT.NO_FOCUS);
		table.setHeaderVisible(true);
		table.setLinesVisible(true);
		table.setToolTipText(Messages.getString(getClass(), "Table.tooltip"));
		cursor = new TableCursor(table, SWT.NONE);
		cursor.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				TreeNode[] x = columnProvider.root.getChildren();
				if (x.length<=cursor.getColumn()) return;
				ColumnNode cn = (ColumnNode) x[cursor.getColumn()];
				if (getSelectedColumn()==cn) return;
				selectColumn(cn);
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		fillParent(table);

		return table;
	}

	private TreeViewer createColumnTree(TabbedPropertySheetWidgetFactory toolkit, Composite composite) {
		ToolBar bar = new ToolBar(composite, SWT.NONE | SWT.HORIZONTAL);
		toolkit.adapt(bar);

		createToolItem(bar, ISharedImages.IMG_OBJS_INFO_TSK,
				Messages.getString(getClass(), "ToolItem.AddField.tooltip"),
				new SelectionAdapter() {
					@Override
					public void widgetSelected(SelectionEvent e) {
						addFieldAfter(getSelectedColumn());
					}
				});

		new ToolItem(bar, SWT.SEPARATOR);

		deleteToolItem = createToolItem(bar, ISharedImages.IMG_TOOL_DELETE,
				Messages.getString(getClass(), "ToolItem.Delete.tooltip"),
				new SelectionAdapter() {
					@Override
					public void widgetSelected(SelectionEvent e) {
						removeColumn(getSelectedColumn());
					}
				});

		new ToolItem(bar, SWT.SEPARATOR);

		moveLeftToolItem = createToolItem(bar, ISharedImages.IMG_TOOL_BACK,
				Messages.getString(getClass(), "ToolItem.MoveLeft.tooltip"),
				new SelectionAdapter() {
					@Override
					public void widgetSelected(SelectionEvent e) {
						moveLeft(getSelectedColumn());
					}
				});

		moveRightToolItem = createToolItem(bar, ISharedImages.IMG_TOOL_FORWARD,
				Messages.getString(getClass(), "ToolItem.MoveRight.tooltip"),
				new SelectionAdapter() {
					@Override
					public void widgetSelected(SelectionEvent e) {
						moveRight(getSelectedColumn());
					}
				});

	    TreeViewer tree = new TreeViewer(composite, SWT.NONE);
	    toolkit.adapt(tree.getTree());
	    tree.addSelectionChangedListener(new ISelectionChangedListener() {
			@Override
			public void selectionChanged(SelectionChangedEvent event) {
				columnChanged(getSelectedColumn());
			}
		});

	    FormData data = new FormData();
	    data.top = new FormAttachment(0);
	    data.left = new FormAttachment(0);
	    data.bottom = new FormAttachment(tree.getControl());
	    data.right = new FormAttachment(100);
	    bar.setLayoutData(data);

	    data = new FormData();
	    data.top = new FormAttachment(bar);
	    data.left = new FormAttachment(0);
	    data.bottom = new FormAttachment(100);
	    data.right = new FormAttachment(100);
	    tree.getControl().setLayoutData(data);

	    return tree;
	}

	private ToolItem createToolItem(
			ToolBar bar,
			String sharedImageName,
			String tooltip,
			SelectionListener listener) {
		ToolItem item = new ToolItem(bar, SWT.PUSH);
		item.setImage(PlatformUI.getWorkbench().getSharedImages().getImage(sharedImageName));
		item.setToolTipText(tooltip);
		item.addSelectionListener(listener);
		return item;
	}

	private Composite createFieldPropertiesEditor(TabbedPropertySheetWidgetFactory toolkit, Composite parent) {
		ExpandBar bar = createExpandBar(toolkit, parent);

		/* Header */
		Composite composite = createPropertyComposite(toolkit, bar);
		indent = createIntegerProperty(toolkit, composite, ColumnNode.PROPERTY_INDENT);
		justification = createJustificationProperty(toolkit, composite, ColumnNode.PROPERTY_JUSTIFICATION);
		scrollbar = createIntegerProperty(toolkit, composite, ColumnNode.PROPERTY_SCROLLBAR);
		text = createStringProperty(toolkit, composite, ColumnNode.PROPERTY_TEXT);
		width = createIntegerProperty(toolkit, composite, ColumnNode.PROPERTY_WIDTH, false);
		createExpandItem(bar, ColumnNode.GROUP_HEADER, composite);

		/* Data */
		composite = createPropertyComposite(toolkit, bar);
		dataIndent = createIntegerProperty(toolkit, composite, ColumnNode.PROPERTY_DATAINDENT);
		dataJustification = createJustificationProperty(toolkit, composite, ColumnNode.PROPERTY_DATAJUSTIFICATION);
		picture = createStringProperty(toolkit, composite, ColumnNode.PROPERTY_PICTURE);
		createExpandItem(bar, ColumnNode.GROUP_DATA, composite);

		/* Flags */
		composite = createPropertyComposite(toolkit, bar);
		fixed = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_FIXED);
		hasColor = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_HASCOLOR);
		lastOnLine = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_LASTONLINE);
		locator = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_LOCATOR);
		resizeable = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_RESIZEABLE);
		style = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_STYLE);
		underline = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_UNDERLINE);
		vertical = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_VERTICAL);
		createExpandItem(bar, ColumnNode.GROUP_FLAGS, composite);

		/* General */
		composite = createPropertyComposite(toolkit, bar);
		icon = createListProperty(toolkit, composite, ColumnNode.PROPERTY_ICON, ColumnNode.VALUES_ICON);
		createExpandItem(bar, ColumnNode.GROUP_GENERAL, composite);

		/* Style */
		composite = createPropertyComposite(toolkit, bar);
		defaultStyle = createIntegerProperty(toolkit, composite, ColumnNode.PROPERTY_DEFAULTSTYLE);
		createExpandItem(bar, ColumnNode.GROUP_STYLE, composite);

		/* Tree */
		composite = createPropertyComposite(toolkit, bar);
		showBoxes = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_SHOWBOXES);
		showLevel = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_SHOWLEVEL);
		showLines = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_SHOWLINES);
		showRoot = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_SHOWROOT);
		tree = createBooleanProperty(toolkit, composite, ColumnNode.PROPERTY_TREE);
		createExpandItem(bar, ColumnNode.GROUP_TREE, composite);

		fillParent(bar);

	    return bar;
	}

	private void fillParent(Control control) {
	    FormData data = new FormData();
	    data.top = new FormAttachment(0);
	    data.left = new FormAttachment(0);
	    data.bottom = new FormAttachment(100);
	    data.right = new FormAttachment(100);
	    control.setLayoutData(data);
	}

	private ExpandBar createExpandBar(TabbedPropertySheetWidgetFactory toolkit, Composite parent) {
		ExpandBar bar = new ExpandBar(parent, SWT.V_SCROLL);
		toolkit.adapt(bar);
		return bar;
	}

	private Composite createPropertyComposite(TabbedPropertySheetWidgetFactory toolkit, ExpandBar bar) {
		Composite composite = toolkit.createFlatFormComposite(bar);
		composite.setLayout(new GridLayout(2, true));
		return composite;
	}

	private Button createBooleanProperty(TabbedPropertySheetWidgetFactory toolkit, Composite parent, final String text) {
		createPropertyLabel(toolkit, parent, text);

		final Button button = toolkit.createButton(parent, "", SWT.CHECK);
		button.setBackground(parent.getBackground());
		layoutPropertyInputControl(button);
		button.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				Assert.isNotNull(selectedColumn);
				selectedColumn.propertyChanged(text, button.getSelection());
				updateTable(selectedColumn);
			}
		});

		return button;
	}

	private Text createStringProperty(TabbedPropertySheetWidgetFactory toolkit, Composite parent, final String text) {
		createPropertyLabel(toolkit, parent, text);

		final Text t = toolkit.createText(parent, "");
		layoutPropertyInputControl(t);
		t.addModifyListener(new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				Assert.isNotNull(selectedColumn);
				selectedColumn.propertyChanged(text, t.getText());
				tableitem.setText(selectedColumn.getIndex(),selectedColumn.getListColumn().getPicture()==null ? "" :selectedColumn.getListColumn().getPicture().getPictureRepresentation()); 
				updateTable(selectedColumn);
			}
		});

		return t;
	}

	private Spinner createIntegerProperty(TabbedPropertySheetWidgetFactory toolkit, Composite parent, String text) {
		return createIntegerProperty(toolkit, parent, text, true);
	}

	private Spinner createIntegerProperty(TabbedPropertySheetWidgetFactory toolkit, Composite parent, final String text, boolean negative) {
		createPropertyLabel(toolkit, parent, text);

		final Spinner spinner = new Spinner(parent, SWT.NONE);
		spinner.setMinimum(negative ? -100 : 0);
		spinner.setMaximum(1000);
		layoutPropertyInputControl(spinner);
		spinner.addModifyListener(new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				Assert.isNotNull(selectedColumn);
				selectedColumn.propertyChanged(text, spinner.getSelection());
				updateTable(selectedColumn);
			}
		});

		spinner.setData(FormToolkit.KEY_DRAW_BORDER, FormToolkit.TEXT_BORDER);
		return spinner;
	}

	private CCombo createListProperty(TabbedPropertySheetWidgetFactory toolkit, Composite parent, final String text, Collection<String> values) {
		createPropertyLabel(toolkit, parent, text);

		final CCombo combo = toolkit.createCCombo(parent);
		combo.setEditable(false);
		combo.add(" ");
		for (String value : values) {
			combo.add(value);
		}
		layoutPropertyInputControl(combo);
		combo.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				Assert.isNotNull(selectedColumn);
				selectedColumn.propertyChanged(text, combo.getText());
				updateTable(selectedColumn);
			}
		});

		return combo;
	}

	private CCombo createJustificationProperty(TabbedPropertySheetWidgetFactory toolkit, Composite parent, final String text) {
		createPropertyLabel(toolkit, parent, text);

		final CCombo combo = toolkit.createCCombo(parent);
		combo.setEditable(false);
		combo.add(" ");
		for (ListColumn.Justify value : ListColumn.Justify.values()) {
			combo.add(value.toString());
		}
		layoutPropertyInputControl(combo);
		combo.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				Assert.isNotNull(selectedColumn);
				selectedColumn.propertyChanged(text, ListColumn.Justify.valueOf(combo.getText()));
				updateTable(selectedColumn);
			}
		});

		return combo;
	}

	private void createPropertyLabel(TabbedPropertySheetWidgetFactory toolkit, Composite parent, String text) {
		GridData data = new GridData();
		data.horizontalIndent = PROPERTY_LABEL_INDENT;
		toolkit.createCLabel(parent, text).setLayoutData(data);
	}

	private boolean ignoreResize=false;
	
	private TableColumn createTableColumn(final ColumnNode column) {
		TableColumn tc = new TableColumn(table, SWT.NONE);
		configureTableColumn(tc, column);
		tc.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				selectColumn(column);
			}
		});
		tc.setResizable(true);
		
		tc.addControlListener(new ControlListener() {
			@Override
			public void controlMoved(ControlEvent e) {
			}

			@Override
			public void controlResized(ControlEvent e) {				
				if (ignoreResize) return;
				
				int width=((TableColumn)e.widget).getWidth();
				
				if (width!=column.getListColumn().getWidth()) {
					if (owner==null) {
						column.getListColumn().setWidth(width);
					} else {
						column.getListColumn().setWidth(owner.widthPixelsToDialog(width));
					}
					if (getSelectedColumn()==column) {
						ListFormatDialog.this.width.setSelection(column.getWidth());
					}
				}
			}
			
		});
		return tc;
	}

	private void configureTableColumn(TableColumn tc, ColumnNode column) {
		tc.setMoveable(false);
		tc.setText(column.getText());
		try {
			ignoreResize=true;
			if (owner!=null) {
				tc.setWidth(owner.widthDialogToPixels(column.getWidth()));		
			} else {
				tc.setWidth(column.getWidth());
			}
		} finally {
			ignoreResize=false;
		}

		int alignment = SWT.LEFT;
		if (column.getDataJustification().equals(PropertyManager.getOrientationRight())) {
			alignment = SWT.RIGHT;
		} else if (column.getDataJustification().equals(PropertyManager.getOrientationCenter())) {
			alignment = SWT.CENTER;
		}
		tc.setAlignment(alignment);

		//tc.pack();
	}

	private void layoutPropertyInputControl(Control control) {
		control.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
	}

	private void createExpandItem(
			//TabbedPropertySheetWidgetFactory toolkit,
			ExpandBar parent,
			String text,
			Composite composite) {
		ExpandItem item = new ExpandItem(parent, SWT.FLAT);
		item.setText(text);
		item.setExpanded(true);
		item.setHeight(composite.computeSize(SWT.DEFAULT, SWT.DEFAULT).y + 5);
		item.setControl(composite);
	}

	private void columnChanged(ColumnNode node) {
		selectedColumn = node;
		updateColumnToolItems(selectedColumn);
		updatePropertiesEditor(selectedColumn);
		if (node!=null) {
			cursor.setSelection(0, node.getIndex());
		}
	}

	private boolean isProcWindow()
	{
		return (editor!=null && editor.getModel()!=null);		
	}
	
	private void addFieldAfter(ColumnNode column) {
		
		String fieldName=null;
		Definition fieldDefinition=null;
		if (isProcWindow()) {
			FieldDialog fd = new FieldDialog();
			fd.setInfo(editor, 0);
			fieldName=fd.openAndWait();
			if (fieldName==null) return;
			fieldDefinition = fd.getDefinition();
		}
		
		ColumnNode field = null;
		if (column==null) {
			field=new ColumnNode();
			field.getListColumn().setJustification(Justify.LEFT);
			field.getListColumn().setHeaderJustification(Justify.CENTER);
			field.getListColumn().setWidth(200);
			field.getListColumn().setResizable(true);
			field.getListColumn().setVerticalLine(true);
			field.getListColumn().setHeader("Header");
		} else {
			ListColumn base = column.getListColumn();
			ListColumn clone = base.clone();
			field = new ColumnNode(clone);
		}
		field.setFieldName(fieldName);
		if (fieldDefinition!=null) {
			String picture = JavaSwingProvider.getDefinitionPattern(fieldDefinition);
			if (picture!=null) {
				field.getListColumn().setPicture(picture);
				int len = field.getListColumn().getPicture().getPictureRepresentation().length();
				field.getListColumn().setWidth(len*4);
				field.getListColumn().setHeader(fieldDefinition.getName());
			}
		}
		if (column == null) {
			columnProvider.root.addChild(field);
		} else {
			columnProvider.root.addChildAfter(field, column);
		}
		update(field);
	}

	private void removeColumn(ColumnNode column) {
		int index = column.getSiblings().indexOf(column);
		Assert.isTrue(index != -1);

		GenericTreeNode parent = (GenericTreeNode) column.getParent();
		parent.removeChild(column);

		List<GenericTreeNode> nodes = ((GenericTreeNode) parent).getKids();
		// Refresh and update the selection...
		GenericTreeNode selection = null;
		if (nodes.isEmpty()) {
			// No selection
			selection = null;
		} else if (nodes.size() > index) {
			// Select node at the position occupied by the deleted node
			selection = nodes.get(index);
		} else {
			// Select last node
			selection = nodes.get(nodes.size() - 1);
		}

		update(selection);
	}

	private void setToolItemEnabled(
			boolean delete,
			boolean moveLeft,
			boolean moveRight) {
		deleteToolItem.setEnabled(delete);
		moveLeftToolItem.setEnabled(moveLeft);
		moveRightToolItem.setEnabled(moveRight);
	}

	private void moveLeft(ColumnNode node) {
		Assert.isNotNull(node);
		node.moveDown();
		update(node);
	}

	private void moveRight(ColumnNode node) {
		Assert.isNotNull(node);
		node.moveUp();
		update(node);
	}

	private ColumnNode getSelectedColumn() {
		ISelection selection = columnTree.getSelection();
		Assert.isTrue(selection instanceof IStructuredSelection);
		return (ColumnNode) ((IStructuredSelection) selection).getFirstElement();
	}

	private void selectColumn(ColumnNode column) {
		ISelection treeSelection;
		if (column != null) {
			treeSelection = new TreeSelection(new TreePath(new Object[] { column }));
		} else {
			treeSelection = new TreeSelection();
		}
		columnTree.setSelection(treeSelection);
	}

	/**
	 * Updates the table to reflect the current column configuration, refreshes
	 * the tree and selects the specified selection
	 */
	private void update(GenericTreeNode selection) {
		updateTable();

		columnTree.refresh();
		columnTree.expandAll();

		selectColumn((ColumnNode) selection);
	}

	private void updateColumnToolItems(ColumnNode column) {
		boolean delete = (column != null);
		boolean moveLeft = (column != null) && column.canMoveDown();
		boolean moveRight = (column != null) && column.canMoveUp();

		setToolItemEnabled(delete, moveLeft, moveRight);
	}

	private void updatePropertiesEditor(ColumnNode column) {
		if (column == null) {
			fieldPropertiesEditor.setVisible(false);
		} else {
			fieldPropertiesEditor.setVisible(true);

			indent.setSelection(column.getIndent());
			justification.setText(column.getJustification());
			scrollbar.setSelection(column.getScrollbar());
			text.setText(column.getText());
			width.setSelection(column.getWidth());
			dataIndent.setSelection(column.getDataIndent());
			dataJustification.setText(column.getDataJustification());
			picture.setText(column.getPicture());
			fixed.setSelection(column.isFixed());
			hasColor.setSelection(column.hasColor());
			lastOnLine.setSelection(column.isLastOnLine());
			locator.setSelection(column.isLocator());
			resizeable.setSelection(column.isResizeable());
			style.setSelection(column.isStyle());
			underline.setSelection(column.isUnderline());
			vertical.setSelection(column.isVertical());
			icon.setText(column.getIcon());
			defaultStyle.setSelection(column.getDefaultStyle());
			showBoxes.setSelection(column.isShowBoxes());
			showLevel.setSelection(column.isShowLevel());
			showLines.setSelection(column.isShowLines());
			showRoot.setSelection(column.isShowRoot());
			tree.setSelection(column.isTree());
		}

	}

	private void updateTable() {
		table.setRedraw(false);

		while (table.getItemCount() > 0) {
			table.getItem(0).dispose();
		}

		while (table.getColumnCount() > 0) {
			table.getColumn(0).dispose();
		}

		int index = 0;
		for (GenericTreeNode node : columnProvider.root.getKids()) {
			Assert.isTrue(node instanceof ColumnNode);
			ColumnNode column = (ColumnNode) node;
			column.setIndex(index++);
			createTableColumn(column);
		}
		TableColumn tc = new TableColumn(table, SWT.NONE);
		tc.setMoveable(false);
		tc.setResizable(true);
		tc.setText("");
		tc.setWidth(1);
		
		// Create a table item so that the table looks like a table
		tableitem = new TableItem(table, SWT.NONE);
		tableitem.setBackground(table.getBackground());
		for (GenericTreeNode node : columnProvider.root.getKids()) {
			ColumnNode column = (ColumnNode) node;
			String text = column.getListColumn().getPicture()==null ? "" :column.getListColumn().getPicture().getPictureRepresentation();
			tableitem.setText(column.getIndex(),text); 
		}
		
		ColumnNode cn = getSelectedColumn();
		if (cn!=null) {
			cursor.setSelection(0, cn.getIndex());
		}

		table.setRedraw(true);
	}

	private void updateTable(ColumnNode column) {
		table.setRedraw(false);
		configureTableColumn(table.getColumn(column.getIndex()), column);
		table.setRedraw(true);
	}

	private String columnsToFormat() {
		List<ListColumn> columns = new ArrayList<ListColumn>();
		for (GenericTreeNode node : columnProvider.root.getKids()) {
			Assert.isTrue(node instanceof ColumnNode);
			columns.add(((ColumnNode) node).getListColumn());
		}
		return ListColumn.deconstruct((ListColumn[]) columns.toArray(new ListColumn[columns.size()]));
	}

	@Override
	protected Point getInitialSize() {
		return new Point(600, 800);
	}
}
