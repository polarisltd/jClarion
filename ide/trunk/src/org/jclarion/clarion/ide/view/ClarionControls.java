package org.jclarion.clarion.ide.view;

import org.eclipse.jface.viewers.ISelectionChangedListener;
import org.eclipse.jface.viewers.SelectionChangedEvent;
import org.eclipse.swt.SWT;
import org.eclipse.swt.dnd.DND;
import org.eclipse.swt.dnd.DragSource;
import org.eclipse.swt.dnd.DragSourceEvent;
import org.eclipse.swt.dnd.DragSourceListener;
import org.eclipse.swt.dnd.TextTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.swt.widgets.TreeItem;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IEditorReference;
import org.eclipse.ui.IPartListener2;
import org.eclipse.ui.IWorkbenchPartReference;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.part.ViewPart;
import org.eclipse.ui.views.contentoutline.IContentOutlinePage;
import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.at.AtSourceSession;
import org.jclarion.clarion.appgen.template.cmd.AdditionCodeSection;
import org.jclarion.clarion.appgen.template.cmd.CodeResult;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.RestrictCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateCmd;
import org.jclarion.clarion.ide.editor.ClarionToJavaEditor;
import org.jclarion.clarion.ide.editor.ControlTemplateTransfer;
import org.jclarion.clarion.ide.model.AbstractPropertyObjectWrapper;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.ControlWrapper;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;


public class ClarionControls extends ViewPart implements ISelectionChangedListener
{
	private Composite parent;
	private ClarionToJavaEditor editor;
	private ClarionToJavaOutlinePage viewer; 
	private Tree tree;
	private TreeItem addControls;
	
