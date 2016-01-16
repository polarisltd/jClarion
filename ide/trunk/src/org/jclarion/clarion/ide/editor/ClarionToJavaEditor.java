package org.jclarion.clarion.ide.editor;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;

import jclarion.Activator;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.commands.operations.AbstractOperation;
import org.eclipse.core.commands.operations.OperationHistoryFactory;
import org.eclipse.core.commands.operations.UndoContext;
import org.eclipse.core.runtime.Assert;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.jface.action.Action;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.jface.viewers.TreePath;
import org.eclipse.jface.viewers.TreeSelection;
import org.eclipse.swt.dnd.Clipboard;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.actions.ActionFactory;
import org.eclipse.ui.handlers.IHandlerActivation;
import org.eclipse.ui.handlers.IHandlerService;
import org.eclipse.ui.operations.RedoActionHandler;
import org.eclipse.ui.operations.UndoActionHandler;
import org.eclipse.ui.part.EditorPart;
import org.eclipse.ui.views.contentoutline.IContentOutlinePage;
import org.eclipse.ui.views.properties.IPropertySheetPage;
import org.eclipse.ui.views.properties.tabbed.ITabbedPropertySheetPageContributor;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.ControlCmd;
import org.jclarion.clarion.appgen.template.cmd.ExtensionCmd;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.PropertyChange;
import org.jclarion.clarion.ide.dialog.ListFormatDialog;
import org.jclarion.clarion.ide.model.AbstractPropertyObjectWrapper;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.ClarionControlEmbedInput;
import org.jclarion.clarion.ide.model.ClarionToJavaInput;
import org.jclarion.clarion.ide.model.ClarionToJavaListener;
import org.jclarion.clarion.ide.model.DirtyProcedureMonitor;
import org.jclarion.clarion.ide.model.JavaSwingContributor;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.ide.model.manager.PropertyManager;
import org.jclarion.clarion.ide.view.AbstractContentOutlinePage;
import org.jclarion.clarion.ide.view.ClarionToJavaOutlinePage;
import org.jclarion.clarion.ide.view.ClarionToJavaViewer;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;


/**
 * An editor for manipulating the Java Swing representation of compiled Clarion
 * source code.
 */
