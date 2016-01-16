package org.jclarion.clarion.appgen.symbol;

import java.util.HashMap;
import java.util.Map;

public class ConstantScope extends ROSymbolScope
{
	private static Map <String,SymbolEntry> baseValues=new HashMap<String,SymbolEntry>();
	static {
		register("%null",new NullSymbolValue());
		register("%eof",new EOFSymbolValue());
		register("%target32",SymbolValue.construct(1));
		register("%programextension",SymbolValue.construct("EXE"));
		register("%applicationlocallibrary",SymbolValue.construct(""));
		register("%applicationdebug",SymbolValue.construct(""));
		register("%true",SymbolValue.construct(1));
		register("%generatelongfilenames",SymbolValue.construct(1));
		register("%false",SymbolValue.construct(""));
				
		register("%driverdll",SymbolValue.construct("filedriver.dll"));
		register("%projecttarget",SymbolValue.construct("myproject.jar"));
	}
	
	private static void register(String name,SymbolValue construct) {
		SymbolStore ss = new IndependentStore();
		ss.save(construct);
		SymbolEntry se = SymbolEntry.create(name,"STRING",ValueType.scalar,ss);
		baseValues.put(name,se);
	}

	
	private SymbolScope parent;

	@Override
	public SymbolEntry get(String name) 
	{
		SymbolEntry result = baseValues.get(name.toLowerCase());
		if (result!=null) return result;
		if (parent==null) return null;
		return parent.get(name);
	}

	@Override
	public SymbolScope getParentScope() {
		return parent;
	}

	@Override
	public void setParentScope(SymbolScope parent) {
		this.parent=parent;
	}


}
