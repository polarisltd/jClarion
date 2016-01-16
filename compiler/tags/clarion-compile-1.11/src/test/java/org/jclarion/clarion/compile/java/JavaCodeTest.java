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

import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;

import junit.framework.TestCase;

public class JavaCodeTest extends TestCase {
    

    public void testSimple()
    {
        SimpleJavaCode c = new SimpleJavaCode("hello;");
        assertEquals("hello;\n",c.write(0,false));
        assertEquals("\thello;\n",c.write(1,false));
        assertEquals("\t// UNREACHABLE! :hello;\n",c.write(1,true));
    }

    public void testExpr()
    {
        JavaCode c = new ExprJavaCode(
            new SimpleExpr(JavaPrec.LABEL,null,"hello;"));
        assertEquals("hello;\n",c.write(0,false));
    }

    public void testBlock()
    {
        JavaCode c = new BlockJavaCode( 
            new SimpleExpr(JavaPrec.LABEL,null,"if (true)"),
            new SimpleJavaCode("hello;"));
        
        assertCode(c,
                "if (true) {\n",
                "\thello;\n",
                "}\n");
    }

    public void testLinear()
    {
        LinearJavaBlock c = new LinearJavaBlock();
        c.add(new SimpleJavaCode("hello;"));
        c.add(new SimpleJavaCode("world;"));
        
        assertCode(c,
            "hello;\n",
            "world;\n"
        );
    }

    public void testLinearUnreachable1()
    {
        LinearJavaBlock c = new LinearJavaBlock();
        c.add((new SimpleJavaCode("hello;")).setCertain(JavaControl.RETURN,JavaControl.END));
        c.add(new SimpleJavaCode("world;"));
        
        assertCode(c,
            "hello;\n",
            "// UNREACHABLE! :world;\n"
        );
    }

    public void testLinearUnreachable2()
    {
        LinearJavaBlock c = new LinearJavaBlock();
        c.add((new SimpleJavaCode("hello;")).setCertain(JavaControl.BREAK,JavaControl.END));
        c.add(new SimpleJavaCode("world;"));
        
        assertCode(c,
            "hello;\n",
            "// UNREACHABLE! :world;\n"
        );
    }

    public void testLinearUnreachable3()
    {
        LinearJavaBlock c = new LinearJavaBlock();
        c.add((new SimpleJavaCode("hello;")).setCertain(JavaControl.CONTINUE,JavaControl.END));
        c.add(new SimpleJavaCode("world;"));
        
        assertCode(c,
            "hello;\n",
            "// UNREACHABLE! :world;\n"
        );
    }
    
