package org.jclarion.clarion.ide.view;

import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;


import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.commands.operations.UndoContext;
import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.action.Action;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.swt.dnd.Clipboard;
import org.eclipse.swt.dnd.DND;
import org.eclipse.swt.dnd.DragSourceEvent;
import org.eclipse.swt.dnd.DragSourceListener;
import org.eclipse.swt.dnd.DropTargetEvent;
import org.eclipse.swt.dnd.DropTargetListener;
import org.eclipse.swt.dnd.TextTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IActionBars;
import org.eclipse.ui.ISharedImages;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPartSite;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.actions.ActionFactory;
import org.eclipse.ui.handlers.IHandlerActivation;
import org.eclipse.ui.handlers.IHandlerService;
import org.eclipse.ui.operations.RedoActionHandler;
import org.eclipse.ui.operations.UndoActionHandler;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.ide.model.AbstractPropertyObjectWrapper;
import org.jclarion.clarion.ide.model.ControlWrapper;
import org.jclarion.clarion.ide.model.PropertyObjectNavigator;
import org.jclarion.clarion.ide.model.WindowTargetWrapper;
import org.jclarion.clarion.ide.Compiler;
import org.osgi.framework.Bundle;

/**
 * Displays an outline of {@link ClarionToJava} models in the Content Outline
 * view. The outline is a tree view, with the {@link AbstractWindowTarget} as
 * the root and constituent child {@link AbstractControl}s branching off.
 */
public class ClarionToJavaOutlinePage extends AbstractContentOutlinePage {

	private final IWorkbenchPartSite editorSite;
	private final UndoContext undoContext;
	private boolean selfDrag;
	private Clipboard clipboard;
	private UndoActionHandler undoAction;
	private RedoActionHandler redoAction;

	public ClarionToJavaOutlinePage(IWorkbenchPartSite editorSite, UndoContext undoContext) {
		super();
		this.editorSite = editorSite;
		this.undoContext = undoContext;
	}
	
	private static ImageDescriptor down=getImage("icons/down.png");
	private static ImageDescriptor up=getImage("icons/up.png");
	
	
	
	  private static ImageDescriptor getImage(String file) {
		   
		    Bundle bundle = Platform.getBundle("clarion-ide");
		    URL url = FileLocator.find(bundle, new Path(file), null);
		    ImageDescriptor image = ImageDescriptor.createFromURL(url);
		    return image;
		  }	
	
	@Override
	public void setActionBars(IActionBars actionBars)
	{       
		IWorkbench workbench = PlatformUI.getWorkbench();
		ISharedImages images = workbench.getSharedImages();
		
	    actionBars.getToolBarManager().add(new Action("Sync",images.getImageDescriptor(ISharedImages.IMG_ELCL_SYNCED)) {
			@Override
			public void run() {
				getInput().getProvider().refresh();
			} 
	    });     
	    actionBars.getToolBarManager().add(new Action("Down",down) {
			@Override
			public void run() {
				move(true);
			} 
	    });     
	    actionBars.getToolBarManager().add(new Action("Up",up) {
			@Override
			public void run() {
				move(false);
			} 
	    });     
	    actionBars.getToolBarManager().update(false);       
	    actionBars.updateActionBars();

		// Set up action handlers that operate on the current context
		undoAction = new UndoActionHandler(editorSite, undoContext);
		redoAction = new RedoActionHandler(editorSite, undoContext);
		actionBars.setGlobalActionHandler(ActionFactory.UNDO.getId(), undoAction);
		actionBars.setGlobalActionHandler(ActionFactory.REDO.getId(), redoAction);
		actionBars.setGlobalActionHandler(ActionFactory.DELETE.getId(), new Action() {
					@Override
					public void run() {
						deleteSelection();
					}
				});
	}	
	
	private List<IHandlerActivation> handlers=new ArrayList<IHandlerActivation>();
	
