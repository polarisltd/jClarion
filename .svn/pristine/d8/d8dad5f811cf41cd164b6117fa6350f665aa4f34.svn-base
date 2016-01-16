package org.jclarion.clarion.ide.builder;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.eclipse.core.resources.IContainer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IFolder;
import org.eclipse.core.resources.IMarker;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.IResourceDelta;
import org.eclipse.core.resources.IncrementalProjectBuilder;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.jdt.core.JavaCore;
import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.grammar.AccumulatingClarionCompileError;
import org.jclarion.clarion.compile.grammar.AccumulatingErrorCollator;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.util.SharedInputStream;
import org.jclarion.clarion.util.SharedWriter;


public class ClarionToJavaBuilder extends IncrementalProjectBuilder 
{
	private ClarionLexerSource source; 
	private ClarionCompiler	   compiler;
	private String			   main;
	private IFolder			   javaTarget;

	@Override
	protected IProject[] build(int kind, Map<String, String> args,IProgressMonitor monitor) throws CoreException 
	{	
		javaTarget = getProject().getFolder("java");
		if (javaTarget==null) return null;
		if (!javaTarget.exists()) return null;
		
		if (kind==FULL_BUILD) {
			loadNewSource();
			createNewCompiler();
			if (compiler==null) return null;
			Lexer l = source.getLexer(main);
			if (l==null) {
				System.out.println("Cannot find main:"+main);
				return null;
			}		
			compiler.collator().associate(source.cleanName(main),compiler.main());		        
			Parser p = new Parser(compiler,source.getLexer(main));
			try {
				p.compileProgram(true);
				saveSource();
			} catch (AccumulatingClarionCompileError err) {
				handleErrors();
			}
			
			return null;
		}
				
		if (source==null) {
			loadNewSource();
		}

		Set<String> changedModules = new HashSet<String>();
		boolean changedMain=false;
		
		if (kind==INCREMENTAL_BUILD || kind==AUTO_BUILD) {
			Set<String> changes = new HashSet<String>();
			loadFileChanges(getDelta(getProject()),changes);	
			
			for (String name : changes) {
				if (compiler!=null) {
					Set<Scope> ass = compiler.collator().getAssociations(name);
					if (ass!=null) {
						for (Scope source : ass) {
							if (source instanceof MainScope) {
								changedMain=true;
							} 
							if (source instanceof ModuleScope) {
								changedModules.add(source.getName()+".clw");
							}
						}
						continue;
					}
				} else {
					if (name.toLowerCase().endsWith("clw") || name.toLowerCase().endsWith("inc")) {
						changedMain=true;
					}
				}
				if (name.toLowerCase().endsWith(".clw")) {
					Lexer l = source.getLexer(name);
					l.setIgnoreWhitespace(true);
					while ( true ) {
						Lex lex = l.next();
						if (lex.type==LexType.eof) break;
						if (lex.type==LexType.nl) continue;
						if (lex.type==LexType.comment) continue;
						if (lex.type==LexType.label && lex.value.equalsIgnoreCase("member")) {
							changedModules.add(name);
						}
						break;
					}
					l.close();
				}
			}
		}
		
		if (changedModules.isEmpty() && changedMain==false) return null;
		
		if (compiler==null || changedMain) {
			createNewCompiler();
			if (compiler==null) return null;
			Lexer l = source.getLexer(main);
			if (l==null) {
				System.out.println("Cannot find main:"+main);
				return null;
			}		
			compiler.collator().associate(source.cleanName(main),compiler.main());		        
			Parser p = new Parser(compiler,source.getLexer(main));
			try {
				p.compileProgram(false);
				saveSource();
			} catch (AccumulatingClarionCompileError err) {
				handleErrors();
			}
		}	
		
		for (String moduleName : changedModules) {
			Lexer l = source.getLexer(moduleName);
			if (l==null) continue;
	        Parser p = new Parser(compiler,l);
			try {
				p.recompileModule(moduleName);
				compiler.stack().fixDisorderedScopes();
				String namespace = moduleName.substring(0,moduleName.indexOf('.')).toLowerCase();
				saveSource(namespace);
			} catch (AccumulatingClarionCompileError err) {
				handleErrors();
			}
		}
		
		return null;
	}

