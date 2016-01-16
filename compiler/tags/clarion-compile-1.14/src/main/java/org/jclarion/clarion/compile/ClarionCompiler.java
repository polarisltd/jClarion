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

import org.jclarion.clarion.compile.expr.DanglingExprType;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.grammar.FileLexerSource;
import org.jclarion.clarion.compile.grammar.LexerSource;
import org.jclarion.clarion.compile.grammar.LocalIncludeCache;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.compile.grammar.TargetOverrides;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.javac.ClarionClassLoader;
import org.jclarion.clarion.compile.javac.ClarionFileManager;
import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.EquateClasses;

public class ClarionCompiler {

    // ClarionCompiler.class.getPackage().getName();
    public static final String CLARION = "org.jclarion.clarion";
    public static final String BASE = "clarion";

    public void compile(String source,String main,File target) throws IOException
    {
        if (!target.isDirectory()) {
            throw new IOException("Target directory : "+target+" not found");
        }
        
        FileLexerSource fls = new FileLexerSource(source);
        LexerSource.setInstance(fls);
        
        TargetOverrides.getInstance().loadWindowOverrides(source);
        
        Parser p = new Parser(fls.getLexer(main));
        p.compileProgram();
        
        Set<File> paths=new HashSet<File>();

        char buffer[]=new char[1024];
        StringBuilder capta = new StringBuilder();

        int writeCount = 0;
        
        for ( JavaClass jc : ClassRepository.getAll() ) {
            File path = new File(target,(jc.getPackage().replace('.','/'))+"/");
        
            if (!paths.contains(path)) {
                paths.add(path);
                path.mkdirs();
            }
            
            path=new File(path,jc.getName()+".java");
            
            String out;
            try {
                out = jc.toJavaSource();
            } catch (RuntimeException ex) {
                throw new RuntimeException("While toSourcing "+jc.getName(),ex);
            }
            
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
        }
        
        System.out.println("Wrote "+writeCount+" java file(s)");

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
    
    public static ClassLoader compile()
    {
        JavaCompiler jc = ToolProvider.getSystemJavaCompiler();
        StandardJavaFileManager sfm = jc.getStandardFileManager(null,null,null);
        
        ClarionFileManager cfm = new ClarionFileManager(sfm);
        
        if (!jc.getTask(null,cfm,null,null,null,cfm.getAllSourceFiles()).call()) {
           
            for (JavaClass log : ClassRepository.getAll()) {
                System.out.println(log.getName());
                System.out.println("=============");
                System.out.println(log.toJavaSource());
            }
            
            throw new RuntimeException("Compilation Failed");
        }
        
        return new ClarionClassLoader(ClassLoader.getSystemClassLoader(),cfm);
    }
    
    public static void clean()
    {
        // rebuild
        ExprType.clear();
        MainScope.clean();

        // empty
        Labeller.clear();
        ScopeStack.clearScope();
        ClassRepository.clear();
        ModuleScope.removeAll();
        EquateClasses.clean();
        LexerSource.setInstance(null); // nullify Lexer source
        LocalIncludeCache.clear();
        DanglingExprType.clean();
        Scope.clean();
        TargetOverrides.clear();
        // rebuild again just to make sure 
        MainScope.clean();
    }
}
