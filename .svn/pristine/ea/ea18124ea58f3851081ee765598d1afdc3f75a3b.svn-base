package org.jclarion.clarion.appgen.template;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import org.jclarion.clarion.BindProcedure2;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.FileTextAppSource;
import org.jclarion.clarion.appgen.app.TextAppSource;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.lang.SourceEncoder;
import org.jclarion.clarion.appgen.loader.DefinitionLoader;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.appgen.symbol.ConstantScope;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.PreserveBarrier;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.system.AppSymbolScope;
import org.jclarion.clarion.appgen.symbol.system.DictSymbolScope;
import org.jclarion.clarion.appgen.symbol.system.SystemSymbolScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.at.AtSourceSession;
import org.jclarion.clarion.appgen.template.cmd.CodeResult;
import org.jclarion.clarion.appgen.template.cmd.GroupCmd;
import org.jclarion.clarion.appgen.template.cmd.Statement;
import org.jclarion.clarion.appgen.template.cmd.TemplateCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateCode;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;
import org.jclarion.clarion.appgen.template.service.GenReadABCFiles;
import org.jclarion.clarion.runtime.ObjectBindProcedure;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprScope;
import org.jclarion.clarion.runtime.expr.LabelExpr;
import org.jclarion.clarion.runtime.expr.LabelExprResult;

public class ExecutionEnvironment extends CExprScope
{
	private SymbolScope				baseScope;
	private UserSymbolScope 		persist;
	private TemplateChain 			chain;
	private WriteTarget 			defaultStream;
	private App 					app;
	private Dict 					dict;
	private int						indent=0;
	private int 					comment=50;
	private Map<String,FileStore> 	files = new HashMap<String,FileStore>();
	private LinkedList<FileStore> 	fileStack = new LinkedList<FileStore>();
	private String 					target="";
	private AtSourceSession 		currentSource;
	private AtSourceSession 		appSource=null;
	private boolean 				generationEnabled=true;
	private boolean					conditionalGenerate=true;
	private String					editProcedure=null;
	private String					editFilename=null;
	private boolean					includeEmptyEmbeds;
	private Map<Object,Object>		dirtyAlternatives=null;
	private ExecutionEnvironmentFileSystem  fileSystem;
	private GeneratorProgress progress;
		
	
	
	private static SymbolEntry get(CExprScope scope,CExpr symbol)
	{
		ExecutionEnvironment ee = (ExecutionEnvironment)scope;
		return ee.getScope().get(((LabelExpr)symbol).getName());
	}
	
	private static abstract class SymbolFunction implements LabelExprResult
	{
		private int ofs;

		private SymbolFunction()
		{
		}

		private SymbolFunction(int ofs)
		{
			this.ofs=ofs;
		}
		
		@Override
		public ClarionObject execute(CExprScope scope, CExpr... params) {
			ExecutionEnvironment ee = (ExecutionEnvironment)scope;
			return resolve(ee,get(scope,params[ofs]),params);
		}

		public abstract ClarionObject resolve(ExecutionEnvironment ee,SymbolEntry symbolEntry,CExpr ...params);
		
	}
	
	private static abstract class EnvFunction implements LabelExprResult
	{

		@Override
		public ClarionObject execute(CExprScope scope, CExpr... params) {
			ExecutionEnvironment ee = (ExecutionEnvironment)scope;
			return resolve(ee,params);
		}

		public abstract ClarionObject resolve(ExecutionEnvironment ee,CExpr... params);
		
	}
	
