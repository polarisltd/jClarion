package org.jclarion.clarion.ide.editor;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.swt.widgets.TreeColumn;
import org.eclipse.swt.widgets.TreeItem;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.actions.ActionFactory;
import org.eclipse.ui.forms.IManagedForm;
import org.eclipse.ui.forms.editor.FormEditor;
import org.eclipse.ui.forms.editor.FormPage;
import org.eclipse.ui.forms.widgets.FormToolkit;
import org.eclipse.ui.forms.widgets.ScrolledForm;
import org.eclipse.ui.handlers.IHandlerActivation;
import org.eclipse.ui.handlers.IHandlerService;
import org.eclipse.swt.dnd.Clipboard;
import org.eclipse.swt.dnd.DND;
import org.eclipse.swt.dnd.DragSource;
import org.eclipse.swt.dnd.DragSourceEvent;
import org.eclipse.swt.dnd.DragSourceListener;
import org.eclipse.swt.dnd.DropTarget;
import org.eclipse.swt.dnd.DropTargetEvent;
import org.eclipse.swt.dnd.DropTargetListener;
import org.eclipse.swt.dnd.TextTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.KeyListener;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.SWT;
import org.jclarion.clarion.appgen.app.AbstractFieldStore;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FieldStore;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.dialog.EditFieldDialog;
import org.jclarion.clarion.ide.dialog.EditPrimaryFileDialog;
import org.jclarion.clarion.ide.model.ClarionProcedureInput;
import org.jclarion.clarion.ide.model.DirtyProcedureMonitor;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.ide.model.fieldops.AbstractOp;
import org.jclarion.clarion.ide.model.fieldops.AddOp;
import org.jclarion.clarion.ide.model.fieldops.DeleteOp;
import org.jclarion.clarion.ide.model.fieldops.ModifyOp;
import org.jclarion.clarion.ide.model.fieldops.MoveOp;
import org.jclarion.clarion.ide.model.fieldops.MultiOp;

public class FieldEditor extends FormPage {

	private static class FieldGroup 
	{
		private String name;
		private FieldStore target;
		private boolean 	updateDirtyProcedure;
		private FieldStore data;
		private List<AbstractOp> ops;
		private boolean dirty;
	}
	
	List<FieldGroup> groups = new ArrayList<FieldGroup>();
	
	private boolean dirty;

	private Tree tree;

	private Clipboard clipboard;
	
	
	/**
	 * Dirty hack to track if drag/drop container are same.  Ideally this should be serialized into drag/drop transfer object.
	 */
	private Field dragOriginField;
	private TreeItem  dragOriginItem;
	
	@Override
	public boolean isDirty() {
		return dirty;
	}
	
	
	
	@Override
	public void init(IEditorSite site, IEditorInput input) 
	{
		super.init(site, input);
		clipboard = new Clipboard(getSite().getShell().getDisplay());
	}
	
	@Override
	public void setActive(boolean active) {
		super.setActive(active);
		if (active) {
			register(ActionFactory.COPY,new Runnable() { public void run() { copy(); } });
			register(ActionFactory.CUT,new Runnable() { public void run() { cut(); } });
			register(ActionFactory.PASTE,new Runnable() { public void run() { paste(); } });			
		} else {
			IHandlerService handlerService = (IHandlerService) getSite().getService(IHandlerService.class);		
			for (IHandlerActivation ah : handlers) {
				handlerService.deactivateHandler(ah);
			}
		}
	}



	@Override
	public void dispose() {
		clipboard.dispose();
		super.dispose();
	}

	
	private List<IHandlerActivation> handlers=new ArrayList<IHandlerActivation>();


	private void register(ActionFactory event, final Runnable runnable) 
	{
		IHandlerService handlerService = (IHandlerService) getSite().getService(IHandlerService.class);		
		AbstractHandler ah = new AbstractHandler() {
			
			@Override
			public boolean isEnabled()
			{
				return isActive();
			}

			@Override
			public Object execute(ExecutionEvent event) throws ExecutionException 
			{
				runnable.run();
				return null;
			}
		};
		
		handlers.add(handlerService.activateHandler(event.getCommandId(),ah));
	}
	
	
	@Override
	public void doSave(IProgressMonitor monitor) {
		
		for (FieldGroup fg : groups) {
			if (fg.dirty) {
				for (AbstractOp op : fg.ops) {
					op.apply(fg.target);
				}
				fg.data=new AbstractFieldStore(fg.target);
				fg.ops=null;
				fg.dirty=false;
			}
		}
		if (dirty) {
			dirty=false;
			loadTree();
		}
	}	
	
