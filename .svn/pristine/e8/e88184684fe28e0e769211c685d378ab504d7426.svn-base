package org.jclarion.clarion.ide.editor;

import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.TreeItem;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.actions.ActionFactory;
import org.eclipse.ui.forms.IManagedForm;
import org.eclipse.ui.forms.editor.FormEditor;
import org.eclipse.ui.forms.editor.FormPage;
import org.eclipse.ui.forms.widgets.FormToolkit;
import org.eclipse.ui.forms.widgets.ScrolledForm;
import org.eclipse.ui.handlers.IHandlerActivation;
import org.eclipse.ui.handlers.IHandlerService;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.SWT;
import org.eclipse.swt.dnd.Clipboard;
import org.eclipse.swt.dnd.TextTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.KeyListener;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Image;
import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.swt.widgets.Tree;
import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.template.prompt.AtTreeNodeEntry;
import org.jclarion.clarion.appgen.template.prompt.EmbedTree;
import org.jclarion.clarion.appgen.template.prompt.EmbedTreeNode;
import org.jclarion.clarion.appgen.template.prompt.EmbedTreeNodeEntry;
import org.jclarion.clarion.appgen.template.prompt.TreeNodeEntry;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.ClarionControlEmbedInput;
import org.jclarion.clarion.ide.model.EmbedInput;
import org.jclarion.clarion.ide.model.EmbedPriorityKey;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.ide.model.app.ProcedureSave;
import org.jclarion.clarion.ide.model.app.ProcedureSaveListener;
import org.osgi.framework.Bundle;

public class EmbedEditor extends FormPage implements ProcedureSaveListener,EmbedChangeListener
{

	private static final Object EXISTING = new Object();
	private static final Object ALTERED  = new Object();
	private static final Object NEW      = new Object();
	
	private Tree 	  					tree;
	private EmbedTree 					embedtree;	
	private Button add;
	private Button modify;
	private Button delete;
	private Button copy;
	private Button paste;
	private Button cut;
	private Composite bottombar;
	private Label status;
	private Button indent;
	private Clipboard 		clipboard;
	private boolean 		refreshRequired;
	private EmbedProvider 	provider;
	private String			keyFilter;
	
	
	
	private EmbedHelper helper()
	{
		return provider.getEmbedHelper();
	}
	
	
	@Override
	public void init(IEditorSite site, IEditorInput input) 
	{
		super.init(site, input);
		clipboard = new Clipboard(getSite().getShell().getDisplay());
		helper().addChangeListener(this);
		
		if (input instanceof ClarionControlEmbedInput) {
			keyFilter=((ClarionControlEmbedInput)input).getControl();
		}
	}
	
	private boolean			expectedChange;
	
	@Override
	public void embedsChanged() {
		if (expectedChange) return ;
		if (isActive()) {
			refresh();
		} else {
			refreshRequired=true;
		}
		getEditor().editorDirtyStateChanged();		
	}