	@Override
	public void createControl(Composite parent) {
		super.createControl(parent);

		getTreeViewer().addDragSupport(
				DND.DROP_MOVE | DND.DROP_COPY,
				new Transfer[] { TextTransfer.getInstance() },
				new DragSourceListener() {

					@Override
					public void dragStart(DragSourceEvent event) {
						if (getTreeViewer().getTree().getSelectionCount()==0) {
							event.doit=false;
							return;
						}
						selfDrag=true;
					}

					@Override
					public void dragSetData(DragSourceEvent event) {
						event.data=getTextSelection();
					}

					@Override
					public void dragFinished(DragSourceEvent event) {
						selfDrag=false;
					}
				});
		
		getTreeViewer().addDropSupport(DND.DROP_MOVE | DND.DROP_COPY,
				new Transfer[] { TextTransfer.getInstance() },
				new DropTargetListener() {
					@Override
					public void dropAccept(DropTargetEvent event) {
						
					}
					
					@Override
					public void drop(DropTargetEvent event) {
						PropertyObject po = ((AbstractPropertyObjectWrapper)event.item.getData()).getPropertyObject();
						if (po==null) return;
						if (selfDrag) {
							moveInto(po);
						} else {
							getInput().getProvider().dropControl(po,(String)event.data);
						}
					}
					
					@Override
					public void dragOver(DropTargetEvent event) {
						event.feedback= DND.FEEDBACK_INSERT_AFTER;
					}
					
					@Override
					public void dragOperationChanged(DropTargetEvent event) {
						// TODO Auto-generated method stub
						
					}
					
					@Override
					public void dragLeave(DropTargetEvent event) {
						// TODO Auto-generated method stub
						
					}
					
					@Override
					public void dragEnter(DropTargetEvent event) {
						event.feedback= DND.FEEDBACK_EXPAND;
					}
				}
		);
		
		clipboard = new Clipboard(getSite().getShell().getDisplay());
		register(ActionFactory.COPY,new Runnable() { public void run() { copy(); } });
		register(ActionFactory.CUT,new Runnable() { public void run() { cut(); } });
		register(ActionFactory.PASTE,new Runnable() { public void run() { paste(); } });					
				
	}	
	
