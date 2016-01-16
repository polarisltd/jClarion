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

import java.io.CharArrayReader;
import java.util.List;

import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

public class PrototypeParserTest  extends TestCase {
    public void setUp()
    {
        org.jclarion.clarion.compile.ClarionCompiler.clean();
        LexerSource.setInstance(new MemoryLexerSource());
    }
    
    public void testPrototypeParam()
    {
        assertParam("byte",false,null,"ClarionNumber",null,false,false,false);

        assertParam("*byte",false,null,"ClarionNumber",null,true,false,false);

        assertParam("<byte>",false,null,"ClarionNumber",null,false,true,false);
        assertParam("byte=12*6",false,null,"ClarionNumber","Clarion.newNumber(12*6)",false,true,false);

        assertParam("const byte",false,null,"ClarionNumber",null,false,false,true);

        assertParam("long name",false,"name","ClarionNumber",null,false,false,false);
        
        assertParam("<byte name>",false,"name","ClarionNumber",null,false,true,false);

        assertParam("const *long name=23",false,"name","ClarionNumber","Clarion.newNumber(23)",true,true,true);
    }

    public void testImplParam()
    {
        assertParam("name",true,"name",null,null,false,false,false);

        assertParam("long name",true,"name","ClarionNumber",null,false,false,false);
    }

    public void testPrototype()
    {
        Procedure p; 
        p = assertPrototype("test   procedure","test",null);

        p = assertPrototype("test   function","test",null);

        p = assertPrototype("test   procedure,private","test",null,"private");
        
        p = assertPrototype("test   procedure,byte","test","ClarionNumber");

        p = assertPrototype("test   procedure,private,byte,proc","test","ClarionNumber","private","proc");

        p = assertPrototype("test   procedure(),private,byte,proc","test","ClarionNumber","private","proc");
        assertEquals(0,p.getParams().length);

        p = assertPrototype("test   procedure(Byte aByte),private,byte,proc","test","ClarionNumber","private","proc");
        assertEquals(1,p.getParams().length);
        assertParam(p.getParams()[0],"aByte","ClarionNumber",null,false,false,false);
    }
    
    public void testModulePrototype()
    {
        Procedure p;
        
        p = assertModulePrototype("       test(Byte aByte),private,byte,proc","test","ClarionNumber","private","proc");
        assertEquals(1,p.getParams().length);
        assertParam(p.getParams()[0],"aByte","ClarionNumber",null,false,false,false);
    }

    public void testMap1()
    {
        Lexer l = createLexer("   map.\njunk");
        Parser p = new Parser(l);
        assertTrue(p.prototype.getMap());
        assertEquals("junk",l.next().value);
    }

    public void testMap2()
    {
        Lexer l = createLexer("   map\n.\njunk");
        Parser p = new Parser(l);
        assertTrue(p.prototype.getMap());
        assertEquals("junk",l.next().value);
    }

    public void testMap3()
    {
        Lexer l = createLexer("   map\n\n.\njunk");
        Parser p = new Parser(l);
        assertTrue(p.prototype.getMap());
        assertEquals("junk",l.next().value);
    }

    public void testMapProc()
    {
        Lexer l = createLexer(
                "   map\n",
                "test   procedure(BYTE),STRING\n",
                "  .\n",
                "junk");
                
        Parser p = new Parser(l);
        assertTrue(p.prototype.getMap());
        assertEquals("junk",l.next().value);
        
        List<Procedure> procs= ScopeStack.getScope().getProcedures();
        
        assertEquals(1,procs.size());
        assertProcedure(procs.get(0),"test","ClarionString");
        assertParam(procs.get(0).getParams()[0],null,"ClarionNumber",null,false,false,false);
    }

    public void testDuplicateProcOnlyFirstUsed()
    {
        Lexer l = createLexer(
                "   map\n",
                "test   procedure(BYTE),STRING\n",
                "Test   procedure(BYTE aByte),STRING\n",
                "  .\n",
                "junk");
                
        Parser p = new Parser(l);
        assertTrue(p.prototype.getMap());
        assertEquals("junk",l.next().value);
        
        List<Procedure> procs= ScopeStack.getScope().getProcedures();
        
        assertEquals(1,procs.size());
        assertProcedure(procs.get(0),"test","ClarionString");
        assertParam(procs.get(0).getParams()[0],null,"ClarionNumber",null,false,false,false);
    }

