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

    public void setUp()
    {
        ClarionCompiler.clean();
    }
    
    public void testEmptyMain()
    {
        assertEquals(
            get(
                "package clarion;\n",
                "\n",
                "public class Main\n",
                "{\n",
                "}\n"
            ),
            ClassRepository.getAll().iterator().next().toJavaSource());
    }

    public void testCompileEmpty()
    {
        compile(get(
                "    program\n",
                "    code\n"));

        assertEquals(
                get(
                    "package clarion;\n",
                    "\n",
                    "import org.jclarion.clarion.crash.Crash;\n",
                    "import org.jclarion.clarion.runtime.CRun;\n",
                    "\n",
                    "public class Main\n",
                    "{\n",
                    "\n",
                    "\tpublic static void init()\n",
                    "\t{\n",
                    "\t}\n",
                    "\tstatic { init(); }\n",
                    "\n",
                    "\tpublic static void main(String[] args)\n",
                    "\t{\n",
                    "\t\ttry { init(); begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); }\n",
                    "\t}\n",
                    "\tpublic static void begin(String[] args)\n",
                    "\t{\n",
                    "\t\tCRun.init(args);\n",
                    "\t}\n",
                    "}\n"
                ),
                ClassRepository.getAll().iterator().next().toJavaSource());
    }

    public void testCompileWithVariable()
    {
        compile(get(
                "    program\n",
                "test  byte\n",
                "    code\n"));

        String result=ClassRepository.getAll().iterator().next().toJavaSource();
        assertEquals(result,
                get(
                    "package clarion;\n",
                    "\n",
                    "import org.jclarion.clarion.Clarion;\n",
                    "import org.jclarion.clarion.ClarionNumber;\n",
                    "import org.jclarion.clarion.crash.Crash;\n",
                    "import org.jclarion.clarion.runtime.CRun;\n",
                    "\n",
                    "public class Main\n",
                    "{\n",
                    "\tpublic static ClarionNumber test;\n",
                    "\n",
                    "\tpublic static void init()\n",
                    "\t{\n",
                    "\t\ttest=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);\n",
                    "\t}\n",
                    "\tstatic { init(); }\n",
                    "\n",
                    "\tpublic static void main(String[] args)\n",
                    "\t{\n",
                    "\t\ttry { init(); begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); }\n",
                    "\t}\n",
                    "\tpublic static void begin(String[] args)\n",
                    "\t{\n",
                    "\t\tCRun.init(args);\n",
                    "\t}\n",
                    "}\n"
                ),
                result);
    }
    
    
    public void compile(String source)
    {
        Lexer l  = new Lexer(new CharArrayReader(source.toCharArray()));
        Parser p = new Parser(l);
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
