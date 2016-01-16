package org.jclarion.clarion.ide.dialog;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FieldStore;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class EditFieldDialog extends Dialog {

	private Field base;
	private Combo type;
	private Button allowPrefix;
	private Text prefix;
	private Button reference;
	private Button staticVar;
	private Text baseType;
	private Text length;
	private Text places;
	private Text dim;
	private Text init;
	private Text description;
	private Text name;
	private FieldStore store;
	private Field result;

	public EditFieldDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public EditFieldDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(Field base,FieldStore store)
	{
		this.base=base;
		this.store=store;
	}
	
	public Field getResult()
	{
		return result;
	}

	private static final String[] TYPES= "STRING|LONG|DECIMAL|ANY|QUEUE|GROUP|CLASS|LIKE|DATE|TIME".split("[|]");
	
	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Add/Edit Field");
		Composite container = (Composite) super.createDialogArea(parent);
		container.setLayout(new GridLayout(2,false));
		
		name=addText("Name",container,base==null ? null : base.getLabel(),150);
		
		addLabel(container,"Type");
		type = new Combo(container,SWT.DROP_DOWN);
		String typeVal=null;
		DefinitionProperty typeDef = base!=null ? base.getDefinition().getTypeProperty() : null; 
		boolean ref=false;
		if (base!=null) {
			typeVal=base.getDefinition().getTypeName();
			if (typeVal.startsWith("&")) {
				ref=true;
				typeVal=typeVal.substring(1);
			}
			type.setText(typeVal);
		}
		
		for (String t : TYPES ) {
			type.add(t);
			if (typeVal!=null && typeVal.equalsIgnoreCase(t)) {
				type.select(type.getItemCount());
			}
		}
		
		
		Label pl=addLabel(container,"Prefix");
		Canvas pc =new Canvas(container,SWT.NONE);
		pc.setLayout(new GridLayout(2,false));
		allowPrefix=new Button(pc,SWT.CHECK);
		allowPrefix.setSelection(base!=null && base.getDefinition().getProperty("PRE")!=null);
		allowPrefix.setData("form.label",pl);
		prefix=addText(null,pc,base!=null && base.getDefinition().getProperty("PRE")!=null ? base.getDefinition().getValue("PRE") : null,50); 
		description=addText("Description",container,base==null ? null : base.getDefinition().getComment(),300);		
		
		addLabel(container,"");
		pc =new Canvas(container,SWT.NONE);
		pc.setLayout(new GridLayout(2,false));
		reference=addCheck("Reference", pc, ref);
		staticVar=addCheck("Static",pc,base!=null && base.getDefinition().getProperty("STATIC")!=null);
		baseType=addText("Base Type",container,getBaseType(typeDef),150);
		length=addText("Characters",container,getLength(typeDef),60);
		places=addText("Places",container,getPlaces(typeDef),60);
		dim=addText("Dim",container,getDim(),100);
		init=addText("Initial Value",container,getValue(),200);
		
		refreshEnabled();
		
		
		
		RefreshListener refModify = new RefreshListener();
		type.addModifyListener(refModify);
		reference.addSelectionListener(refModify);
		allowPrefix.addSelectionListener(refModify);
			
		return container;
	}
	
	private class RefreshListener implements ModifyListener,SelectionListener
	{
		@Override
		public void widgetSelected(SelectionEvent e) {
			refreshEnabled();
			
		}

		@Override
		public void widgetDefaultSelected(SelectionEvent e) {
		}

		@Override
		public void modifyText(ModifyEvent e) {
			refreshEnabled();
		}
		
	}
	
	private static Set<String> ss(String ...items)
	{
		HashSet<String> r = new HashSet<String>();
		for (String item : items ) {
			r.add(item);
		}
		return r;
	}
	
	private static final Set<String> LENGTH = ss("STRING","CSTRING","PSTRING","DECIMAL");
	private static final Set<String>  PRE  = ss("QUEUE","RECORD");
	private static final Set<String>  BASE  = ss("QUEUE","RECORD","LIKE","CLASS");
	private static final Set<String> INITIAL = ss("STRING","CSTRING","PSTRING","DECIMAL","LONG","DATE","TIME","ULONG","BYTE","SHORT","USHORT","SIGNED","UNSIGNED");

	
	private void refreshEnabled() {
		setEnabled(length,  !reference.getSelection() && LENGTH.contains(type.getText().toUpperCase()) );
		setEnabled(places, type.getText().equalsIgnoreCase("DECIMAL"));
		setEnabled(allowPrefix,   !reference.getSelection() && PRE.contains(type.getText().toUpperCase()) );
		setEnabled(prefix,  !reference.getSelection() && allowPrefix.getSelection() && PRE.contains(type.getText().toUpperCase()) );
		setEnabled(init, !reference.getSelection() && INITIAL.contains(type.getText().toUpperCase()) );
		setEnabled(baseType, !reference.getSelection() && BASE.contains(type.getText().toUpperCase()) );
	}


	private void setEnabled(Control w, boolean b) {
		w.setEnabled(b);
		Label l = (Label)w.getData("form.label");
		if (l!=null) {
			l.setEnabled(b);
		}
	}

	private String getDim() {
		if (base==null) return null;		
		DefinitionProperty dp = base.getDefinition().getProperty("DIM");
		if (dp==null) return null;
		return dp.renderPart();
	}
	
	private String getValue()
	{
		if (base==null) return "";
		DefinitionProperty dp = base.getGuiDefinition().getProperty("INITIAL");
		if (dp==null) return "";
		String val = dp.getProp(0).value;
				
		int end = val.length();
		while (end>0) {
			if (val.charAt(end-1)==' ') {
				end--;
			} else {
				break;
			}
		}
		return end>0 ? val.substring(0,end) : val;
	}
	
	private String getBaseType(DefinitionProperty typeDef) 
	{
		if (typeDef==null) return "";
		String name = typeDef.getName();
		if (typeDef.getPropCount()==0) return "";
		if (BASE.contains(name.toUpperCase())) {
			return typeDef.getProp(0).value;
		}
		return "";
	}
	
	private String getLength(DefinitionProperty typeDef) {
		if (typeDef==null) return "";
		String name = typeDef.getName();
		if (typeDef.getPropCount()==0) return "";

		if (name.equalsIgnoreCase("STRING") || name.equalsIgnoreCase("PSTRING") || name.equalsIgnoreCase("CSTRING")) {
			Lex l = typeDef.getProp(0);
			if (l.type==LexType.string) {
				return String.valueOf(typeDef.getProp(0).value.length());
			}
			if (l.type==LexType.integer) {
				return l.value; 
			}
		}
		
		if (name.equalsIgnoreCase("DECIMAL")) {
			return typeDef.getProp(0).value;
		}
		
		return "";
	}

	private String getPlaces(DefinitionProperty typeDef) {
		if (typeDef==null) return "";
		String name = typeDef.getName();
		if (typeDef.getPropCount()==0) return "";
		if (name.equalsIgnoreCase("DECIMAL")) {
			if (typeDef.getPropCount()==1) {
				return "0";
			}
			return typeDef.getProp(1).value;
		}
		return "";
	}
	
	private Text addText(String label,Composite container, String string,int width) {
		Label l = null;
		if (label!=null) {
			l=addLabel(container,label);
		}
		Text t = new Text(container,SWT.BORDER);
		t.setData("form.label",l);
		if (string!=null) {
			t.setText(string);
		}
		
		GridData gd= new GridData();
		gd.widthHint=width;
		gd.minimumWidth=width;
		gd.grabExcessHorizontalSpace=true;
		t.setLayoutData(gd);
		return t;
	}

	private Button addCheck(String label,Composite container,boolean checked) {
		Button b = new Button(container,SWT.CHECK);
		if (label!=null) {
			b.setText(label);
		}
		b.setSelection(checked);
		return b;
	}
	
	private Label addLabel(Composite container, String init) 
	{
		Label t = new Label(container,SWT.NONE);
		t.setText(init);
		return t;
	}


	private void error(String reason) 
	{
		MessageBox mb = new MessageBox(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(),SWT.ICON_ERROR+SWT.OK);
		mb.setText("Add/Edit");
		mb.setMessage(reason);
		mb.open();
	}
	
	
	private static final String WS_BUFFER="                                                                                                             ";
	
	@Override
	protected void okPressed() {
		// construct result
		
		if (name.getText().trim().length()==0) {
			error("No field label");
			return;
		}

		if (type.getText().trim().length()==0) {
			error("No field type");
			return;
		}
		
		Field existing = store.getField(name.getText().trim());
		if (existing!=null && existing!=base) {
			error("Duplicate field name");
			return;			
		}
		
		Field result=  new Field();
		
		
		String whitespace=null;
		String name=this.name.getText();
		
		if (base!=null) {
			whitespace=base.getDefinition().getWhitespace();
			
			int change = name.length()-base.getLabel().length();
			if (change<0) {
				whitespace=whitespace+WS_BUFFER.substring(0,-change);
			}
			if (change>0) {
				int len  =whitespace.length()-change;
				if (len<4) len=4;
				whitespace=whitespace.substring(0,len);
			}			
		} else {
			int length=20;
			FieldStore fs = store; 
			while (fs!=null) {
				fs=fs.getParentField();
				length+=4;
			}
			length=length-name.length();
			if (length<4) length=4;
			whitespace=WS_BUFFER.substring(0,length);		
		}
		
		
		Definition main = new Definition(name,whitespace);
		main.add(constructType());
		if (description.getText().trim().length()>0) {
			main.setComment(description.getText().trim());
		}
		
		Map<String,DefinitionProperty> newVals = new LinkedHashMap<String,DefinitionProperty>();
		Set<String> remove=new HashSet<String>();
		if (prefix.getText().trim().length()>0 && prefix.isEnabled()) {
			newVals.put("PRE", new DefinitionProperty("PRE",new Lex(LexType.label,prefix.getText().trim())));
		}
		if (!allowPrefix.isEnabled() || !allowPrefix.getSelection()) {
			remove.add("PRE");
		}
		if (staticVar.getSelection()) {
			newVals.put("STATIC", new DefinitionProperty("STATIC"));
		}
		if (dim.getText().trim().length()>0) {
			String dim[] = this.dim.getText().trim().split("[^0-9]+");
			List<Lex> ldim = new ArrayList<Lex>();
			for (String d : dim) {
				if (d.length()==0) continue;
				ldim.add(new Lex(LexType.integer,d));
			}
			newVals.put("DIM", new DefinitionProperty("DIM",ldim));
		}		
		mergeDef(main,base!=null ? base.getDefinition() : null,newVals,remove );
		result.setDefinition(main);

		Definition gui = new Definition(null,null);
		if (base!=null) {
			gui.add(base.getGuiDefinition().getTypeProperty());
		} else {
			gui.add(new DefinitionProperty("GUID",new Lex(LexType.string,UUID.randomUUID().toString())));
		}
		
		remove.clear();
		newVals.clear();
		if (init.isEnabled()) {
			String init = this.init.getText();
			if (init.trim().length()==0) {
				remove.add("INITIAL");
			} else {
				String type = this.type.getText().toUpperCase();
				if (type.endsWith("STRING")) {
					int length = getInt(this.length);
					if (length>init.length()) {
						init=init+WS_BUFFER.substring(init.length(),length);
					}
					if (length<init.length()) {
						init=init.substring(0,length);
					}
					newVals.put("INITIAL",new DefinitionProperty("INITIAL",new Lex(LexType.string,init)));
				} else {
					init=init.trim();
					if (type.equals("DECIMAL")) {
						newVals.put("INITIAL",new DefinitionProperty("INITIAL",new Lex(LexType.decimal,init)));
					} else {
						newVals.put("INITIAL",new DefinitionProperty("INITIAL",new Lex(LexType.integer,init)));
					}
				}
			}
		}
		mergeDef(gui,base!=null ? base.getGuiDefinition() : null,newVals,remove );		
		result.setGuiDefinition(gui);

		this.result=result;
		super.okPressed();		
	}
	
	private void mergeDef(Definition main, Definition orig,Map<String,DefinitionProperty> newVals,Set<String> remove ) 
	{
		if (orig!=null) {
			for (DefinitionProperty scan : orig.getProperties()) {
				String name = scan.getName().toUpperCase();
				if (remove!=null && remove.contains(name)) continue;
				DefinitionProperty ne = newVals.remove(name);
				main.add(ne!=null ? ne : scan );
			}
		}
		for (DefinitionProperty scan : newVals.values()) {
			main.add(scan);
		}
	}

	private DefinitionProperty constructType()
	{
		String type = this.type.getText().toUpperCase();

		if (this.reference.getSelection()) {
			return new DefinitionProperty("&"+type);
		}
		
		if (type.equals("DECIMAL")) {
			int length = getInt(this.length);
			int places = getInt(this.places);
			
			if (places==0) {
				return new DefinitionProperty(type,new Lex(LexType.integer,String.valueOf(length)));
			}
			return new DefinitionProperty(type,new Lex(LexType.integer,String.valueOf(length)),new Lex(LexType.integer,String.valueOf(places)));
		}
		
		if (BASE.contains(type)) {
			String base = baseType.getText().trim();
			if (base.length()>0) {
				return new DefinitionProperty(type,new Lex(LexType.label,base));
			} else {
				return new DefinitionProperty(type);
			}
		}
		
		if (LENGTH.contains(type)) {
			int length = getInt(this.length);
			return new DefinitionProperty(type,new Lex(LexType.integer,String.valueOf(length)));
		}
		
		return new DefinitionProperty(type);
	}
	
	private int getInt(Text t)
	{
		if (!t.isEnabled()) return 0;
		String val = t.getText().trim();
		if (val.length()==0) return 0;
		return Integer.parseInt(val);
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
		return new Point(450, 400);
	}

}
