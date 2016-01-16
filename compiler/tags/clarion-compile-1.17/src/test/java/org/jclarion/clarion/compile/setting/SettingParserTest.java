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
package org.jclarion.clarion.compile.setting;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.grammar.Parser;

import junit.framework.TestCase;

public class SettingParserTest extends TestCase 
{
    public void testSimple()
    {
        Parser p = new Parser(",hello,world,this,that");
        
        SimpleSettingParser ssp = new SimpleSettingParser("this","hello","world");
        SettingResult<?> r[] = ssp.getArray(p);
        assertEquals(3,r.length);
        assertEquals("hello",r[0].getName());
        assertEquals("world",r[1].getName());
        assertEquals("this",r[2].getName());
        
        assertEquals(",",p.getLexer().lookahead(0).value);
        assertEquals("that",p.getLexer().lookahead(1).value);
    }
    
    public void testExprOK()
    {
        Parser p =new Parser(",dim((3*2)^4)");
        
        ExprSettingParser esp = new ExprSettingParser("dim");
        SettingResult<Expr> r[] = esp.getArray(p);
        assertEquals(1,r.length);
        assertEquals("dim",r[0].getName());
        assertEquals("Clarion.newNumber(3*2).power(4)",r[0].getValue().toJavaString());
        
    }
    
    public void testExprNotFound()
    {
        Parser p =new Parser(",name((3*2)^4)");
        
        ExprSettingParser esp = new ExprSettingParser("dim");
        SettingResult<Expr> r[] = esp.getArray(p);
        assertEquals(0,r.length);

        assertEquals(",",p.getLexer().lookahead(0).value);
        assertEquals("name",p.getLexer().lookahead(1).value);
        
    }

    public void testJoined()
    {
        Parser p =new Parser(",auto,static,name('hello'),thread");

        JoinedSettingParser setting = new JoinedSettingParser(
                new SimpleSettingParser("auto","static","thread"),
                new ExprSettingParser("name")
                );
        
        SettingResult<Object> r[] = setting.getArray(p);
        assertEquals(4,r.length);
        
        assertEquals("auto",r[0].getName());
        assertSame(true,r[0].getValue());
        
        assertEquals("static",r[1].getName());
        assertSame(true,r[1].getValue());
        
        assertEquals("name",r[2].getName());
        assertEquals("\"hello\"",((Expr)r[2].getValue()).toJavaString());
        
        assertEquals("thread",r[3].getName());
        assertSame(true,r[3].getValue());
    }
}
