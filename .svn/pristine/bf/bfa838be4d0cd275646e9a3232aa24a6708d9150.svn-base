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
package org.jclarion.clarion.compile.java;

import java.io.CharArrayReader;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

public class JavaClassTest extends TestCase {

    private ClarionCompiler compiler;

	public void setUp()
    {
        compiler=new ClarionCompiler();
    }
    
    public void testEmptyMain()
    {
        assertEquals(
            get(
            		"package clarion;\n"+
            		"\n"+
            		"@SuppressWarnings(\"all\")\n"+
            		"public class Main\n"+
            		"{\n"+
            		"\n"+
            		"	private static java.util.List<Runnable> __static_init_list = new java.util.ArrayList<Runnable>();\n"+
            		"	public static void __register_init(Runnable r) {\n"+
            		"		__static_init_list.add(r);\n"+
            		"	}\n"+
            		"\n"+
            		"	private static java.util.List<Runnable> __static_destruct_list = new java.util.ArrayList<Runnable>();\n"+
            		"	public static void __register_destruct(Runnable r) {\n"+
            		"		__static_destruct_list.add(r);\n"+
            		"	}\n"+
            		"\n"+
            		"	private static boolean __is_init=false;\n"+
            		"	static {\n"+
            		"		__static_init();\n"+
            		"	}\n"+
            		"\n"+
            		"	public static void __static_init() {\n"+
            		"		__is_init=true;\n"+
            		"		java.util.List<Runnable> __init_list = new java.util.ArrayList<Runnable>(__static_init_list);\n"+
            		"		for (Runnable __scan : __init_list) { __scan.run(); };\n"+
            		"	}\n"+
            		"\n"+
            		"	public static void __static_destruct() {\n"+
            		"		__is_init=false;\n"+
            		"		java.util.List<Runnable> __destruct_list = new java.util.ArrayList<Runnable>(__static_destruct_list);\n"+
            		"		for (Runnable __scan : __destruct_list) { __scan.run(); };\n"+
            		"	}\n"+
            		"\n"+
            		"}\n"+
            		""),
            compiler.repository().getAll().iterator().next().toJavaSource(compiler));
    }

    public void testCompileEmpty()
    {
        compile(get(
                "    program\n",
                "    code\n"));

        assertEquals(
                get(
                		"package clarion;\n"+
                		"\n"+
                		"import org.jclarion.clarion.crash.Crash;\n"+
                		"import org.jclarion.clarion.runtime.CRun;\n"+		
                		"\n"+
                		"@SuppressWarnings(\"all\")\n"+
                		"public class Main\n"+
                		"{\n"+
                		"\n"+
                		"	private static java.util.List<Runnable> __static_init_list = new java.util.ArrayList<Runnable>();\n"+
                		"	public static void __register_init(Runnable r) {\n"+
                		"		__static_init_list.add(r);\n"+
                		"	}\n"+
                		"\n"+
                		"	private static java.util.List<Runnable> __static_destruct_list = new java.util.ArrayList<Runnable>();\n"+
                		"	public static void __register_destruct(Runnable r) {\n"+
                		"		__static_destruct_list.add(r);\n"+
                		"	}\n"+
                		"\n"+
                		"	private static boolean __is_init=false;\n"+
                		"	static {\n"+
                		"		__static_init();\n"+
                		"	}\n"+
                		"\n"+
                		"	public static void __static_init() {\n"+
                		"		__is_init=true;\n"+
                		"		java.util.List<Runnable> __init_list = new java.util.ArrayList<Runnable>(__static_init_list);\n"+
                		"		for (Runnable __scan : __init_list) { __scan.run(); };\n"+
                		"	}\n"+
                		"\n"+
                		"	public static void __static_destruct() {\n"+
                		"		__is_init=false;\n"+
                		"		java.util.List<Runnable> __destruct_list = new java.util.ArrayList<Runnable>(__static_destruct_list);\n"+
                		"		for (Runnable __scan : __destruct_list) { __scan.run(); };\n"+
                		"	}\n"+
                		"\n\n"+
                        "\tpublic static void main(String[] args)\n",
                        "\t{\n",
                        "\t\ttry { if (!__is_init) { __static_init(); } begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { __static_destruct(); }\n"+
                        "\t}\n",
                        "\tpublic static void begin(String[] args)\n",
                        "\t{\n",
                        "\t\tCRun.init(args);\n",
                        "\t}\n",                		
                		"}\n"+
                		""),                
                compiler.repository().getAll().iterator().next().toJavaSource(compiler));
    }

    public void testCompileWithVariable()
    {
        compile(get(
                "    program\n",
                "test  byte\n",
                "    code\n"));

        String result=compiler.repository().getAll().iterator().next().toJavaSource(compiler);
        assertEquals(result,
                get(
                		"package clarion;\n"+
                		"\n"+
                		"import org.jclarion.clarion.Clarion;\n"+
                		"import org.jclarion.clarion.ClarionNumber;\n"+
                		"import org.jclarion.clarion.crash.Crash;\n"+
                		"import org.jclarion.clarion.runtime.CRun;\n"+
                		"\n"+
                		"@SuppressWarnings(\"all\")\n"+
                		"public class Main\n"+
                		"{\n"+
                		"	public static ClarionNumber test;\n"+
                		"\n"+
                		"	private static java.util.List<Runnable> __static_init_list = new java.util.ArrayList<Runnable>();\n"+
                		"	public static void __register_init(Runnable r) {\n"+
                		"		__static_init_list.add(r);\n"+
                		"	}\n"+
                		"\n"+
                		"	private static java.util.List<Runnable> __static_destruct_list = new java.util.ArrayList<Runnable>();\n"+
                		"	public static void __register_destruct(Runnable r) {\n"+
                		"		__static_destruct_list.add(r);\n"+
                		"	}\n"+
                		"\n"+
                		"	private static boolean __is_init=false;\n"+
                		"	static {\n"+
                		"		__static_init();\n"+
                		"	}\n"+
                		"\n"+
                		"	public static void __static_init() {\n"+
                		"		__is_init=true;\n"+
                		"		java.util.List<Runnable> __init_list = new java.util.ArrayList<Runnable>(__static_init_list);\n"+
                		"		test=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);\n"+
                		"		for (Runnable __scan : __init_list) { __scan.run(); };\n"+
                		"	}\n"+
                		"\n"+
                		"	public static void __static_destruct() {\n"+
                		"		__is_init=false;\n"+
                		"		java.util.List<Runnable> __destruct_list = new java.util.ArrayList<Runnable>(__static_destruct_list);\n"+
                		"		for (Runnable __scan : __destruct_list) { __scan.run(); };\n"+
                		"	}\n"+
                		"\n"+
                		"\n"+
                		"	public static void main(String[] args)\n"+
                		"	{\n"+
                		"		try { if (!__is_init) { __static_init(); } begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { __static_destruct(); }\n"+
                		"	}\n"+
                		"	public static void begin(String[] args)\n"+
                		"	{\n"+
                		"		CRun.init(args);\n"+
                		"	}\n"+
                		"}\n"+
                		""
                ),result);
    }
    
    
    public void compile(String source)
    {
        Lexer l  = new Lexer(new CharArrayReader(source.toCharArray()));
        Parser p = new Parser(compiler,l);
        p.compileProgram();
    }
    
    public String get(String... merge)
    {
        StringBuilder r=new StringBuilder();
        for (int scan=0;scan<merge.length;scan++) {
            r.append(merge[scan]);
        }
        return r.toString();
    }
}