	@Override
	public void setActive(boolean active) {
		super.setActive(active);
		if (active) {
			if (refreshRequired) {
				refresh();
			}
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
		helper().removeChangeListener(this);
		if (tree!=null) {
			Procedure proc = getProcedure().getProcedure();
			ProcedureSave.get(proc).remove(this);			
		}
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



	/**
	 * Create the form page.
	 * @param editor
	 * @param id
	 * @param title
	 * @wbp.parser.constructor
	 * @wbp.eval.method.parameter id "Some id"
	 * @wbp.eval.method.parameter title "Some title"
	 */
	public EmbedEditor(FormEditor editor, String id, String title,EmbedProvider provider) {
		super(editor, id, title);
		this.provider=provider;
	}

	
	public void setDirty() {
		try {
			expectedChange=true;
			helper().fireChange();
		} finally {
			expectedChange=false;
		}
		getEditor().editorDirtyStateChanged();				
	}

	public boolean isDirty()
	{
		return helper().isDirty();
	}
	
	@Override
	public void doSave(IProgressMonitor monitor) {
		loadEmbedTree();
		refresh();
	}
	
	/**
	 * Create contents of the form.
	 * @param managedForm
	 */
	@Override
	protected void createFormContent(IManagedForm managedForm) {
		FormToolkit toolkit = managedForm.getToolkit();
		ScrolledForm form = managedForm.getForm();
		form.setText("Embed Tree");
		Composite body = form.getBody();
		toolkit.decorateFormHeading(form.getForm());
		toolkit.paintBordersFor(body);				
		body.setLayout(new GridLayout(1,true));
		
		Composite topbar = new Composite(body,SWT.BORDER|SWT.NO_FOCUS);
		RowLayout fill = new RowLayout();
		fill.spacing=4;
		topbar.setLayout(fill);
		
		Button collapse = new Button(topbar,SWT.PUSH|SWT.NO_FOCUS);
		collapse.setText("Collapse All");
		collapse.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				expand(tree.getItems(),false);
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});

		Button expand = new Button(topbar,SWT.PUSH|SWT.NO_FOCUS);
		expand.setText("Expand All");
		expand.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				expand(tree.getItems(),true);
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});

		Button expandEmbeds = new Button(topbar,SWT.PUSH|SWT.NO_FOCUS);
		expandEmbeds.setText("Expand Embeds");
		expandEmbeds.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				expandEmbeds(tree.getItems());
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});

		Button showEmbeds = new Button(topbar,SWT.TOGGLE|SWT.NO_FOCUS);
		showEmbeds.setText("Only show Embeds");
		showEmbeds.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				showOnlyEmbeds(((Button)e.getSource()).getSelection());
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		tree = new Tree(body, SWT.BORDER);
		managedForm.getToolkit().adapt(tree);
		managedForm.getToolkit().paintBordersFor(tree);
		
		GridData grid = new GridData();
		grid.grabExcessVerticalSpace=true;
		grid.grabExcessHorizontalSpace=true;
		grid.horizontalAlignment=GridData.FILL;
		grid.verticalAlignment=GridData.FILL;
		tree.setLayoutData(grid);
		
		tree.addMouseListener(new MouseListener() {
			@Override
			public void mouseDoubleClick(MouseEvent e) {
				doubleClick();
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
					delete(false);
				}
			}
		});
		
		tree.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				
				boolean embed=false;
				boolean insert=false;
				String labelText="";
				
				if (tree.getSelectionCount()>0) {
					TreeItem item = tree.getSelection()[0];
					if (item.getData() instanceof EmbedTreeNodeEntry) {
						indent.setEnabled(true);
						indent.setSelection(((EmbedTreeNodeEntry)item.getData()).getEmbed().isIndent());
						embed=true;						
					}  else {
						indent.setEnabled(false);
					}
					
					if (item.getData() instanceof TreeNodeEntry) {
						insert=true;
						labelText="Priority:"+((TreeNodeEntry)item.getData()).getPriority();
					}
					
					if (item.getData() instanceof EmbedTreeNode && ((EmbedTreeNode)item.getData()).getKey()!=null) {
						insert=true;
					}
				}
			
				add.setEnabled(insert);
				paste.setEnabled(insert);
				copy.setEnabled(embed);
				cut.setEnabled(embed);
				modify.setEnabled(embed);
				delete.setEnabled(embed);
				if (!status.getText().equals(labelText)) {
					status.setText(labelText);
					status.pack();
					bottombar.pack(true);
					
				}
				
				
			}
			
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		bottombar = new Composite(body,SWT.BORDER);
		fill = new RowLayout();
		fill.spacing=4;
		bottombar.setLayout(fill);
		
		add = addButton(bottombar,"Add",new Runnable() { public void run() { add(); } });
		modify = addButton(bottombar,"Modify",new Runnable() { public void run() { modify(); } });
		delete = addButton(bottombar,"Delete",new Runnable() { public void run() { delete(false); } });
		cut = addButton(bottombar,"Cut",new Runnable() { public void run() { cut(); } });
		copy = addButton(bottombar,"Copy",new Runnable() { public void run() { copy(); } });
		paste = addButton(bottombar,"Paste",new Runnable() { public void run() { paste(); } });
		
		indent = new Button(bottombar,SWT.CHECK);
		indent.setText("Indent");
		indent.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				toggleIndent();
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});

		status = new Label(bottombar,SWT.NONE);

		initImages();		
		loadEmbedTree();
		
		loadTree(tree);
		if (keyFilter==null || keyFilter.length()==0) {
			expandEmbeds(tree.getItems());
		} else {
			expand(tree.getItems(),true);
		}
		
		
		Procedure proc = getProcedure().getProcedure();
		ProcedureSave.get(proc).add(this);
	}
	
	private ProcedureModel getProcedure()
	{
		return provider.getModel();
	}
	
	private void loadEmbedTree()
	{
		ProcedureModel model = getProcedure();
		AppProject project = model.getApp().getAppProject();
		embedtree = project.getEmbeds(model.getProcedure());
		
		
		
		if (keyFilter!=null) {
			pruneEmbedTree(embedtree.getRoot());
		}
	}
	
	private boolean pruneEmbedTree(EmbedTreeNode root) {
		if (root.getKey()!=null) {
			EmbedKey ek = root.getKey();
			for (int scan=0;scan<ek.getInstanceCount();scan++) {
				if (ek.getInstance(scan).equalsIgnoreCase(keyFilter)) {
					return false;
				}
			}
		}
		
		boolean prune=true;
		
		Iterator<EmbedTreeNode> loop = root.getChildren().iterator();
		while (loop.hasNext()) {
			EmbedTreeNode etn = loop.next();
			if (pruneEmbedTree(etn)) {
				loop.remove();
			} else {
				prune=false;
			}
		}
		return prune;
	}


	private Button addButton(Composite bottombar, String string,final Runnable runnable) {
		Button add = new Button(bottombar,SWT.PUSH);
		add.setText(string);
		add.setEnabled(false);
		add.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				runnable.run();
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		return add;
	}

	private Image folder;
	private Image embedpoint;
	private Image folder_emb;
	private Image embedpoint_emb;
	private Image at;
	private Image embed;
	
	private EmbedTreeNodeEntry getSelection()
	{
		if (tree.getSelectionCount()==0) return null;
		Object data = tree.getSelection()[0].getData();
		if (!(data instanceof EmbedTreeNodeEntry)) return null;
		return (EmbedTreeNodeEntry)data;
	}
		
	public void save(EmbedTreeNodeEntry entry, String text) 
	{
		if (entry.getData()==NEW) {
			entry.setData(ALTERED);
			entry.getEmbed().setValue(text);
			helper().add(entry.getEmbed());
		} else {
			Embed oe = entry.getEmbed();			
			Embed e = helper().modify(oe);
			entry.setData(ALTERED);
			entry.setEmbed(e);
			e.setValue(text);			
		}
		refresh();
		setDirty();
	}

	private void doubleClick()
	{
		if (tree.getSelectionCount()==0) return;
		Object data = tree.getSelection()[0].getData();
		if (data instanceof EmbedTreeNodeEntry) modify();
		if (data instanceof AtTreeNodeEntry) add();
		if (data instanceof EmbedTreeNode) add();
	}
	
	private Embed addEmbed() {
		if (tree.getSelectionCount()==0) return null;
		TreeItem item = tree.getSelection()[0];
		Object data = item.getData();
		
		EmbedTreeNode entry=null;
		TreeNodeEntry after=null;
		
		if (data instanceof TreeNodeEntry) {
			after=(TreeNodeEntry)data;
			data=null;
			if (item.getParentItem()!=null) {
				data=item.getParentItem().getData();
			}
		}
		
		if (data instanceof EmbedTreeNode) {
			entry = (EmbedTreeNode)data;
		}
		
		if (entry==null) return null;
		if (entry.getKey()==null) return null;
		
		Map<SortKey,TreeNodeEntry> entries=loadEntries(entry,helper());
		
		int minPriority = entry.getMinPriority();
		int maxPriority = entry.getMaxPriority();
		
		
		boolean minPrioritySet=false;
		if (after==null) minPrioritySet=true;
		
		for (TreeNodeEntry tne : entries.values()) {
			if (minPrioritySet) {
				maxPriority=tne.getPriority();
				break;
			}
			
			if (tne.equals(after)) {
				minPriority=tne.getPriority();
				minPrioritySet=true;
			}
		}
		
		if (minPriority==maxPriority || minPriority+1==maxPriority || minPriority>maxPriority) {
			MessageBox mb = new MessageBox(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(),SWT.OK);
			mb.setText("Add embed");
			mb.setMessage("Cannot insert Embed here");			
		}
		
		Embed ne = new Embed((maxPriority+minPriority)/2,entry.getKey(),0);
		return ne;
	}
	
	private void add()
	{
		Embed ne = addEmbed();
		if (ne==null) return;
		ne.setValue("");
		ne.setIndent(false);
		EmbedTreeNodeEntry add = new EmbedTreeNodeEntry(ne);
		add.setData(NEW);
		
		IWorkbench workbench = PlatformUI.getWorkbench();
		try {
			workbench.getActiveWorkbenchWindow().getActivePage().openEditor(
			new EmbedInput(this,getModel(),add,(AbstractClarionEditor) getEditor()),"org.jclarion.clarion.ide.editor.ClarionIncEditor");
		} catch (PartInitException e1) {
			e1.printStackTrace();
		}		
	}
	
	private void delete(boolean force)
	{
		EmbedTreeNodeEntry entry = getSelection();
		if (entry==null) return;
		if (!force) {
			MessageBox mb = new MessageBox(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(),
				SWT.ICON_QUESTION+SWT.YES+SWT.NO);
			mb.setText("Delete");
			mb.setMessage("Are you sure you want to delete this?");
			if (mb.open()!=SWT.YES) return;
		}
		
		helper().delete(entry.getEmbed());
		TreeItem ti = tree.getSelection()[0];
		ti.getParent().select(ti.getParentItem());
		setDirty();
		refresh();
	}

	public void cut()
	{
		copy();
		delete(true);
	}

	public void copy()
	{
		EmbedTreeNodeEntry entry = getSelection();
		if (entry==null) return;		
		TextTransfer tt = TextTransfer.getInstance();	
		EmbedTransfer et = EmbedTransfer.getInstance();
		clipboard.setContents(new Object[] { entry.getEmbed(),entry.getEmbed().getValue() } ,new Transfer[] { et,tt });
	}

	public void paste()
	{
		EmbedTransfer et = EmbedTransfer.getInstance();
		Embed data = (Embed)clipboard.getContents(et);		
		if (data==null) {
			TextTransfer tt = TextTransfer.getInstance();
			String text = (String)clipboard.getContents(tt);
			if (text!=null) {
				data=new Embed(0,null,0);
				data.setValue(text);
				data.setIndent(false);
			}
		}
		
		if (data==null) {
			return;
		}
		
		Embed ne = addEmbed();
		if (ne==null) return;
		ne.setValue(data.getValue());
		ne.setIndent(data.isIndent());
		EmbedTreeNodeEntry add = new EmbedTreeNodeEntry(ne);
		add.setData(NEW);
		save(add, data.getValue());
	}
	
	private void toggleIndent()
	{
		EmbedTreeNodeEntry entry = getSelection();
		if (entry==null) return;
		
		Embed oe = entry.getEmbed();		
		Embed e = helper().modify(oe);
		entry.setData(ALTERED);
		entry.setEmbed(e);			
		entry.getEmbed().setIndent(!entry.getEmbed().isIndent());
		setDirty();
	}
	
	private void modify()
	{
		EmbedTreeNodeEntry entry = getSelection();
		if (entry==null) return;
		IWorkbench workbench = PlatformUI.getWorkbench();
		try {
			workbench.getActiveWorkbenchWindow().getActivePage().openEditor(
			new EmbedInput(this,getModel(),entry,(AbstractClarionEditor) getEditor()),"org.jclarion.clarion.ide.editor.ClarionIncEditor");
		} catch (PartInitException e1) {
			e1.printStackTrace();
		}
	}
	
	private ProcedureModel getModel()
	{
		return provider.getModel();
	}
	
	private void expand(TreeItem[] items,boolean value)
	{
		for (TreeItem scan : items) {
			scan.setExpanded(value);
			expand(scan.getItems(),value);
		}
	}

	private void expandEmbeds(TreeItem[] items)
	{
		for (TreeItem scan : items) {
			scan.setExpanded(scan.getImage()==folder_emb || scan.getImage()==embedpoint_emb); 
			expandEmbeds(scan.getItems());
		}
	}
	
	private static class State
	{
		private boolean expanded;
		private boolean selected;
	}
	
	private boolean lastOnlyEmbeds;
	
	private void refresh()
	{
		if (tree==null || !isActive()) {
			refreshRequired=true;
			return;
		}
		refreshRequired=true;
		showOnlyEmbeds(lastOnlyEmbeds);
	}
	
	private void showOnlyEmbeds(boolean onlyEmbeds)
	{
		HashMap<Object,State> orig=new HashMap<Object,State>();
		loadMap(tree.getItems(),orig);
		for (TreeItem scan : tree.getSelection()) {
			State s = orig.get(scan.getData("MapPath"));
			if (s!=null) {
				s.selected=true;
			}
		}
		
		loadTree(tree);
		lastOnlyEmbeds=onlyEmbeds;
		if (onlyEmbeds) {
			pruneEmbeds(tree.getItems());
		}
		
		// restore map
		List<TreeItem> selections=new ArrayList<TreeItem>();
		restoreMap(tree.getItems(),orig,selections);
		if (!selections.isEmpty()) {
			tree.setSelection(selections.toArray(new TreeItem[selections.size()]));
		}
	}
	
	private void restoreMap(TreeItem[] items,HashMap<Object, State> orig,List<TreeItem> selections) 
	{
		for (TreeItem scan : items ) {
			Object path=scan.getData("MapPath");
			if (path!=null) { 
				State prev = orig.get(path);
				if (prev!=null) {				
					scan.setExpanded(prev.expanded);
					if (prev.selected) {
						selections.add(scan);
					}
				}
			}
			restoreMap(scan.getItems(),orig,selections);
		}
	}

	private void loadMap(TreeItem[] original,HashMap<Object, State> orig) 
	{		
		for (TreeItem scan : original) {
			State s = new State();
			s.expanded=scan.getExpanded();
			Object path = scan.getData("MapPath");
			if (path!=null) {
				orig.put(path,s);
			}
			loadMap(scan.getItems(),orig);
		}
	}

	private void pruneEmbeds(TreeItem[] items) {
		for (TreeItem scan : items) {
			if (scan.getImage()==folder_emb || scan.getImage()==embedpoint_emb || scan.getImage()==embed || scan.getImage()==at) {
				pruneEmbeds(scan.getItems());
			} else {
				scan.dispose();
			}
		}
	}

	private void initImages()
	{
		folder = getImage("icons/embeds/folder.png");
		embedpoint = getImage("icons/embeds/embedpoint.png");
		folder_emb = getImage("icons/embeds/folder-embedded.png");
		embedpoint_emb = getImage("icons/embeds/embedpoint-embedded.png");
		embed = getImage("icons/embeds/embed.png");
		at = getImage("icons/embeds/at.png");
	}

	private static Image getImage(String file) {		  
	    Bundle bundle = Platform.getBundle("clarion-ide");
	    URL url = FileLocator.find(bundle, new Path(file), null);
	    ImageDescriptor image = ImageDescriptor.createFromURL(url);
	    return image.createImage();
	  }		

	private void loadTree(Tree tree) {
		
		EmbedHelper helper=helper();
		tree.removeAll();
		for (EmbedTreeNode base : embedtree.getRoot().getChildren()) {
			TreeItem parent = new TreeItem(tree,0);
			styleNode(parent,base,base.getName());
			addTree(parent,base,base.getName(),helper);			
		}
	}

	private void styleNode(TreeItem parent, EmbedTreeNode base,String path) {
		parent.setText(base.getName());
		int color=base.getColor();
		parent.setForeground(new Color(null,(color)&0xff,(color>>8)&0xff,(color>>16)&0xff));
		
		if (base.getChildren().isEmpty()) {
			parent.setImage(embedpoint);
		} else {
			parent.setImage(folder);
		}
		parent.setData(base);
		parent.setData("MapPath",path);
	}

	private static class SortKey implements Comparable<SortKey>
	{
		private int priority;
		private int order;

		
		public SortKey(int priority,int order)
		{
			this.priority=priority;
			this.order=order;
		}
		
		@Override
		public int compareTo(SortKey o) {
			if (o.priority!=priority) return priority-o.priority;
			return order-o.order;
		}



		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + order;
			result = prime * result + priority;
			return result;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj) return true;
			if (obj == null) return false;
			if (getClass() != obj.getClass()) return false;
			SortKey other = (SortKey) obj;
			if (order != other.order) return false;
			if (priority != other.priority) return false;
			return true;
		}
	}
	
	private void addTree(TreeItem parent, EmbedTreeNode base,String path,EmbedHelper helper) 
	{
		for (EmbedTreeNode kids : base.getChildren()) {
			TreeItem child = new TreeItem(parent,0);
			String childPath = path+"|"+kids.getName();
			styleNode(child,kids,childPath);
			addTree(child,kids,childPath,helper);
		}

		
		
		if (base.getKey()!=null) {
			
			Map<SortKey,TreeNodeEntry> entries=loadEntries(base,helper);
								
			boolean embedded=false;
			for (TreeNodeEntry entry : entries.values()) {
				if (entry.getDescription()==null) continue;
				TreeItem child = new TreeItem(parent,0);
				child.setText(entry.getDescription());
				child.setData(entry);				
				if (entry instanceof EmbedTreeNodeEntry) {
					embedded=true;
					child.setData("MapPath",new EmbedPriorityKey(base.getKey(),entry.getPriority()));
					child.setImage(embed);
				} else {
					child.setData("MapPath",path+"#"+entry.getDescription());
					child.setImage(at);
				}
			}
			
			if (embedded) { 
				for (TreeItem scan=parent;scan!=null;scan=scan.getParentItem()) {
					if (scan.getImage()==embedpoint) {
						scan.setImage(embedpoint_emb);
					}
					if (scan.getImage()==folder) {
						scan.setImage(folder_emb);
					}
				}				
			}
			
		}
	}

	private Map<SortKey, TreeNodeEntry> loadEntries(EmbedTreeNode base,EmbedHelper helper) {
		Map<SortKey,TreeNodeEntry> entries=new TreeMap<SortKey,TreeNodeEntry>();
		
		for (TreeNodeEntry entry : base.getNodes()) {
			if (entry instanceof AtTreeNodeEntry) {
				entries.put(new SortKey(entry.getPriority(),entries.size()),entry);
			}
		}
		loadEmbeds(entries,helper.getUnmodifiedEmbeds(base.getKey()),EXISTING,helper);
		loadEmbeds(entries,helper.getNewEmbeds(base.getKey()),ALTERED,helper);
		return entries;
	}

	private void loadEmbeds(Map<SortKey, TreeNodeEntry> entries,Iterator<? extends Advise> scan, Object data,EmbedHelper helper) {
		while (scan.hasNext()) {
			Advise a = scan.next();
			EmbedTreeNodeEntry etne = new EmbedTreeNodeEntry((Embed)a);
			etne.setData(data);
			entries.put(new SortKey(a.getPriority(),entries.size()),etne);
		}
	}



	@Override
	public void procedureSaved() {
		loadEmbedTree();	
		refresh();
	}



	@Override
	public void procedureDeleted() {
	}



}