    public void testSimilarProc()
    {
        Lexer l = createLexer(
                "   map\n",
                "test   procedure(BYTE),STRING\n",
                "Test   procedure(STRING aByte),STRING\n",
                "  .\n",
                "junk");
                
        Parser p = new Parser(l);
        assertTrue(p.prototype.getMap());
        assertEquals("junk",l.next().value);
        
        List<Procedure> procs= ScopeStack.getScope().getProcedures();
        
        assertEquals(2,procs.size());
        assertProcedure(procs.get(0),"test","ClarionString");
        assertParam(procs.get(0).getParams()[0],null,"ClarionNumber",null,false,false,false);

        assertProcedure(procs.get(1),"Test","ClarionString");
        assertParam(procs.get(1).getParams()[0],"aByte","ClarionString",null,false,false,false);
    }
    
    
    public void testMapProcWithModules()
    {
        Lexer l = createLexer(
                "   map\n",
                "test   procedure(BYTE),STRING\n",
                "   module('hello.clw')\n",
                "isPrimaryKey   procedure(STRING fieldName),BOOL\n",
                "   .\n",
                "  .\n",
                "junk");
                
        Parser p = new Parser(l);
        assertTrue(p.prototype.getMap());
        assertEquals("junk",l.next().value);
        
        List<Procedure> procs= ScopeStack.getScope().getProcedures();
        
        assertEquals(2,procs.size());
        assertProcedure(procs.get(0),"test","ClarionString");
        assertParam(procs.get(0).getParams()[0],null,"ClarionNumber",null,false,false,false);
        
        assertEquals(1,ModuleScope.getModules().size());
        
        procs = ModuleScope.getModules().iterator().next().getProcedures();
        assertEquals(1,procs.size());
        assertProcedure(procs.get(0),"isPrimaryKey","ClarionBool");
        assertParam(procs.get(0).getParams()[0],"fieldName","ClarionString",null,false,false,false);
    }
    
    
    
    private Lexer createLexer(String... s)
    {
        StringBuilder sb = new StringBuilder();
        for (int scan=0;scan<s.length;scan++) {
            sb.append(s[scan]);
        }
        return new Lexer(new CharArrayReader(sb.toString().toCharArray()));
    }
    
    public Procedure assertPrototype(String in,String name,String ret,String... modifiers) {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
    
        Procedure proc = p.prototype.getPrototype();
        
        assertProcedure(proc,name,ret,modifiers);
        return proc;
    }

    public Procedure assertModulePrototype(String in,String name,String ret,String... modifiers) {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        Procedure proc = p.prototype.getModulePrototype();
        
        assertProcedure(proc,name,ret,modifiers);
        return proc;
    }
        
    public void assertProcedure(Procedure proc,String name,String ret,String... modifiers) 
    {
        assertEquals(name,proc.getName());
        if (ret==null) {
            assertNull(proc.getResult());
        } else {
            assertEquals(ret,proc.getResult().getType().generateDefinition());
        } 
        
        for (int scan=0;scan<modifiers.length;scan++) {
            assertTrue(proc.isModifierSet(modifiers[scan]));
        }
        assertEquals(proc.getModifierCount(),modifiers.length);
    }
    
    
    public Param assertParam(String in,boolean impl
            ,String name
            ,String type
            ,String def
            ,boolean reference,boolean optional,boolean constant
            )
    {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        l.setIgnoreWhitespace(true);
        
        Param result = p.prototype.getParam(impl);
        
        assertParam(result,name,type,def,reference,optional,constant);
        return result;
    }
    
    public void assertParam(Param result,String name,String type,String def,
            boolean reference,boolean optional,boolean constant)
    {
        assertEquals(name,result.getName());
        
        if (type==null) {
            assertNull(result.getType());
        } else {
            assertEquals(type,result.getType().generateDefinition());
        }
        
        if (def==null) {
            assertNull(result.getDefaultValue());
        } else {
            assertEquals(def,result.getDefaultValue().toJavaString());
        }

        assertEquals(reference,result.isPassByReference());
        assertEquals(optional,result.isOptional());
        assertEquals(constant,result.isConstant());
    }


}
