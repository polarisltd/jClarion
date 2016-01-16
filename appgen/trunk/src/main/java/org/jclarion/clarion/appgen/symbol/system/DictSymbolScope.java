package org.jclarion.clarion.appgen.symbol.system;


import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.Field;
import org.jclarion.clarion.appgen.dict.File;
import org.jclarion.clarion.appgen.dict.Join;
import org.jclarion.clarion.appgen.dict.Key;
import org.jclarion.clarion.appgen.dict.RelationKey;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
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
public class DictSymbolScope extends SystemSymbolScope
{
	private static class FileStringProperty extends SymbolFactory<DictSymbolScope> 
	{
		private String name;

		public FileStringProperty(String name)
		{
			super(false,"%file");
			this.name=name;
		}
		
		@Override			
		public SymbolValue load(DictSymbolScope scope) {
			return SymbolValue.construct(scope.file.getFile().getValue(name));
		}
	}

	private static class FieldStringProperty extends SymbolFactory<DictSymbolScope> 
	{
		private String name;

		public FieldStringProperty(String name)
		{
			super(false,"%field");
			this.name=name;
		}
		
		@Override			
		public SymbolValue load(DictSymbolScope scope) {
			return SymbolValue.construct(scope.field.getField().getValue(name));
		}
	}
	
	private static class FileBoolProperty extends SymbolFactory<DictSymbolScope> 
	{
		private String name;

		public FileBoolProperty(String name)
		{
			super(false,"%file");
			this.name=name;
		}
		
		@Override			
		public SymbolValue load(DictSymbolScope scope) {
			return SymbolValue.construct(scope.file.getFile().getProperty(name)!=null);
		}
	}

	private static class KeyBoolProperty extends SymbolFactory<DictSymbolScope> 
	{
		private String name;

		public KeyBoolProperty(String name)
		{
			super(false,"%key");
			this.name=name;
		}
		
		@Override			
		public SymbolValue load(DictSymbolScope scope) {
			return SymbolValue.constructBlank(scope.key.getKey().getProperty(name)!=null);
		}
	}
	
	
	static FactoryBuilder<DictSymbolScope> builder;
	static {
		builder=new FactoryBuilder<DictSymbolScope>();
		
		builder.add("%file",new SymbolFactory<DictSymbolScope>(true) {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				List<String> files = new ArrayList<String>();
				for (File f : scope.source.getFiles()) {
					files.add(f.getFile().getName());
				}
				return new ROSetListSymbol(files) {
					@Override
					public void applyFix(String value) {
						scope.file=scope.source.getFile(value);
					}
				};
			}
		});

