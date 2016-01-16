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
package org.jclarion.clarion.compile.rewrite;

import java.io.CharArrayReader;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

public class PatternRewriterTest extends TestCase {

    public void testRewriteOptions()
    {
        RewriteFactory rf = new RewriteFactory(
              PatternRewriter.create(null,"set","$.setStart()",ExprType.key).call()
             ,PatternRewriter.create(null,"set","$.set($)",ExprType.key,ExprType.key).call().exact(2)
            );
                
        Expr[] in;
        
        in = new Expr[] { new SimpleExpr(0,ExprType.key,"key") };
        assertEquals("key.setStart()",rf.rewrite("set",in).toJavaString());
    }
    
    public void testTypicalRewrite()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt($,$,$,$)",ExprType.rawint);
        Expr[] in = list("1+3,'hello',27.2,5)");
        assertEquals("setAt(1+3,Integer.parseInt(\"hello\"),Clarion.newDecimal(\"27.2\").intValue(),5)",r.rewrite(in).toJavaString());
    }

    public void testRewriteWithNulls()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt($,$,$,$)",ExprType.rawint);
        Expr[] in = list("1+3,'hello',,)");
        assertEquals("setAt(1+3,Integer.parseInt(\"hello\"),null,null)",r.rewrite(in).toJavaString());
    }
    
    public void testRewriteTooFew()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt($,$,$,$)",ExprType.rawint).range(2,4);
        Expr[] in = list("1,2,3)");
        assertEquals("setAt(1,2,3,null)",r.rewrite(in).toJavaString());
    }

    public void testRewriteTooFewDefaultRefuse()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt($,$,$,$)",ExprType.rawint);
        Expr[] in = list("1,2,3)");
        assertNull(r.rewrite(in));
    }

    public void testRewriteTooManyDefaultRefuse()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt($,$,$,$)",ExprType.rawint);
        Expr[] in = list("1,2,3,4,5)");
        assertNull(r.rewrite(in));
    }
    
    public void testRewriteTooMany()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt($,$,$,$)",ExprType.rawint);
        Expr[] in = list("1,2,3,4,5)");
        assertNull(r.rewrite(in));
    }

    public void testRewriteMultiple()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt(@)",ExprType.rawint);
        Expr[] in = list("1,2,3,4,5)");
        assertEquals("setAt(1,2,3,4,5)",r.rewrite(in).toJavaString());
    }
    
    public void testRewriteMixing()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt($,$,$,$)",ExprType.rawint,ExprType.number,ExprType.rawint);
        Expr[] in = list("1,2,3,4)");
        assertEquals("setAt(1,Clarion.newNumber(2),3,4)",r.rewrite(in).toJavaString());
    }

    public void testRewriteMixingMultiple()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt(@)",ExprType.rawint,ExprType.number,ExprType.rawint);
        Expr[] in = list("1,2,3,4,5)");
        assertEquals("setAt(1,Clarion.newNumber(2),3,4,5)",r.rewrite(in).toJavaString());
    }

    public void testRewriteAlternates()
    {
        Rewriter r = PatternRewriter.create(null,"at",
           "setAt(@)").add(ExprType.rawint,ExprType.rawstring);
        
        Expr[] in = list("1,'2',3,4.0,5)");
        assertEquals("setAt(1,\"2\",3,Clarion.newDecimal(\"4.0\").intValue(),5)",r.rewrite(in).toJavaString());
    }

    public void testRewriteBand()
    {
        Rewriter r = PatternRewriter.create(JavaPrec.BAND,ExprType.rawint,"band",
           "$ & $").add(JavaPrec.BAND,ExprType.rawint);
        
        Expr[] in = list("27,30.5");
        
        Expr o = r.rewrite(in).getExpr();
        o=(new ExprBuffer(0,null)).add(o.wrap(JavaPrec.EQUALITY)).add("==0"); 
        
        assertEquals("(27 & Clarion.newDecimal(\"30.5\").intValue())==0",o.toJavaString());
    }
    
    public void testRewriteBasedOnExprType()
    {
        RewriteFactory f = new RewriteFactory();
        f.add(
        PatternRewriter.create(null,"add","addInt($)",ExprType.rawint),
        PatternRewriter.create(null,"add","addString($)",ExprType.rawstring)
        );
        
        assertEquals("addInt(1)",f.rewrite("add",list("1")).toJavaString());
        assertEquals("addString(\"1\")",f.rewrite("add",list("'1'")).toJavaString());
    }

    public void testRewriteBasedOnMoreEsoteric()
    {
        RewriteFactory f = new RewriteFactory();
        f.add(
        PatternRewriter.create(null,"open","openFile($)",ExprType.file),
        PatternRewriter.create(null,"open","openView($)",ExprType.view)
        );
        
        assertEquals("openFile(myfile)",f.rewrite("open",
            new Expr[] { new SimpleExpr(JavaPrec.LABEL,ExprType.file,"myfile") }
            ).toJavaString());

        assertEquals("openView(myview)",f.rewrite("open",
                new Expr[] { new SimpleExpr(JavaPrec.LABEL,ExprType.view,"myview") }
                ).toJavaString());

        assertNull(f.rewrite("open",
            new Expr[] { new SimpleExpr(JavaPrec.LABEL,ExprType.group,"mygroup") }
            ));

    }

    public void testRewriteMixedPosition()
    {
        Rewriter r = PatternRewriter.create(null,"instring",
           ":2.inString(:1)",ExprType.rawstring,ExprType.string);
        
        Expr[] in = list("'hell','hello'");
        assertEquals("Clarion.newString(\"hello\").inString(\"hell\")",r.rewrite(in).toJavaString());
    }

    public void testRewriteMixedPositionMany()
    {
        Rewriter r = PatternRewriter.create(null,"instring",
           ":2.inString(:1,:3,:4)",ExprType.rawstring,ExprType.string,ExprType.rawint);
        
        Expr[] in = list("'hell','hello',1,2");
        assertEquals("Clarion.newString(\"hello\").inString(\"hell\",1,2)",r.rewrite(in).toJavaString());
    }
    
    public void testRewriteMixedPositionWithTooMany()
    {
        Rewriter r = PatternRewriter.create(null,"instring",
           ":2.inString(:1)",ExprType.rawstring,ExprType.string);
        
        Expr[] in = list("'hell','hello',1,2");
        assertNull(r.rewrite(in));
    }

    public void testRewriteMixedPosition2()
    {
        Rewriter r = PatternRewriter.create(null,"instring",
           ":2.inString(:1,:3,:4)",ExprType.rawstring,ExprType.string,ExprType.rawint);
        
        Expr[] in = list("'hell','hello',3,4");
        assertEquals("Clarion.newString(\"hello\").inString(\"hell\",3,4)",r.rewrite(in).toJavaString());
    }

    public void testRewriteMixedRemain()
    {
        Rewriter r = PatternRewriter.create(null,"instring",
           ":2.inString(:1,@)",ExprType.rawstring,ExprType.string,ExprType.rawint);
        
        Expr[] in = list("'hell','hello',3,4,5");
        assertEquals("Clarion.newString(\"hello\").inString(\"hell\",3,4,5)",r.rewrite(in).toJavaString());
    }

    public void testRewriteMixedRemainLimitMax()
    {
        Rewriter r = PatternRewriter.create(null,"instring",
           ":2.inString(:1,@)",ExprType.rawstring,ExprType.string,ExprType.rawint).max(4);
        
        Expr[] in = list("'hell','hello',3,4,5");
        assertNull(r.rewrite(in));
    }

    public void testRewriteMin()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).min(5);
        
        Expr[] in = list("'hello',1,2,3,4)");
        assertEquals("buffer(\"hello\",1,2,3,4)",r.rewrite(in).toJavaString());
    }

    public void testRewriteMinMissed()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).min(5);
        
        Expr[] in = list("'hello',1,2,3)");
        assertNull(r.rewrite(in));
    }
    
    public void testRewriteOverrun()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).min(5);
        
        Expr[] in = list("'hello',1,2,3,4,5,6)");
        assertEquals("buffer(\"hello\",1,2,3,4,5,6)",r.rewrite(in).toJavaString());
    }

    public void testRewriteMax()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).max(5);
        
        Expr[] in = list("'hello',1,2,3,4)");
        assertEquals("buffer(\"hello\",1,2,3,4)",r.rewrite(in).toJavaString());
    }

    public void testRewriteMaxMissed()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).max(5);
        
        Expr[] in = list("'hello',1,2,3,4,5,6)");
        assertNull(r.rewrite(in));
    }
    
    public void testRewriteMaxUnderrun()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).max(5);
        
        Expr[] in = list("'hello',1,2,3,4)");
        assertEquals("buffer(\"hello\",1,2,3,4)",r.rewrite(in).toJavaString());
    }

    public void testRewriteExact()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).exact(5);
        
        Expr[] in = list("'hello',1,2,3,4)");
        assertEquals("buffer(\"hello\",1,2,3,4)",r.rewrite(in).toJavaString());
    }

    public void testRewriteExactUnder()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).exact(5);
        
        Expr[] in = list("'hello',1,2,3)");
        assertNull(r.rewrite(in));
    }
    
    public void testRewriteExactOver()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).exact(5);
        
        Expr[] in = list("'hello',1,2,3,4,5,6)");
        assertNull(r.rewrite(in));
    }

    public void testRewriteRangeA()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).range(5,6);
        
        Expr[] in = list("'hello',1,2,3,4)");
        assertEquals("buffer(\"hello\",1,2,3,4)",r.rewrite(in).toJavaString());
    }

    public void testRewriteRangeB()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).range(5,6);
        
        Expr[] in = list("'hello',1,2,3,4,5)");
        assertEquals("buffer(\"hello\",1,2,3,4,5)",r.rewrite(in).toJavaString());
    }

    public void testRewriteRangeUnder()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).range(5,6);
        
        Expr[] in = list("'hello',1,2,3)");
        assertNull(r.rewrite(in));
    }
    
    public void testRewriteRangeOver()
    {
        Rewriter r = PatternRewriter.create(null,"buffer",
           "buffer(:1,@)",ExprType.rawstring,ExprType.rawint).range(5,6);
        
        Expr[] in = list("'hello',1,2,3,4,5,6,7)");
        assertNull(r.rewrite(in));
    }
    
    
    private Expr[] list(String in)
    {
        Lexer l = new Lexer(new CharArrayReader(in.toCharArray()));
        Parser p = new Parser(l);
        return p.expressionList(LexType.rparam);
    }
}
