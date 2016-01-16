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
package org.jclarion.clarion.compile.grammar;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.tools.JavaCompiler;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.EquateExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.javac.ClarionClassLoader;
import org.jclarion.clarion.compile.javac.ClarionFileManager;
import org.jclarion.clarion.lang.LexType;

public class EquateParser extends AbstractParser {

    private Map<String,Boolean> complexEquates=new HashMap<String, Boolean>(); 
    
    public EquateParser(ClarionCompiler compiler,Parser parser) {
        super(compiler,parser);
    }

    public boolean equateDefinition()
    {
        return equateDefinition(LexType.rparam);
    }

    public boolean equateDefinition(LexType end)
    {
        if (la().value.equals("java")) {
            next();
            return true;
        }
        
        Expr e = null;
        try {
            EquateExpr.setEquateMode();
            e = parser().expression();
            if (e!=null) {
                String s = e.toJavaString();
                if (s.equals("1")) return true;
                if (s.equals("0")) return false;
                if (s.equals("")) return false;
                
                return lookupComplexEquate(ExprType.rawboolean.cast(e).toJavaString());
            }
        } finally {
            EquateExpr.clearEquateMode();
        }
        
        // else
        StringBuilder sb = new StringBuilder();
        while ( true ) {
            if (la().type==end) break;
            if (la().type==LexType.eof) break;
            sb.append(next().value);
        }
        String s = sb.toString();
        if (s.equals("1")) return true;
        if (s.equals("0")) return false;
        if (s.equals("")) return false;
        return lookupComplexEquate(s);
    }
    
    public boolean lookupComplexEquate(String equate)
    {
        Boolean result = complexEquates.get(equate.toLowerCase());
        if (result!=null) return result;
        
        StringBuilder code = new StringBuilder();
        code.append("package eval;\n");
        code.append("public class Test\n");
        code.append("{\n");
        code.append("\tpublic static boolean test() { return ");
        code.append(equate);
        code.append("; }\n");
        code.append("}\n");

        JavaCompiler jc = ToolProvider.getSystemJavaCompiler();
        StandardJavaFileManager sfm = jc.getStandardFileManager(null,null,null);
        ClarionFileManager cfm = new ClarionFileManager(new ClarionCompiler(),sfm,"eval","Test",code.toString());

        if (!jc.getTask(null,cfm,null,null,null,cfm.getAllSourceFiles()).call()) {
            System.out.println(code.toString());
            error("Failed to compile complex equatedef");
        }

        ClassLoader cl = new ClarionClassLoader(ClassLoader.getSystemClassLoader(),cfm);;
        
        try {
            Class<?> c = cl.loadClass("eval.Test");
            Method m = c.getMethod("test");
            Boolean b = (Boolean)m.invoke(null);
            
            complexEquates.put(equate.toLowerCase(),b);
            return b;
            
        } catch (ClassNotFoundException e) {
        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        error("Failed to evaluate complex equatedef");
        return false;
    }

    /*
    public void addComplexEquate(String equate,boolean result)
    {
        complexEquates.put(equate.toLowerCase(),result);
    }
    */
}
