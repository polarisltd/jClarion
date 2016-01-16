package org.jclarion.clarion.ide.dialog;

import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.FileJoin;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.RelationKey;

public class EditFileDialog extends Dialog {

	
	private FileJoin 	file;
	private boolean 	inner;
	private String 		expression;
	private boolean		relation;
	private boolean     related;
	private Button relationship;
	private Button custom;
	private Text customVal;
	
	public EditFileDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public EditFileDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(FileJoin key,Dict dict)
	{
		this.file=key;
		this.inner=file.isInner();
		this.expression=file.getExpression();
		if (expression==null) expression="";
		
		for (RelationKey rk : dict.getFile(key.getParent().getName()).getRelations()) {			
			if (rk.getOther().getFile().getFile().getName().equalsIgnoreCase(key.getChild().getName())) {
				related=true;
				break;
			}
		}
	}

	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Add/Edit "+file.getParent().getName()+" => "+file.getChild().getName());
		Composite container = (Composite) super.createDialogArea(parent);	
		container.setLayout(new GridLayout(2,false));
		
		Button b = new Button(container,SWT.CHECK);
		b.setText("Inner");
		b.setSelection(inner);
		b.setLayoutData(new GridData(GridData.BEGINNING, GridData.BEGINNING,false,false,2,1));
		b.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				Button b = (Button)e.widget;
				inner=b.getSelection();
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		

		relationship = new Button(container,SWT.RADIO);
		relationship.setText("Relationship");
		relationship.setLayoutData(new GridData(GridData.BEGINNING, GridData.BEGINNING,false,false,2,1));		
		
		custom = new Button(container,SWT.RADIO);
		custom.setText("Custom");
		
		customVal = new Text(container,SWT.NONE);
		customVal.setLayoutData(new GridData(GridData.FILL, GridData.BEGINNING,true,false));
		customVal.setText(expression);		
		
		if (!related) {
			relationship.setEnabled(false);
		} else {
			relation=expression.length()==0;
		}
		refreshRadio();
		
		
		relationship.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {				
				relation=true;
				refreshRadio();
			}
			
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});

		custom.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {				
				relation=false;
				refreshRadio();
			}
			
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		customVal.addModifyListener(new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				refreshRadio();
			}
		});
		
		return container;
	}

	
	private void refreshRadio()
	{
		if (relation) {
			relationship.setSelection(true);
			custom.setSelection(false);
			customVal.setEnabled(false);
		} else {
			relationship.setSelection(false);
			custom.setSelection(true);
			customVal.setEnabled(true);
		}
		Button ok = getButton(OK);
		if (ok!=null) {
			ok.setEnabled(relation || customVal.getText().length()>0);
		}
	}
	
	
	
	@Override
	protected Button createButton(Composite parent, int id, String label,boolean defaultButton) {
		Button result = super.createButton(parent, id, label, defaultButton);
		if (id==OK && !related && expression.length()==0) {
			result.setEnabled(false);
		}
		return result;
	}

	@Override
	protected void okPressed() {
		if (relation) {
			file.clearExpression();
		} else {
			file.setExpression(customVal.getText());
		}
		file.setInner(inner);
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
		return new Point(450, 300);
	}

}