public class ClarionToJavaEditor extends EditorPart implements
		AbstractContentOutlinePage.Listener, ClarionToJavaListener,
		ITabbedPropertySheetPageContributor, JavaSwingContributor, AbstractClarionEditor
{

	public static final String ID = ClarionToJavaEditor.class.getName();
	public static final String POSITION_CATEGORY = "__awt_content_abstract_controls";

	public ClarionToJavaViewer viewer;

	private final UndoContext undoContext;

	private ClarionToJavaOutlinePage outlinePage;
	private boolean dirty;
	private UndoActionHandler undoAction;
	private RedoActionHandler redoAction;
	private Clipboard clipboard;
	private EditorCloseProducer  tracker =new EditorCloseProducer(); 
	
	public ClarionToJavaEditor() {
		super();
		this.undoContext = new UndoContext();
	}
	
	public ClarionToJavaViewer getViewer()
	{
		return viewer;
	}

	@Override
	public void createPartControl(Composite parent) {
		
		getClarionToJavaInput().provider.startEditSession();
		
		viewer = new ClarionToJavaViewer(parent, getClarionToJavaInput().provider,undoContext,this);
		viewer.addListener(this);

		if (getEditorInput() != null) {
			viewer.setInput(getEditorInput());
		}

		getSite().setSelectionProvider(viewer);

		// Set up action handlers that operate on the current context
		undoAction = new UndoActionHandler(getEditorSite(), undoContext);
		redoAction = new RedoActionHandler(getEditorSite(), undoContext);

		getEditorSite().getActionBars().setGlobalActionHandler(ActionFactory.UNDO.getId(), undoAction);
		getEditorSite().getActionBars().setGlobalActionHandler(ActionFactory.REDO.getId(), redoAction);
		getEditorSite().getActionBars().setGlobalActionHandler(ActionFactory.DELETE.getId(), new Action() {
			@Override
			public void run() {
				outlinePage.deleteSelection();
			};
		});

	}

	@Override
	public void doSave(IProgressMonitor monitor) {
		viewer.save();
		setDirty(false);
	}

	@Override
	public void doSaveAs() {
		// Save As is not allowed
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Object getAdapter(Class adapter) {
		if (IContentOutlinePage.class.equals(adapter)) {
			if (outlinePage == null) {
				outlinePage = new ClarionToJavaOutlinePage(getEditorSite(), undoContext);
				outlinePage.setInput(viewer);
				outlinePage.setListener(this);
			}
			return outlinePage;
		}
		if (IPropertySheetPage.class.equals(adapter)) {
			return new TabbedPropertySheetPage(this);
		}
		return super.getAdapter(adapter);
	}

	@Override
	public void init(IEditorSite site, IEditorInput input) throws PartInitException {
		Assert.isTrue(input instanceof ClarionToJavaInput);
		setSite(site);
		setInput(input);
		setPartName(getClarionToJavaInput().getName());
		clipboard = new Clipboard(getSite().getShell().getDisplay());
		register(ActionFactory.COPY,new Runnable() { public void run() { copy(); } });
		register(ActionFactory.CUT,new Runnable() { public void run() { cut(); } });
		register(ActionFactory.PASTE,new Runnable() { public void run() { paste(); } });			
	}
	
	private List<IHandlerActivation> handlers=new ArrayList<IHandlerActivation>();
	private void register(ActionFactory event, final Runnable runnable) 
	{
		IHandlerService handlerService = (IHandlerService) getSite().getService(IHandlerService.class);		
		AbstractHandler ah = new AbstractHandler() {
			
			@Override
			public boolean isEnabled()
			{
				return true;
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
		
	public void copy()
	{
		outlinePage.copy();
	}
	
	public void cut()
	{
		outlinePage.cut();
	}
	
	public void paste()
	{
		outlinePage.paste();
	}
	
	@Override
	public boolean isDirty() {
		return dirty;
	}

	@Override
	public boolean isSaveAsAllowed() {
		return false;
	}

	@Override
	public void setFocus() {
		viewer.getControl().setFocus();
	}

	@Override
	public void dispose() {
		getClarionToJavaInput().provider.finishEditSession();		
		undoAction.dispose();
		redoAction.dispose();
		viewer.dispose();
		outlinePage.dispose();
		if (editorClose!=null) {
			getClarionToJavaInput().provider.removeEditorCloseListener(editorClose);
		}		
		tracker.fire();
		super.dispose();
		clipboard.dispose();
		IHandlerService handlerService = (IHandlerService) getSite().getService(IHandlerService.class);		
		for (IHandlerActivation ah : handlers) {
			handlerService.deactivateHandler(ah);
		}
	}

	@Override
	public void contentOutlineSelectionChanged(final StructuredSelection selection) {
		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				List<PropertyObject> controls = new ArrayList<PropertyObject>(selection.size());
				if (!selection.isEmpty()) {
					for (Object element : selection.toArray()) {
						if (element instanceof AbstractPropertyObjectWrapper) {
							controls.add(((AbstractPropertyObjectWrapper) element).getPropertyObject());
						}
					}
				}
				if (!controls.isEmpty()) {
					viewer.highlight(controls);
				} else {
					viewer.resetHighlight();
				}
			}
		});
	}

	@Override
	public void contentOutlineDoubleClicked(StructuredSelection selection) {
		// Not implemented
	}

	@Override
	public void controlChanged(final PropertyObject control, int property, Object value) {
		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				setDirty(getManager(control).isDirty());
				outlinePage.refresh(control,false);
			}
		});
	}

	@Override
	public void structureChanged(final PropertyObject control) {
		if (control==null) {
			throw new IllegalStateException("Is null");
		}
		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				setDirty(true);
				outlinePage.refresh(control,true);
			}
		});
	}

	@Override
	public void mouseDragged(List<PropertyObject> controls,
			int sx,int sy,
			int x, int y,
			int deltaX, int deltaY,
			int deltaWidth, int deltaHeight,
			boolean rehome,List<PropertyChange> otherChanges) {

		if (controls.isEmpty()) {
			return;
		}

		final List<PropertyManager> managers = new ArrayList<PropertyManager>(controls.size());
		for (PropertyObject po : controls) {
			managers.add(getManager(po));
		}
		PropertyManager.addMouseDraggedUndoHistory(managers, sx,sy,x, y, deltaX, deltaY, deltaWidth, deltaHeight, rehome,otherChanges);

		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				boolean dirty = false;
				for (PropertyManager manager : managers) {
					dirty |= manager.isDirty();
				}
				setDirty(dirty);
			}
		});
	}

	@Override
	public void mouseSelectionChanged(final List<PropertyObject> controls) {
		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				setFocus();
				ISelection sel = createMutiSelection(controls);
				outlinePage.setSelection(sel);
				viewer.setSelection(sel);
			}
		});
	}

	@Override
	public String getContributorId() {
		return ID;
	}
	
	private EditorClosedListener editorClose;

	@Override
	protected void setInput(IEditorInput input) {
		super.setInput(input);
		if (outlinePage != null) {
			outlinePage.setInput(input);
		}		
		editorClose=new EditorClosedListener() {
			@Override
			public void editorClosed() {
				getSite().getPage().closeEditor(ClarionToJavaEditor.this,false);
			}
		};
		getClarionToJavaInput().provider.addEditorCloseListener(editorClose);
	}

	private ClarionToJavaInput getClarionToJavaInput() {
		return (ClarionToJavaInput) getEditorInput();
	}
	
	public ProcedureModel getProcedureModel()
	{
		return getClarionToJavaInput().getProvider().getModel();
	}

	private void setDirty(boolean dirty) {
		this.dirty = dirty;
		firePropertyChange(PROP_DIRTY);
	}

	private PropertyManager getManager(PropertyObject po) {
		return constructWrapperFor(po).getManager();
	}

	private StructuredSelection createMutiSelection(List<PropertyObject> controls) {
		if (controls.isEmpty()) {
			return new StructuredSelection();
		}

		List<AbstractPropertyObjectWrapper> wrappers = new ArrayList<AbstractPropertyObjectWrapper>();
		for (PropertyObject scan : controls) {
			wrappers.add(constructWrapperFor(scan));
		}

		StructuredSelection selection;
		if (wrappers.size() == 1) {
			selection = new StructuredSelection(wrappers.get(0));
		} else {
			TreePath[] paths = new TreePath[wrappers.size()];
			for (int i = 0, n = controls.size(); i < n; i++) {
				paths[i] = new TreePath(new Object[] { wrappers.get(i) });
			}
			selection = new TreeSelection(paths);
		}
		return selection;
	}

	private AbstractPropertyObjectWrapper constructWrapperFor(PropertyObject control) {
		return outlinePage.constructContentFor(control);
	}
	
	public void embeds()
	{
		PropertyObject po = viewer.getSelectedControl();
		if (po==null) return;
		if (!(po instanceof AbstractControl)) return;
		String uv = ExtendProperties.get(po).getUsevar();
		if (uv==null) return;
		IWorkbench workbench = PlatformUI.getWorkbench();
		try {
			workbench.getActiveWorkbenchWindow().getActivePage().openEditor(
			new ClarionControlEmbedInput(this,uv),"org.jclarion.clarion.ide.editor.ClarionControlEmbedEditor");
		} catch (PartInitException e1) {
			e1.printStackTrace();
		}		
		
	}
	
	public void files()
	{
		Procedure p = getClarionToJavaInput().getProvider().getDirtyProcedure();
		Addition a = getFileAddition();
		if (p==null || a==null) return;
		
		ProcedureModel model = getProcedureModel();
		model.getApp().getAppProject().fileDialog(a);		
	}
	
	public void listBoxFormat()
	{
		PropertyObject po = viewer.getSelectedControl();
		if (po==null) return;
		if (!(po instanceof ListControl)) return;
		
		ListFormatDialog lfd = new ListFormatDialog(getSite().getShell());
		lfd.setEditor(this);
		AbstractOperation ao = lfd.openAndWait(po);
		if (ao!=null) {
			ao.addContext(undoContext);
			try {
				OperationHistoryFactory.getOperationHistory().execute(ao, null,null);
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
			setDirty(true);
		}		
	}
	
	public void actions()
	{
		PropertyObject po = viewer.getSelectedControl();
		if (po==null) return;
		if (!(po instanceof AbstractControl)) return;
		
		ProcedureModel model = getProcedureModel();
		
		Procedure p = getClarionToJavaInput().getProvider().getDirtyProcedure();
		String params[] = ExtendProperties.get(po).getPragma("SEQ");
		String base_window = p.getWindow();
		p.setWindow(viewer.serialize());
		AtSource as = null;
		String field=null;
		if (params!=null && params.length>0) {
			as=p.getAddition(Integer.parseInt(params[0]));
		} else {
			as = p;			
			field =  ExtendProperties.get(po).getUsevar();
		}
		if (as==null) return;
		
		
		AppProject project = model.getApp().getAppProject();
		ExecutionEnvironment env = project.getEnvironment(true);
		env.setAlternative(model.getProcedure(),p);
		
		if (model.getApp().getAppProject().prompt(env,as,field)) {
			as.meta().setObject("PromptDirty",true);
			DirtyProcedureMonitor.fire(p);
		}
		p.setWindow(base_window);
	}

	@Override
	public void contributePopup(JPopupMenu menu) {
		
		PropertyObject po = viewer.getSelectedControl();
		if (po!=null && (po instanceof ListControl)) {
			JMenuItem item = new JMenuItem("List Box Format");
			menu.add(item);
			item.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					Activator.getDefault().runOnUiThread(new Runnable() {
						@Override
						public void run() {
							listBoxFormat();
						}					
					});
				} });
		}
		
		if (getProcedureModel()==null) return;		
		JMenuItem item = new JMenuItem("Actions");
		menu.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				Activator.getDefault().runOnUiThread(new Runnable() {
					@Override
					public void run() {
						actions();
					}					
				});
			} });

		contributeFile(menu);
		
		item = new JMenuItem("Embeds");
		menu.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				Activator.getDefault().runOnUiThread(new Runnable() {
					@Override
					public void run() {
						embeds();
					}					
				});
			} });
	}
	
	private Addition getFileAddition()
	{
		PropertyObject po = viewer.getSelectedControl();
		if (po==null) return null;
		if (!(po instanceof AbstractControl)) return null;
		
		ProcedureModel model = getProcedureModel();		
		Procedure p = getClarionToJavaInput().getProvider().getDirtyProcedure();
		String params[] = ExtendProperties.get(po).getPragma("SEQ");
		if (params==null) return null;
		
		Addition as=p.getAddition(Integer.parseInt(params[0]));
		if (as==null) return null;

		
		TemplateChain tc = model.getApp().getAppProject().getChain();
		
		while (as!=null) {
			CodeSection cs = tc.getSection("#CONTROL",as.getBase(),false);
			boolean yes=false;
			if (cs instanceof ControlCmd) {
				if (((ControlCmd)cs).isPrimary()) yes=true;
			}
			if (cs instanceof ExtensionCmd) {
				if (((ExtensionCmd)cs).isPrimary()) yes=true;
			}
			if (yes) return as;
			as=as.getParentAddition();
		}
		return null;
	}

	private void contributeFile(JPopupMenu menu) {
		Addition a = getFileAddition();
		if (a==null) return;
		
		String name = "Files";
		if (a.getPrimaryFile()!=null) {
			if (a.getPrimaryFile().getKey()!=null && a.getPrimaryFile().getKey().length()>0) {
				name="Files ("+a.getPrimaryFile().getKey()+")";				
			} else {
				name="Files ("+a.getPrimaryFile().getName()+")";
			}
		}
		
		JMenuItem item = new JMenuItem(name);
		menu.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				Activator.getDefault().runOnUiThread(new Runnable() {
					@Override
					public void run() {
						files();
					}					
				});
			} });				
	}

	@Override
	public void removeEditorCloseListener(EditorClosedListener listener) {
		tracker.removeEditorCloseListener(listener);
	}

	@Override
	public void addEditorCloseListener(EditorClosedListener listener) {
		tracker.addEditorCloseListener(listener);
	}

	@Override
	public void restoreFocus() {
		getEditorSite().getPage().activate(this);
	}

	@Override
	public Procedure getDirtyProcedure() {
		return getClarionToJavaInput().provider.getDirtyProcedure();
	}

	@Override
	public ProcedureModel getModel() {
		return getClarionToJavaInput().provider.getModel();
	}

	@Override
	public AbstractClarionEditor getParentEditor() {
		// TODO Auto-generated method stub
		return getClarionToJavaInput().provider;
	}

}
