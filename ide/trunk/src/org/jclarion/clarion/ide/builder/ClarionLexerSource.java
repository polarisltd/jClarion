package org.jclarion.clarion.ide.builder;

import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IMarker;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.CoreException;
import org.jclarion.clarion.compile.grammar.LexerSource;
import org.jclarion.clarion.lang.Lexer;

public class ClarionLexerSource extends LexerSource 
{
	private static Set<String> ignoredExtensions = new HashSet<String>();
	static {
		ignoredExtensions.add("java");
		ignoredExtensions.add("class");
		ignoredExtensions.add("module");
	}
	
	private Map<String,IFile> mapping=new HashMap<String,IFile>();

	
	public ClarionLexerSource(IProject project)
	{
	}
	
	public IFile getFile(String name)
	{
		IFile base = mapping.get(cleanName(name));
		if (base==null || !base.exists()) return null;
		return base;
	}
	
	@Override
	public Lexer getLexer(String name) 
	{
		IFile base = mapping.get(cleanName(name));
		if (base==null || !base.exists()) return null;
		try {
			base.deleteMarkers(IMarker.PROBLEM, true,0);
		} catch (CoreException e) {
			e.printStackTrace();
		}
		try {
			return new Lexer(new InputStreamReader(base.getContents()),name);
		} catch (CoreException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public boolean addFile(IFile file)
	{
		String name = cleanName(file.getName());
		if (ignoredExtensions.contains(name.substring(name.lastIndexOf('.')+1))) return false;		
		mapping.put(name, file);
		return true;
	}

	public boolean removeFile(IFile file)
	{
		return mapping.remove(cleanName(file.getName()))!=null;
	}
}