	/**
	 * Create the form page.
	 * @param id
	 * @param title
	 */
	public FieldEditor(String id, String title) {
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
	public FieldEditor(FormEditor editor, String id, String title) {
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
		form.setText("Fields");
		Composite body = form.getBody();
		toolkit.decorateFormHeading(form.getForm());
		toolkit.paintBordersFor(body);				
		body.setLayout(new GridLayout(1,false));
				
		tree = new Tree(body,SWT.NONE);
		tree.setLayoutData(new GridData(GridData.FILL,GridData.FILL,true,true));		
		tree.setHeaderVisible(true);
		tree.setLinesVisible (true);		
		TreeColumn tc = new TreeColumn(tree,SWT.NONE);
		tc.setText("Label");
		tc = new TreeColumn(tree,SWT.NONE);
		tc.setText("Type");
		tc = new TreeColumn(tree,SWT.NONE);
		tc.setText("Init");
		tc = new TreeColumn(tree,SWT.NONE);
		tc.setText("Description");
		
		ProcedureModel pm  =getProcedure();
		addGroup("Local Variables",pm.getProcedure(),true);
		addGroup("Module Variables",(Module)pm.getProcedure().getParent(),false);
		addGroup("Application Variables",pm.getApp().getApp().getProgram(),false);
		
		loadTree();
		
		Canvas buttonGroup = new Canvas(body,SWT.NONE);
		buttonGroup.setLayout(new RowLayout());
		
		addButton(buttonGroup,"Add",new Runnable() { public void run(){ add(); } });
		addButton(buttonGroup,"Modify",new Runnable() { public void run(){ modify(); } });
		addButton(buttonGroup,"Delete",new Runnable() { public void run(){ delete(); } });
		addButton(buttonGroup,SWT.ARROW|SWT.UP,new Runnable() { public void run(){ move(-1); } });
		addButton(buttonGroup,SWT.ARROW|SWT.DOWN,new Runnable() { public void run(){ move(1); } });
		addButton(buttonGroup,"Cut",new Runnable() { public void run(){ cut(); } });
		addButton(buttonGroup,"Copy",new Runnable() { public void run(){ copy(); } });
		addButton(buttonGroup,"Paste",new Runnable() { public void run(){ paste(); } });
		
		tree.addMouseListener(new MouseListener() {
			@Override
			public void mouseDoubleClick(MouseEvent e) {
				if (tree.getSelectionCount()==0) return;
				TreeItem ti = tree.getSelection()[0];
				if (ti.getData() instanceof Field) {
					modify();
					return;
				}
				if (ti.getData() instanceof FieldGroup) {
					add();
					return;
				}
			}

			@Override
			public void mouseDown(MouseEvent e) {
			}

			@Override
			public void mouseUp(MouseEvent e) {
			}
		});
		
		
		tree.addKeyListener(new KeyListener() {
			@Override
			public void keyReleased(KeyEvent e) {
			}
			
			@Override
			public void keyPressed(KeyEvent e) {
				if (e.keyCode==SWT.CR) {
					e.doit=false;
					modify();
				}
				
				if (e.keyCode==SWT.INSERT) {
					e.doit=false;
					add();
				}

				if (e.keyCode==SWT.DEL) {
					e.doit=false;
					delete();
				}
				
				if (e.keyCode==SWT.ARROW_UP && e.stateMask==SWT.CTRL) {
					e.doit=false;
					move(-1);					
				}

				if (e.keyCode==SWT.ARROW_DOWN && e.stateMask==SWT.CTRL) {
					e.doit=false;
					move(1);					
				}
			}
		});
		
		
		DragSource source = new DragSource(tree,  DND.DROP_MOVE | DND.DROP_COPY);
		Transfer[] types = new Transfer[] {FieldTransfer.getInstance()};
		source.setTransfer(types);
		source.addDragListener(new DragSourceListener() {

			@Override
			public void dragStart(DragSourceEvent event) {
				if (tree.getSelectionCount()==0) {
					event.doit=false;
					return;
				}
				TreeItem ti = tree.getSelection()[0];
				if (!(ti.getData() instanceof Field)) {
					event.doit=false;
					return;
				}
				dragOriginField=(Field)ti.getData();
				dragOriginItem=ti;
			}

			@Override
			public void dragSetData(DragSourceEvent event) 
			{
				event.data=dragOriginField;
			}

			@Override
			public void dragFinished(DragSourceEvent event) 
			{
				dragOriginField=null;
				dragOriginItem=null;
			}
			
		});
		
		
		DropTarget target = new DropTarget(tree, DND.DROP_MOVE | DND.DROP_COPY|DND.DROP_DEFAULT);
		target.setTransfer(types);
		target.addDropListener(new DropTargetListener() {
			@Override
			public void dragEnter(DropTargetEvent event) {
				test(event);				
			}

			@Override
			public void dragLeave(DropTargetEvent event) {
			}

			private void test(DropTargetEvent event) 
			{				
				TreeItem ti = (TreeItem)event.item;
				if (ti==null) {
					event.detail = DND.DROP_NONE;
					return;
				}
				
				TreeItem scan = ti;
				while (scan!=null) {
					if (scan==dragOriginItem) {
						event.detail = DND.DROP_NONE;
						return;						
					}
					scan=scan.getParentItem();
				}
				
				event.feedback= DND.FEEDBACK_INSERT_AFTER;
			}

			@Override
			public void dragOperationChanged(DropTargetEvent event) {
			}

			@Override
			public void dragOver(DropTargetEvent event) {
				test(event);
			}

			@Override
			public void drop(DropTargetEvent event) {
				if (dragOriginItem!=null && event.detail==DND.DROP_MOVE) {
					addOp(dragOriginItem,new DeleteOp(dragOriginField));
				}
				paste((TreeItem)event.item,(Field)event.data);
			}

			@Override
			public void dropAccept(DropTargetEvent event) {
			}
			
		});
		
	}
	
	private FieldStore getStore(TreeItem ti)
	{
		ti=ti.getParentItem();
		if (ti==null) return null;
		Object d = ti.getData();
		if (d instanceof FieldGroup) {
			return ((FieldGroup)d).data;
		}
		return (FieldStore)d;
	}
	
	public FieldGroup getGroup(TreeItem ti)
	{
		while ( ti!=null ) {
			if (ti.getData() instanceof FieldGroup) {
				return (FieldGroup)ti.getData();
			}
			ti=ti.getParentItem();
		}
		return null;
	}
	
	public void cut()
	{
		copy();
		if (tree.getSelectionCount()==0) return;
		TreeItem ti = tree.getSelection()[0];
		if (!(ti.getData() instanceof Field)) return;
		addOp(ti,new DeleteOp((Field)ti.getData()));		
	}

	public void copy()
	{
		if (tree.getSelectionCount()==0) return;
		TreeItem ti = tree.getSelection()[0];
		if (!(ti.getData() instanceof Field)) return;
		Field f = (Field)ti.getData();
		TextTransfer tt = TextTransfer.getInstance();	
		FieldTransfer et = FieldTransfer.getInstance();
		clipboard.setContents(new Object[] { f,FieldTransfer.encode(f) } ,new Transfer[] { et,tt });
	}

	public void paste()
	{
		FieldTransfer et = FieldTransfer.getInstance();
		Field data = (Field)clipboard.getContents(et);		
		if (data==null) return;				
		if (tree.getSelectionCount()==0) return;
		TreeItem ti = tree.getSelection()[0];
		
		paste(ti,data);
	}
	
	public void paste(TreeItem ti,Field data)
	{
		if (ti==null || data==null) return;
		FieldStore base = null;
		if (ti.getData() instanceof Field) {
			base=(Field)ti.getData();
		} else {
			base = ((FieldGroup)ti.getData()).data;
		}
		
		int ofs=0;
		if (base instanceof Field) {
			Field test = (Field)base;
			if (!canContainChildren(test)) {
				base=test.getParent();
				ofs = base.getOffset(test)+1;
			}
		}
		
		int inc=0;
		while (base.getField(data.getLabel())!=null) {
			inc++;
			String lab = data.getLabel();
			
			int end=lab.length();
			boolean num=false;
			while (end>0) {
				char c = lab.charAt(end-1);
				if (c>='0' && c<='9') {
					num=true;
					end--;
					continue;
				}
				if (c==':' && num && end>0) {
					lab=lab.substring(0,end-1);
				}
				break;
			}
			lab=lab+":"+inc;
			
			data.getDefinition().setName(lab);
		}
		
		
		MultiOp op = new MultiOp();
		op.add(new AddOp(base,data,ofs));
		pasteDeep(op,AbstractOp.getPath(base),data);
		addOp(ti,op);
	}
	
	
	private void pasteDeep(MultiOp target, String path[],Field data) {
		String newpath[]=null;
		for (Field child : data.getFields()) {
			
			if (newpath==null) {
				newpath=new String[path.length+1];
				System.arraycopy(path,0,newpath,0,path.length);
				newpath[path.length]=data.getLabel();
			}
			target.add(new AddOp(newpath,child));
			pasteDeep(target,newpath,child);
		}
	}


	private void delete()
	{
		if (tree.getSelectionCount()==0) return;
		TreeItem ti = tree.getSelection()[0];
		if (!(ti.getData() instanceof Field)) return;
		MessageBox mb = new MessageBox(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(),SWT.ICON_QUESTION+SWT.YES+SWT.NO);
		mb.setText("Delete");
		mb.setMessage("Are you sure you want to delete this?");
		if (mb.open()!=SWT.YES) return;
		
		addOp(ti,new DeleteOp((Field)ti.getData()));		
	}
	
	
	private void add()
	{
		if (tree.getSelectionCount()==0) return;
		TreeItem ti = tree.getSelection()[0];
		FieldStore base = null;
		if (ti.getData() instanceof Field) {
			base=(Field)ti.getData();
		} else {
			base = ((FieldGroup)ti.getData()).data;
		}
		EditFieldDialog efd = new EditFieldDialog();
		efd.setInfo(null,base);
		efd.setBlockOnOpen(true);
		if (efd.open()==EditPrimaryFileDialog.OK) {
			int ofs=0;
			if (base instanceof Field) {
				Field test = (Field)base;
				if (!canContainChildren(test)) {
					base=test.getParent();
					ofs = base.getOffset(test)+1;
				}
			}
			addOp(ti,new AddOp(base,efd.getResult(),ofs));
		}
		return;			
	}
	
	private boolean canContainChildren(Field base)
	{
		String type = base.getDefinition().getTypeName();
		return type.equalsIgnoreCase("GROUP") || type.equalsIgnoreCase("CLASS") || type.equalsIgnoreCase("QUEUE");
	}
	
	private void move(int offset)
	{
		if (tree.getSelectionCount()==0) return;
		TreeItem ti = tree.getSelection()[0];
		if (!(ti.getData() instanceof Field)) return;

		FieldStore target=null;
		int position=-1;
		
		
		Field item = (Field)ti.getData();
		if (offset==1) {	
			// move down
			Field next = item.getParent().getNext(item);			
			if (next!=null) {
				// if item has a NEXT sibling 				
				if (canContainChildren(next)) {
					// if that NEXT sibling can take kids then that is our target
					target=next;
					position=0;
				} else {
					// otherwise our target is after the next sibling				
					target=item.getParent();
					position=target.getOffset(item)+1;
				}
			} else {
				// otherwise our target is is as a next sibling after our parent
				target=item.getParent().getParentStore();
				if (target==null) return;
				position=target.getOffset(item.getParentField())+1;				
			}
		} 
		if (offset==-1) {
			// move up
			Field prev = item.getParent().getPrevious(item);
			if (prev!=null) {
				// item has a prior sibling. If that sibling can hold us then add us to the end
				
				
				if (canContainChildren(prev)) {
					target=prev;
					position=prev.getFieldCount();
				} else {
					// otherwise make ourselves the prior sibling of this 
					target=prev.getParent();
					position=target.getOffset(prev);
				}
				
			} else {
				// item has no prior sibling. Make ourselves prior sibling of our parent if possible
				target=item.getParent().getParentStore();
				if (target==null) return;
				position=target.getOffset(item.getParentField());				
			}
		}

		if (target==null || position==-1) return;
		addOp(ti,new MoveOp(item,target,position));		
	}
	
	private void modify()
	{
		if (tree.getSelectionCount()==0) return;
		TreeItem ti = tree.getSelection()[0];
		if (!(ti.getData() instanceof Field)) return;
		Field f = (Field)ti.getData();
		if (f==null) return;
		FieldStore fs = getStore(ti);
		
		EditFieldDialog efd = new EditFieldDialog();
		efd.setInfo(f,fs);
		efd.setBlockOnOpen(true);
		if (efd.open()==EditPrimaryFileDialog.OK) {
			addOp(ti,new ModifyOp(fs,f.getLabel(),efd.getResult()));
		}
		return;		
	}
	
	private void addOp(TreeItem ti, AbstractOp op) 
	{
		while (ti.getParentItem()!=null) {
			ti=ti.getParentItem();
		}		
		FieldGroup group = (FieldGroup)ti.getData();		
		op.apply(group.data);
		op.apply(ti);
		if (group.ops==null) {
			group.ops=new ArrayList<AbstractOp>();		
		}
		group.ops.add(op);
		group.dirty=true;
		dirty=true;
		getEditor().editorDirtyStateChanged();
		if (group.updateDirtyProcedure) {
			op.apply(getDirtyProcedure());
		}
		DirtyProcedureMonitor.fire(getDirtyProcedure());
	}

	private Button addButton(Canvas buttonGroup, String string, final Runnable runnable) {
		Button b = new Button(buttonGroup,SWT.PUSH);
		b.setText(string);
		b.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				if (runnable!=null) {
					runnable.run();
				}
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
			
		});
		return b;
	}

	private Button addButton(Canvas buttonGroup, int style, final Runnable runnable) {
		Button b = new Button(buttonGroup,style);
		b.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				if (runnable!=null) {
					runnable.run();
				}
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
			
		});
		return b;
	}
	
	private void loadTree()
	{
		tree.removeAll();
		for (FieldGroup scan : groups) {
			TreeItem ti  =new TreeItem(tree,SWT.NONE);
			ti.setText(scan.name);
			ti.setData(scan);
			loadTree(ti,scan.data);
			expandAll(ti);
		}
		for (int i=0; i<tree.getColumnCount(); i++) {
			tree.getColumn (i).pack ();
		}
		
	}
	
	private void expandAll(TreeItem ti) {
		boolean any=false;
		for (TreeItem kid : ti.getItems()) {
			if (!any) {
				ti.setExpanded(true);
				any=true;
			}
			expandAll(kid);
		}
	}

	private void loadTree(TreeItem ti, FieldStore data) 
	{
		for (Field f : data.getFields()) {
			TreeItem field  =new TreeItem(ti,SWT.NONE);
			
			renderField(f,field);
			if (f.getFields().iterator().hasNext()) {
				loadTree(field,f);
			}
		}
	}

	private void renderField(Field f,TreeItem field) {
		AbstractOp.render(f,field);
	}

	public ProcedureModel getProcedure()
	{
		ClarionProcedureInput input = (ClarionProcedureInput)getEditorInput();
		return input.getModel();
	}
	
	public Procedure getDirtyProcedure()
	{
		return ((ClarionProcedureEditor)getEditor()).getDirtyProcedure();
	}
	
	public void addGroup(String name,FieldStore base,boolean dirty)
	{
		FieldGroup fg = new FieldGroup();
		fg.target=base;
		fg.updateDirtyProcedure=dirty;
		fg.data=new AbstractFieldStore(base);
		fg.name=name;
		groups.add(fg);
	}
}
