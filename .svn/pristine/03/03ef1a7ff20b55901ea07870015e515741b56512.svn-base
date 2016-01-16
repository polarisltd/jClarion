package org.jclarion.clarion.appgen.symbol.user;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.ROSymbolScope;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolScope;

/**
 * Special type of scope used when an app is loading.  It is used to provide
 * undefined dependent variables, such as %Field
 *  
 * @author barney
 */
public class AppLoaderScope extends ROSymbolScope
{
	private Map<String,PlaceholderDependency> placeholders;
	
	public AppLoaderScope() {
		placeholders=new HashMap<String,PlaceholderDependency>();
		placeholders.put("%file",new PlaceholderDependency("%file","placeholder"));
		placeholders.put("%module",new PlaceholderDependency("%module","placeholder"));
		placeholders.put("%control",new PlaceholderDependency("%control","placeholder"));
		placeholders.put("%controlfield",new PlaceholderDependency("%controlfield","placeholder",placeholders.get("%control")));
	}

	public AppLoaderScope(AppLoaderScope from) {
		placeholders=new HashMap<String,PlaceholderDependency>();
		placeholders.put("%file",new PlaceholderDependency(from.placeholders.get("%file")));
		placeholders.put("%module",new PlaceholderDependency(from.placeholders.get("%module")));
		placeholders.put("%control",new PlaceholderDependency(from.placeholders.get("%control")));
		placeholders.put("%controlfield",new PlaceholderDependency(from.placeholders.get("%controlfield"),placeholders.get("%control")));
	}
	
	@Override
	public SymbolEntry get(String name) {
		return placeholders.get(name.toLowerCase());
	}

	@Override
	public SymbolScope getParentScope() {
		return null;
	}
	
	@Override
	public void setParentScope(SymbolScope parent) {
		throw new IllegalStateException("Disallowed");
	}

}
