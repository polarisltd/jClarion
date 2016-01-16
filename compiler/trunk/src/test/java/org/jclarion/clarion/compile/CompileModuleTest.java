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

import java.util.TreeSet;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.compile.grammar.LexerSource;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.Variable;

public class CompileModuleTest extends CompileTestHelper
{
	
	public void testIncrementalJavaImport()
	{
        getSource().addLexer("m1.inc",
       		 "  MODULE('M1.CLW')\n",
       		 "  END\n",
               "");

  
        getSource().addLexer("m1.clw",
                "   member\n",
                "   map\n",                
                "   include('m1.INC')\n",
                "   end\n",
                "proc1 procedure\n",
                "  @java-import 'org.jclarion.clarion.compile.RefClass'\n",
                "myclass SimpleClass\n",
                "test string\n",
                "  code\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  return 4\n",
                "");


        getSource().addLexer("main.clw",
                "   program\n",
                "result long\n",
                "   map\n",
                "    module('m1.clw')\n",
                "proc1 procedure,long\n",
                "   .\n",
                "   .\n",
                "myclass class\n",
                "doit procedure,long\n",
                ".\n",
                "   code\n",
                "   result=myclass.doit\n",
                "myclass.doit procedure\n",
                "   code\n",
                "   return proc1()+2\n",
                "");

        ClassLoader cl;
        Parser p;
        ClarionObject result;
        
        incrementalCompile(getSource().getLexer("main.clw"));
        p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
        p.recompileModule("m1.clw");
        compiler.stack().fixDisorderedScopes();
        cl =compiler.compile();
        runClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(6, result.intValue());  
        
        
        p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
        p.recompileModule("m1.clw");
        compiler.stack().fixDisorderedScopes();
        cl =compiler.compile();
        runClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(6, result.intValue());  
        
	}

	public void testIncrementalCompileOfGlobalFunc()
	{
        getSource().addLexer("m1.inc",
        		 "  MODULE('M1.CLW')\n",
        		 "  END\n",
                "");

   
         getSource().addLexer("m1.clw",
                 "   member\n",
                 "   map\n",                
                 "   include('m1.INC')\n",
                 "   end\n",
                 "proc1 procedure\n",                
                 "   code\n",
                 "   return 4\n",
                 "");


         getSource().addLexer("main.clw",
                 "   program\n",
                 "result long\n",
                 "   map\n",
                 "    module('m1.clw')\n",
                 "proc1 procedure,long\n",
                 "   .\n",
                 "   .\n",
                 "myclass class\n",
                 "doit procedure,long\n",
                 ".\n",
                 "   code\n",
                 "   result=myclass.doit\n",
                 "myclass.doit procedure\n",
                 "   code\n",
                 "   return proc1()+2\n",
                 "");
         
         ClassLoader cl;
         ClarionObject result;
         
         cl =compile(getSource().getLexer("main.clw"));
         runClarionProgram(cl);
         result = getMainVariable(cl, "result");
         assertEquals(6, result.intValue());        

         ClarionCompiler old = compiler;
         
         // recompile but only the main scope 
         LexerSource ls = compiler.source();
         ClassRepository cr = compiler.repository();
         compiler=new ClarionCompiler();
         compiler.setSource(ls);
         
         JavaClass jc = cr.get("m1.M1");
         final String src = jc.toJavaSource(old);
         incrementalCompile(getSource().getLexer("main.clw"));
         compiler.stack().fixDisorderedScopes();
         
         compiler.repository().clear("clarion.m1");
         compiler.repository().add(new JavaClass() {
			@Override
			public String getPackage() {
				return "clarion.m1";
			}

			@Override
			public Iterable<? extends Procedure> getMethods() {
				return null;
			}

			@Override
			public Iterable<? extends Variable> getFields() {
				return null;
			}

			@Override
			protected void buildConstructor(StringBuilder main,
					JavaDependencyCollector collector) {
			}

			@Override
			public String toJavaSource(ClarionCompiler compiler) {
				return src;
			}
         },"clarion.m1","M1");             
                  
         cl =compiler.compile();
         runClarionProgram(cl);
         result = getMainVariable(cl, "result");
         assertEquals(6, result.intValue());  		
		
	}
	
	
	public void testRecompileSelfRefClass()
	{
        getSource().addLexer("m1.inc",
        		 "  MODULE('M1.CLW')\n",
        		 "proc1               PROCEDURE,byte\n",
        		 "  END\n",
                "");

   
         getSource().addLexer("m1.clw",
                 "   member\n",
                 "   map\n",                
                 "   include('m1.INC')\n",
                 "   end\n",
                 "proc1 procedure\n",                
                 "myclass class\n",
                 "method1 procedure,long\n",
                 "method2 procedure,long\n",
                 ".\n",
                 "   code\n",
                 "   return myclass.method1\n",
                 "myclass.method1 procedure\n",
                 "   code\n",
                 "   return myclass.method2+1\n",
                 "myclass.method2 procedure\n",
                 "   code\n",
                 "   return 5\n",
                 "");


         getSource().addLexer("main.clw",
                 "   program\n",
                 "result long\n",
                 "   map\n",
                 "   include('m1.INC')\n",
                 "   .\n",
                 "   code\n",
                 "   result=proc1\n",
                 "");
         
         ClassLoader cl;
         ClarionObject result;
         
         cl =compile(getSource().getLexer("main.clw"));
         runClarionProgram(cl);
         result = getMainVariable(cl, "result");
         assertEquals(6, result.intValue());        

         
         // throw away compiler and start over
         LexerSource ls = compiler.source();
         compiler=new ClarionCompiler();
         compiler.setSource(ls);
         
         Parser p;
         
         incrementalCompile(getSource().getLexer("main.clw"));
         p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
         p.recompileModule("m1.clw");
         p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
         p.recompileModule("m1.clw");
         compiler.stack().fixDisorderedScopes();
         cl =compiler.compile();
         runClarionProgram(cl);
         result = getMainVariable(cl, "result");
         assertEquals(6, result.intValue());  		
	}

