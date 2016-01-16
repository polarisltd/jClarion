package org.jclarion.clarion.ide.editor;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.forms.IManagedForm;
import org.eclipse.ui.forms.editor.FormEditor;
import org.eclipse.ui.forms.editor.FormPage;
import org.eclipse.ui.forms.widgets.FormToolkit;
import org.eclipse.ui.forms.widgets.ScrolledForm;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Text;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.model.ClarionProcedureInput;
import org.jclarion.clarion.ide.model.ClarionToJavaInput;

public class ProcedureForm extends FormPage {
	private Text procedure;
	private Text category;
	private Text description;
	private Text prototype;

	/**
	 * Create the form page.
	 * @param id
	 * @param title
	 */
	public ProcedureForm(String id, String title) {
		super(id, title);
	}

	/**
	 * Create the form page.
	 * @param editor
	 * @param id
	 * @param title
	 * @wbp.parser.constructor
	 * @wbp.eval.method.parameter id "Some id"
	 * @wbp.eval.method.parameter title "Some title"
	 */
	public ProcedureForm(FormEditor editor, String id, String title) {
		super(editor, id, title);
	}

	/**
	 * Create contents of the form.
	 * @param managedForm
	 */
	@Override
	protected void createFormContent(final IManagedForm managedForm) {
		
		
		FormToolkit toolkit = managedForm.getToolkit();
		ScrolledForm form = managedForm.getForm();
		form.setText("Procedure Properties");
		Composite body = form.getBody();
		toolkit.decorateFormHeading(form.getForm());
		toolkit.paintBordersFor(body);
		GridLayout gl = new GridLayout(2,false);
		gl.verticalSpacing=10;
		body.setLayout(gl);
		
		
		Canvas left = new Canvas(body,SWT.NO_BACKGROUND);
		Canvas right = new Canvas(body,SWT.NO_BACKGROUND);
		
		
		gl = new GridLayout(2,false);		
		left.setLayout(gl);
		left.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		
		gl = new GridLayout(2,false);
		right.setLayoutData(new GridData(GridData.BEGINNING,GridData.BEGINNING,true,false));
		right.setLayout(gl);
				
		body=left;
		
		Label lblNewLabel = new Label(body, SWT.NONE);
		managedForm.getToolkit().adapt(lblNewLabel, true, true);
		lblNewLabel.setText("Procedure Name");

		procedure = new Text(body, SWT.BORDER);
		procedure.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		managedForm.getToolkit().adapt(procedure, true, true);
		
		Label label = new Label(body, SWT.NONE);
		label.setText("Template");
		
		Label template = new Label(body, SWT.NONE);
		managedForm.getToolkit().adapt(template, true, true);
		template.setText("New Label");		
		
		Label lblNewLabel_1 = new Label(body, SWT.NONE);
		managedForm.getToolkit().adapt(lblNewLabel_1, true, true);
		lblNewLabel_1.setText("Category");
		
		category = new Text(body, SWT.BORDER);
		category.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		managedForm.getToolkit().adapt(category, true, true);
		
		Label lblNewLabel_2 = new Label(body, SWT.NONE);
		managedForm.getToolkit().adapt(lblNewLabel_2, true, true);
		lblNewLabel_2.setText("Description");
		
		description = new Text(body, SWT.BORDER);
		description.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		managedForm.getToolkit().adapt(description, true, true);
		
		Label lblPrototype = new Label(body, SWT.NONE);
		lblPrototype.setText("Prototype");
		managedForm.getToolkit().adapt(lblPrototype, true, true);
		
		prototype = new Text(body, SWT.BORDER);
		prototype.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		managedForm.getToolkit().adapt(prototype, true, true);
		
		Button window = new Button(right,SWT.PUSH);
		window.setText("Window");
		window.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				
				IWorkbench workbench = PlatformUI.getWorkbench();
				IWorkbenchPage page = workbench.getActiveWorkbenchWindow().getActivePage();				
				ClarionToJavaInput input = new ClarionToJavaInput((ClarionProcedureEditor)getEditor());				
				try {
					page.openEditor(input,"org.jclarion.clarion.ide.editor.ClarionToJavaEditor");
				} catch (PartInitException e1) {
					e1.printStackTrace();
				}
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
				// TODO Auto-generated method stub
				
			}
			
		});

		Button winsrc = new Button(right,SWT.PUSH);
		winsrc.setText("...");
		winsrc.addSelectionListener(new SelectionListener() {

			@Override
			public void widgetSelected(SelectionEvent e) {
				IWorkbench workbench = PlatformUI.getWorkbench();
				try {
					workbench.getActiveWorkbenchWindow().getActivePage().openEditor(
						new ClarionToJavaInput((ClarionProcedureEditor)getEditor()),
						"org.jclarion.clarion.ide.editor.ClarionIncEditor");
				} catch (PartInitException e1) {
					e1.printStackTrace();
				}				
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
			
		});

		Button actions = new Button(right,SWT.PUSH);
		actions.setText("Actions");
		actions.setLayoutData(new GridData(GridData.BEGINNING,GridData.BEGINNING,false,false,2,1));
		actions.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				ClarionProcedureEditor editor = (ClarionProcedureEditor)getEditor();
				editor.prompt(editor.getDirtyProcedure(),null);
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		
		Procedure procedure = getProcedure();
		this.procedure.setText(procedure.getName());
		if (procedure.getDescription()!=null) {
			this.description.setText(procedure.getDescription());
		}
		if (procedure.getCategory()!=null) {
			this.category.setText(procedure.getCategory());
		}
		if (procedure.getPrototype()!=null) {
			this.prototype.setText(procedure.getPrototype());
		}
		if (procedure.getBase()!=null) {
			template.setText(procedure.getBase().toString());
		}
		
		ModifyListener listener = new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				getEditor().editorDirtyStateChanged();
			}
			
		};
		
		this.description.addModifyListener(listener);
		this.category.addModifyListener(listener);
		this.prototype.addModifyListener(listener);
		this.procedure.addModifyListener(listener);
	}
	
	public Procedure getDirtyProcedure()
	{
		ClarionProcedureEditor editor = (ClarionProcedureEditor)getEditor();
		return editor.getDirtyProcedure();
	}	
	
	private Procedure getProcedure()
	{
		return ((ClarionProcedureInput)getEditorInput()).getModel().getProcedure();
	}

	@Override
	public boolean isDirty()
	{
		if (isChanged(getProcedure().getName(),procedure)) return true;
		if (isChanged(getProcedure().getDescription(),description)) return true;
		if (isChanged(getProcedure().getPrototype(),prototype)) return true;
		if (isChanged(getProcedure().getCategory(),category)) return true;
		return false;
	}
	
	

	@Override
	public void doSave(IProgressMonitor monitor) {
		if (procedure==null) return;
		Procedure p = getProcedure();
		p.setName(n(procedure.getText()));
		p.setDescription(n(description.getText()));
		p.setPrototype(n(prototype.getText()));
		p.setCategory(n(category.getText()));	
	}
	
	private String n(String in)
	{
		if (in.trim().length()==0) return null;
		return in;
	}

	private boolean isChanged(String val, Text txt) 
	{
		if (txt==null) return false;
		if (val==null) val="";
		String v2 = txt.getText();
		if (v2==null) v2="";
		return !v2.equals(val);
	}
}
