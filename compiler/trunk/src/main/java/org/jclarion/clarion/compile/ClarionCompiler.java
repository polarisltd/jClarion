/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.compile;


import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.tools.JavaCompiler;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.compile.expr.DanglingContainer;
import org.jclarion.clarion.compile.grammar.AbstractErrorCollator;
import org.jclarion.clarion.compile.grammar.FailFastErrorCollator;
import org.jclarion.clarion.compile.grammar.FileLexerSource;
import org.jclarion.clarion.compile.grammar.LexerSource;
import org.jclarion.clarion.compile.grammar.LocalIncludeCache;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.compile.grammar.SourceFileCollator;
import org.jclarion.clarion.compile.grammar.TargetOverrides;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.javac.ClarionClassLoader;
import org.jclarion.clarion.compile.javac.ClarionFileManager;
import org.jclarion.clarion.compile.javaimport.DefaultJavaImporter;
import org.jclarion.clarion.compile.javaimport.JavaImporter;
import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.EquateClasses;

public class ClarionCompiler {

    // ClarionCompiler.class.getPackage().getName();
    public static final String CLARION = "org.jclarion.clarion";
    public static final String RAW_BASE = "clarion";


    private MainScope			   main; 
	private ScopeStack				stack;
	private EquateClasses   		eqClasses;
	private ClassRepository			repository;
	private DanglingContainer		dangles;
	private TargetOverrides			overrides;
	private LexerSource				source;
	private SourceFileCollator		collator;
	private JavaImporter<?>			importer;
	private AbstractErrorCollator	error;
	private boolean					recycled;
    
    public ClarionCompiler()
    {    	
    	dangles=new DanglingContainer();
    	repository=new ClassRepository();
    	this.stack=new ScopeStack(this);
    	main=new MainScope(stack);
    	this.eqClasses=new EquateClasses(this);
    	overrides=new TargetOverrides();
    	collator=new SourceFileCollator();
    }
    
    
    public void setRecycled()
    {
    	this.recycled=true;
    }
    
    public boolean isRecycled()
    {
    	return recycled;
    }
    
    public AbstractErrorCollator error()
    {
    	if (error==null) {
    		error=new FailFastErrorCollator();
    	}
    	return error;
    }
    
    public void setErrorCollator(AbstractErrorCollator error)
    {
    	this.error=error;
    }
    
    
    public JavaImporter<?> importer()
    {
    	if (importer==null) {
    		setImporter(new DefaultJavaImporter());
    	}
    	return importer;
    }
    
    public void setImporter(JavaImporter<?> importer)
    {
    	this.importer=importer;
    	importer.setCompiler(this);
    }
    
    public SourceFileCollator collator()
    {
    	return collator;
    }    
    
    public LexerSource source()
    {
    	return source;
    }
    
    public void setSource(LexerSource source)
    {
    	this.source=source;
    }
    
    public TargetOverrides getTargetOverrides()
    {
    	return overrides;
    }
    
    public DanglingContainer dangles()
    {
    	return dangles;
    }
    
    public ClassRepository repository()
    {
    	return repository;
    }
    
    public LocalIncludeCache getLocalIncludeCache(String name)
    {
    	Scope scan = getScope();
    	LocalIncludeCache result = scan.getLocalIncludeCache(name);
    	if (result==null) {
    		result = scan.getLocalIncludeCache(true);
    	}    	
    	return result;
    }
    
    
    public MainScope main()
    {
    	return main;
    }
    
    public ScopeStack stack()
    {
    	return stack;
    }

    public Scope getScope()
    {
    	return stack.getScope();
    }
    
    public EquateClasses equates()
    {
    	return eqClasses;
    }
      
    
    public void compile(String source,String main,File target) throws IOException
    {
    	long start=System.currentTimeMillis();
    	
        if (!target.isDirectory()) {
            throw new IOException("Target directory : "+target+" not found");
        }
        
        FileLexerSource fls = new FileLexerSource(source);
        setSource(fls);
        
        getTargetOverrides().loadWindowOverrides(fls.getLexer("win.properties"));
        
        boolean incremental = "true".equals(System.getProperty("incremental"));
        
        collator.associate(source().cleanName(main),main());
        
        Parser p = new Parser(this,fls.getLexer(main));
        p.compileProgram(!incremental);
        
        Set<File> paths=new HashSet<File>();

        char buffer[]=new char[8096];
        StringBuilder capta = new StringBuilder();

        int readCount = 0;
        int writeCount = 0;
        Set<String> writeFiles=new HashSet<String>();
              
        for ( JavaClass jc : repository.getAll() ) {
        	
            if (incremental && !jc.isCompiled()) {
            	continue;
            }
        	
        	if (jc.getPackage()==null) {
        		System.err.println("Missing package for :"+jc.getName());
        		continue;
        	}
        	
            File path = new File(target,(jc.getPackage().replace('.','/'))+"/");
        
            if (!paths.contains(path)) {
                paths.add(path);
                path.mkdirs();
            }
            
            path=new File(path,jc.getName()+".java");
            
            String out;
            try {
                out = jc.toJavaSource(this);
            } catch (RuntimeException ex) {
                throw new RuntimeException("While toSourcing "+jc.getName(),ex);
            }
            
            readCount++;
            
            if (path.exists()) {
                Reader r = new FileReader(path);
                capta.setLength(0);
                while (true) {
                    int count = r.read(buffer);
                    if (count<=0) break;
                    capta.append(buffer,0,count);
                }
                r.close();
                
                if (capta.toString().equals(out)) continue;
            }
            
            Writer w = new FileWriter(path);
            w.write(out);
            w.close();
            writeCount++;
            if (writeFiles.size()<10) {
            	writeFiles.add(jc.getPackage()+"."+jc.getName());
            }
        }
        
        long end = System.currentTimeMillis();
        ClarionDecimal cd = new ClarionDecimal(10,2);
        cd.setValue(end-start);
        cd=cd.divide(1000).getDecimal();
        
        System.out.println("Wrote "+writeCount+" of "+readCount+" java file(s) "+writeFiles+" in "+cd+" sec");
    }
    
    
	public static void main(String args[]) throws IOException
    {        
        long start=System.currentTimeMillis();
        
        ClarionCompiler compile = new ClarionCompiler();

        if (args.length!=3) {
            System.out.println("Compile: <sourceDirectory> <main.clw> <targetDirectory>");
            return;
        }
        
        compile.compile(args[0],args[1],new File(args[2]));
        
        long runTime=System.currentTimeMillis()-start;
        BigDecimal bd = new BigDecimal(runTime);
        bd=bd.scaleByPowerOfTen(-4);
        System.out.println("Total run time:"+bd+"s");
    }
    
    
    public ClassLoader compile()
    {
        JavaCompiler jc = ToolProvider.getSystemJavaCompiler();
        StandardJavaFileManager sfm = jc.getStandardFileManager(null,null,null);
        
        ClarionFileManager cfm = new ClarionFileManager(this,sfm);
        
        if (!jc.getTask(null,cfm,null,null,null,cfm.getAllSourceFiles()).call()) {
           
        	int count=logRepository();
            throw new RuntimeException("Compilation Failed:"+count);
        }
        
        return new ClarionClassLoader(ClassLoader.getSystemClassLoader(),cfm);
    }
    
    public int logRepository()
    {
    	int count=0;
        for (JavaClass log : repository.getAll()) {
        	count++;
            System.out.println(log.getName());
            System.out.println("=============");
            System.out.println(log.toJavaSource(this));
        }
        
        return count;
    }
}
