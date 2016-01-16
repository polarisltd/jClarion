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

import java.io.CharArrayReader;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import junit.framework.TestCase;

import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.compile.grammar.LexerSource;
import org.jclarion.clarion.compile.grammar.MemoryLexerSource;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.lang.Lexer;

public class CompileTestHelper extends TestCase 
{
    
    public void setUp()
    {
        ClarionCompiler.clean();
        LexerSource.setInstance(new MemoryLexerSource());
        System.setProperty("__clarion.unittest","true");
    }
    
    public MemoryLexerSource getSource()
    {
        return (MemoryLexerSource)LexerSource.getInstance();
    }
    
    public ClassLoader compile(String... source)
    {
        return compile(get(source));
    }
    
    public ClassLoader compile(String source)
    {
        System.setProperty("clarion.compile.forceHardAssert","1");
        try {
            Lexer l  = new Lexer(new CharArrayReader(source.toCharArray()));
            Parser p = new Parser(l);
            p.compileProgram();
            return ClarionCompiler.compile();
        } finally {
            System.clearProperty("clarion.compile.forceHardAssert");
        }
    }
    
    public String get(String... merge)
    {
        StringBuilder r=new StringBuilder();
        for (int scan=0;scan<merge.length;scan++) {
            r.append(merge[scan]);
        }
        return r.toString();
    }

    public ClarionObject getMainVariable(ClassLoader cl,String name)
    {
        return getOtherVariable(cl,ClarionCompiler.BASE+".Main",name);
    }

    public Object getMainObject(ClassLoader cl,String name)
    {
        try {
            Class<?> c = cl.loadClass(ClarionCompiler.BASE+".Main");
            assertNotNull(c);
            
            Field f = c.getField(name);
            return f.get(null);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchFieldException e) {
            return null;
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        }
        return null;
    }
    
    
    public ClarionObject getOtherVariable(ClassLoader cl,String clazz,String name)
    {
        try {
            Class<?> c = cl.loadClass(clazz);
            assertNotNull(c);
            
            Field f = c.getField(name);
            return (ClarionObject)f.get(null);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchFieldException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        }
        return null;
    }

    public int getOtherRawInt(ClassLoader cl,String clazz,String name)
    {
        try {
            Class<?> c = cl.loadClass(clazz);
            assertNotNull(c);
            
            Field f = c.getField(name);
            return f.getInt(null);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchFieldException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        }
        return 0;
    }
    
    @SuppressWarnings("unchecked")
	public ClarionArray<ClarionNumber> getMainArrayVariableN(ClassLoader cl,String name)
    {
    	return (ClarionArray<ClarionNumber>)getMainArrayVariable(cl,name);
    }

    @SuppressWarnings("unchecked")
	public ClarionArray<ClarionString> getMainArrayVariableS(ClassLoader cl,String name)
    {
    	return (ClarionArray<ClarionString>)getMainArrayVariable(cl,name);
    }
    
    public ClarionArray<?> getMainArrayVariable(ClassLoader cl,String name)
    {
        try {
            Class<?> c = cl.loadClass("clarion.Main");
            assertNotNull(c);
            
            Field f = c.getField(name);
            return (ClarionArray<?>)f.get(null);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchFieldException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        }
        return null;
    }
    
    
    public void runClarionProgram(ClassLoader cl,String... params)
    {
        try {
            Class<?> c = cl.loadClass("clarion.Main");
            assertNotNull(c);
            Method m = c.getMethod("begin",params.getClass());
            Object arg = params;
            m.invoke(null,arg);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchMethodException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        } catch (InvocationTargetException e) {
            e.printStackTrace();
            Throwable b = e.getTargetException();
            if (b instanceof RuntimeException) {
                throw (RuntimeException)b;
            }
            e.printStackTrace();
            fail(e.getMessage());
        }
    }

    public void runMainClarionProgram(ClassLoader cl,String... params)
    {
        try {
            Class<?> c = cl.loadClass("clarion.Main");
            assertNotNull(c);
            Method m = c.getMethod("main",params.getClass());
            Object arg = params;
            m.invoke(null,arg);
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (SecurityException e) {
            fail(e.getMessage());
        } catch (NoSuchMethodException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        } catch (InvocationTargetException e) {
            Throwable b = e.getTargetException();
            if (b instanceof RuntimeException) {
                throw (RuntimeException)b;
            }
            fail(e.getMessage());
        }
    }
    
    public Object instantiate(ClassLoader cl,String name)
    {
        try {
            Class<?> c = cl.loadClass(name);
            assertNotNull(c);
            return c.newInstance();
        } catch (ClassNotFoundException e) {
            fail(e.getMessage());
        } catch (InstantiationException e) {
            fail(e.getMessage());
        } catch (IllegalAccessException e) {
            fail(e.getMessage());
        }
        return null;
    }

}