	private boolean handleErrors() {
		AccumulatingErrorCollator coll = (AccumulatingErrorCollator)compiler.error();
		boolean severe=false;
		for (AccumulatingErrorCollator.Entry scan : coll.getErrors()) {
			
			IFile file = source.getFile(scan.getSource());
			if (file!=null) {
				try {
					IMarker marker = file.createMarker(IMarker.PROBLEM);
					marker.setAttribute(IMarker.LINE_NUMBER,scan.getLineNumber());
					marker.setAttribute(IMarker.CHAR_START,scan.getCharStart());
					marker.setAttribute(IMarker.CHAR_END,scan.getCharEnd());
					marker.setAttribute(IMarker.MESSAGE,scan.getMessage());
					if (scan.isWarning()) {
						marker.setAttribute(IMarker.SEVERITY,IMarker.SEVERITY_WARNING);
					} else {
						marker.setAttribute(IMarker.SEVERITY,IMarker.SEVERITY_ERROR);
						severe=true;
					}
					marker.setAttribute("appgen.source",scan.getSource());
				} catch (CoreException e) {
					e.printStackTrace();
				}
			}
		}
		coll.clearErrors();
		return severe;
	}

	private void createNewCompiler() {
		AppProject o = AppProject.get(getProject());
		if (o!=null && o.getApp()!=null) {
			main = o.getApp().getName()+".clw";
		} else {
			main=null;
			compiler=null;
			return;
		}
		
		compiler=new ClarionCompiler();
		compiler.setSource(source);
		compiler.getTargetOverrides().loadWindowOverrides(source.getLexer("win.properties"));
		compiler.setImporter(new EclipseJavaImporter(JavaCore.create(getProject())));
		compiler.setErrorCollator(new AccumulatingErrorCollator());
	}
	
	private void saveSource() 
	{
		saveSource(null);
	}
	
	private void saveSource(String path) 
	{
		if (!((AccumulatingErrorCollator)compiler.error()).getErrors().isEmpty()) {
			if (handleErrors()) return;
		}
		Collection<JavaClass> src = path==null ? compiler.repository().getAll() : compiler.repository().getAll(path);
		
		for (JavaClass jc : src) {
			if (!jc.isCompiled()) continue;
			IFolder scan = javaTarget;
			for (String bit : jc.getPackage().split("[.]")) {
				scan = scan.getFolder(bit);
				if (!scan.exists()) {
					try {
						scan.create(true,true,null);
						scan.setDerived(true,null);
					} catch (CoreException e) {
						e.printStackTrace();
						return;
					}
				}
			}
			IFile file = scan.getFile(jc.getName()+".java");
			String content = jc.toJavaSource(compiler);
			if (file.exists()) {
				SharedWriter sw = new SharedWriter();
				try {
					Reader r = new InputStreamReader(file.getContents());
					char buffer[] = new char[8192];
					while ( true ) {
						int len = r.read(buffer);
						if (len<=0) break;
						sw.write(buffer,0,len);
					}
					if (sw.toString().equals(content)) {
						continue;
					}
				} catch (IOException ex) { 
					ex.printStackTrace();
				} catch (CoreException e) {
					e.printStackTrace();
				}				
				try {
					file.setContents(new SharedInputStream(content.getBytes()),true,false,null);
				} catch (CoreException e) {
					e.printStackTrace();
				}
			} else {
				try {
					file.create(new SharedInputStream(content.getBytes()),true,null);
					file.setDerived(true,null);
				} catch (CoreException e) {
					e.printStackTrace();
				}				
			}
		}
	}

	private void loadFileChanges(IResourceDelta delta,Set<String> changes) {		
		if (delta.getResource() instanceof IFile) {
			IFile f = (IFile)delta.getResource();
			if (delta.getKind()==IResourceDelta.REMOVED) {
				if (!source.removeFile(f)) return;
			} else {
				if (!source.addFile(f)) return;
			}
			changes.add(source.cleanName(f.getName()));
			return;
		}
		for (IResourceDelta kid : delta.getAffectedChildren()) {
			loadFileChanges(kid,changes);
		}
	}

	private void loadNewSource() {
		source=new ClarionLexerSource(getProject());
		addFiles(getProject());
	}

	private void addFiles(IContainer parent) {
		try {
			for (IResource scan : parent.members()) {
				if (scan instanceof IFile) {
					source.addFile((IFile)scan);
					continue;
				}			
				if (scan instanceof IContainer) {
					addFiles((IContainer)scan);
				}
			}
		} catch (CoreException ex) {
			ex.printStackTrace();
		}
	}

}