	private static Map<String,LabelExprResult> builtins = new HashMap<String,LabelExprResult>();
	static {
		builtins.put("upper",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				return p[0].getString().upper();
			}
		});
		builtins.put("len",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				return new ClarionNumber(p[0].getString().len());
			}
		});
		builtins.put("inrange",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				if (p[0].compareTo(p[1])<0) return new ClarionBool(false);
				if (p[0].compareTo(p[2])>0) return new ClarionBool(false);
				return new ClarionBool(true);
			}
		});
		builtins.put("left",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				return p[0].getString().left();
			}
		});
		builtins.put("all",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				return p[0].getString().all(p[1].intValue());
			}
		});
		builtins.put("fileexists",new EnvFunction() {

			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,CExpr... params) {
				File f = new File(ee.getTargetPath()+ee.eval(params[0]));
				return new ClarionBool(f.exists());
			}
		});
		builtins.put("clip",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				return p[0].getString().clip();
			}
		});
		builtins.put("quote",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				String src = p[0].toString();
				StringBuilder target = new StringBuilder(src.length()+8);
				try {
					SourceEncoder.encodeString(src, target, false);
				} catch (IOException e) {
					e.printStackTrace();
				}
				return new ClarionString(target.toString());
			}
		});
		builtins.put("extract",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				DefinitionProperty d = DefinitionLoader.construct(p[0]).getProperty(p[1].toString());
				if (d==null) {
					return new ClarionString();
				}
				if (p.length==3 && p[2].intValue()==0) {
					return new ClarionString(d.renderPart());
				}
				if (p.length==3 ) {
					return new ClarionString(d.render(p[2].intValue()-1));
				}
				return new ClarionString(d.render());
			}
		});
		builtins.put("sub",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				if (p.length==2) {
					return p[0].getString().sub(p[1].intValue());
				}
				return p[0].getString().sub(p[1].intValue(),p[2].intValue());
			}
		});
		builtins.put("slice",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				return p[0].getString().stringAt(p[1],p[2]);
			}
		});
		builtins.put("instring",new BindProcedure2() {
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				if (p.length==2) {
					return new ClarionNumber(p[1].getString().inString(p[0].toString()));
				}
				if (p.length==3) {
					return new ClarionNumber(p[1].getString().inString(p[0].toString(),p[2].intValue(),1));
				}
				return new ClarionNumber(p[1].getString().inString(p[0].toString(),p[2].intValue(),p[3].intValue()));
			}
		});
		builtins.put("varexists",new SymbolFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,SymbolEntry symbolEntry,CExpr ...params) {
				return new ClarionBool(symbolEntry!=null);
			}
		});
		builtins.put("items",new SymbolFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,SymbolEntry symbolEntry,CExpr ...params) {
				return new ClarionNumber(symbolEntry.list().values().size());
			}
		});
		builtins.put("inlist",new SymbolFunction(1) {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,SymbolEntry symbolEntry,CExpr ...params) {
				
				ListSymbolValue lsv = symbolEntry.list().values();
				SymbolValue sv = SymbolValue.construct(params[0].eval(ee));
				
				return new ClarionNumber(lsv.containsPos(sv));
			}
		});
		builtins.put("instance",new SymbolFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,SymbolEntry symbolEntry,CExpr ...params) {
				return new ClarionNumber(symbolEntry.list().values().instance());
			}
		});
		
		builtins.put("%outputindent",new EnvFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,CExpr ...params) {
				return new ClarionNumber(ee.getIndent());
			}
		});

		builtins.put("choose",new LabelExprResult() {

			@Override
			public ClarionObject execute(CExprScope scope, CExpr... params) 
			{
				ClarionObject co = params[0].eval(scope);
				if (co instanceof ClarionBool && params.length==1) {
					return new ClarionNumber(co.boolValue() ? 1 : 0 ); 
				}
				if (params.length==3) {
					return params[co.boolValue() ? 1 : 2 ].eval(scope);
				}
				int val = co.intValue();

				if (val<1 || val>=params.length) {
					return new ClarionString();
				}
				return params[val].eval(scope);
			}
		});
		
		builtins.put("%bytesoutput",new EnvFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,CExpr ...params) {
				return new ClarionNumber(ee.getWriteTarget(false).getCharsWritten());
			}
		});
		
		// TODO : move these into generator
		builtins.put("%conditionalgenerate",new EnvFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,CExpr... params) {
				return new ClarionBool(ee.conditionalGenerate);
			} });
		builtins.put("%dictionarychanged",new ObjectBindProcedure(new ClarionNumber(0)));
		builtins.put("%registrychanged",new ObjectBindProcedure(new ClarionNumber(0)));
		builtins.put("%createlocalmap",new ObjectBindProcedure(new ClarionNumber(1)));
		builtins.put("%editprocedure",new EnvFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,CExpr... params) {
				return new ClarionString(ee.editProcedure==null ? "" : ee.editProcedure);
			} });
		builtins.put("%editfilename",new EnvFunction() {
			@Override
			public ClarionObject resolve(ExecutionEnvironment ee,CExpr... params) {
				return new ClarionString(ee.editFilename==null ? "" : ee.editFilename);
			} });
		
	}

	
	public ExecutionEnvironment()
	{
	}
	
	public ExecutionEnvironment(TemplateChain chain,App app,Dict dict)
	{
		this.chain=chain;
		this.app=app;
		this.dict=dict;
		this.defaultStream=new AppendableWriteTarget(System.out);
	}
	
	public void recycle()
	{
		this.buffer=null;
		//this.comment=50;
		this.currentSource=null;
		this.conditionalGenerate=true;
		this.defaultStream=null;
		this.editFilename=null;
		this.editProcedure=null;
		this.includeEmptyEmbeds=true;
		this.files.clear();
		this.fileStack.clear();
		this.generationEnabled=true;
		this.indent=0;
		this.stack.clear();
		this.stopOnError=false;
		this.target="";
		this.tempFile.clear();
		this.templateStack.clear();		
		this.dirtyAlternatives=null;
		this.fileSystem=null;
		this.progress=null;
		if (this.appSource!=null) {
			this.appSource.setGenerated(false);
			SymbolScope scope = this.appSource.getScope();
			while (scope!=null) {
				if (scope instanceof SystemSymbolScope) {
					((SystemSymbolScope)scope).recycle();
				}
				scope=scope.getParentScope();
			}
		}
		
		TemplateCmd set = chain.getTemplate(app.getBase().getChain());
		pushTemplate(set);
		
	}
	
	public ExecutionEnvironmentFileSystem getFileSystem()
	{
		if (fileSystem==null) {
			fileSystem=new DefaultExecutionEnvironmentFileSystem();
		}
		return fileSystem;
	}
	
	public void setFileSystem(ExecutionEnvironmentFileSystem system)
	{
		this.fileSystem=system;
	}
	
	
	public <X> void setAlternative(X base,X alternative)
	{
		if (dirtyAlternatives==null) {
			dirtyAlternatives=new IdentityHashMap<Object,Object>();
		}
		
		if (base instanceof AtSource) {
			AtSource a = (AtSource)base;
			AtSourceSession session = getSession(a.getParent(),false);
			if (session!=null) {
				session.deleteChildren();
			}
		}
		dirtyAlternatives.put(base, alternative);
	}
	
	@SuppressWarnings("unchecked")
	public <X> X getAlternative(X base)
	{
		if (dirtyAlternatives==null) return base;
		X result = (X) dirtyAlternatives.get(base);
		if (result==null) return base;
		return result;
	}
	
	private TextAppSource libsrc;
	
	public void init()
	{
		bindService("C55TPLSX.DLL#GenReadABCFiles",new GenReadABCFiles(libsrc));
		bindService("C55TPLS.DLL#GenReadABCFiles",new GenReadABCFiles(libsrc));
		pushBaseScope(new ConstantScope());
		pushBaseScope(new AppSymbolScope(app,this));
		pushBaseScope(new DictSymbolScope(dict,this));
		setPersist(app.getPersist());
		
		TemplateCmd set = chain.getTemplate(app.getBase().getChain());
		if (set==null) {
			error("Could not find template set for "+app.getBase());
		}		
		pushTemplate(set);
		
		if (set.getSystem()!=null) {
			AdditionExecutionState state = getAppSource().prepareToExecute();				
			set.getSystem().run(this);
			set.getSystem().prime(this);
			state.finish();
		}		
	}
	
	public void setDefaultStream(Appendable out)
	{
		this.defaultStream=new AppendableWriteTarget(out);
	}
	
	public void setConditionalGenerate(boolean value)
	{
		this.conditionalGenerate=value;
	}

	public void setEditProcedure(String filename,String value)
	{
		setEditProcedure(filename,value,true);
	}
	
	public void setEditProcedure(String filename,String value,boolean includeEmptyEmbeds)
	{
		if (value!=null && value.length()==0) value=null;
		this.editFilename=filename;
		this.editProcedure=value;
		this.includeEmptyEmbeds=includeEmptyEmbeds;
	}
	
	public boolean isIncludeEmptyEmbeds()
	{
		return includeEmptyEmbeds;
	}
	
	public boolean isEditProcedure()
	{
		return editProcedure!=null;
	}
	
	public void setLibSrc(String libsrc)
	{
		this.libsrc=new FileTextAppSource(libsrc);
	}

	public void setLibSrc(TextAppSource libsrc)
	{
		this.libsrc=libsrc;
	}
	
	public Dict getDict()
	{
		return dict;
	}
	
	public int getComment() {
		return comment;
	}

	public void setComment(int comment) {
		this.comment=comment;
	}

	public int getIndent()
	{
		return indent;
	}
	
	private String indentBuffer="                              ";
	private CharSequence indentSeq=indentBuffer;
	public CharSequence getIndentSeq()
	{
		if (indentSeq.length()!=indent) {
			indentSeq=indentBuffer.subSequence(0, indent);
		}
		return indentSeq;
	}
	
	public void setIndent(int indent)
	{
		this.indent=indent;
	}
	
	public App getApp()
	{
		return app;
	}
	
	public void setPersist(UserSymbolScope persist)
	{
		persist=new UserSymbolScope(persist,baseScope);
		this.persist=persist;
		pushBaseScope(persist);
	}
	
	public TemplateChain getTemplateChain()
	{
		return chain;
	}

	public void pushBaseScope(SymbolScope scope)
	{
		scope.setParentScope(baseScope);
		baseScope=scope;
	}

	public SymbolScope getBaseScope()
	{
		return baseScope;
	}
	
	public UserSymbolScope pushAutoScope(String name)
	{
		UserSymbolScope newScope = new UserSymbolScope(name);
		pushAutoScope(newScope);
		return newScope;
	}

	public void pushAutoScope(UserSymbolScope newScope)
	{
		this.currentSource.pushAutoScope(newScope);
	}

	public void popAutoScope()
	{
		this.currentSource.popAutoScope();
	}
	

	public SymbolScope getScope()
	{
		if (currentSource==null) {
			return baseScope;
		}
		return currentSource.getScope();
	}
	
	public UserSymbolScope getPersist()
	{
		return persist;
	}
	
	private LinkedList<Statement> stack=new LinkedList<Statement>();	
	public CodeResult runBlock(Iterable<Statement> statements) 
	{
		for (Statement s : statements ) {
			//stack.add(s);
			try {
				CodeResult cr = s.run(this);
				if (cr!=CodeResult.OK) return cr;
			} catch (TemplateExecutionError ex) {
				ex.append(",@"+s.getSrcRef());
				throw(ex);
			} catch (RuntimeException ex) {
				throw new TemplateExecutionError(ex.getMessage()+" @"+s.getSrcRef(),ex);
			} finally {
				//stack.removeLast();
			}
			
			
		}
		return CodeResult.OK;
	}
	
	public Statement getNonGroup()
	{
		Iterator<Statement> i = stack.descendingIterator();
		while (i.hasNext()) {
			Statement s = i.next();
			if (s.getSrcFile().equalsIgnoreCase("ABGROUP.TPW")) continue;
			return s;
		}
		return stack.getLast();
	}
	
	public void logStack()
	{
		Appendable a = getWriteTarget();
		try {
			Iterator<Statement> scan = stack.descendingIterator();
			if (scan.hasNext()) {
				scan.next();
			}
			while (scan.hasNext()) {
			String item = scan.next().getSrcRef();
			for (int s=item.length();s<20;s++) {
				a.append(' ');
			}			
			a.append(item).append("\n");
			
		}
		} catch (IOException ex) { }
	}

	public ClarionObject eval(CExpr expression) 
	{
		return expression.eval(this);
	}

	private long start=System.currentTimeMillis();
	private boolean stopOnError;
	
	public void setGeneratorProgress(GeneratorProgress progress)
	{
		this.progress=progress;
	}
	
	public void message(String string, int line) 
	{
		if (progress!=null) {
			progress.message(string, line);
			return;
		}
		if (line==1) {
			System.out.println((System.currentTimeMillis()-start)+" : " +string);
		}
	}

	private class RuntimeGroupFunction implements LabelExprResult
	{
		private String name;

		public RuntimeGroupFunction(String name) 
		{
			this.name=name;
		}

		@Override
		public ClarionObject execute(CExprScope scope, CExpr... params) {
			ArrayList<CExpr> al = new ArrayList<CExpr>(params.length);
			for (CExpr i : params) {
				al.add(i);
			}
			CodeResult cr = run(new TemplateID(null,name),al,true);
			if (cr.getReturnValue()!=null) {
				return cr.getReturnValue().asClarionObject();
			}
			return new ClarionString();
		}
	}
	
	@Override
	public LabelExprResult resolveBind(String name, boolean mustBeProcedure) 
	{
		LabelExprResult b = builtins.get(name.toLowerCase());
		if (b!=null) return b;
		
		if (!mustBeProcedure) {
			SymbolEntry se = getScope().get(name);
			if (se==null) {
				throw new IllegalStateException("Cannot resolve field:"+name);
			}		
			SymbolValue sv = se.getAny();
			if (sv==null) {
				return StringSymbolValue.BLANK;
			}
			return sv;
		}
		
		if (getTemplate().getSection("#GROUP", name)!=null) {
			return new RuntimeGroupFunction(name);
		}
		
		throw new IllegalStateException("Cannot resolve procedure:"+name);
	}
	
	public void setStopOnError(boolean stopOnError)
	{
		this.stopOnError=stopOnError;
	}
	
	public void error(String name)
	{
		if (stopOnError) {
			throw new IllegalStateException(name);
		}
		System.out.println(name);
	}

	private static class FileStore
	{
		public String name;
		public BufferedReader 			reader;
		public WriteTarget 				writer;
		public int indent;
	}	

	public String getTargetPath()
	{
		return target;
	}

	public void setTarget(String target) 
	{
		this.target=target;
	}
	
	
	public static final int READONLY=0;
	public static final int APPEND=1;
	public static final int CREATE=2;
	/**
	 * 
	 * @param name
	 * @param readonly
	 * @param mode.   0 = READONLY. 1 = APPEND. 2 = CREATE
	 * @return
	 */
	
	public Reader getReader(String name,boolean testFirst)
	{
		if (name.indexOf("$")>-1) {
			BufferedWriteTarget sw = getBuffer(name);
			if (sw!=null) {
				return sw.getReader();
			}
		}
		try {
			return getFileSystem().read(name,testFirst);
		} catch (IOException e) {
			e.printStackTrace();
		} 		
		return null;
	}
	
	public WriteTarget getWriter(String name,boolean append)
	{
		if (name.indexOf("$")>-1) {
			BufferedWriteTarget sw = new BufferedWriteTarget();
			tempFile.put(name.toLowerCase(),sw);
			return sw;
		}
		try {
			return getFileSystem().write(name, append);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean open(String name,int mode)
	{
		name=getTargetPath()+name;
		FileStore fs = new FileStore();
		fs.name=name;
		fs.indent=-1;
		if (mode==READONLY) {
			Reader r=getReader(name,false);
			if (r==null) return false;
			fs.reader=new BufferedReader(r);
		} else {
			fs.indent=this.indent;
			this.indent=0;
			fs.writer=getWriter(name,mode==APPEND);
			if (fs.writer==null) return false;
		}
		
		files.put(name,fs);
		fileStack.addFirst(fs);
		return true;
	}
	
	private Map<String,BufferedWriteTarget> tempFile=new HashMap<String,BufferedWriteTarget>();
	
	public BufferedWriteTarget getBuffer(String name)
	{
		return tempFile.get(name.toLowerCase());
	}
	
	public void closeAll() {
		for (FileStore fs : files.values()) {
			if (fs.reader!=null) {
				try {
					fs.reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fs.writer!=null) {
				fs.writer.close();
			}
			if (fs.indent>-1) {
				indent=fs.indent;
			}
		}
	}
	
	public boolean close(String name,boolean readonly)
	{
		FileStore fs=null;
		if (name!=null) {
			fs = files.get(name);
		}  else {
			Iterator<FileStore> scan = fileStack.iterator();
			while (scan.hasNext()) {
				fs=scan.next();
				if (readonly && fs.reader!=null) break;
				if (!readonly && fs.writer!=null) break;
			}
		}

		if (fs==null) return false;
		
		files.remove(fs.name);
		fileStack.remove(fs);
		
		if (fs.reader!=null) {
			try {
				fs.reader.close();
			} catch (IOException ex) { }
		}
		if (fs.writer!=null) {
			fs.writer.close();
		}
		return true;
	}
	
	private class SuspendBuffer {	
		private SuspendBuffer 			parent;
		private String 					name;
		private BufferedWriteTarget 	content=new BufferedWriteTarget(); 
		private BufferedWriteTarget 	alternative=null;

		public SuspendBuffer(SuspendBuffer parent,String name)
		{
			this.parent=parent;
			this.name=name;
		}	
		
		public String toString()
		{
			return name+" content:"+(content!=null)+" alternative:"+(alternative!=null);
		}
	}
	
	private SuspendBuffer buffer=null;
	
	public void suspend(String name)
	{
		SuspendBuffer buffer=new SuspendBuffer(this.buffer,name);
		this.buffer=buffer;
	}

	public void release()
	{
		if (buffer==null) return;
		if (buffer.content==null) return;
		try {
			release(getWriteTarget(false),buffer);
		} catch (IOException ex) {
			ex.printStackTrace();
			error(ex.getMessage());
		}
	}
	
	private void release(WriteTarget writeTarget, SuspendBuffer buffer) throws IOException 
	{
		if (buffer==null) return;
		if (buffer.content==null) return;
		release(writeTarget,buffer.parent);
		buffer.content.flushInto(writeTarget);
		buffer.content=null;
		buffer.alternative=null;
	}

	public void resume()
	{
		BufferedWriteTarget alternative=null;
		if (buffer.content!=null) {
			alternative=buffer.alternative;
		}
		buffer=buffer.parent;
		
		if (alternative!=null) {
			try {
				alternative.flushInto(getWriteTarget(true));
			} catch (IOException e) {
				e.printStackTrace();
				error(e.getMessage());
			}
		}
	}
	
	public void debugBuffers()
	{
		System.err.println("BUFFERS");
		SuspendBuffer sb = buffer;
		while (sb!=null) {
			System.err.println(sb);
			sb=sb.parent;
		}
	}
	
	public void alternative(String target,String content)
	{
		SuspendBuffer scan = buffer;
		if (buffer.content==null) {
			try {
				getWriteTarget(false).append(content);
			} catch (IOException e) {
				e.printStackTrace();
				error(e.getMessage());
			}			
		} else {
			buffer.content.append(content);
		}
		while (!target.equals(scan.name)) {
			if (scan.alternative==null) {
				scan.alternative=new BufferedWriteTarget();
			}
			scan.alternative.append(content);
			scan=scan.parent;
		}
	}

	
	public BufferedReader getReadSource()
	{
		for (FileStore fs : fileStack) {
			if (fs.reader!=null) return fs.reader;
		}
		return null;
	}

	public WriteTarget getWriteTarget() 
	{		
		return getWriteTarget(true);
	}

	public WriteTarget getWriteTarget(boolean useBuffers) 
	{		
		if (useBuffers && buffer!=null && buffer.content!=null) {
			return buffer.content;
		}
		for (FileStore fs : fileStack) {
			if (fs.writer!=null) return fs.writer;
		}
		return defaultStream;
	}

	private Map<String,TemplateCode> service=new HashMap<String,TemplateCode>();

	public TemplateCode getService(String key) 
	{
		return service.get(key.toLowerCase());
	}

	public void bindService(String service, TemplateCode code) 
	{
		this.service.put(service.toLowerCase(),code);
	}

	private Stack<TemplateCmd> templateStack=new Stack<TemplateCmd>();
	
	public void pushTemplate(TemplateCmd set) 
	{
		templateStack.push(set);
	}	

	public TemplateCmd getTemplate() 
	{
		return templateStack.peek();
	}	

	public TemplateCmd popTemplate() 
	{
		return templateStack.pop();
	}
	
	public CodeResult run(TemplateID target,List<CExpr> params,boolean useCurrentScope)
	{
		TemplateCmd targetSet;
		if (target.getChain()==null) {
			useCurrentScope=true;
			targetSet=getTemplate();
		} else {
			targetSet=getTemplateChain().getTemplate(target.getChain());
		}
		
		
		if (!useCurrentScope) {
			pushTemplate(targetSet);			
		}
		
		try {
			GroupCmd cmd = (GroupCmd)targetSet.getSection("#GROUP", target.getType());
			return cmd.call(this, params);
		} finally {
			if (!useCurrentScope) {
				popTemplate();
			}
		}
	}

	public void run(TemplateID target,List<CExpr> params,String returnSymbol,boolean useCurrentScope)
	{
		CodeResult cr = run(target,params,useCurrentScope);
		if (cr.getCode()==CodeResult.CODE_RETURN && returnSymbol!=null && cr.getReturnValue()!=null) {
			getScope().get(returnSymbol).scalar().setValue(cr.getReturnValue());
		}
	}

	public void debugScope()
	{
		System.err.println("SOURCESCOPE ");
		debugScope(getScope());
	}

	public void debugScope(SymbolScope from)
	{
		SymbolScope san = from;
		while (san!=null) {
			System.err.println(san);
			san=san.getParentScope();
		}		
	}

	public void debugAdvise(EmbedKey key)
	{
	}

	
	public AtSourceSession getCurrentSource() 
	{
		return currentSource;
	}
	
	public void setCurrentSource(AtSourceSession source)
	{
		this.currentSource=source;
	}
	
	
	public AtSourceSession getAppSource()
	{
		if (appSource==null) {
			appSource=new AtSourceSession(app,this,baseScope);
		}
		return appSource;		
	}

	public AtSourceSession getSession(AtSource source)
	{
		return getSession(source,true);
	}
	
	public AtSourceSession getSession(AtSource source,boolean allowCreate)
	{
		if (source==app) {
			if (!allowCreate && appSource==null) return null;
			return getAppSource();
		}		
		
		AtSourceSession parent = getSession(source.getParent(),allowCreate);
		if (parent==null) return null;
		
		if (!allowCreate && !parent.isChildrenLoaded()) return null;
		
		return parent.getChild(source);
	}
	
	public void setGenerationEnabled(boolean state)
	{
		this.generationEnabled=state;
	}

	public void generate()
	{
		if (baseScope==null) {
			init();
		}
		generate(getApp());
		closeAll();		
	}
	
	public void generate(AtSource source)
	{		
		generate(source,generationEnabled);
	}
	
	public void generate(AtSource source,boolean generationEnabled)
	{		
		if (!generationEnabled) return;
		AtSourceSession sess= getSession(source);
		if (sess.isGenerated()) {
			return;
			//throw new IllegalStateException("Already Generated:"+source.getName());
		}
		sess.setGenerated(true);
		AdditionExecutionState state = sess.prepareToExecute();
		currentSource.getCodeSection().run(this);
		state.finish();
	}

	public void popMonitor() 
	{
		getScope().popMonitor();
	}
	
	public void pushMonitor(PreserveBarrier pb) 
	{
		getScope().pushMonitor(pb);
	}
	
}
