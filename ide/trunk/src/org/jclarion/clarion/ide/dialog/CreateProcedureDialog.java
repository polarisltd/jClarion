package org.jclarion.clarion.ide.dialog;

import java.io.IOException;
import java.io.StringReader;

import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableColumn;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.AppLoader;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.at.AtSourceSession;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.ProcedureCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateCmd;
import org.jclarion.clarion.appgen.template.cmd.Widget;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class CreateProcedureDialog extends Dialog {

	private ProcedureModel base;
	private ProcedureCmd   procedure;
	private TemplateCmd	   template;

	public CreateProcedureDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public CreateProcedureDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(ProcedureModel base)
	{
		this.base=base;
	}

	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Create Procedure");
		Composite container = (Composite) super.createDialogArea(parent);		
		container.setLayout(new GridLayout(1,false));
		Table t=  new Table(container,SWT.BORDER);
		t.setLayoutData(new GridData(GridData.FILL,GridData.FILL,true,true));
		t.setHeaderVisible(true);
		t.setLinesVisible(true);
		TableColumn tc;
		tc=new TableColumn(t,SWT.NONE);
		tc.setText("Name");
		tc=new TableColumn(t,SWT.NONE);
		tc.setText("Family");
		tc=new TableColumn(t,SWT.NONE);
		tc.setText("Description");
		
		TemplateChain chain = base.getApp().getAppProject().getChain();
		for (TemplateCmd templates : chain.getTemplates()) {
			for (CodeSection cs : templates.getSection("#PROCEDURE")) {
				ProcedureCmd pc = (ProcedureCmd)cs;
				TableItem ti = new TableItem(t,SWT.NONE);
				ti.setText(0,pc.getName());
				ti.setText(1,templates.getName());
				ti.setText(2,pc.getDescription());
				ti.setData("Procedure", pc);
				ti.setData("Template",templates);
			}
		}
		
		t.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				procedure = (ProcedureCmd)e.item.getData("Procedure");
				template = (TemplateCmd)e.item.getData("Template");
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
			
		});
		
		for (TableColumn scan : t.getColumns()) {
			scan.pack();
		}
		
		return container;
	}

	
	@Override
	protected void okPressed() 
	{
		if (procedure==null || template==null) return;
		
		// first find a new module name
		App a = base.getApp().getAppProject().getApp();
		Module m = base.getApp().getAppProject().createNewModule(base.getName(),template.getFamily());
		
		Procedure p=null;
		
		if (procedure.getDefault()!=null) {
			AppLoader al = new AppLoader();
			al.setLoader(new StringReader("[PROCEDURE]\n"+procedure.getDefault()));
			try {
				p=al.loadProcedure();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (p==null) {
			p=new Procedure();
		}
		p.setName(base.getName());
		p.setBase(template.getName(),procedure.getName());

		ExecutionEnvironment ee = base.getApp().getAppProject().getEnvironment(true);
		
		m.addProcedure(p);
		a.addModule(m);
		
		// prep prompts
		declarePrompt(base.getApp().getAppProject().getChain(),p);				
		ee.recycle();
		ee.getAppSource().deleteChildren();
		initPrompt(ee,p);
		base.getApp().getAppProject().recycleEnvironment(ee);
		base.save(p,null);
		
		super.okPressed();
	}

	private void declarePrompt(TemplateChain chain,AtSource src)
	{
		CodeSection cs = chain.getSection(src.getTemplateType(), src.getBase(),false);
		if (src.getPrompts()==null) {
			src.setPrompts(cs.getDeclaredPrompts());
		} else{
			cs.declare(src.getPrompts());
		}
		
		for (AtSource kid : src.getChildren()) {
			declarePrompt(chain,kid);
		}		
	}
	
	private void initPrompt(ExecutionEnvironment ee, AtSource src) 
	{
		AtSourceSession session = ee.getSession(src);
		CodeSection cs = session.getCodeSection();
		AdditionExecutionState state = session. prepareToExecute();
		for (Widget w : cs.getWidgets()) {
			w.prime(ee);
		}		
		session.prepare();		
		UserSymbolScope ns=new UserSymbolScope(session.getScope(),new AppLoaderScope(),false);
		ns.constrainFields(cs.getDeclaredPrompts());
		src.setPrompts(ns);
		state.finish();

		for (AtSource kid : src.getChildren()) {
			initPrompt(ee,kid);
		}
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
