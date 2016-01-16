package org.jclarion.clarion.ide.editor;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.swt.widgets.TreeItem;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.forms.IManagedForm;
import org.eclipse.ui.forms.editor.FormEditor;
import org.eclipse.ui.forms.editor.FormPage;
import org.eclipse.ui.forms.widgets.FormToolkit;
import org.eclipse.ui.forms.widgets.ScrolledForm;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Color;
import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.File;
import org.jclarion.clarion.appgen.app.FileJoin;
import org.jclarion.clarion.appgen.app.PrimaryFile;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.RelationKey;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.at.AtSourceSession;
import org.jclarion.clarion.appgen.template.cmd.AdditionCodeSection;
import org.jclarion.clarion.appgen.template.cmd.CodeResult;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.RestrictCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateCmd;
import org.jclarion.clarion.appgen.template.cmd.Widget;
import org.jclarion.clarion.ide.dialog.EditFileDialog;
import org.jclarion.clarion.ide.dialog.EditPrimaryFileDialog;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.DirtyProcedureListener;
import org.jclarion.clarion.ide.model.DirtyProcedureMonitor;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.ide.model.app.ProcedureSave;
import org.jclarion.clarion.ide.model.app.ProcedureSaveListener;
import org.jclarion.clarion.ide.model.window.WindowEditorHelper;

public class ProcedureExtensionEditor extends FormPage implements DirtyProcedureListener, ProcedureSaveListener
{
	private Tree available;
	private Composite body;
	private Tree structure;
	private boolean dirty;
	

	public void setDirty() {
		dirty=true;
		getEditor().editorDirtyStateChanged();				
	}

	@Override
	public void doSave(IProgressMonitor monitor) {
		dirty=false;
		super.doSave(monitor);		
	}

	
	
	@Override
	public void dispose()
	{
		super.dispose();
		DirtyProcedureMonitor.get(getDirtyProcedure()).removeListener(this);
		ProcedureSave.get(getProcedureModel().getProcedure()).remove(this);
	}

	public boolean isDirty()
	{
		return dirty;
	}
	
	/**
	 * Create the form page.
	 * @param id
	 * @param title
	 */
	public ProcedureExtensionEditor(String id, String title) {
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
	public ProcedureExtensionEditor(FormEditor editor, String id, String title) {
		super(editor, id, title);
		DirtyProcedureMonitor.get(getDirtyProcedure()).addListener(this);
		ProcedureSave.get(getProcedureModel().getProcedure()).add(this);		
	}

	/**
	 * Create contents of the form.
	 * @param managedForm
	 */
	@Override
	protected void createFormContent(IManagedForm managedForm) {
		
		
		FormToolkit toolkit = managedForm.getToolkit();
		ScrolledForm form = managedForm.getForm();
		form.setText("Extensions");
		Composite body = form.getBody();
		toolkit.decorateFormHeading(form.getForm());
		toolkit.paintBordersFor(body);				
		body.setLayout(new GridLayout(3,false));
		this.body=body;
		
		structure = new Tree(body,SWT.SINGLE);
		structure.setLayoutData(new GridData(GridData.FILL,GridData.FILL,true,true));
		
		loadTree();
		

		structure.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				TreeItem ti[] = ((Tree)e.widget).getSelection();
				available.removeAll();
				if (ti.length==1) {
					refreshAvailable(ti[0]);				
				}
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
			
		});
		
		Canvas buttonGroup = new Canvas(body,SWT.NONE);
		buttonGroup.setLayout(new GridLayout(1,false));

		Button b;

		b = new Button(buttonGroup,SWT.PUSH);
		b.setText("Add");
		b.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		b.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				add();
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		b = new Button(buttonGroup,SWT.PUSH);
		b.setText("Modify");
		b.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		b.addSelectionListener(new SelectionListener() {
			
			@Override
			public void widgetSelected(SelectionEvent e) {
				modify();
			}
			
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});

