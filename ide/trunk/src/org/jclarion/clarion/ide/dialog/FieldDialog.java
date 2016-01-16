package org.jclarion.clarion.ide.dialog;


import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.view.FieldTreeHelper;

public class FieldDialog extends Dialog {

	private AbstractClarionEditor editor;
	private FieldTreeHelper helper;
	private String result;
	private int additionFilter;
	private Definition definition;

	public FieldDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public FieldDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(AbstractClarionEditor editor,int additionFilter)
	{
		this.editor=editor;
		this.additionFilter=additionFilter;
	}

	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Select Field");
		Composite body = (Composite) super.createDialogArea(parent);
		body.setLayout(new FillLayout());
		helper=new FieldTreeHelper(editor,body,additionFilter);
		helper.getViewer();
		return body;
	}
	
	/**
	 * Create contents of the button bar.
	 * @param parent
	 */
	@Override
	protected void createButtonsForButtonBar(Composite parent) {
		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL,true);
		createButton(parent, IDialogConstants.CANCEL_ID, IDialogConstants.CANCEL_LABEL,true);
	}


	public String openAndWait()
	{
		setBlockOnOpen(true);
		try {
			if (super.open()==OK) {
				return result;
			} else {
				return null;
			}
		} finally {
			helper.dispose();
		}
	}

	@Override
	protected void okPressed() {
		result=helper.getFieldName();
		definition=helper.getFieldDefinition(true);
		if (result==null) return;
		super.okPressed();
	}
	
	public Definition getDefinition()
	{
		return definition;
	}

	/**
	 * Return the initial size of the dialog.
	 */
	@Override
	protected Point getInitialSize() {
		return new Point(500, 500);
	}

}
