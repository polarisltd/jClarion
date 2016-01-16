package org.jclarion.clarion.ide.dialog;


import java.util.Set;
import java.util.TreeSet;

import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.jface.viewers.ArrayContentProvider;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.jface.viewers.TableViewer;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.jface.viewers.ViewerFilter;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.Procedure;

public class FindProcedureDialog extends Dialog {

	private App base;
	private String filter="";
	private TableViewer viewer;
	private String result;
	
	
	public FindProcedureDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
		
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public FindProcedureDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(App base)
	{
		this.base=base;
	}
	
	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Find Procedure");
		Composite container = (Composite) super.createDialogArea(parent);		
		container.setLayout(new GridLayout(1,false));
		
		Text text = new Text(container,SWT.BORDER);
		text.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		text.addModifyListener(new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				filter=((Text)e.widget).getText().trim().toLowerCase();
				viewer.refresh();
			}
		});
		
		viewer = new TableViewer(container,SWT.BORDER);
		viewer.getTable().setLayoutData(new GridData(GridData.FILL,GridData.FILL,true,true));
		
		viewer.addFilter(new ViewerFilter() {
			@Override
			public boolean select(Viewer viewer, Object parentElement,Object element) {
				if (filter.length()==0) return true;
				return element.toString().toLowerCase().contains(filter);
			}
		});		

		Set<String> procs=new TreeSet<String>();
		for (Procedure p  : base.getProcedures()) {
			procs.add(p.getName());
		}
		viewer.setContentProvider(ArrayContentProvider.getInstance());
		viewer.setInput(procs.toArray());
		
		return container;
	}

	@Override
	protected void okPressed() 
	{	
		if (!(viewer.getSelection() instanceof StructuredSelection)) return;
 		StructuredSelection ss = (StructuredSelection)viewer.getSelection();
 		if (ss.size()==0) return;
 		result =ss.getFirstElement().toString();
		super.okPressed();
	}
	
	public String getResult()
	{
		return result;
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
		return new Point(350, 450);
	}

}