	public void testRecompileSelfRefClass2()
	{
        getSource().addLexer("m1.inc",
        		 "  MODULE('M1.CLW')\n",
        		 "proc1               PROCEDURE,byte\n",
        		 "proc2               PROCEDURE,byte\n",
        		 "  END\n",
                "");

   
         getSource().addLexer("m1.clw",
                 "   member\n",
                 "   map\n",                
                 "   include('m1.INC')\n",
                 "   end\n",
                 "proc2 procedure\n",
                 "    code\n",
                 "proc1 procedure\n",                
                 "myclass class\n",
                 "method1 procedure,long\n",
                 "method2 procedure,long\n",
                 ".\n",
                 "   code\n",
                 "   return myclass.method1\n",
                 "myclass.method1 procedure\n",
                 "   code\n",
                 "   return myclass.method2+1\n",
                 "myclass.method2 procedure\n",
                 "   code\n",
                 "   return 5\n",
                 "");


         getSource().addLexer("main.clw",
                 "   program\n",
                 "result long\n",
                 "   map\n",
                 "   include('m1.INC')\n",
                 "   .\n",
                 "   code\n",
                 "   result=proc1\n",
                 "");
         
         ClassLoader cl;
         ClarionObject result;
         
         cl =compile(getSource().getLexer("main.clw"));
         runClarionProgram(cl);
         result = getMainVariable(cl, "result");
         assertEquals(6, result.intValue());        

         
         // throw away compiler and start over
         LexerSource ls = compiler.source();
         compiler=new ClarionCompiler();
         compiler.setSource(ls);
         
         Parser p;
         
         incrementalCompile(getSource().getLexer("main.clw"));
         p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
         p.recompileModule("m1.clw");
         p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
         p.recompileModule("m1.clw");
         compiler.stack().fixDisorderedScopes();
         cl =compiler.compile();
         runClarionProgram(cl);
         result = getMainVariable(cl, "result");
         assertEquals(6, result.intValue());  		
	}
	
	
	public void testRecompileIncludeSourcedConstants()
	{
        getSource().addLexer("m1.inc",
         		 "  MODULE('M1.CLW')\n",
         		 "proc1               PROCEDURE,byte\n",
         		 "  END\n",
                 "");

        getSource().addLexer("icons.inc",
        		"PADLOCK_ICON  equate(7)\n",
                "");
        
          getSource().addLexer("m1.clw",
                  "   member\n",
                  "   include('icons.inc')\n",
                  "   map\n",                
                  "   include('m1.INC')\n",
                  "   end\n",         
                  "proc1 procedure\n",                
                  "   code\n",
                  "   return PADLOCK_ICON\n",
                  "");


          getSource().addLexer("main.clw",
                  "   program\n",
                  "result long\n",
                  "   map\n",
                  "   include('m1.INC')\n",
                  "   .\n",
                  "   code\n",
                  "   result=proc1\n",
                  "");
          
          ClassLoader cl;
          ClarionObject result;
          
          cl =compile(getSource().getLexer("main.clw"));
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());        

          
          // throw away compiler and start over
          LexerSource ls = compiler.source();
          compiler=new ClarionCompiler();
          compiler.setSource(ls);
          
          Parser p;
          
