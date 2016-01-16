package org.jclarion.clarion.ide.view;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.jface.viewers.TreeViewer;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.swt.dnd.DND;
import org.eclipse.swt.dnd.DragSourceEvent;
import org.eclipse.swt.dnd.DragSourceListener;
import org.eclipse.swt.dnd.TextTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.widgets.Composite;
import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.Component;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.File;
import org.jclarion.clarion.appgen.app.FileJoin;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.editor.DefinitionTransfer;
import org.jclarion.clarion.ide.model.DirtyProcedureListener;
import org.jclarion.clarion.ide.model.DirtyProcedureMonitor;
import org.jclarion.clarion.ide.model.app.ProcedureSave;
import org.jclarion.clarion.ide.model.app.ProcedureSaveListener;
import org.jclarion.clarion.lang.Lex;

public class FieldTreeHelper implements ITreeContentProvider, ProcedureSaveListener, DirtyProcedureListener
{
	private AbstractClarionEditor editor;
	private Composite parent;
	private TreeViewer viewer;
	private int additionFilter;
	
	private static interface FieldName
	{
		public String getFieldName();
		public Definition getFieldDefinition();
	}
	
	private static abstract class AbstractAppProvider
	{
		private String name;

		public AbstractAppProvider(String name)
		{
			this.name=name;
		}
		
		public abstract Component getCompareComponent();
		public abstract Component getFieldSourceComponent();
		
		public String toString()
		{
			return name;
		}

		@Override
		public int hashCode()
		{
			return getCompareComponent().hashCode();
		}
		
		@Override
		public boolean equals(Object o) {
			if (o==this) return true;
			if (o==null) return false;
			if (o.getClass()!=getClass()) return false;
			return ((AbstractAppProvider)o).getCompareComponent()==getCompareComponent();
		}
	}
	
	public class ProcAppProvider extends AbstractAppProvider
	{
		public ProcAppProvider()
		{
			super("Procedure Fields");
		}

		@Override
		public Component getCompareComponent() {
			return editor.getModel().getProcedure();
		}

		@Override
		public Component getFieldSourceComponent() {
			return getProcedure(editor);
		}
		
		
	}
	
	
	private static  class BasicAppProvider extends AbstractAppProvider	
	{
		private Component c;

		public BasicAppProvider(String name,Component c)
		{
			super(name);
			this.c=c;
		}
		
		@Override
		public Component getCompareComponent() {
			return c;
		}

		@Override
		public Component getFieldSourceComponent() {
			return c;
		}
	}
	
	private static class DictFieldProvider implements FieldName
	{
		private org.jclarion.clarion.appgen.dict.Field field;
		private org.jclarion.clarion.appgen.dict.File file;
		
		public DictFieldProvider(org.jclarion.clarion.appgen.dict.File file,org.jclarion.clarion.appgen.dict.Field field) {
			this.field=field;
			this.file=file;
		}
		
		public String toString()
		{
			return field.getField().getName();
		}
		
		@Override
		public int hashCode()
		{
			return field.hashCode();
		}		
		
		public boolean equals(Object o) {
			if (o==this) return true;
			if (o==null) return false;
			if (o.getClass()!=getClass()) return false;
			return ((DictFieldProvider)o).field==field;
		}

		@Override
		public String getFieldName() {
			return file.getFile().getValue("PRE")+":"+field.getField().getName();
		}

		@Override
		public Definition getFieldDefinition() {
			return field.getField();
		}						
	}

	private static class DictKeyProvider implements FieldName
	{
		private org.jclarion.clarion.appgen.dict.Key key;
		private org.jclarion.clarion.appgen.dict.File file;
		
		public DictKeyProvider(org.jclarion.clarion.appgen.dict.File file,org.jclarion.clarion.appgen.dict.Key key) {
			this.key=key;
			this.file=file;
		}
		
		public String toString()
		{
			return key.getKey().getName();
		}
		
		@Override
		public int hashCode()
		{
			return key.hashCode();
		}		
		
		public boolean equals(Object o) {
			if (o==this) return true;
			if (o==null) return false;
			if (o.getClass()!=getClass()) return false;
			return ((DictKeyProvider)o).key==key;
		}

		@Override
		public String getFieldName() {
			return file.getFile().getValue("PRE")+":"+key.getKey().getName();
		}		
		
		@Override
		public Definition getFieldDefinition() {
			return key.getKey();
		}								
	}
	
	private static class FileProvider implements FieldName
	{
		private org.jclarion.clarion.appgen.dict.File file;
		
		public FileProvider(org.jclarion.clarion.appgen.dict.File name)
		{
			this.file=name;
		}
		
		public String toString()
		{
			return "TABLE: "+file.getFile().getName();
		}
		
		@Override
		public int hashCode()
		{
			return file.hashCode();
		}		
		
		public boolean equals(Object o) {
			if (o==this) return true;
			if (o==null) return false;
			if (o.getClass()!=getClass()) return false;
			return ((FileProvider)o).file==file;
		}

		@Override
		public String getFieldName() {
			return file.getFile().getName();
		}

		@Override
		public Definition getFieldDefinition() {
			return file.getFile();
		}				
		
	}

