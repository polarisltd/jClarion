package org.jclarion.clarion.ide.dialog;


import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.App;

public class CopyProcedureDialog extends Dialog {

	private String name;
	private App base;

	public CopyProcedureDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public CopyProcedureDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(App base,String name)
	{
		this.base=base;
		this.name=name;
	}
	
	public String getName()
	{
		return name;
	}

	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Copy Procedure");
		Composite container = (Composite) super.createDialogArea(parent);		
		container.setLayout(new GridLayout(1,false));
		
		Text text = new Text(container,SWT.BORDER);
		text.setLayoutData(new GridData(GridData.FILL,GridData.CENTER,true,true));
		text.setText(name);
		text.addModifyListener(new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				name=((Text)e.widget).getText();
			}
		});
		return container;
	}

	
	@Override
	protected void okPressed() 
	{	
		if (base.getProcedure(name)!=null) {
			MessageBox mb = new MessageBox(getShell(),SWT.ICON_ERROR+SWT.OK);
			mb.setText("Copy Procedure");
			mb.setMessage("Procedure Name already exists");
			mb.open();
			return;
		}
		super.okPressed();
	}

	/**
	 * Create contents of the button bar.
	 * @param parent
	 */
	@Override
	protected void createButtonsForButtonBar(Composite parent) {
		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL,true);
		createButton(parent, IDialogConstants.CANCEL_ID,IDialogConstants.CANCEL_LABEL, false);
	}

	/**
	 * Return the initial size of the dialog.
	 */
	@Override
	protected Point getInitialSize() {
		return new Point(350, 130);
	}

}