		b = new Button(buttonGroup,SWT.PUSH);
		b.setText("Delete");		
		b.setLayoutData(new GridData(GridData.FILL,GridData.BEGINNING,true,false));
		b.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				delete();
			}
			
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});

		
		available = new Tree(body,SWT.SINGLE);
		available.setLayoutData(new GridData(GridData.FILL,GridData.FILL,true,true));		
		refreshAvailable(structure.getItem(0));		
	}
	
	private void loadTree() {
		if (structure==null) return;
		structure.removeAll();
		TreeItem base = new TreeItem(structure,SWT.NONE);
		base.setText("Procedure");
		populateTree(base,getDirtyProcedure());
		expandAll(base);
		base.setData(getDirtyProcedure());
		structure.setSelection(base);		
	}



	private void add()
	{
		if (structure.getSelectionCount()==0) return;
		if (available.getSelectionCount()==0) return;
		
		TreeItem item = structure.getSelection()[0];		
		AtSource src = (AtSource)item.getData();
		File f = (File)item.getData("clarion.file");

		TreeItem add_item = available.getSelection()[0];		
		
		if (f!=null && (add_item.getData() instanceof File)) {
			
			EditFileDialog efd = new EditFileDialog();
			
			File new_file = (File)add_item.getData();
			FileJoin fj = f.addChild(new_file,false,"");
			efd.setInfo(fj, getDict());			
			efd.setBlockOnOpen(true);
			if (efd.open()==EditFileDialog.OK) {
				src.meta().setObject("FileDirty",true);				
				setDirty();
				add(item,src,fj.getChild());
			} else {
				fj.delete();
			}
			refresh(item);
			refresh();
			return;
		}
		
		if (add_item.getData() instanceof File) {
			EditPrimaryFileDialog efd = new EditPrimaryFileDialog();
			PrimaryFile pf = new PrimaryFile();
			pf.setName(((File)add_item.getData()).getName());
			efd.setInfo(pf,getDict());
			efd.setBlockOnOpen(true);
			if (efd.open()==EditPrimaryFileDialog.OK) {
				src.meta().setObject("FileDirty",true);
				((Addition)src).setPrimaryFile(pf);
				add(item,src,pf);
				setDirty();
				refresh(item);
				refresh();
			}
			return;			
		}
		
		if (add_item.getData() instanceof TemplateItem) {
			TemplateItem i = (TemplateItem)add_item.getData(); 
			Addition a = new Addition();
			a.setBase(i.template.getFamily(),i.code.getCodeID());
			
			Procedure p = null;
			AtSource scan=src;
			while ( !(scan instanceof Procedure)) {
				scan=scan.getParent();
			}
			p=(Procedure)scan;			
			a.setInstanceID(p.getMaxInstanceID()+1);
			a.setOrderID(a.getInstanceID());
			
			if (src instanceof Addition) {
				((Addition)src).addChild(a);
			}
			p.addAddition(a);			
			
			a.setPrompts(i.code.getDeclaredPrompts());

			ExecutionEnvironment generator = getEnvironment();
			
			AtSourceSession session = generator.getSession(a);		
			session.getCodeSection();		
			AdditionExecutionState state = session. prepareToExecute();			
			for (Widget w : i.code.getWidgets()) {
				w.prime(generator);
			}
			
			// prepare called mainly to make sure construction is good
			session.prepare();
			
			generator.open("control.$$$",ExecutionEnvironment.CREATE);
			i.code.run(generator);
			String content = generator.getBuffer("control.$$$").getBuffer();
			
			// after priming has been completed : copy back newly primed result
			UserSymbolScope ns=new UserSymbolScope(session.getScope(),new AppLoaderScope(),false);
			ns.constrainFields(i.code.getDeclaredPrompts());
			a.setPrompts(ns);
			
			state.finish();
			
			recycleEnvironment(generator);
			
			Procedure proc = getDirtyProcedure();
			proc.setWindow(WindowEditorHelper.mergeInTemplateControls(proc.getWindow(),content,a.getInstanceID()));
			
			
			add(item,a,null);
			setDirty();
			refresh();
			return;
		}
	}
	
	private void add(TreeItem item, AtSource src, File child) {		
		TreeItem file;
		
		if (child instanceof PrimaryFile) {
			file = new TreeItem(item,SWT.NONE,0);
		} else {
			file = new TreeItem(item,SWT.NONE);
		}
		file.setData(src);
		if (child!=null) {
			file.setData("clarion.file",child);
			refresh(file);
		} else {
			file.setText("*** New Addition");
		}
		item.setExpanded(true);
	}
	
	private void delete()
	{
		if (structure.getSelectionCount()==0) return;
		TreeItem item = structure.getSelection()[0];		
		AtSource src = (AtSource)item.getData();
		File f = (File)item.getData("clarion.file");

		MessageBox mb = new MessageBox(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(),
				SWT.ICON_QUESTION+SWT.YES+SWT.NO);
		mb.setText("Delete");
		mb.setMessage("Are you sure you want to delete this?");
		if (mb.open()==SWT.YES) {
			
			
			item.dispose();
			setDirty();
			
			if (f==null) {
				// note the deletion
				@SuppressWarnings("unchecked")
				List<Addition> deleted=(List<Addition>)getDirtyProcedure().meta().getObject("DeletedAdditions");
				if (deleted==null) {
					deleted=new ArrayList<Addition>();
					getDirtyProcedure().meta().setObject("DeletedAdditions",deleted);
				}
				deleted.add((Addition)src);				
				((Addition)src).delete();
				refresh();
				return;
			}
			src.meta().setObject("FileDirty",true);
			
			if (f instanceof PrimaryFile) {
				((Addition)src).setPrimaryFile(null);
				refresh();
				return;
			}
			
			if (f instanceof File) {
				((File)f).getParent().delete();
				refresh();
				return;
			}
		}
	}

	private void modify()
	{
		if (structure.getSelectionCount()==0) return;
		TreeItem item = structure.getSelection()[0];		
		AtSource src = (AtSource)item.getData();
		File f = (File)item.getData("clarion.file");
		
		if (f==null) {
			((ClarionProcedureEditor)getEditor()).prompt(src,new Runnable() { public void run() { refresh(); } } );
			return;
		}
		
		if (f instanceof PrimaryFile) {
			EditPrimaryFileDialog efd = new EditPrimaryFileDialog();
			efd.setInfo((PrimaryFile)f,getDict());
			efd.setBlockOnOpen(true);
			if (efd.open()==EditPrimaryFileDialog.OK) {
				src.meta().setObject("FileDirty",true);
				setDirty();
				refresh(item);
				refresh();
			}
			return;
		}
		
		if (f instanceof File) {
			EditFileDialog efd = new EditFileDialog();
			efd.setInfo(f.getParent(),getDict());
			efd.setBlockOnOpen(true);
			if (efd.open()==EditPrimaryFileDialog.OK) {
				src.meta().setObject("FileDirty",true);
				setDirty();
				refresh(item);
				refresh();
			}
			return;
		}
	}
	
	private Dict getDict()
	{
		return getProcedureModel().getApp().getAppProject().getDict();
	}
	
	private void refresh(TreeItem item) {
		File f = (File)item.getData("clarion.file");
		if (f instanceof PrimaryFile) {
			PrimaryFile pf = (PrimaryFile)f;
			item.setForeground(new Color(null, 80,190,80));
			item.setText(pf.getName()+(pf.getKey()!=null ? " "+pf.getKey() : ""));
			return;
		}
		if (f instanceof File) {
			item.setForeground(new Color(null, 80,190,80));		
			FileJoin fj = f.getParent();
			String expr = fj.getExpression();
			if (expr!=null && expr.length()>0) { 
				expr=" ("+expr+")";
			} else {
				expr="";
			}
			item.setText((fj.isInner() ? "[INNER] " : "") + f.getName()+expr);			
			return;
		}
	}
	
	private void expandAll(Tree base) {
		for (TreeItem scan : base.getItems()) {
			expandAll(scan);
		}		
	}
	
	private void expandAll(TreeItem base) {
		base.setExpanded(true);
		for (TreeItem scan : base.getItems()) {
			expandAll(scan);
		}
	}

	private static class TemplateItem
	{
		private TemplateCmd template;
		private CodeSection code;
		
		public TemplateItem(TemplateCmd template,CodeSection code)
		{
			this.template=template;
			this.code=code;
		}
	}

	private static String[] types = new String[] {"#EXTENSION","#CONTROL" };
	private void refreshAvailable(TreeItem ti)
	{
		AtSource as = (AtSource)ti.getData();
		File file = (File)ti.getData("clarion.file");
		if (file!=null) {
			refreshAvailable(as,file);
			expandAll(available);
			return;
		}
		
		AppProject project = getProcedureModel().getApp().getAppProject();		
		ExecutionEnvironment generator = getEnvironment();
		
		AtSourceSession session = generator.getSession(as);		
		CodeSection baseSection = session.getCodeSection();		
		AdditionExecutionState state = session. prepareToExecute();
		session.prepare();
		
		for (TemplateCmd cmd : project.getChain().getTemplates()) {
			if (!cmd.getFamily().equals(as.getBase().getChain())) continue;
			TreeItem family = null;
			for (String type : types ) {
				for (CodeSection cs : cmd.getSection(type)) {
					AdditionCodeSection ec = (AdditionCodeSection)cs;
					if ((ec.isProcedure() || ec.getRequired()==null) && (!(as instanceof Procedure))) continue;
					if (ec.isWindow() && ((getDirtyProcedure().getWindow()==null || getDirtyProcedure().getWindow().length()==0))) continue;
					if (ec.isReport()) continue;
					if (ec.isApplication()) continue;
					if (!ec.isMulti()) {
						boolean duplicate=false;
						for (AtSource kids : as.getChildren()) {
							if (!kids.getBase().getChain().equals(cmd.getFamily())) continue;
							if (!kids.getBase().getType().equals(ec.getCodeID())) continue;
							duplicate=true;
							break;
						}
						if (duplicate) continue;
					}
					if (ec.getRequired()!=null) {
						
						if (!ec.getRequired().getType().equals(as.getBase().getType())) continue;

						String chain = ec.getRequired().getChain();
						if (chain==null) chain=cmd.getFamily();
						if (!chain.equals(as.getBase().getChain())) continue; 
					}
					
					if (ec.getRestrictions()!=null) {
						boolean restricted=false;
						for (RestrictCmd rc : ec.getRestrictions()) {
							if (rc.getWhere()!=null) {
								if (!generator.eval(rc.getWhere()).boolValue()) continue;
							}
							CodeResult cr = rc.run(generator);
							if (cr.getCode()==CodeResult.CODE_ACCEPT) continue;
							restricted=true;
							break;
						}
						if (restricted) continue;
					}
					
					if (family==null) {
						family=new TreeItem(available,SWT.NONE);
						family.setText(cmd.getDescription());
					}
					TreeItem add = new TreeItem(family,SWT.NONE);
					add.setData(new TemplateItem(cmd,cs));
					add.setText(ec.getDescription());
				}
			}
			if (family!=null) {
				family.setExpanded(true);
			}
		}
		
		if (as.getPrimaryFile()==null) {
			if (baseSection instanceof AdditionCodeSection) {
				AdditionCodeSection test = (AdditionCodeSection)baseSection;
				if (test.isPrimary()) {
					showAllTables("Primary File",null);
				}
			}
			// ERE IS were we would check primary on ProcedureCmd if we needed it
		}
		
		state.finish();
		project.recycleEnvironment(generator);

		expandAll(available);
		body.layout(true);
	}
	

	private void refreshAvailable(AtSource as, File file) 
	{
		// look for related files
		AppProject project = getProcedureModel().getApp().getAppProject();
		Dict d = project.getDict();
		
		org.jclarion.clarion.appgen.dict.File dictFile = d.getFile(file.getName());
		
		Set<String> relations = new HashSet<String>();
		loadFileNames(as.getPrimaryFile(),relations);
		
		
		Map<String,org.jclarion.clarion.appgen.dict.File> relatedTables = new TreeMap<String,org.jclarion.clarion.appgen.dict.File>();  
		
		for (RelationKey scan : dictFile.getRelations()) {	
			String name = scan.getOther().getFile().getFile().getName().toLowerCase();	
			if (relations.contains(name)) continue;
			relations.add(name);
			relatedTables.put(name,scan.getOther().getFile());
		}

		
		if (!relatedTables.isEmpty()) {
			TreeItem base = new TreeItem(available,SWT.NONE);
			base.setText("Related Tables");
			
			for (org.jclarion.clarion.appgen.dict.File scan : relatedTables.values()) {
				TreeItem rel = new TreeItem(base,SWT.NONE);
				rel.setText(scan.getFile().getName());				
				rel.setData(new File(scan.getFile().getName()));
			}
		}
		
		showAllTables("Other Tables",relations);
	}

	private void showAllTables(String dname, Set<String> relations) 
	{
		AppProject project = getProcedureModel().getApp().getAppProject();
		Dict d = project.getDict();
		
		Map<String,org.jclarion.clarion.appgen.dict.File> tables = new TreeMap<String,org.jclarion.clarion.appgen.dict.File>();
		for (org.jclarion.clarion.appgen.dict.File scan : d.getFiles()) {	
			String name = scan.getFile().getName().toLowerCase();
			if (relations!=null) {
				if (relations.contains(name)) continue;
				relations.add(name);
			}
			tables.put(name,scan);
		}	
		
		if (!tables.isEmpty()) {
			TreeItem base = new TreeItem(available,SWT.NONE);
			base.setText(dname);
			
			for (org.jclarion.clarion.appgen.dict.File scan : tables.values()) {
				TreeItem rel = new TreeItem(base,SWT.NONE);
				rel.setData(new File(scan.getFile().getName()));
				rel.setText(scan.getFile().getName());				
			}
		}
		
	}

	private void loadFileNames(File f, Set<String> relations) {
		if (f==null) return;
		relations.add(f.getName().toLowerCase());
		for (FileJoin scan : f.getChildren()) {
			loadFileNames(scan.getChild(),relations);
		}
	}

	private void populateTree(TreeItem parent, AtSource source) 
	{
		AppProject project = getProcedureModel().getApp().getAppProject();
		ExecutionEnvironment generator = getEnvironment();
		populateTree(parent,source,project,generator);
		project.recycleEnvironment(generator);
		
	}
	
	private void refresh() 
	{
		AppProject project = getProcedureModel().getApp().getAppProject();
		ExecutionEnvironment generator = getEnvironment();
		for (TreeItem scan : structure.getItems()) {
			refreshTree(scan,generator);
		}
		project.recycleEnvironment(generator);
		DirtyProcedureMonitor.fire(getDirtyProcedure());
	}

	
	

	private void refreshTree(TreeItem scan, ExecutionEnvironment generator) 
	{
		if (scan.getData() instanceof Addition && scan.getData("clarion.file")==null) {
			AtSource src= (AtSource)scan.getData();
			AtSourceSession session = generator.getSession(src);		
			AdditionCodeSection cs = (AdditionCodeSection)session.getCodeSection();		
			AdditionExecutionState state = session. prepareToExecute();
			session.prepare();
			
			String desc = cs.getDescription();
			if (cs.getDisplayDescription()!=null) {
				desc=  generator.eval(cs.getDisplayDescription()).toString();
			}
			
			if (scan.getText()==null || !desc.equals(scan.getText())) {
				scan.setText(desc);
			}
			
			state.finish();
		}
		
		for (TreeItem child : scan.getItems()) {
			refreshTree(child,generator);
		}		
	}



	private void populateTree(TreeItem parent, AtSource source,AppProject project, ExecutionEnvironment generator) 
	{
		populateFile(parent,source);
		
		
		for (AtSource scan : source.getChildren()) {
			
			AtSourceSession session = generator.getSession(scan);
			if (session==null) {
				System.out.println("Null session for:"+scan);
			}
			AdditionCodeSection cs = (AdditionCodeSection)session.getCodeSection();		
			AdditionExecutionState state = session. prepareToExecute();
			session.prepare();
			
			TreeItem ti = new TreeItem((TreeItem)parent,SWT.NONE);
			
			String desc = cs.getDescription();
			if (cs.getDisplayDescription()!=null) {
				desc=  generator.eval(cs.getDisplayDescription()).toString();
			}
			
			ti.setText(desc);
			ti.setData(scan);
			state.finish();
			
			populateTree(ti,scan,project,generator);			
			
		}		
	}

	private void populateFile(TreeItem parent, AtSource source) {
		PrimaryFile pf=source.getPrimaryFile();
		if (pf==null) return;
		
		TreeItem item = new TreeItem(parent,SWT.NONE);		
		item.setData(source);
		item.setData("clarion.file",pf);
		refresh(item);
		
		for (FileJoin join : pf.getChildren()) {
			populateFile(item,source,join);
		}
	}

	private void populateFile(TreeItem parent,AtSource source,FileJoin join) 
	{
		TreeItem item = new TreeItem(parent,SWT.NONE);
		item.setData(source);
		item.setData("clarion.file",join.getChild());
		refresh(item);
		
		for (FileJoin kid :join.getChild().getChildren()) {
			populateFile(item,source,kid);
		}
	}
	
	public ExecutionEnvironment getEnvironment()
	{
		AppProject project = getProcedureModel().getApp().getAppProject();
		ExecutionEnvironment generator = project.getEnvironment(true);		
		generator.setAlternative(getProcedureModel().getProcedure(),getDirtyProcedure());
		return generator;
	}
	
	public void recycleEnvironment(ExecutionEnvironment env)
	{
		AppProject project = getProcedureModel().getApp().getAppProject();
		project.recycleEnvironment(env);
	}
	
	public Procedure getDirtyProcedure()
	{
		ClarionProcedureEditor editor = (ClarionProcedureEditor)getEditor();
		return editor.getDirtyProcedure();
	}

	public ProcedureModel getProcedureModel()
	{
		ClarionProcedureEditor editor = (ClarionProcedureEditor)getEditor();
		return editor.getModel();
	}

	@Override
	public void procedureChanged() {
		
		if (testIsDirty(getDirtyProcedure())) {
			loadTree();
			setDirty();
		}
	}

	private boolean testIsDirty(AtSource test) 
	{
		if (test.meta().getObject("FileDirty")!=null) return true;
		if (test.meta().getObject("PromptDirty")!=null) return true;
		if (test.meta().getObject("DeletedAdditions")!=null) return true;
		if (test.meta().getObject("Original")==null) return true;
		
		for (AtSource scan : test.getChildren()) {
			if (testIsDirty(scan)) return true;
		}
		return false;
	}

	@Override
	public void procedureSaved() {
		DirtyProcedureMonitor.get(getDirtyProcedure()).addListener(this);		
		loadTree();
	}

	@Override
	public void procedureDeleted() {
	}

}