	private static class AppFieldProvider implements FieldName
	{
		private Field field;
		private AbstractAppProvider ancestor;

		public AppFieldProvider(AbstractAppProvider ancestor,Field field)
		{
			this.field=field;
			this.ancestor=ancestor;
		}
		
		public String toString()
		{
			return field.getLabel();
		}
		
		@Override
		public int hashCode()
		{
			return field.hashCode();
		}		
		
		public boolean equals(Object o) {
			if (o==this) return true;
			if (o==null) return false;
			if (o.getClass()!=getClass()) return false;
			return ((AppFieldProvider)o).field==field;
		}

		@Override
		public String getFieldName() {
			String result = field.getLabel();
			Field scan=field.getParentField();
			while (scan!=null) {
				String pre = scan.getDefinition().getValue("PRE");
				if (pre==null || pre.length()==0) {
					result=scan.getLabel()+"."+result;
				} else {
					result=pre+":"+result;
				}
				scan=scan.getParentField();
			}
			return result;
		}	
		
		@Override
		public Definition getFieldDefinition() {
			return field.getDefinition();
		}						
	}

	public FieldTreeHelper(AbstractClarionEditor editor,Composite parent)
	{
		this(editor,parent,0);
	}
	
	public FieldTreeHelper(AbstractClarionEditor editor,Composite parent,int additionFilter)
	{
		this.editor=editor;
		this.parent=parent;
		this.additionFilter=additionFilter;
	}
	
	private Object getFirstSelection()
	{
		ISelection is = viewer.getSelection();
		if (!(is instanceof StructuredSelection)) return null;
		StructuredSelection ss = (StructuredSelection)is;
		if (ss.size()==0) return null;
		return ss.getFirstElement();
	}
	
	public String getFieldName()
	{
		Object o = getFirstSelection();
		if (o==null) return null;
		if (o instanceof FieldName) {
			return ((FieldName)o).getFieldName();
		}
		return null;
	}

	public Definition getFieldDefinition(boolean origName)
	{
		Object o = getFirstSelection();
		if (o==null) return null;
		if (o instanceof FieldName) {
			FieldName fn = (FieldName)o;
			if (origName) return fn.getFieldDefinition();
			Definition x = fn.getFieldDefinition();
			x=new Definition(x);
			x.setName(fn.getFieldName());
			return x;
		}
		return null;
	}
	
	public TreeViewer getViewer()
	{
		if (viewer==null) {
			viewer=new TreeViewer(parent);
			viewer.setContentProvider(this);
			viewer.setInput(editor);
			viewer.setExpandedElements(new Object[] {
					new ProcAppProvider()					
			});
			ProcedureSave.get(editor.getModel().getProcedure()).add(this);
			if (editor.getDirtyProcedure()!=null) {
				DirtyProcedureMonitor.get(editor.getDirtyProcedure()).addListener(this);
			}
			
			
			viewer.addDragSupport(DND.DROP_MOVE | DND.DROP_COPY,new Transfer[] { DefinitionTransfer.getInstance(),TextTransfer.getInstance() }, 
					new DragSourceListener() {
				@Override
				public void dragStart(DragSourceEvent event) {
					Object o =getFirstSelection();
					if (o==null || (!(o instanceof FieldName)) || (((FieldName)o).getFieldName()==null)) { 
						event.doit=false;
						return;
					}
				}

				@Override
				public void dragSetData(DragSourceEvent event) 
				{
					if (DefinitionTransfer.getInstance().isSupportedType(event.dataType)) {
						event.data=getFieldDefinition(false);
					}
					if (TextTransfer.getInstance().isSupportedType(event.dataType)) {
						event.data=getFieldName();
					}
				}

				@Override
				public void dragFinished(DragSourceEvent event) 
				{
				}
				
			});
		}
		
		return viewer;
	}
	