    public void testForkUnreachableReturns()
    {
        ForkingJavaBlock f = new ForkingJavaBlock();

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"if (true)"),
                (new SimpleJavaCode("return;")).setCertain(JavaControl.RETURN,JavaControl.END)));

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"else"),
                (new SimpleJavaCode("return;")).setCertain(JavaControl.RETURN,JavaControl.END)));
        
        LinearJavaBlock c = new LinearJavaBlock();
        c.add(f);
        c.add(new SimpleJavaCode("call();")); 
        
            assertCode(c,
                    "if (true) {\n",
                    "\treturn;\n",
                    "}\n",
                    "else {\n",
                    "\treturn;\n",
                    "}\n",
                    "// UNREACHABLE! :call();\n");
    }

    public void testForkUnreachableLoopControl()
    {
        ForkingJavaBlock f = new ForkingJavaBlock();

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"if (true)"),
                (new SimpleJavaCode("break;")).setCertain(JavaControl.BREAK,JavaControl.END)));

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"else"),
                (new SimpleJavaCode("continue;")).setCertain(JavaControl.CONTINUE,JavaControl.END)));
        
        LinearJavaBlock c = new LinearJavaBlock();
        c.add(f);
        c.add(new SimpleJavaCode("call();")); 

            assertCode(c,
                    "if (true) {\n",
                    "\tbreak;\n",
                    "}\n",
                    "else {\n",
                    "\tcontinue;\n",
                    "}\n",
                    "// UNREACHABLE! :call();\n");
    }

    public void testInfiniteLoop1()
    {
        ForkingJavaBlock f = new ForkingJavaBlock();

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"if (true)"),
                (new SimpleJavaCode("break;")).setCertain(JavaControl.BREAK,JavaControl.END)));

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"else"),
                (new SimpleJavaCode("continue;")).setCertain(JavaControl.CONTINUE,JavaControl.END)));
        
        LinearJavaBlock c = new LinearJavaBlock();
        c.add(new LoopJavaCode(new BlockJavaCode("while (true)",f),true));
        c.add(new SimpleJavaCode("call();")); 

            assertCode(c,
                    "while (true) {\n",
                    "\tif (true) {\n",
                    "\t\tbreak;\n",
                    "\t}\n",
                    "\telse {\n",
                    "\t\tcontinue;\n",
                    "\t}\n",
                    "}\n",
                    "call();\n");
    }

    public void testInfiniteLoop2()
    {
        ForkingJavaBlock f = new ForkingJavaBlock();

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"if (true)"),
                (new SimpleJavaCode("return;")).setCertain(JavaControl.RETURN,JavaControl.END)));

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"else"),
                (new SimpleJavaCode("continue;")).setCertain(JavaControl.CONTINUE,JavaControl.END)));
        
        LinearJavaBlock c = new LinearJavaBlock();
        c.add(new LoopJavaCode(new BlockJavaCode("while (true)",f),true));
        c.add(new SimpleJavaCode("call();")); 

            assertCode(c,
                    "while (true) {\n",
                    "\tif (true) {\n",
                    "\t\treturn;\n",
                    "\t}\n",
                    "\telse {\n",
                    "\t\tcontinue;\n",
                    "\t}\n",
                    "}\n",
                    "// UNREACHABLE! :call();\n");
    }

    public void testFiniteLoop3()
    {
        ForkingJavaBlock f = new ForkingJavaBlock();

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"if (true)"),
                (new SimpleJavaCode("return;")).setCertain(JavaControl.RETURN,JavaControl.END)));

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"else"),
                (new SimpleJavaCode("continue;")).setCertain(JavaControl.CONTINUE,JavaControl.END)));
        
        LinearJavaBlock c = new LinearJavaBlock();
        c.add(new LoopJavaCode(new BlockJavaCode("while (ok())",f),false));
        c.add(new SimpleJavaCode("call();")); 

            assertCode(c,
                    "while (ok()) {\n",
                    "\tif (true) {\n",
                    "\t\treturn;\n",
                    "\t}\n",
                    "\telse {\n",
                    "\t\tcontinue;\n",
                    "\t}\n",
                    "}\n",
                    "call();\n");
    }

    public void testFiniteLoop4()
    {
        ForkingJavaBlock f = new ForkingJavaBlock();

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"if (true)"),
                (new SimpleJavaCode("return;")).setCertain(JavaControl.RETURN,JavaControl.END)));

        f.add( new BlockJavaCode( 
                new SimpleExpr(JavaPrec.LABEL,null,"else"),
                (new SimpleJavaCode("continue;")).setCertain(JavaControl.CONTINUE,JavaControl.END)));

        LinearJavaBlock i = new LinearJavaBlock();
        i.add(f);
        i.add(new SimpleJavaCode("that();"));
        
        LinearJavaBlock c = new LinearJavaBlock();
        c.add(new LoopJavaCode(new BlockJavaCode("while (ok())",i),false));
        c.add(new SimpleJavaCode("call();")); 

            assertCode(c,
                    "while (ok()) {\n",
                    "\tif (true) {\n",
                    "\t\treturn;\n",
                    "\t}\n",
                    "\telse {\n",
                    "\t\tcontinue;\n",
                    "\t}\n",
                    "\t// UNREACHABLE! :that();\n",
                    "}\n",
                    "call();\n");
    }
    
    

    
    public void logStates(JavaCode c)
    {
        logState(c,"break",JavaControl.BREAK);
        logState(c,"continue",JavaControl.CONTINUE);
        logState(c,"return",JavaControl.RETURN);
        logState(c,"end",JavaControl.END);
    }
    
    public void logState(JavaCode c, String string, JavaControl end) {
        if (c.isCertain(end)) {
            System.out.println(string+":certain");
            return;
        }
        if (c.isPossible(end)) {
            System.out.println(string+":possible");
            return;
        }
        System.out.println(string+":no");
    }

    public void assertCode(JavaCode c,String... bits)
    {
        assertEquals(get(bits),c.write(0,false));
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