          incrementalCompile(getSource().getLexer("main.clw"));
          p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
          p.recompileModule("m1.clw");
          p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
          p.recompileModule("m1.clw");
          cl =compiler.compile();
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());      
	}
	

	public void testRecompileEscalatedVar()
	{
        getSource().addLexer("m1.inc",
         		 "  MODULE('M1.CLW')\n",
         		 "proc1               PROCEDURE,byte\n",
         		 "  END\n",
                 "");

          getSource().addLexer("m1.clw",
                  "   member\n",
                  "   map\n",                
                  "   include('m1.INC')\n",
                  "   end\n",         
                  "proc1 procedure\n",
                  "result &long\n",
                  "   code\n",
                  "   do primeresult\n",
                  "   return result\n",
                  "primeresult routine\n",
                  "   if result&=null\n",
                  "      result&=new long\n",
                  "      result=7\n",
                  "   else\n",
                  "      result=8\n",
                  "   .\n",
                  "");


          getSource().addLexer("main.clw",
                  "   program\n",
                  "result long\n",
                  "   map\n",
                  "   include('m1.INC')\n",
                  "   .\n",
                  "   code\n",
                  "   result=proc1\n",
                  "");
          
          ClassLoader cl;
          ClarionObject result;
          
          cl =compile(getSource().getLexer("main.clw"));
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());        

          
          // throw away compiler and start over
          LexerSource ls = compiler.source();
          compiler=new ClarionCompiler();
          compiler.setSource(ls);
          
          Parser p;
          
          incrementalCompile(getSource().getLexer("main.clw"));
          p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
          p.recompileModule("m1.clw");
          cl =compiler.compile();
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());      
          
          
          p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
          p.recompileModule("m1.clw");
          cl =compiler.compile();
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());      
	}
		
	
	public void testRecompileGlobalProcedure()
	{
        getSource().addLexer("m1.inc",
         		 "  MODULE('M1.CLW')\n",
         		 "  END\n",
                 "");


          getSource().addLexer("m1.clw",
                  "   member\n",
                  "   map\n",                
                  "   include('m1.INC')\n",
                  "   end\n",         
                  "proc1 procedure\n",                
                  "   code\n",
                  "   return 7\n",
                  "");


          getSource().addLexer("main.clw",
                  "   program\n",
                  "result long\n",
                  "   map\n",
          		 "  MODULE('M1.CLW')\n",
          		 "proc1               PROCEDURE,byte\n",
          		 "  END\n",
                  "   .\n",
                  "   code\n",
                  "   result=proc1\n",
                  "");
          
          ClassLoader cl;
          ClarionObject result;
          
          cl =compile(getSource().getLexer("main.clw"));
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());        

          
          // throw away compiler and start over
          LexerSource ls = compiler.source();
          compiler=new ClarionCompiler();
          compiler.setSource(ls);
          
          Parser p;
          
          incrementalCompile(getSource().getLexer("main.clw"));
          p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
          p.recompileModule("m1.clw");
          cl =compiler.compile();
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());      
          
          
          p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
          p.recompileModule("m1.clw");
          cl =compiler.compile();
          runClarionProgram(cl);
          result = getMainVariable(cl, "result");
          assertEquals(7, result.intValue());      
	}
	
	public void testRecompileAModule()
	{
        getSource().addLexer("m1.inc",
          		 "  MODULE('M1.CLW')\n",
          		 "proc1               PROCEDURE,byte\n",
          		 "  END\n",
                  "");

           getSource().addLexer("m2.inc",
           		 "  MODULE('M2.CLW')\n",
           		 "proc2               PROCEDURE,byte\n",
           		 "  END\n",
                   "");
           
           getSource().addLexer("m1.clw",
                   "   member\n",
                   "   map\n",                
                   "   include('m1.INC')\n",
                   "   include('m2.INC')\n",
                   "   end\n",         
                   "proc1 procedure\n",                
                   "   code\n",
                   "   return proc2+3\n",
                   "");

           getSource().addLexer("m2.clw",
                   "   member\n",
                   "   map\n",                
                   "   include('m2.INC')\n",
                   "   end\n",         
                   "proc2 procedure\n",
                   "   code\n",
                   "   return 2\n",
                   "");

           getSource().addLexer("main.clw",
                   "   program\n",
                   "result long\n",
                   "   map\n",
                   "   include('m1.INC')\n",
                   "   .\n",
                   "   code\n",
                   "   result=proc1\n",
                   "");
           
           ClassLoader cl;
           ClarionObject result;
           
           cl =compile(getSource().getLexer("main.clw"));
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(2+3, result.intValue());        

           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(2+3, result.intValue());      
           
           Parser p;

           getSource().addLexer("m2.clw",
                   "   member\n",
                   "   map\n",                
                   "   include('m2.INC')\n",
                   "   end\n",         
                   "proc2 procedure\n",
                   "   code\n",
                   "   return 7\n",
                   "");           
           
           
           p = new Parser(compiler,compiler.source().getLexer("m2.clw"));
           p.recompileModule("m2.clw");
           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(7+3, result.intValue());      
           
           getSource().addLexer("m1.clw",
                   "   member\n",
                   "   map\n",                
                   "   include('m1.INC')\n",
                   "   include('m2.INC')\n",
                   "   end\n",         
                   "proc1 procedure\n",                
                   "   code\n",
                   "   return proc2*2\n",
                   "");
           
           p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
           p.recompileModule("m1.clw");
           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(7*2, result.intValue());      
           
           
           
           getSource().addLexer("m2.clw",
                   "   member\n",
                   "   map\n",                
                   "   include('m2.INC')\n",
                   "   end\n", 
                   "myclass class\n",
                   "someresult procedure,long\n",
                   ".\n",
                   "proc2 procedure\n",
                   "   code\n",
                   "   return myclass.someresult\n",
                   "myclass.someresult procedure\n",
                   "   code\n",
                   "   return 11\n",
                   "");           
           
           
           p = new Parser(compiler,compiler.source().getLexer("m2.clw"));
           p.recompileModule("m2.clw");
           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(11*2, result.intValue());        
           
           
           
           getSource().addLexer("m1.clw",
                   "   member\n",
                   "   map\n",                
                   "   include('m1.INC')\n",
                   "   include('m2.INC')\n",
                   "   end\n",         
                   "proc1 procedure\n",  
                   "mywindow window\n",
                   "    string,use(?use1)\n",
                   "    string,use(?use2)\n",
                   "    string,use(?use3)\n",
                   "   .\n",
                   "   code\n",
                   "   return proc2*?use3\n",
                   "");
           
           p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
           p.recompileModule("m1.clw");
           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(11*3, result.intValue());
           
           
           getSource().addLexer("m2.clw",
                   "   member\n",
                   "   map\n",                
                   "   include('m2.INC')\n",
                   "   end\n", 
                   "mynextclass class\n",
                   "someresult procedure,long\n",
                   ".\n",
                   "proc2 procedure\n",
                   "   code\n",
                   "   return mynextclass.someresult\n",
                   "mynextclass.someresult procedure\n",
                   "   code\n",
                   "   return -1\n",
                   "");           
           
           assertNotNull(compiler.repository().get("m2.Myclass"));           
           
           p = new Parser(compiler,compiler.source().getLexer("m2.clw"));
           p.recompileModule("m2.clw");
           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(-1*3, result.intValue());        
           
                      
           assertNotNull(compiler.repository().get("m2.Mynextclass"));
           assertNull(compiler.repository().get("m2.Myclass"));
           
           TreeSet<String> res = new TreeSet<String>();
           for (JavaClass jc : compiler.repository().getAll("m2")) {
        	   res.add(jc.getName());
           }
           assertEquals("[M2, Mynextclass]",res.toString());
           
           
           // throw away compiler and start over
           LexerSource ls = compiler.source();
           compiler=new ClarionCompiler();
           compiler.setSource(ls);
           
           incrementalCompile(getSource().getLexer("main.clw"));
           assertSource();
           p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
           p.recompileModule("m1.clw");
           assertSource();
           p = new Parser(compiler,compiler.source().getLexer("m2.clw"));
           p.recompileModule("m2.clw");
           assertSource();
           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(-1*3, result.intValue());      
           
           
           
           // throw away compiler and start over
           ls = compiler.source();
           compiler=new ClarionCompiler();
           compiler.setSource(ls);
           
           incrementalCompile(getSource().getLexer("main.clw"));
           assertSource();
           p = new Parser(compiler,compiler.source().getLexer("m2.clw"));
           p.recompileModule("m2.clw");
           assertSource();
           p = new Parser(compiler,compiler.source().getLexer("m1.clw"));
           p.recompileModule("m1.clw");
           assertSource();
           cl =compiler.compile();
           runClarionProgram(cl);
           result = getMainVariable(cl, "result");
           assertEquals(-1*3, result.intValue());               
           
	}	
	
	private void assertSource() {
		for (JavaClass jc : compiler.repository().getAll()) {
			jc.toJavaSource(compiler);
		}
	}

	public void testSharedIncludeNested()
	{
        getSource().addLexer("m1.inc",
       		 "  MODULE('M1.CLW')\n",
       		 "proc1               PROCEDURE,byte\n",
       		 "  END\n",
               "");

        getSource().addLexer("m2.inc",
        		 "  MODULE('M2.CLW')\n",
        		 "proc2               PROCEDURE,byte\n",
        		 "  END\n",
                "");
        
        getSource().addLexer("m1.clw",
                "   member\n",
                "   map\n",                
                "   include('m1.INC')\n",
                "   include('m2.INC')\n",
                "   end\n",         
                "proc1 procedure\n",                
                "   code\n",
                "   return proc2+3\n",
                "");

        getSource().addLexer("m2.clw",
                "   member\n",
                "   map\n",                
                "   include('m2.INC')\n",
                "   end\n",         
                "proc2 procedure\n",
                "   code\n",
                "   return 2\n",
                "");
        
        ClassLoader cl =compile(
                "   program\n",
                "result long\n",
                "   map\n",
                "   include('m1.INC')\n",
                "   .\n",
                "   code\n",
                "   result=proc1\n",
                "");
       
        runClarionProgram(cl);
        
        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(2+3, result.intValue());        
	}
	
	
	
	
	public void testConflictedStatics()
	{
		
        getSource().addLexer("m1.inc",
                "proc1 procedure,byte\n",
                "");

        getSource().addLexer("m2.inc",
                "proc2 procedure,byte\n",
                "");
        
        getSource().addLexer("m1.clw",
                "   member\n",
                "   map\n",                
                "   include('m1.inc')\n",
                "   end\n",         
        		"myclass class\n",
        		"result long(1)\n",
        		".\n",
                "proc1 procedure\n",                
                "   code\n",
                "   return myclass.result\n",
                "");

        getSource().addLexer("m2.clw",
                "   member\n",
                "   map\n",                
                "   include('m2.inc')\n",
                "   end\n",                
        		"myclass class\n",
        		"result long(2)\n",
        		".\n",
                "proc2 procedure\n",
                "   code\n",
                "   return myclass.result\n",
                "");
        
        ClassLoader cl =compile(
                "   program\n",
                "result long\n",
                "   map\n",
                "     module('m1.clw')\n",
                "        include('m1.inc')\n",
                "     .\n",
                "     module('m2.clw')\n",
                "        include('m2.inc')\n",
                "     .\n",
                "   .\n",
                "   code\n",
                "   result=proc1+proc2\n",
                "");
		
        for (JavaClass jc : compiler.repository().getAll()) {
        	System.out.println(jc.toJavaSource(compiler));
        }
        
        runClarionProgram(cl);
        
        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(1+2, result.intValue());                
	}

	public void testConflictedStaticsReinitialise()
	{
		
        getSource().addLexer("m1.inc",
                "proc1 procedure,byte\n",
                "");

        getSource().addLexer("m2.inc",
                "proc2 procedure,byte\n",
                "");
        
        getSource().addLexer("m1.clw",
                "   member\n",
                "   map\n",                
                "   include('m1.inc')\n",
                "   end\n",         
        		"myclass class\n",
        		"result long(1)\n",
        		".\n",
                "proc1 procedure\n",                
                "   code\n",
                "	x#=myclass.result\n",
                "   myclass.result+=1\n",
                "   return x#\n",
                "");

        getSource().addLexer("m2.clw",
                "   member\n",
                "   map\n",                
                "   include('m2.inc')\n",
                "   end\n",                
        		"myclass class\n",
        		"result long(2)\n",
        		".\n",
                "proc2 procedure\n",
                "   code\n",
                "	x#=myclass.result\n",
                "   myclass.result+=1\n",
                "   return x#\n",
                "");
        
        ClassLoader cl =compile(
                "   program\n",
                "result long\n",
                "   map\n",
                "     module('m1.clw')\n",
                "        include('m1.inc')\n",
                "     .\n",
                "     module('m2.clw')\n",
                "        include('m2.inc')\n",
                "     .\n",
                "   .\n",
                "   code\n",
                "   result=proc1+proc2\n",
                "");
		
        ClarionObject result = getMainVariable(cl, "result");

        runClarionProgram(cl);
        assertEquals(1+2, result.intValue());                
        runClarionProgram(cl);
        assertEquals(1+2+2, result.intValue());                

        initProgram(cl);        
        result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());                
        runClarionProgram(cl);
        assertEquals(1+2, result.intValue());                
	}
	
	
	public void testSharedIncludeFrom2Modules()
	{
        getSource().addLexer("share.inc",
                "id equate(1)\n",
                "");
		
        getSource().addLexer("m1.inc",
                "proc1 procedure,byte\n",
                "");

        getSource().addLexer("m2.inc",
                "proc2 procedure,byte\n",
                "");
        
        getSource().addLexer("m1.clw",
                "   member\n",
                "   map\n",                
                "   include('m1.inc')\n",
                "   end\n",         
                "   include('share.inc')\n",
                "id1 equate(5)\n",
                "proc1 procedure\n",                
                "   code\n",
                "   return id+id1\n",
                "");

        getSource().addLexer("m2.clw",
                "   member\n",
                "   map\n",                
                "   include('m2.inc')\n",
                "   end\n",                
                "   include('share.inc')\n",
                "id1 equate(6)\n",
                "proc2 procedure\n",
                "   code\n",
                "   return id+id1\n",
                "");
        
        ClassLoader cl =compile(
                "   program\n",
                "result long\n",
                "   map\n",
                "     module('m1.clw')\n",
                "        include('m1.inc')\n",
                "     .\n",
                "     module('m2.clw')\n",
                "        include('m2.inc')\n",
                "     .\n",
                "   .\n",
                "   code\n",
                "   result=proc1+proc2\n",
                "");
       
        runClarionProgram(cl);
        
        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(1+1+5+6, result.intValue());        
	}
	
	
    public void testThreadEscalatedAssignmentPreCompiledO()
    {
        getSource().addLexer("m1.inc",
                "tcontent group\n",
                "id long\n",
                ".\n",
                "tc class,type\n",
                "val &tcontent\n",
                "construct procedure\n",
                ".\n",

                "tc2 class,type\n",
                "val &tc\n",
                "construct procedure\n",
                ".\n",
                
                "");

        getSource().addLexer("m1.clw",
                "   member\n",
                "   include('m1.inc')\n",
                "   map\n",
                "tp2 procedure\n",
                "   .\n",
                "tci tc\n",
                "tci2 tc2\n",
                "tc.construct procedure\n",
                "   code\n",
                "   SELF.val&=new tcontent\n",
                "   SELF.val.id=1\n",
                "tc2.construct procedure\n",
                "   code\n",
                "   SELF.val&=new tc\n",
                "   SELF.val.val.id=1\n",
                "tp2 procedure\n",
                "   code\n",
                "   tci.val&=new TContent\n",
                "   tci2.val&=new TC\n",
                "   tci.val.id=1\n",
                "   tci2.val.val.id=2\n",
                "   if tci.val&=null then return\n.",
                "   if tci2.val.val&=null then return\n.",
                "   if tci2.val.val.id=4 then return\n.",
                "");

        getSource().addLexer("m2.inc",
                "myproc procedure\n",
                "");

        getSource().addLexer("m2.clw",
                "   member\n",
                "   include('m1.inc')\n",
                "   map\n",
                "     include('m2.inc')\n",
                "   .\n",
                "mtc2 tc2,thread\n",
                "myproc procedure\n",
                "   code\n",
                "");

        ClassLoader cl =compile(
                "   program\n",
                "   include('m1.inc')\n",
                "   map\n",
                "     module('m1.clw')\n",
                "     .\n",
                "     module('m2.clw')\n",
                "        include('m2.inc')\n",
                "     .\n",
                "   .\n",
                "   code\n",
                "   myproc\n",
                "");
        
        runClarionProgram(cl);
    }
    
    
    public void testInitOrderCanCauseProblemsForConstruction()
    {
        getSource().addLexer("default.clw",
                "default group\n",
                "count long\n",
                ".\n",
                "");

        getSource().addLexer("util.clw",
                "   member\n",
                "myclass class,type\n",
                "Construct procedure\n",
                ".\n",
                "   include('default.clw')\n",
                "myclass.construct procedure\n",
                "   code\n",
                "   default.count=1\n",
                "");

        ClassLoader cl =compile(
                "   program\n",
                "   map\n",
                "     module('util.clw')\n",
                "     .\n",
                "   .\n",
                "tclass myclass\n",
                "   code\n",
                "");
        runClarionProgram(cl);
    }
    
    public void testSystemParamBug()
    {
        getSource().addLexer("util.clw",
                "   member\n",
                "   map\n",
                "     SystemParametersInfo(LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni), LONG, RAW, PASCAL, DLL(TRUE), NAME('SystemParametersInfoA'),PROC\n",
                "   .\n",
                "");

        getSource().addLexer("util.inc",
                "     SystemParametersInfo(LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni), LONG, RAW, PASCAL, DLL(TRUE), NAME('SystemParametersInfoA'),PROC\n",
                "");

        ClassLoader cl =compile(
                "   program\n",
                "   map\n",
                "     module('util.clw')\n",
                "       include('util.inc')\n",
                "     .\n",
                "   .\n",
                "   code\n",
                "   SystemParametersInfo (38, 0,1, 0)\n",
                "");
        runClarionProgram(cl);
    }
    
    public void testModuleVariableClears()
    {
        getSource().addLexer("module.clw",
        "   member\n",
        "myresult long\n",
        "myfunc  procedure\n",
        "   code\n",
        "   myresult+=1\n",
        "   return myresult\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "myfunc procedure,long\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");
        
        System.out.println(compiler.repository().get("module.Module").toJavaSource(compiler));

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runMainClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(1, result.intValue());

        runMainClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(1, result.intValue());
        
        runMainClarionProgram(cl);
        result = getMainVariable(cl, "result");
        assertEquals(1, result.intValue());
        
    }
    
    
    public void testSimple()
    {
        getSource().addLexer("module.clw",
        "   member\n",
        "myfunc  procedure\n",
        "   code\n",
        "   return 2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "myfunc procedure,long\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(2, result.intValue());
    }

    public void testWithRedundantMap()
    {
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "myfunc procedure,long\n",
        "     .\n",
        "myfunc  procedure\n",
        "   code\n",
        "   return 2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "myfunc procedure,long\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(2, result.intValue());
    }

    public void testIncludeStyleMapping()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "   code\n",
        "   return 2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(2, result.intValue());
    }

    public void testIncludeSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testIncludeDoubleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    
    public void testIncludeSingleProcedureClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    public void testIncludeSingleProcedureDeepClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testIncludeSingleProcedureDeepClassScopeTraversal2()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");
        
        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    
    
    public void testIncludeDoubleProcedureClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    public void testIncludeDoubleProcedureDeepClassScopeTraversal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testIncludeDoubleProcedureDeepClassScopeTraversal2()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
        
    }

    public void testDeepRoutineCall()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r long\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        ".\n",
        "   code\n",
        "   myclass.mymethod\n",
        "   return r\n",
        "myproc routine\n",
        "   r=1\n",
        "myclass.mymethod procedure\n",
        "   code\n",
        "   do myproc\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        
        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(1, result.intValue());
        
    }

    
    public void testIncludeSingleProcedureDeepClassWindowComboA()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        "myfield long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "mydata long\n",
        "mywindow window\n",
        "    string(@s10),use(mydata)\n",
        "    string(@s10),use(r1)\n",
        "    string(@s10),use(myclass.myfield)\n",
        "    string(@s10),use(SELF.myfield)\n",
        ".\n",
        "    code\n",
        "   return r1+r2+SELF.myfield\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }
    
    
    public void testIncludeSingleProcedureDeepClassWindowCombo()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "myclass class\n",
        "mymethod procedure,long\n",
        "myfield long\n",
        ".\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "   return myclass.mymethod\n",
        "myclass.mymethod procedure\n",
        "mydata long\n",
        "   code\n",
        "   do myproc\n",
        "myproc routine\n",
        "    data\n",
        "mywindow window\n",
        "    string(@s10),use(mydata)\n",
        "    string(@s10),use(r1)\n",
        "    string(@s10),use(myclass.myfield)\n",
        "    string(@s10),use(SELF.myfield)\n",
        ".\n",
        "    code\n",
        "   return r1+r2+?mydata+SELF.myfield\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(4, result.intValue());
    }
    
    
    public void testIncludeSingleProcedureModeWithGlobal()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myglobal long(5)\n",
        
        "myfunc  procedure\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   myglobal+=1\n",
        "   return r1+r2+myglobal\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(9, result.intValue());

        runClarionProgram(cl);
        assertEquals(10, result.intValue());
    }

    public void testDodgyName()
    {
        compile("   program\n",
        "        MAP\n",
        "        MODULE('C runtime')\n",
        "    FNSplit   PROCEDURE(*CSTRING Path, *CSTRING Drv, *CSTRING Dir, *CSTRING Nme, *CSTRING Ext),SIGNED,PROC,RAW,NAME('_fnsplit')\n",
        "    FNMerge   PROCEDURE(*CSTRING Path, *CSTRING Drv, *CSTRING Dir, *CSTRING Nme, *CSTRING Ext),RAW,NAME('_fnmerge')\n",
        "        END\n",
        "      END\n",
        "   code\n",
        
        "");        
    }
    
    public void testIncludeSingleProcedureWithPassedVariable()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   return r1+r2+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());

    }

    public void testIncludeSingleProcedureWithPassedVariable2()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        
        "myclass class\n",
        "doit   procedure,long\n",
        ".\n",
        "   code\n",
        "   return myclass.doit\n",
        "myclass.doit   procedure\n",
        "   code\n",
        "   return r1+r2+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());

    }

    public void testLikeSymbolFromMainScope()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "t2 like(ptp:record),static\n",
        "   code\n",
        "   return 2+t1.val+t2.val\n",
        "");

        ClassLoader cl = compile(
          "   program\n",
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "t1 file,driver('DOS'),pre(ptp)\n",
          "   record,pre()\n",
          "val  long(3)\n",
          "   . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        System.out.println(compiler.repository().get("module.Module").toJavaSource(compiler));
        
        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(8, result.intValue());
    }

    public void testLocalEquates()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        "ff:normal equate(1)\n",
        "ff2:normal equate(2)\n",
        "    code\n",
        "    return ff:normal+ff2:normal\n",
        "");

        ClassLoader cl = compile(
          "   program\n",
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testStolenDangler()
    {
        getSource().addLexer("q1.inc",
        "q1 class,module('q1.clw')\n",
        "run procedure\n",
        "Fields &FieldQueue\n",
        ".\n",
        "");

        getSource().addLexer("q2.inc",
        "q2 class,module('q2.clw')\n",
        "run procedure\n",
        ".\n",
        "");
        
        getSource().addLexer("q1.clw",
        "   member\n",
        "FieldQueue group,type\n",
        "f2 long\n",
        ".\n",
        "q1.run   procedure\n",
        "    code\n",
        "    self.fields.f2=1\n",
        "");

        getSource().addLexer("q2.clw",
        "   member\n",
        "q2.run   procedure\n",
        "FieldQueue group\n",
        "f1 long\n",
        ".\n",
        "    code\n",
        "    FieldQueue.f1=1\n",    
        "");

        compile(
          "   program\n",
          "   include('test/q1.inc')\n",
          "   include('test/q2.inc')\n",
          "   code\n", 
          "");
    }

    public void testIncludeSingleProcedureWithConstructedObjectInRoutineScope()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "   code\n",
        "   do calldoit\n",
        "calldoit routine\n",
        "   data\n",
        "mw  window\n",
        "   string(@n10),use(r1)\n",
        "   string(@n10),use(r2)\n",
        ".\n",
        "   code\n",
        "");

        compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");
    }

    public void testIncludeInsideQueue()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "r1   long(1)\n",
        "r2   long(2)\n",
        "mq   queue\n",
        "r1   like(r1)\n",
        "r2   like(r2)\n",
        ".\n",
        "   code\n",
        "   return mq.r1+mq.r2+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());
    }

    public void testClashingNamesInSingleProcMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(long),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        
        "myfunc  procedure(long aLong)\n",
        "orcq queue,pre(orc)\n",
        "x long(2)\n",
        ".\n",
        "    code\n",
        "    do callit\n",
        "callit routine\n",
        "   data\n",
        "orc &onroadcost\n",
        "   code\n",
        "   orc&=new onroadcost\n",
        "   return orc.val+ORC:x+aLong\n",
        "");

        ClassLoader cl = compile(
          "   program\n",
          "onroadcost class,type\n",
          "val long(1)\n",
          ".\n",
          "orcline group,pre(orc)\n",
          "gx long(2)\n",
          ".\n",
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc(4)\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(7, result.intValue());
    }
    
    public void testSelfReferencingClassSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        
        "myclass class\n",
        "p1  procedure,long\n",
        "p2  procedure,long\n",
        ".\n",
        "r1 long(1)\n",
        "r2 long(2)\n",
        "   code\n",
        "   return myclass.p1()\n",
        "myclass.p1 procedure\n",
        "   code\n",
        "   return myclass.p2()\n",
        "myclass.p2 procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    public void testSelfReferencingClassNotSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure,long\n",
                "myfunc2 procedure,long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "   include('test/module.inc')\n",
        "     .\n",
        "myfunc  procedure\n",
        
        "myclass class\n",
        "p1  procedure,long\n",
        "p2  procedure,long\n",
        ".\n",
        "r1 long(1)\n",
        "r2 long(2)\n",
        "   code\n",
        "   return myclass.p1()\n",
        "myclass.p1 procedure\n",
        "   code\n",
        "   return myclass.p2()\n",
        "myclass.p2 procedure\n",
        "   code\n",
        "   return r1+r2\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "   include('test/module.inc')\n",
          "     . .\n",
          "result long\n",
          "   code\n", 
          "   result=myfunc\n",
          "");

        ClarionObject result = getMainVariable(cl, "result");
        assertEquals(0, result.intValue());

        runClarionProgram(cl);
        assertEquals(3, result.intValue());
    }

    
    public void testVariableUsedInTargetInSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(myclass),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "       include('test/module.inc')\n",
        "   .\n",
        "myfunc  procedure(myclass aclass)\n",
        "mywindow window\n",
        "     string(@n10),use(aclass.val)\n",
        "   .\n",
        "    code\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "          include('test/module.inc')\n",
          "     . .\n",
          "myclass class,type\n",
          "val  long\n",
          ".\n",
          "mc  &myclass\n",
          "   code\n",
          "   mc &= new myclass\n",
          "   myfunc(mc)\n",
          "");
        
        runClarionProgram(cl);
    }

    public void testVariableUsedInTarget2InSingleProcedureMode()
    {
        getSource().addLexer("module.inc",
                "myfunc procedure(myclass),long\n",
        "");
                
        getSource().addLexer("module.clw",
        "   member\n",
        "   map\n",
        "       include('test/module.inc')\n",
        "   .\n",
        "myfunc  procedure(myclass aclass)\n",
        "mywindow window\n",
        "     string(@n10),at(aclass.val,),use(?string)\n",
        "   .\n",
        "    code\n",
        "    open(mywindow)\n",
        "    assert(?string{7c02h}=10)\n", // = Prop.XPOS   
        "    close(mywindow)\n",
        "");

        ClassLoader cl = compile(
          "   program\n", 
          "   map\n",
          "     module('module.clw')\n",
          "          include('test/module.inc')\n",
          "     . .\n",
          "myclass class,type\n",
          "val  long\n",
          ".\n",
          "mc  &myclass\n",
          "   code\n",
          "   mc &= new myclass\n",
          "   mc.val=10\n",
          "   myfunc(mc)\n",
          "");
        
        runClarionProgram(cl);
    }
    
}
