package org.jclarion.clarion.appgen.symbol.system;


import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.app.FileJoin;
import org.jclarion.clarion.appgen.app.PrimaryFile;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;

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
public class FileStructureSymbolScope extends SystemSymbolScope
{
	static FactoryBuilder<FileStructureSymbolScope> builder;
	
	static {
		builder=new FactoryBuilder<FileStructureSymbolScope>();
		
		builder.add("%primary",new SymbolFactory<FileStructureSymbolScope>(false) {
			@Override
			public SymbolValue load(FileStructureSymbolScope scope) {
				if (scope.primary==null) {
					return StringSymbolValue.BLANK;
				}
				return SymbolValue.construct(scope.primary.getName());
			}
		});		
		
		builder.add("%primarykey",new SymbolFactory<FileStructureSymbolScope>(false) {
			@Override
			public SymbolValue load(FileStructureSymbolScope scope) {
				if (scope.primary==null) {
					return StringSymbolValue.BLANK;
				}
				return SymbolValue.construct(scope.primary.getKey());
			}
		});		

		builder.add("%secondary",new SymbolFactory<FileStructureSymbolScope>(true) {
			@Override
			public SymbolValue load(final FileStructureSymbolScope scope) {
				List<String> names = new ArrayList<String>();
				
				if (scope.primary==null) {
					return ROSetListSymbol.create();
				}
				
				for (FileJoin fj : scope.primary.getJoins()) {
					names.add(fj.getChild().getName());
				}
				return new ROSetListSymbol(names) {
					@Override
					public void applyFix(String value) {
						scope.secondary=scope.primary.getJoin(value);
					}										
				};
			}
		});		

		builder.add("%secondarycustomjoin",new SymbolFactory<FileStructureSymbolScope>(false,"%secondary") {
			@Override
			public SymbolValue load(final FileStructureSymbolScope scope) {
				return SymbolValue.construct(scope.secondary.getExpression()!=null);
			}
		});		

		builder.add("%secondarycustomtext",new SymbolFactory<FileStructureSymbolScope>(false,"%secondary") {
			@Override
			public SymbolValue load(final FileStructureSymbolScope scope) {
				return SymbolValue.construct(scope.secondary.getExpression());
			}
		});		

		builder.add("%secondaryinner",new SymbolFactory<FileStructureSymbolScope>(false,"%secondary") {
			@Override
			public SymbolValue load(final FileStructureSymbolScope scope) {
				return SymbolValue.construct(scope.secondary.isInner());
			}
		});		

		builder.add("%secondaryto",new SymbolFactory<FileStructureSymbolScope>(false,"%secondary") {
			@Override
			public SymbolValue load(final FileStructureSymbolScope scope) {
				return SymbolValue.construct(scope.secondary.getParent().getName());
			}
		});		
		
	}
	
	private PrimaryFile		primary;
	private FileJoin		secondary;
	
	public FileStructureSymbolScope(PrimaryFile primary,ExecutionEnvironment environment)
	{
		super(builder.get(),environment);
		this.primary=primary;
	}
}
