package org.jclarion.clarion.ide.editor;

import java.util.Collection;
import java.util.TreeSet;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.forms.IManagedForm;
import org.eclipse.ui.forms.editor.FormEditor;
import org.eclipse.ui.forms.editor.FormPage;
import org.eclipse.ui.forms.widgets.FormToolkit;
import org.eclipse.ui.forms.widgets.ScrolledForm;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.jclarion.clarion.appgen.dict.File;
import org.jclarion.clarion.ide.model.ClarionProcedureInput;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class OtherFileEditor extends FormPage {

	private boolean dirty;
	private Table list;
	private Table calls;
	private Text filter;
	private Button move;
	private TreeSet<String> files;
	
	@Override
	public void doSave(IProgressMonitor monitor) {
		if (files==null) return;
		if (dirty) {
			dirty=false;
			getProcedure().getProcedure().getOtherFiles().clear();
			getProcedure().getProcedure().getOtherFiles().addAll(files);
		}
		
	}	
	
	/**
	 * Create the form page.
	 * @param id
	 * @param title
	 */
	public OtherFileEditor(String id, String title) {
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
	public OtherFileEditor(FormEditor editor, String id, String title) {
		super(editor, id, title);
	}

	/**
	 * Create contents of the form.
	 * @param managedForm
	 */
	@Override
	protected void createFormContent(IManagedForm managedForm) {
		FormToolkit toolkit = managedForm.getToolkit();
		ScrolledForm form = managedForm.getForm();
		form.setText("Other Files");
		Composite body = form.getBody();
		toolkit.decorateFormHeading(form.getForm());
		toolkit.paintBordersFor(body);				
		body.setLayout(new GridLayout(3,false));
		
		filter = new Text(body,SWT.NONE);
		GridData gd = new GridData();
		gd.horizontalSpan=3;
		filter.setLayoutData(gd);
		filter.addModifyListener(new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				loadList(((Text)e.widget).getText());
			}
		});
		
		list = new Table(body,SWT.SINGLE);
		list.setLayoutData(new GridData(GridData.FILL, GridData.FILL,true,true));
		loadList("");
				
		move = new Button(body,SWT.PUSH);
		move.setText(">>>");
		move.addSelectionListener(new SelectionListener() {

			@Override
			public void widgetSelected(SelectionEvent e) 
			{
				move();
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) 
			{
			}
			
		});
		
		calls = new Table(body,SWT.SINGLE);
		calls.setLayoutData(new GridData(GridData.FILL, GridData.FILL,true,true));
		files = new TreeSet<String>();
		for (String s : getProcedure().getProcedure().getOtherFiles()) {
			files.add(s);			
		}
		refreshCalls();
		
		calls.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				if (calls.getSelectionCount()>0) {
					list.deselectAll();
					move.setText("<<<");
				}
			}
			
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		list.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				if (list.getSelectionCount()>0) {
					calls.deselectAll();
					move.setText(">>>");
				}
			}
			
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		list.addMouseListener(new MouseListener() {
			@Override
			public void mouseDoubleClick(MouseEvent e) {
				move();
			}

			@Override
			public void mouseDown(MouseEvent e) {
			}

			@Override
			public void mouseUp(MouseEvent e) {
			}
			
		});
		
		calls.addMouseListener(new MouseListener() {
			@Override
			public void mouseDoubleClick(MouseEvent e) {
				move();
			}

			@Override
			public void mouseDown(MouseEvent e) {
			}

			@Override
			public void mouseUp(MouseEvent e) {
			}
			
		});
		
	}
	
	private void move()
	{
		int ofs= calls.getSelectionIndex();
		if (ofs>-1) {
			files.remove(calls.getItem(ofs).getText());
		}
		
		ofs = list.getSelectionIndex();
		if (ofs>-1) {
			files.add(list.getItem(ofs).getText());
		}
		
		refreshCalls();
		dirty=true;
		getEditor().editorDirtyStateChanged();				
	}
	
	public boolean isDirty()
	{
		return dirty;
	}
	
	private void refreshCalls() {
		calls.removeAll();
		loadTable(calls,files);
	}

	private void loadList(String string) {
		string=string.toLowerCase();
		TreeSet<String> files = new TreeSet<String>();
	
		for (File f : getProcedure().getApp().getAppProject().getDict().getFiles()) {
			
			String name = f.getFile().getName();
			if (string.length()==0 || name.toLowerCase().indexOf(string)>-1) {
				files.add(name);
			}
		}
		list.setRedraw(false);
		list.removeAll();
		loadTable(list,files);
		list.setRedraw(true);
		list.redraw();
	}

	private void loadTable(Table list, Collection<String> procedures) {
		for (String name : procedures) {
			TableItem ti = new TableItem(list,SWT.NONE);
			ti.setText(name);
		}
	}

	public ProcedureModel getProcedure()
	{
		ClarionProcedureInput input = (ClarionProcedureInput)getEditorInput();
		return input.getModel();
	}

}