	public AbstractClarionEditor getEditor()
	{
		return editor;
	}
	
	
	@Override
	public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
	}
	
	@Override
	public void dispose() 
	{
		if (viewer==null) return;
		ProcedureSave.get(editor.getModel().getProcedure()).remove(this);
		if (editor.getDirtyProcedure()!=null) {
			DirtyProcedureMonitor.get(editor.getDirtyProcedure()).removeListener(this);
		}						
		viewer=null;
	}
	
	@Override
	public boolean hasChildren(Object element) {
		
		if (element instanceof AbstractClarionEditor) return true;
		
		if (element instanceof AbstractAppProvider) {						
			AbstractAppProvider as = (AbstractAppProvider)element;
			return as.getFieldSourceComponent().getFieldCount()>0;
		}					
		if (element instanceof AppFieldProvider) {						
			AppFieldProvider as = (AppFieldProvider)element;
			return as.field.getFieldCount()>0;
		}
		if (element instanceof FileProvider) {
			return true;
		}
		if (element instanceof DictKeyProvider) {
			return true;
		}
		return false;
	}
	
	@Override
	public Object getParent(Object element) {
		if (element instanceof AppFieldProvider) {
			AppFieldProvider as = (AppFieldProvider)element;
			if (as.field.getParentField()!=null) {
				return new AppFieldProvider(as.ancestor,as.field.getParentField());
			}
			return as.ancestor;
		}
		if (element instanceof FileProvider) {
			return editor;
		}
		if (element instanceof DictFieldProvider) {
			DictFieldProvider dfp = (DictFieldProvider)element;
			return new FileProvider(dfp.file);
		}
		if (element instanceof AbstractAppProvider) {
			return editor;
		}
		return null;
	}
	
	@Override
	public Object[] getElements(Object inputElement) {
		
		if (inputElement instanceof AbstractClarionEditor) {
			
			Procedure src = getProcedure(editor);
			if (src==null) return new Object[0];
			
			List<Object> result = new ArrayList<Object>();
			
			TreeSet<String> files = new TreeSet<String>();
			for (String name : src.getOtherFiles()) {
				files.add(name);
			}
			loadFiles(src,files);
			for (String res : files ) {
				org.jclarion.clarion.appgen.dict.File f = editor.getModel().getApp().getAppProject().getDict().getFile(res);
				if (f==null) continue;
				result.add(new FileProvider(f));
			}
			
			result.add(new ProcAppProvider());
			result.add(new BasicAppProvider("Module Fields",(Module)src.getParent()));
			result.add(new BasicAppProvider("App Fields",editor.getModel().getApp().getAppProject().getApp().getProgram()));
			
			return result.toArray();
		}
		
		if (inputElement instanceof DictKeyProvider) {
			DictKeyProvider kp= (DictKeyProvider)inputElement;
			List<Object> result = new ArrayList<Object>();
			
			for (Lex l : kp.key.getKey().getTypeProperty().getParams()) {
				String name = l.value;
				name=name.substring(name.indexOf(':')+1);
				org.jclarion.clarion.appgen.dict.Field f = kp.file.getField(name);
				if (f==null) continue;
				result.add(new DictFieldProvider(kp.file,f));
			}
			return result.toArray();
			
		}
		
		if (inputElement instanceof FileProvider) {
			FileProvider fp = (FileProvider)inputElement;
			List<Object> result = new ArrayList<Object>();
			org.jclarion.clarion.appgen.dict.File f = fp.file;
			for (org.jclarion.clarion.appgen.dict.Key scan : f.getKeys()) {
				result.add(new DictKeyProvider(f,scan));
			}
			for (org.jclarion.clarion.appgen.dict.Field scan : f.getFields()) {
				result.add(new DictFieldProvider(f,scan));
			}
			return result.toArray();
		}
		
		AbstractAppProvider ancestor=null;
		Iterable<Field> scan = null;
		if (inputElement instanceof AppFieldProvider) {
			AppFieldProvider as = (AppFieldProvider)inputElement;
			ancestor=as.ancestor;
			scan = as.field.getFields();
		}
		if (inputElement instanceof AbstractAppProvider) {
			ancestor=(AbstractAppProvider)inputElement;
			scan = ancestor.getFieldSourceComponent().getFields();
		}
		if (ancestor!=null) {
			List<AppFieldProvider> result = new ArrayList<AppFieldProvider>();
			for (Field f : scan) {
				result.add(new AppFieldProvider(ancestor,f));
			}
			return result.toArray(new Object[result.size()]);
		}
		
		return null;
	}
	
	
	private void loadFiles(AtSource src,TreeSet<String> files) {
		if (additionFilter<=0) { 
			loadFiles(src.getPrimaryFile(),files);
		} else {
			if (src instanceof Addition && ((Addition)src).getInstanceID()==additionFilter) {
				loadFiles(src.getPrimaryFile(),files);
			}
		}
		for (AtSource kid : src.getChildren()) {
			loadFiles(kid,files);
		}
	}

	private void loadFiles(File primaryFile,TreeSet<String> files) {
		if (primaryFile==null) return;
		files.add(primaryFile.getName());
		for (FileJoin fj : primaryFile.getChildren()) {
			loadFiles(fj.getChild(), files);
		}
	}

	@Override
	public Object[] getChildren(Object parentElement) {
		return getElements(parentElement);
	}
	
	public boolean isSameAs(AbstractClarionEditor editor)
	{
		return getProcedure(this.editor)==getProcedure(editor);
	}
	
	public boolean isValid()
	{
		return getProcedure(editor)!=null;
	}
	
	private Procedure getProcedure(AbstractClarionEditor editor)
	{
		if (editor==null) return null;
		if (editor.getModel()==null) return null;
		Procedure result = editor.getDirtyProcedure();
		if (result!=null) return result;
		return editor.getModel().getProcedure();
	}
	
	@Override
	public void procedureSaved() {
		if (viewer!=null) {
			viewer.refresh(editor);
			if (editor.getDirtyProcedure()!=null) {
				DirtyProcedureMonitor.get(editor.getDirtyProcedure()).removeListener(this);
				DirtyProcedureMonitor.get(editor.getDirtyProcedure()).addListener(this);
			}
		}		
	}

	@Override
	public void procedureDeleted() 
	{
	}

	@Override
	public void procedureChanged() 
	{
		if (viewer!=null) {
			viewer.refresh(editor);
		}
	}

}
