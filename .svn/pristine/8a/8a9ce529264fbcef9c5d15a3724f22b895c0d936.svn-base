package org.jclarion.clarion.ide.dialog;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.swt.widgets.TreeItem;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.File;
import org.jclarion.clarion.appgen.app.FileJoin;
import org.jclarion.clarion.appgen.app.PrimaryFile;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.RelationKey;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.DirtyProcedureMonitor;

public class AdditionFileDialog extends Dialog {

	
	private AtSource src;
	private Tree structure;
	private Tree available;
	private AppProject project;
	private Composite body;

	public AdditionFileDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public AdditionFileDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(AppProject project,AtSource src)
	{
		this.project=project;
		this.src=src;
	}

	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Add/Edit Files");
		body = (Composite) super.createDialogArea(parent);	
		body.setLayout(new GridLayout(3,false));
		structure = new Tree(body,SWT.SINGLE);
		structure.setLayoutData(new GridData(GridData.FILL,GridData.FILL,true,true));
		
		loadTree();
		

		structure.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				refreshAvailable();
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
		refreshAvailable(structure.getItemCount()>0 ? structure.getItem(0) : null);		
		return body;
	}
	
	private void add()
	{
		if (structure.getSelectionCount()==0 && structure.getItemCount()>0) return;
		if (available.getSelectionCount()==0) return;
		
		File f=null;
		TreeItem item=null;
		if (structure.getItemCount()>0) {
			item = structure.getSelection()[0];		
			f = (File)item.getData("clarion.file");
		}

		TreeItem add_item = available.getSelection()[0];		
		
		if (f!=null && (add_item.getData() instanceof File)) {
			
			EditFileDialog efd = new EditFileDialog();
			
			File new_file = (File)add_item.getData();
			FileJoin fj = f.addChild(new_file,false,"");
			efd.setInfo(fj, project.getDict());			
			efd.setBlockOnOpen(true);
			if (efd.open()==EditFileDialog.OK) {
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
			efd.setInfo(pf,project.getDict());
			efd.setBlockOnOpen(true);
			if (efd.open()==EditPrimaryFileDialog.OK) {
				((Addition)src).setPrimaryFile(pf);
				add(item,src,pf);
				setDirty();
				refresh();
			}
			return;			
		}		
	}
	
	
	private void add(TreeItem item, AtSource src, File child) {		
		TreeItem file;
		
		if (child instanceof PrimaryFile) {
			file = new TreeItem(structure,SWT.NONE,0);
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
		if (item!=null) {
			item.setExpanded(true);
		}
	}
	
	private void refresh() 
	{
		refreshAvailable();		
	}
	
	private void setDirty()
	{
		src.meta().setObject("FileDirty",true);
		AtSource scan=src;
		while (scan!=null) {
			if (scan instanceof Procedure) {
				DirtyProcedureMonitor.fire((Procedure)scan);
				return;
			}
			scan=scan.getParent();
		}
	}
	
	
	private void delete()
	{
		if (structure.getSelectionCount()==0) return;
		TreeItem item = structure.getSelection()[0];		
		File f = (File)item.getData("clarion.file");

		MessageBox mb = new MessageBox(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(),SWT.ICON_QUESTION+SWT.YES+SWT.NO);
		mb.setText("Delete");
		mb.setMessage("Are you sure you want to delete this?");
		if (mb.open()==SWT.YES) {
			item.dispose();
			setDirty();
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
		File f = (File)item.getData("clarion.file");
		
		if (f instanceof PrimaryFile) {
			EditPrimaryFileDialog efd = new EditPrimaryFileDialog();
			efd.setInfo((PrimaryFile)f,project.getDict());
			efd.setBlockOnOpen(true);
			if (efd.open()==EditPrimaryFileDialog.OK) {
				setDirty();
				refresh(item);
				refresh();
			}
			return;
		}
		
		if (f instanceof File) {
			EditFileDialog efd = new EditFileDialog();
			efd.setInfo(f.getParent(),project.getDict());
			efd.setBlockOnOpen(true);
			if (efd.open()==EditPrimaryFileDialog.OK) {
				setDirty();
				refresh(item);
				refresh();
			}
			return;
		}
	}
	
	
	private void loadTree() {
		if (structure==null) return;
		structure.removeAll();
		if (src.getPrimaryFile()!=null) {
			PrimaryFile pf=src.getPrimaryFile();
			TreeItem item = new TreeItem(structure,SWT.NONE);		
			item.setData("clarion.file",pf);
			refresh(item);
			for (FileJoin join : pf.getChildren()) {
				populateFile(item,join);
			}
		}
	}

	private void populateFile(TreeItem parent,FileJoin join) 
	{
		TreeItem item = new TreeItem(parent,SWT.NONE);
		item.setData("clarion.file",join.getChild());
		refresh(item);
			
		for (FileJoin kid :join.getChild().getChildren()) {
			populateFile(item,kid);
		}
	}
		
	private void refresh(TreeItem item) {
		File f = (File)item.getData("clarion.file");
		if (f instanceof PrimaryFile) {
			PrimaryFile pf = (PrimaryFile)f;
			item.setText(pf.getName()+(pf.getKey()!=null ? " "+pf.getKey() : ""));
			return;
		}
		if (f instanceof File) {
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

	private void showAllTables(String dname, Set<String> relations) 
	{
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
	
	private void layout()
	{
		body.layout(true);		
	}
	
	private void refreshAvailable()
	{
		TreeItem ti[] = structure.getSelection();
		available.removeAll();
		if (ti.length==1) {
			refreshAvailable(ti[0]);				
		} else if (structure.getItemCount()==0) {
			refreshAvailable(null);
		}
	}
	
	private void refreshAvailable(TreeItem ti)
	{
		if (ti==null) {
			showAllTables("Primary File",null);
			expandAll(available);
			layout();
			return;
		}
		
		// look for related files
		File file = (File)ti.getData("clarion.file");
		Dict d = project.getDict();
		
		org.jclarion.clarion.appgen.dict.File dictFile = d.getFile(file.getName());
		
		Set<String> relations = new HashSet<String>();
		loadFileNames(src.getPrimaryFile(),relations);
		
		
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
		
		expandAll(available);
		layout();		
	}

	private void loadFileNames(File f, Set<String> relations) {
		if (f==null) return;
		relations.add(f.getName().toLowerCase());
		for (FileJoin scan : f.getChildren()) {
			loadFileNames(scan.getChild(),relations);
		}
	}
	
	
	/**
	 * Create contents of the button bar.
	 * @param parent
	 */
	@Override
	protected void createButtonsForButtonBar(Composite parent) {
		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL,true);
	}

	/**
	 * Return the initial size of the dialog.
	 */
	@Override
	protected Point getInitialSize() {
		return new Point(500, 500);
	}

}
