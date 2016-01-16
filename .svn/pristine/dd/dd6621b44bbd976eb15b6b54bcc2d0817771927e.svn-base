package org.jclarion.clarion.compile.grammar;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.Scope;

public class SourceFileCollator 
{
	private Map<String,Set<Scope>> associations=new HashMap<String,Set<Scope>>();
	
	public SourceFileCollator()
	{
	}
	
	public void associate(String sourceFile,Scope scope)
	{
		while (scope!=null) {
			if (scope instanceof MainScope) break;
			if (scope instanceof ModuleScope) break;
			scope=scope.getParent();
		}
		if (scope==null) return;
		
		sourceFile=sourceFile.toLowerCase();
		Set<Scope> s = associations.get(sourceFile);
		if (s==null) {
			s=new HashSet<Scope>();
			associations.put(sourceFile,s);
		}
		s.add(scope);
	}
	
	public Set<Scope> getAssociations(String sourceFile)
	{
		return associations.get(sourceFile.toLowerCase());
	}
	
}