	@Override
	public void createPartControl(Composite parent) {
		this.parent=parent;
		
		PlatformUI.getWorkbench().getActiveWorkbenchWindow().getPartService().addPartListener(new IPartListener2()
		{
			@Override
			public void partActivated(IWorkbenchPartReference partRef) {
				if (partRef instanceof IEditorReference) {
					setEditor( ((IEditorReference)partRef).getEditor(false));
				}
			}

			@Override
			public void partBroughtToTop(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partClosed(IWorkbenchPartReference partRef) {
				if (partRef instanceof IEditorReference) {
					clearEditor( ((IEditorReference)partRef).getEditor(false));
				}				
			}

			@Override
			public void partDeactivated(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partOpened(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partHidden(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partVisible(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partInputChanged(IWorkbenchPartReference partRef) {
			}
			
		});
		
		setEditor(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().getActiveEditor());	
	}
	
	
	private void setEditor(IEditorPart ed) {
		if (ed==editor) return;
		if (ed!=null) {
			if (ed instanceof ClarionToJavaEditor) {
				dropEditor();
				editor =(ClarionToJavaEditor)ed;
				if (editor.getModel()==null) {
					editor=null;
				}
			} else {
				dropEditor();
			}
		} else {
			dropEditor();
		}
		
		for (Control c : parent.getChildren()) {
			c.dispose();
		}
		
		if (editor==null) {
			Label t = new Label(parent,SWT.NONE);
			t.setText("No Clarion Designer Selected");			
		} else {
			tree=new Tree(parent,SWT.BORDER);
			viewer=(ClarionToJavaOutlinePage) editor.getAdapter(IContentOutlinePage.class);
			viewer.addSelectionChangedListener(this);
			DragSource source = new DragSource(tree,  DND.DROP_MOVE | DND.DROP_COPY);
			source.setTransfer(new Transfer[] { ControlTemplateTransfer.getInstance(),TextTransfer.getInstance() });			
			source.addDragListener(new DragSourceListener() {
				@Override
				public void dragStart(DragSourceEvent event) {
					if (tree.getSelectionCount()==0) {
						event.doit=false;
						return;
					}
					TreeItem ti = tree.getSelection()[0];
					if (ti.getData("Template")==null) {
						event.doit=false;
						return;
						
					}
					
				}

				@Override
				public void dragSetData(DragSourceEvent event) {
					
					TreeItem ti = tree.getSelection()[0];
					StringBuilder sb = new StringBuilder();
					TemplateCmd tc = (TemplateCmd)ti.getData("Template");
					CodeSection cs = (CodeSection)ti.getData("CodeSection");
					AtSource as = (AtSource)ti.getData("AtSource");
					
					sb.append("Template=").append(tc.getName()).append(";");
					sb.append("Type=").append(cs.getItemType()).append(";Name=").append(cs.getCodeID());
					if (as instanceof Addition) {
						sb.append(";Parent=").append(((Addition)as).getInstanceID());
					}
					event.data=sb.toString();
				}

				@Override
				public void dragFinished(DragSourceEvent event) {
				}
				
			});
			loadTree();
		}
		parent.layout(true);
		parent.redraw();
	}

	private void dropEditor() {
		if (viewer!=null) {
			viewer.removeSelectionChangedListener(this);
		}
		editor=null;
	}
	
	private void loadTree()
	{
		AppProject project = editor.getModel().getApp().getAppProject();
		ExecutionEnvironment generator=getEnvironment();
		AtSource as  = editor.getDirtyProcedure();

		if (tree.getItemCount()==0) {
			addControls = new TreeItem(tree,SWT.NONE);
			addControls.setText("Add Related Control");
			TreeItem newControls = new TreeItem(tree,SWT.NONE);
			newControls.setText("New Control");
			loadTree(generator,as,project,newControls);
		} else {
			for (TreeItem ti : addControls.getItems()) {
				ti.dispose();
			}
		}
		
		AbstractPropertyObjectWrapper po =viewer.getFirstSelection();
		if (po!=null && (po instanceof ControlWrapper)) {
			String seq[] =ExtendProperties.get(po.getPropertyObject()).getPragma("SEQ");
			if (seq!=null) {
				int id = Integer.parseInt(seq[0]);
				as = editor.getDirtyProcedure().getAddition(id);
				if (as!=null) {
					loadTree(generator,as,project,addControls);
				}
			}
		}
		
		
		project.recycleEnvironment(generator);
	}
	
	public ExecutionEnvironment getEnvironment()
	{
		AppProject project = editor.getModel().getApp().getAppProject();
		ExecutionEnvironment generator = project.getEnvironment(true);		
		generator.setAlternative(editor.getModel().getProcedure(),editor.getDirtyProcedure());
		return generator;
	}
	
	
	private void loadTree(ExecutionEnvironment generator,AtSource as,AppProject project,TreeItem ni)
	{
		AtSourceSession session = generator.getSession(as);		
		AdditionExecutionState state = session. prepareToExecute();
		session.prepare();		
		
		for (TemplateCmd cmd : project.getChain().getTemplates()) {
			if (!cmd.getFamily().equals(as.getBase().getChain())) continue;
			TreeItem family = null;
			for (CodeSection cs : cmd.getSection("#CONTROL")) {
				AdditionCodeSection ec = (AdditionCodeSection)cs;
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
				
				if (as instanceof Procedure) {
					if (ec.getRequired()!=null) continue;
					if (!ec.isWindow()) continue;					
					//if (!ec.isProcedure()) continue;
				} else {
					if (ec.getRequired()==null) continue;
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
					family=new TreeItem(ni,SWT.NONE);
					family.setText(cmd.getDescription());
					ni.setExpanded(true);					
				}
				TreeItem add = new TreeItem(family,SWT.NONE);
				add.setData("Template",cmd);
				add.setData("CodeSection",cs);
				add.setData("AtSource",as);
				add.setText(ec.getDescription());
			}
			if (family!=null) {
				family.setExpanded(true);
			}
		}
		
		state.finish();
	}


	private void clearEditor(IEditorPart editor) {
		if (this.editor!=null && this.editor==editor) {
			setEditor(null);
		}
	}
	

	@Override
	public void dispose() {
		super.dispose();
	}


	@Override
	public void setFocus() {
	}


	@Override
	public void selectionChanged(SelectionChangedEvent event) 
	{
		loadTree();
	}
}