	public void dispose()
	{
		super.dispose();
		clipboard.dispose();
		undoAction.dispose();
		redoAction.dispose();

		IHandlerService handlerService = (IHandlerService) getSite().getService(IHandlerService.class);
		if (handlerService != null) {
			for (IHandlerActivation ah : handlers) {
				handlerService.deactivateHandler(ah);
			}
		}
	}
	
	
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
		TextTransfer tt = TextTransfer.getInstance();	
		clipboard.setContents(new Object[] { getInput().getProvider().getTextSelection() } ,new Transfer[] { tt });
	}
	
	public void cut()
	{
		TextTransfer tt = TextTransfer.getInstance();	
		clipboard.setContents(new Object[] { getInput().getProvider().getTextSelection() } ,new Transfer[] { tt });
		getInput().getProvider().beginStructuralChange("Cut Control", false);
		for (PropertyObject po : getInput().getProvider().getRootSelections(null)) {
			if (po instanceof AbstractControl) {
				getInput().getProvider().delete((AbstractControl)po);
			}
		}
		getInput().getProvider().commitStructuralChange();
	}
	
	public void paste()
	{
		AbstractPropertyObjectWrapper w = getFirstSelection();
		TextTransfer tt = TextTransfer.getInstance();	
		String data = (String)clipboard.getContents(tt);		
		if (data==null) return;				
		getInput().getProvider().dropControl(w==null ? null : w.getPropertyObject(),(String)data);
	}
	
	public void moveInto(PropertyObject target)
	{
		LinkedList<PropertyObject> ll = new LinkedList<PropertyObject>(getInput().getProvider().getRootSelections(target));
		if (ll.isEmpty()) return;
		Iterator<PropertyObject> iscan = ll.descendingIterator();
		getInput().getProvider().beginStructuralChange("Move Control", true);
		while (iscan.hasNext()) {
			PropertyObject scan = iscan.next();
			if (!(scan instanceof AbstractControl)) continue;
			
			PropertyObject host = target;
			int offset=0;
			while (host!=null) {
				if (Compiler.isValidParent(scan,host)) {
					break;
				}
				
				PropertyObject parent = host.getParentPropertyObject();
				if (parent!=null) {
					offset=parent.getChildIndex(host)+1;					
				}
				host=parent;
			}
			if (host==null) break;
			getInput().getProvider().move(host,offset,(AbstractControl)scan);
		}
		getInput().getProvider().commitStructuralChange();
	}
	
	public void move(boolean down)
	{		
		AbstractPropertyObjectWrapper item = getFirstSelection();
		if (item==null) return;
		PropertyObject child = item.getPropertyObject();
		if (!(child instanceof AbstractControl)) return;
		
		PropertyObjectNavigator nav= new PropertyObjectNavigator();
		nav.set(child);
		if (down) {
			nav.next();
		} else {
			nav.previous();
		}
		if (nav.getObject()==null) return;
		
		// update both parents
		getInput().getProvider().beginStructuralChange("Move Control", true);		
		getInput().getProvider().move(nav.getObject(),nav.getIndex(),(AbstractControl)child);
		getInput().getProvider().commitStructuralChange();
	}
	
	public String getTextSelection()
	{
		return getInput().getProvider().getTextSelection();		
	}
	
	public AbstractPropertyObjectWrapper getFirstSelection()
	{
		ISelection s = getSelection();
		if (!(s instanceof StructuredSelection)) return null;
		StructuredSelection ss = (StructuredSelection)s;
		if (ss.isEmpty()) return null;
		return (AbstractPropertyObjectWrapper) ss.getFirstElement();		
	}
	
	public AbstractPropertyObjectWrapper constructContentFor(PropertyObject control) {
		if (control instanceof AbstractTarget) {
			return new WindowTargetWrapper(
					getInput().getTarget(),
					getInput().getProvider(),
					getInput().getName(),
					undoContext);			
		} else {
			return new ControlWrapper((AbstractControl)control, getInput().getProvider(), undoContext);			
		}
	}

	public void refresh(PropertyObject control,boolean structural) {
		AbstractPropertyObjectWrapper wrapper = constructContentFor(control);
		if (structural) {
			getTreeViewer().refresh(wrapper,true);
		} else {
			getTreeViewer().update(wrapper, null);
		}
	}

	public void deleteSelection() {
		ISelection selection = viewer.getSelection();
		if (selection instanceof StructuredSelection) {

			StructuredSelection ss = (StructuredSelection) selection;
			if (!ss.isEmpty()) {

				getInput().getProvider().beginStructuralChange("Delete Controls", false);				
				for (Object element : ss.toList()) {
					if (element instanceof ControlWrapper) {
						ControlWrapper wrapper = (ControlWrapper) element;
						wrapper.provider.delete(wrapper.getControl());
					}
				}
				getInput().getProvider().commitStructuralChange();
			}
		}
	}

	@Override
	ITreeContentProvider getContentProvider() {
		return new ContentProvider();
	}
	
	

	private ClarionToJavaViewer getInput() {
		return (ClarionToJavaViewer) input;
	}

	/**
	 * Populates the Content Outline view with objects for each for each of the
	 * active editor's supplied content types
	 */
	private class ContentProvider implements ITreeContentProvider {

		public ContentProvider() {
			// Empty
		}

		@Override
		public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
		}

		@Override
		public void dispose() {
			// Empty
		}

		@Override
		public Object[] getElements(Object element) {
			return getChildren(element);
		}

		@Override
		public boolean hasChildren(Object element) {
			if (element == getInput()) {
				return true;
			}
			if (element instanceof WindowTargetWrapper) {
				return true;
			}
			if (element instanceof ControlWrapper) {
				return !((ControlWrapper) element).getControl().getChildren().isEmpty();
			}
			return false;
		}

		@Override
		public Object getParent(Object element) {
			if (element == getInput()) {
				return null;
			}
			if (element instanceof WindowTargetWrapper) {
				return null;
			}
			if (element instanceof ControlWrapper) {
				return ((ControlWrapper) element).getParent();
			}
			return null;
		}

		@Override
		public Object[] getChildren(Object element) {
			if (element == getInput()) {
				if (getInput().getTarget() == null) {
					return null;
				}
				return createWindowTargetContent();
			}
			if (element instanceof WindowTargetWrapper) {
				WindowTargetWrapper wrapper = (WindowTargetWrapper) element;
				return createControlWrapperContent(wrapper.getTarget().getControls());
			}
			if (element instanceof ControlWrapper) {
				ControlWrapper parent = (ControlWrapper) element;
				return createControlWrapperContent(parent.getControl().getChildren());
			}
			return null;
		}

		private Object[] createWindowTargetContent() {
			WindowTargetWrapper wrapper = new WindowTargetWrapper(
					getInput().getTarget(),
					getInput().getProvider(),
					getInput().getName(),
					undoContext);
			return new WindowTargetWrapper[] { wrapper };
		}

		private ControlWrapper[] createControlWrapperContent(Collection<? extends AbstractControl> collection) {
			List<ControlWrapper> wrappers = new ArrayList<ControlWrapper>();
			for (AbstractControl control : collection) {
				ControlWrapper wrapper = new ControlWrapper(control, getInput().getProvider(), undoContext);
				wrappers.add(wrapper);
			}
			return (ControlWrapper[]) wrappers.toArray(new ControlWrapper[wrappers.size()]);
		}
	}

}
