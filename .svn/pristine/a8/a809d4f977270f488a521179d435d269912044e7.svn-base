package org.jclarion.clarion.appgen.symbol.system;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FlatFields;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionLoader;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;
import org.jclarion.clarion.control.ListColumn;
import org.jclarion.clarion.lang.Lex;

/**
 * Class is used to help manufacture scopes that feed off system data stores. i.e.:
 *   Application
 *   Dictionary
 *   Procedure
 *   Window/Report
 * 
 * 
 * @author barney
 *
 */
public class AppSymbolScope extends SystemSymbolScope
{
	private static class ControlStringProperty extends SymbolFactory<AppSymbolScope> 
	{
		private String name;

		public ControlStringProperty(String name)
		{
			super(false,"%control");
			this.name=name;
		}
		
		@Override			
		public SymbolValue load(AppSymbolScope scope) {
			return SymbolValue.construct(scope.control.getValue(name));
		}
	}
	
	private static final Map<String,String[]> controlevents=new HashMap<String,String[]>();		
	static FactoryBuilder<AppSymbolScope> builder;
	
	static {
		builder=new FactoryBuilder<AppSymbolScope>();
		
		builder.add("%application",new SymbolFactory<AppSymbolScope>() {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.source.getName());
			}
		});

		
		builder.add("%globaldata",new SymbolFactory<AppSymbolScope>(true) {
			@Override
			public SymbolValue load(final AppSymbolScope scope) { 
				List<String> fn = new ArrayList<String>();
				scope.globalFields=FlatFields.flatten(scope.source.getProgram().getFields());
				for (Field f : scope.globalFields) {
					fn.add(f.getLabel());
				}
				return new ROSetListSymbol(fn) {
					@Override
					public void applyFix(int value) {
						scope.globalField=scope.globalFields.get(value);
					}										
				};
			}
		});
		
		builder.add("%globaldatastatement",new SymbolFactory<AppSymbolScope>(false,"%globaldata") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return scope.globalField.getStatement();
			}
		});		

		builder.add("%globaldatalast",new SymbolFactory<AppSymbolScope>(false,"%globaldata") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(false);
			}
		});		

		builder.add("%globaldataindictionary",new SymbolFactory<AppSymbolScope>(false,"%globaldata") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(false);
			}
		});		
		
		builder.add("%globaldatalevel",new SymbolFactory<AppSymbolScope>(false,"%globaldata") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.globalField.getDefinition().getIndent());
			}
		});		
		
		builder.add("%helpfile",new SymbolFactory<AppSymbolScope>() {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return StringSymbolValue.BLANK;
			}
		});

		builder.add("%firstprocedure",new SymbolFactory<AppSymbolScope>() {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.source.getProcedure());
			}
		});
		
		builder.add("%module",new SymbolFactory<AppSymbolScope>(true) {
			@Override
			public SymbolValue load(final AppSymbolScope scope) { 
				List<String> modules = new ArrayList<String>();
				for (Module m : scope.source.getModules()) {
					modules.add(m.getName());
				}
				
				
				return new ROSetListSymbol(modules) {
					@Override
					public void applyFix(int value) {
						scope.module=scope.source.getModule(value);
					}
				};
			}					
		});

		builder.add("%moduleinclude",new SymbolFactory<AppSymbolScope>(false,"%module") {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				return SymbolValue.construct(scope.module.getInclude());
			}
		});
		
		builder.add("%modulechanged",new SymbolFactory<AppSymbolScope>(false,"%module") {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				return SymbolValue.construct(false);
			}			
		});
		
		builder.add("%moduledata",new SymbolFactory<AppSymbolScope>(true,"%module") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				
				scope.moduleFields=FlatFields.flatten(scope.module.getFields());
				List<String> fields = new ArrayList<String>(scope.moduleFields.size());
				for (Field f : scope.moduleFields) {
					String label=f.getLabel();
					fields.add(label!=null ? label : "");
				}
				return new ROSetListSymbol(fields) {
					@Override
					public void applyFix(int ofs) {
						scope.moduleField=scope.moduleFields.get(ofs);
					}					
				};				
			}
		});
		
		builder.add("%moduledatastatement",new SymbolFactory<AppSymbolScope>(false,"%moduledata") {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				return scope.moduleField.getStatement();
			}
		});

		builder.add("%modulebase",new SymbolFactory<AppSymbolScope>(false,"%module") {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				String name = scope.module.getName();
				return SymbolValue.construct(name.substring(0,name.indexOf('.')));
			}
		});

		builder.add("%moduleexternal",new SymbolFactory<AppSymbolScope>(false,"%module") {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				return SymbolValue.construct(scope.module.getInclude()!=null);
			}
		});

		builder.add("%moduletemplate",new SymbolFactory<AppSymbolScope>(false,"%module") {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				return SymbolValue.construct(scope.module.getBase().getType()+"("+scope.module.getBase().getChain()+")");
			}
		});
		
		builder.add("%moduleprocedure",new SymbolFactory<AppSymbolScope>(true,"%module") {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				List<String> procs = new ArrayList<String>();
				for (Procedure p : scope.module.getProcedures()) {
					procs.add(p.getName());
				}
				return new ROSetListSymbol(procs);
			}
		});

		builder.add("%procedure",new SymbolFactory<AppSymbolScope>("STRING",true,true) {
			@Override
			public SymbolValue load(final AppSymbolScope scope) { 
				Set<String> procs = new TreeSet<String>();
				for (Procedure p : scope.source.getProcedures()) {
					procs.add(p.getName());
				}
				return new ROSetListSymbol(procs) {
					@Override
					public void applyFix(String value) {
						scope.procedure=null;
						if (scope.module!=null) {
							scope.procedure=scope.alt(scope.module.getProcedure(value));
						}
						if (scope.procedure==null) {
							scope.procedure=scope.alt(scope.source.getProcedure(value));
						}
						scope.window=null;
						scope.controls=null;
					}					
				};
			}
		});

		builder.add("%formula",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return ROSetListSymbol.create();
			}
		});

		builder.add("%activetemplate",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				Set<String> templates = new TreeSet<String>();
				for (Addition a : scope.procedure.getAllAdditions()) {
					TemplateID base = a.getBase();
					if (base.getChain()==null) throw new IllegalStateException("Base is null");
					templates.add(base.getType()+"("+base.getChain()+")"); 
				}
				return new ROSetListSymbol(templates);
			}
		});

		builder.add("%activetemplateinstance",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				List<String> templates = new ArrayList<String>();
				templates.add("");
				
				//String fixvalue = scope.get("%activetemplate").getFix();
				
				for (Addition a : scope.procedure.getAllAdditions()) {
					TemplateID base = a.getBase();
					if (base.getChain()==null) throw new IllegalStateException("Base is null");
					//String key = base.getType()+"("+base.getChain()+")";
					//if (key.equals(fixvalue)) {
						templates.add(String.valueOf(a.getInstanceID()));
					//}
				}
				return new ROSetListSymbol(templates) {
					@Override
					public void applyFix(String value) {
						if (value.length()>0) {
							int instance=Integer.parseInt(value);
							scope.addition=scope.procedure.getAddition(instance);
						}
					}										
				};
			}
		});

		builder.add("%activetemplateparentinstance",new SymbolFactory<AppSymbolScope>(false,"%activetemplateinstance") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				if (scope.addition.getParent()==null) {
					return StringSymbolValue.BLANK;
				}
				return SymbolValue.construct(scope.addition.getParentID());
			}
		});
		
		builder.add("%otherfiles",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return new ROSetListSymbol(scope.procedure.getOtherFiles());
			}
		});

		builder.add("%localdata",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				scope.localFields=FlatFields.flatten(scope.procedure.getFields());
				List<String> fields = new ArrayList<String>(scope.localFields.size());
				for (Field f : scope.localFields) {
					String label=f.getLabel();
					fields.add(label!=null ? label : "");
				}
				return new ROSetListSymbol(fields) {
					@Override
					public void applyFix(int ofs) {
						scope.localField=scope.localFields.get(ofs);
					}					
				};
			}
		});

		builder.add("%localdatastatement",new SymbolFactory<AppSymbolScope>(false,"%localdata") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return scope.localField.getStatement();
			}
		});		

		
		builder.add("%procedurecalled",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				return new ROSetListSymbol(scope.procedure.getAllCalls());
			}
		});

		builder.add("%proceduretype",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				return SymbolValue.construct(scope.procedure.getReturnType().length()>0 ? "FUNCTION" : "PROCEDURE");
			}
		});

		builder.add("%procedurereturntype",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				return SymbolValue.construct(scope.procedure.getReturnType());
			}
		});
		
		builder.add("%prototype",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				return SymbolValue.construct(scope.procedure.getPrototype());
			}
		});

		builder.add("%proceduredescription",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				return SymbolValue.construct(scope.procedure.getDescription());
			}
		});

		builder.add("%proceduretemplate",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				return SymbolValue.construct(scope.procedure.getBase().getType());
			}
		});
		
		builder.add("%procedureisglobal",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) { 
				return SymbolValue.construct(scope.procedure.isGlobal());
			}
		});
		
		builder.add("%window",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				if (!scope.loadWindow()) return StringSymbolValue.BLANK;
				return SymbolValue.construct(scope.window.getName());
			}
		});

		builder.add("%report",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return ROSetListSymbol.create();
			}
		});
		
		builder.add("%windowstatement",new SymbolFactory<AppSymbolScope>(false,"%procedure") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				if (!scope.loadWindow()) return StringSymbolValue.BLANK;
				return scope.window.getStatement().asSymbolValue();
			}
		});
		
		builder.add("%control",new SymbolFactory<AppSymbolScope>(true,"%procedure") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {		
				if (!scope.loadWindow()) {
					return ROSetListSymbol.create();
				}
				List<String> controls = new ArrayList<String>(scope.controls.size());
				controls.addAll(scope.controls.keySet());
				return new ROSetListSymbol(controls) {
					@Override
					public void applyFix(String value) {
						scope.loadWindow();
						scope.control=scope.controls.get(value);		
						scope.listFormat=null;
					}					
				};
			}
		});

		builder.add("%controlparent",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				
				Definition parent = scope.control.getParent();
				if (parent==null) {
					return StringSymbolValue.BLANK;
				} else {
					return SymbolValue.construct(parent.getUse());
				}
			}
		});
		
		builder.add("%controltype",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.control.getTypeProperty().getName().toUpperCase());
			}
		});
		
		controlevents.put("list",new String[] { "Accepted","NewSelection","Selected" });
		controlevents.put("list-imm",new String[] { 
				"0102h","ScrollUp","ScrollDown","PageUp","PageDown","ScrollTop","ScrollBottom",
				"ScrollTrack","ScrollDrag","AlertKey","PreAlertKey","ColumnResize"
				});
		controlevents.put("button",new String[] { "0102h","Accepted","Selected" });
		controlevents.put("check",new String[] { "Accepted","Selected" });
		controlevents.put("option",new String[] { "Accepted","Selected" });
		controlevents.put("radio",new String[] { "Accepted","Selected" });
		controlevents.put("tab",new String[] {});
		controlevents.put("ellipse",new String[] {});
		controlevents.put("menu",new String[] {});
		controlevents.put("item",new String[] { "Accepted" });
		controlevents.put("prompt",new String[] {});
		controlevents.put("menubar",new String[] {});
		controlevents.put("image",new String[] {});
		controlevents.put("progress",new String[] {});
		controlevents.put("string",new String[] {});
		controlevents.put("group",new String[] {});
		controlevents.put("panel",new String[] {});
		controlevents.put("line",new String[] {});
		controlevents.put("box",new String[] {});
		controlevents.put("sheet",new String[] { "Accepted", "NewSelection", "Selected", "TabChanging" });
		controlevents.put("entry",new String[] { "0102h","Accepted", "Rejected", "Selected" } );
		controlevents.put("entry-imm",new String[] { "NewSelection" } );
		controlevents.put("text",new String[] { "Accepted","Selected" });
		controlevents.put("combo",new String[] { "Accepted", "Rejected", "Selected","NewSelection" } );
		controlevents.put("spin",new String[] { "Accepted", "Rejected", "Selected","NewSelection" } );

		final String[] baseWindowEvents=new String[] { "CloseWindow","CloseDown",
				"OpenWindow","LoseFocus","GainFocus","AlertKey","PreAlertKey","020Ah","Completed","Move","Size","Restore","Maximize",
				"Iconize","Moved","Sized","Restored","Maximized","Iconized","03FFh" };
		
		builder.add("%windowevent",new SymbolFactory<AppSymbolScope>(true,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				List<String> ts = new ArrayList<String>();
				for (String s : baseWindowEvents ) {
					ts.add(s);
				}
				if (scope.window.getProperty("TIMER")!=null) {
					ts.add("Timer");
				}
				return new ROSetListSymbol(ts);
			}
		});
		
		builder.add("%controlevent",new SymbolFactory<AppSymbolScope>(true,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				
				String name = scope.control.getTypeProperty().getName().toLowerCase();				
				String[] bits = controlevents.get(name);
				if (bits==null) {
					throw new IllegalStateException("Events for "+name+" unknown");
				}
				List<String> events = new ArrayList<String>();
				for (String s : bits) {
					events.add(s);
				}
				
				if (scope.control.getProperty("DRAGID")!=null) {
					events.add("Drag");
					events.add("Dragging");
				}

				if (scope.control.getProperty("DROPID")!=null) {
					events.add("Drop");
				}
				
				if (scope.control.getProperty("IMM")!=null) {
					bits = controlevents.get(name+"-imm");
					if (bits!=null) {
						for (String s : bits) {
							events.add(s);
						}						
					}
				}
				
				if (name.equals("list")) {
					scope.loadListFormat();
					if (scope.listFormat!=null) {
						for (ListColumn lc : scope.listFormat) {
							if (lc.isTree()) {
								events.add("Expanded");
								events.add("Contracted");
								break;
							}
						}
					}
				}
				
				return new ROSetListSymbol(events);
			}
		});
		
		
		builder.add("%controlindent",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.control.getIndent()-1);
			}
		});

		builder.add("%controlmenu",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				Definition d = scope.control;
				while (d!=null) {
					if (d.getTypeName().equalsIgnoreCase("MENUBAR")) return SymbolValue.construct(true);
					d=d.getParent();
				}
				return SymbolValue.construct(false);
			}
		});

		builder.add("%controltool",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				Definition d = scope.control;
				while (d!=null) {
					if (d.getTypeName().equalsIgnoreCase("TOOLBAR")) return SymbolValue.construct(true); 
					d=d.getParent();
				}
				return SymbolValue.construct(false);
			}
		});
		
		builder.add("%controluse",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				DefinitionProperty dp = scope.control.getProperty("USE");
				if (dp==null) return StringSymbolValue.BLANK;
				return dp.get(0);
			}
		});
		
		builder.add("%controlinstance",new ControlStringProperty("#SEQ"));
		builder.add("%controloriginal",new ControlStringProperty("#ORIG"));

		builder.add("%controlstatement",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return scope.control.getStatement().asSymbolValue();
			}
		});

		builder.add("%controlunsplitstatement",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.control.renderUnsplit());
			}
		});
		
		builder.add("%controlfield",new SymbolFactory<AppSymbolScope>(true,"%control") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				List<String> controls = new ArrayList<String>();
				DefinitionProperty prop = scope.control.getProperty("#FIELDS");
				if (prop!=null) {
					for (Lex l : prop.getParams()) {
						controls.add(l.value);
					}
				}
				return new ROSetListSymbol(controls) {
					@Override
					public void applyFix(int ofs) {
						scope.loadListFormat();
						scope.listColumn=scope.listFormat[ofs];
					}					
				};
			}
		});
		
		builder.add("%controlhascolor",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				scope.loadListFormat();
				if (scope.listFormat!=null) {
					for (ListColumn scan : scope.listFormat) {
						if (scan.isColor()) {
							return SymbolValue.construct(true);
						}
					}
				}
				return SymbolValue.construct(false);
			}
		});

		builder.add("%controlhasicon",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				scope.loadListFormat();
				if (scope.listFormat!=null) {
					for (ListColumn scan : scope.listFormat) {
						if (scan.isIcon()) {
							return SymbolValue.construct(true);
						}
					}
				}
				return SymbolValue.construct(false);
			}
		});

		builder.add("%controlhasstyle",new SymbolFactory<AppSymbolScope>(false,"%control") {
			@Override
			public SymbolValue load(final AppSymbolScope scope) {
				scope.loadListFormat();
				if (scope.listFormat!=null) {
					for (ListColumn scan : scope.listFormat) {
						if (scan.isStyle()) {
							return SymbolValue.construct(true);
						}
					}
				}
				return SymbolValue.construct(false);
			}
		});
		
		builder.add("%controlfieldhascolor",new SymbolFactory<AppSymbolScope>(false,"%controlfield") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.listColumn.isColor());
			}
		});
		builder.add("%controlfieldhastip",new SymbolFactory<AppSymbolScope>(false,"%controlfield") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(false);
			}
		});
		builder.add("%controlfieldhasicon",new SymbolFactory<AppSymbolScope>(false,"%controlfield") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.listColumn.isIcon() ||scope.listColumn.isTransparantIcon());
			}
		});
		builder.add("%controlfieldhastree",new SymbolFactory<AppSymbolScope>(false,"%controlfield") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.listColumn.isTree());
			}
		});
		builder.add("%controlfieldhasstyle",new SymbolFactory<AppSymbolScope>(false,"%controlfield") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.listColumn.isStyle());
			}
		});
		builder.add("%controlfieldpicture",new SymbolFactory<AppSymbolScope>(false,"%controlfield") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.listColumn.getPicture().getPicture());
			}
		});
		builder.add("%controlfieldheader",new SymbolFactory<AppSymbolScope>(false,"%controlfield") {
			@Override
			public SymbolValue load(AppSymbolScope scope) {
				return SymbolValue.construct(scope.listColumn.getHeader());
			}
		});
		
		builder.add("%driver",new SymbolFactory<AppSymbolScope>(true) {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				return ROSetListSymbol.create("ASCII","DOS","SQL","BASIC");
			}
		});

		builder.add("%program",new SymbolFactory<AppSymbolScope>() {
			@Override
			public SymbolValue load(AppSymbolScope scope) { 
				return SymbolValue.construct(scope.source.getProgram().getName());
			}
		});
		
	}
	
	private Procedure 		procedure;
	private App 			source;
	private Module 			module;
	private Definition 		control;
	protected ListColumn[]  listFormat;
	protected ListColumn	listColumn;
	private List<Field>		localFields;
	private Field 			localField;
	private List<Field> 	moduleFields;
	private Field 			moduleField;
	private Addition		addition;
	
	private List<Field>		globalFields;
	private Field 			globalField;
	
	
	private Map<String,Definition> controls;
	private Definition				window;
	
	public AppSymbolScope(App app,ExecutionEnvironment environment)
	{
		super(builder.get(),environment);
		this.source=app;
	}
	
	protected void loadListFormat() {
		if (listFormat!=null) return;
		if (control==null) return;
		DefinitionProperty d = control.getProperty("FORMAT");
		if (d==null) return;
		if (d.size()==0) return;
		String format=d.getProp(0).value;
		listFormat=ListColumn.construct(format);
	}
	

	public boolean loadWindow()
	{
		if (window!=null) return true; 
		
		if (procedure.getWindow()==null) {
			window=null;
			controls=null;
			return false;
		}
		window=DefinitionLoader.loadStructure(procedure.getWindow());
		controls=new LinkedHashMap<String,Definition>();
		
		boolean nullUse=false;
		
		for (Definition ci : window.getAll()) {
			if (ci==window) continue;
			String use = ci.getUse();
			if (use==null) {
				nullUse=true;
				continue;
			}
			controls.put(use,ci);
		}
		
		if (nullUse) {
			controls=new LinkedHashMap<String,Definition>();
			Set<String> ucControls=new HashSet<String>();
			for (String c : controls.keySet()) {
				ucControls.add(c.toUpperCase());
			}
			
			for (Definition ci : window.getAll()) {
				if (ci==window) continue;
				String use = ci.getUse();
				if (use==null) {
					int scan=1;
					while ( true ) {
						ci.setDefUseID(scan);
						use = ci.getUse();
						if (ucControls.contains(use)) {
							scan++;
							continue;
						}
						ucControls.add(use.toUpperCase());
						break;
					}
				}
				controls.put(use,ci);
			}			
		}
		
		return true;
	}	
}