		builder.add("%filestruct",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override			
			public SymbolValue load(DictSymbolScope scope) {
				return scope.file.getFile().asSymbolValue();
			}
		});

		builder.add("%filecreate",new FileBoolProperty("create"));
		builder.add("%fileowner",new FileStringProperty("owner"));
		builder.add("%fileprefix",new FileStringProperty("pre"));
		builder.add("%filereclaim",new FileStringProperty("reclaim"));
		
		builder.add("%filethreaded",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override			
			public SymbolValue load(DictSymbolScope scope) {
				return SymbolValue.construct(scope.file.isThreaded());
			}
		});
		
		builder.add("%filename",new FileStringProperty("name"));
		builder.add("%filedriver",new FileStringProperty("driver"));
		
		builder.add("%filetype",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override			
			public SymbolValue load(DictSymbolScope scope) {
				return SymbolValue.construct(scope.file.getFile().get(0).getName().toUpperCase());
			}
		});

		builder.add("%filestructrec",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override			
			public SymbolValue load(DictSymbolScope scope) {
				Definition d = scope.file.getRecord();
				return d.asSymbolValue();
			}
		});

		builder.add("%filestructrecend",new SymbolFactory<DictSymbolScope>(false) {
			@Override			
			public SymbolValue load(DictSymbolScope scope) {
				return SymbolValue.construct("                         END");
			}
		});

		builder.add("%filestructend",new SymbolFactory<DictSymbolScope>(false) {
			@Override			
			public SymbolValue load(DictSymbolScope scope) {
				return SymbolValue.construct("                       END");
			}
		});
		
		
		builder.add("%fileuseroptions",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override			
			public SymbolValue load(DictSymbolScope scope) {
				return SymbolValue.construct("");
			}
		});
		
		builder.add("%field",new SymbolFactory<DictSymbolScope>(true,"%file") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				List<String> fields = new ArrayList<String>();
				String prefix = scope.file.getFile().getValue("PRE")+":";
				for (Field f : scope.file.getFields()) {
					fields.add(prefix+f.getField().getName());
				}
				return new ROSetListSymbol(fields) {
					@Override
					public void applyFix(String value) {
						scope.field=scope.file.getField(value);
					}					
				};
			}
		});

		builder.add("%fieldfile",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				return SymbolValue.construct(scope.file.getFile().getName());
			}
		});

		builder.add("%fieldinitial",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				DefinitionProperty dp = scope.field.getParameter("INITIAL");
				if (dp==null) return StringSymbolValue.BLANK;
				return dp.get(0);
			}
		});

		builder.add("%fieldvalidation",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				DefinitionProperty dp = scope.field.getParameter("VALID");
				if (dp==null) return StringSymbolValue.BLANK;
				return dp.get(0);
			}
		});
		
		builder.add("%fielddimension1",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				return StringSymbolValue.BLANK;
			}
		});

		builder.add("%fieldid",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				return SymbolValue.construct(scope.field.getField().getName());
			}
		});

		builder.add("%fieldvalues",new SymbolFactory<DictSymbolScope>(true,"%field") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				DefinitionProperty dp = scope.field.getParameter("VALUES");
				if (dp==null) {
					return ROSetListSymbol.create();
				} else {
					return ROSetListSymbol.createList(dp.getProp(0).value.split("\\|"));
				}
			}
		});

		builder.add("%fieldchoices",new SymbolFactory<DictSymbolScope>(true,"%field") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				DefinitionProperty dp = scope.field.getParameter("VALID");
				if (dp==null || dp.size()<2) {
					return ROSetListSymbol.create();
				} else {
					return ROSetListSymbol.createList(dp.getProp(1).value.split("\\|"));
				}
			}
		});
		
		builder.add("%fieldname",new FieldStringProperty("NAME"));
		
		builder.add("%key",new SymbolFactory<DictSymbolScope>(true,"%file") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				List<String> keys = new ArrayList<String>();
				String prefix = scope.file.getFile().getValue("PRE")+":";
				for (Key f : scope.file.getKeys()) {
					keys.add(prefix+f.getKey().getName());
				}
				return new ROSetListSymbol(keys) {
					@Override
					public void applyFix(String value) {
						scope.key=scope.file.getKey(value);
					}
				};
			}
		});

		builder.add("%keystruct",new SymbolFactory<DictSymbolScope>(false,"%key") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				return scope.key.getKey().asSymbolValue();
			}
		});
		
		builder.add("%keydescription",new SymbolFactory<DictSymbolScope>(false,"%key") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				String comment = scope.key.getKey().getComment();
				return SymbolValue.construct(comment==null ? "" : comment	);
			}
		});

		builder.add("%keyfield",new SymbolFactory<DictSymbolScope>(true,"%key") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				List<String> fields = new ArrayList<String>();
				for (Lex scan : scope.key.getKey().getTypeProperty().getParams()) {
					String line =scan.value;
					if (line.startsWith("-")) {
						line=line.substring(1);
					}
					fields.add(line);
				}
				return new ROSetListSymbol(fields) {
					@Override
					public void applyFix(int ofs) {
						scope.keyFieldDescend = scope.key.getKey().getTypeProperty().getProp(ofs).value.startsWith("-");
					}					
				};
			}
		});

		builder.add("%keyfieldsequence",new SymbolFactory<DictSymbolScope>(false,"%key") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				return SymbolValue.construct(scope.keyFieldDescend ? "DESCENDING" : "ASCENDING");
			}
		});
		
		builder.add("%keynocase",new KeyBoolProperty("NOCASE"));
		builder.add("%keyduplicate",new KeyBoolProperty("DUP"));

		builder.add("%keyauto",new SymbolFactory<DictSymbolScope>(false,"%key") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				//for (Key key : scope.file.getKeys()) {
				Key key = scope.key;
					if (key.getParameter("AUTO")!=null) {
						DefinitionProperty type = key.getKey().getTypeProperty();
						if (type.size()>0) {
							Lex scan = type.getProp(type.size()-1);
							if (scan.value.startsWith("-")) {
								return new StringSymbolValue(scan.value.substring(1));
							} else {
								return new StringSymbolValue(scan.value);
							}
						}
					}
				//}
				return StringSymbolValue.BLANK;
			}
		});

		builder.add("%fileprimarykey",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				for (Key key : scope.file.getKeys()) {
					if (key.getKey().getProperty("PRIMARY")!=null) {
						String prefix = scope.file.getFile().getValue("PRE")+":";
						return SymbolValue.construct(prefix+key.getKey().getName());
					}
				}
				return StringSymbolValue.BLANK;
			}
		});
		
		builder.add("%aliasfile",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				return StringSymbolValue.BLANK;
			}
		});
		
		builder.add("%fieldlookup",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				return StringSymbolValue.BLANK;
			}
		});

		builder.add("%fieldrangelow",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				DefinitionProperty dp =scope.field.getParameter("VALID");
				if (dp!=null && dp.get(0).getString().equalsIgnoreCase("INRANGE")) {
					return dp.get(1);
				}
				return StringSymbolValue.BLANK;
			}
		});
		
		builder.add("%fieldrangehigh",new SymbolFactory<DictSymbolScope>(false,"%file") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				DefinitionProperty dp =scope.field.getParameter("VALID");
				if (dp!=null && dp.get(0).getString().equalsIgnoreCase("INRANGE")) {
					return dp.get(2);
				}
				return StringSymbolValue.BLANK;
			}
		});
		
		builder.add("%fieldtype",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				return SymbolValue.construct(scope.field.getField().getTypeName());
			}
		});

		
		builder.add("%fielddescription",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				String comment = scope.field.getField().getComment();
				if (comment!=null) {
					return SymbolValue.construct(comment);
				}
				DefinitionProperty prop=scope.field.getParameter("MESSAGE");
				if (prop==null) {
					return SymbolValue.construct(scope.field.getDescription());
				} else {
					return prop.get(0);
				}
			}
		});
		
		builder.add("%fieldstruct",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				return scope.field.getField().asSymbolValue();
			}
		});

		builder.add("%fieldstatement",new SymbolFactory<DictSymbolScope>(false,"%field") {
			@Override
			public SymbolValue load(DictSymbolScope scope) {
				return scope.field.getField().getStatement().asSymbolValue();
			}
		});
		
		
		builder.add("%relation",new SymbolFactory<DictSymbolScope>(true,"%file") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				List<String> rel = new ArrayList<String>();
				for (RelationKey rk : scope.file.getRelations()) {
					rel.add(rk.getOther().getFile().getFile().getName());
				}
				return new ROSetListSymbol(rel) {
					@Override
					public void applyFix(int ofs) {
						scope.relation=scope.file.getRelation(ofs);
					}
					
				};
			}
		});

		builder.add("%filerelationtype",new SymbolFactory<DictSymbolScope>(false,"%relation") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				return SymbolValue.construct(scope.relation.isOneToMany() ? "1:MANY" : "MANY:1");
			}
		});
		
		builder.add("%relationkey",new SymbolFactory<DictSymbolScope>(false,"%relation") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				Key k =scope.relation.getOther().getKey(); 
				if (k!=null) {
					String prefix = scope.relation.getOther().getFile().getFile().getValue("PRE")+":";
					return SymbolValue.construct(prefix+k.getKey().getName());
				} 
				return StringSymbolValue.BLANK;
			}
		});

		builder.add("%filekey",new SymbolFactory<DictSymbolScope>(false,"%relation") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				Key k =scope.relation.getKey(); 
				if (k!=null) {
					String prefix = scope.relation.getFile().getFile().getValue("PRE")+":";
					return SymbolValue.construct(prefix+k.getKey().getName());
				} 
				return StringSymbolValue.BLANK;
			}
		});
		
		
		builder.add("%relationconstraintdelete",new SymbolFactory<DictSymbolScope>(false,"%relation") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				String s =scope.relation.getDeleteMode();
				if (s==null) s="CLEAR";
				return SymbolValue.construct(s);
			}
		});
		
		builder.add("%relationconstraintupdate",new SymbolFactory<DictSymbolScope>(false,"%relation") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				String s =scope.relation.getUpdateMode();
				if (s==null) s="CLEAR";
				return SymbolValue.construct(s);
			}
		});

		builder.add("%filekeyfield",new SymbolFactory<DictSymbolScope>(true,"%relation") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				List<String> keys = new ArrayList<String>();
				String prefix = scope.relation.getFile().getFile().getValue("PRE")+":";
				for (Join j : scope.relation.getJoins()) {
					Field f = j.getFrom();
					if (f==null) {
						keys.add("");
					} else {
						keys.add(prefix+f.getField().getName());
					}
					
				}
				return new ROSetListSymbol(keys);
			}
		});		

		builder.add("%filekeyfieldlink",new SymbolFactory<DictSymbolScope>(false,"%filekeyfield") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				int ofs = scope.get("%filekeyfield").list().values().instance()-1;
				String prefix = scope.relation.getOther().getFile().getFile().getValue("PRE")+":";
				return SymbolValue.construct(prefix+scope.relation.getJoin(ofs).getTo().getField().getName());
			}
		});
		
		builder.add("%relationkeyfield",new SymbolFactory<DictSymbolScope>(true,"%relation") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				List<String> keys = new ArrayList<String>();
				String prefix = scope.relation.getOther().getFile().getFile().getValue("PRE")+":";
				for (Join j : scope.relation.getOther().getJoins()) {
					Field f = j.getFrom();
					if (f==null) {
						keys.add("");
					} else {
						keys.add(prefix+f.getField().getName());
					}
				}
				return new ROSetListSymbol(keys);
			}
		});		

		builder.add("%relationkeyfieldlink",new SymbolFactory<DictSymbolScope>(false,"%relationkeyfield") {
			@Override
			public SymbolValue load(final DictSymbolScope scope) {
				int ofs = scope.get("%relationkeyfield").list().values().instance()-1;
				String prefix = scope.relation.getFile().getFile().getValue("PRE")+":";
				return SymbolValue.construct(prefix+scope.relation.getOther().getJoin(ofs).getTo().getField().getName());
			}
		});		
		
	}
	
	private Dict source;
	private File file;	
	private Field field;
	private Key key;
	private boolean keyFieldDescend;
	private RelationKey relation;
	
	public DictSymbolScope(Dict app,ExecutionEnvironment environment)
	{
		super(builder.get(),environment);
		this.source=app;
	}
}
