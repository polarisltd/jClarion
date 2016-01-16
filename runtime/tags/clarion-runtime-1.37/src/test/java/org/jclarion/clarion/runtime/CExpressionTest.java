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
package org.jclarion.clarion.runtime;

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

import junit.framework.TestCase;

public class CExpressionTest extends TestCase {

    public void testEvaluate()
    {
        assertEquals("1",CExpression.evaluate("1").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("0",CExpression.evaluate("0").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("0",CExpression.evaluate("'0'").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("2",CExpression.evaluate("1+1").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("194",CExpression.evaluate("100+(20*5)-6").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("1",CExpression.evaluate("100 AND 40").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("0",CExpression.evaluate("100 AND 0").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("0",CExpression.evaluate("5>10").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("1",CExpression.evaluate("5<10").toString());
        assertEquals(0,CError.errorCode());
    }
    
    public void testEvaluateErrors()
    {
        assertEquals("",CExpression.evaluate("5+").toString());
        assertEquals(800,CError.errorCode());

        assertEquals("",CExpression.evaluate("5+fred").toString());
        assertEquals(801,CError.errorCode());
    }

    public void testBindVar()
    {
        ClarionNumber n = new ClarionNumber();
        
        CExpression.bind("fred",n);
        
        assertEquals("5",CExpression.evaluate("5+fred").toString());
        assertEquals(0,CError.errorCode());
        
        n.setValue(10);

        assertEquals("15",CExpression.evaluate("5+fred").toString());
        assertEquals(0,CError.errorCode());
    }

    public void testUnBindVar()
    {
        ClarionNumber n = new ClarionNumber();
        
        CExpression.bind("fred",n);
        
        assertEquals("5",CExpression.evaluate("5+fred").toString());
        assertEquals(0,CError.errorCode());
        
        n.setValue(10);

        assertEquals("15",CExpression.evaluate("5+fred").toString());
        assertEquals(0,CError.errorCode());

        assertEquals("",CExpression.evaluate("5+fred()").toString());
        assertEquals(801,CError.errorCode());

        CExpression.unbind("fred");

        assertEquals("",CExpression.evaluate("5+fred").toString());
        assertEquals(801,CError.errorCode());
    }
    
    public void testBindProc()
    {
        BindProcedure bc = new BindProcedure() {
            @Override
            public ClarionObject execute(ClarionString[] p) {
                int a = p[0].intValue();
                int b = p[1].intValue();
                int c = p[2].intValue();
                
                while (c>0) {
                    int nb = a+b;
                    a=b;
                    b=nb;
                    c--;
                }
                return Clarion.getClarionObject(b);
            }
        };
        
        new ClarionNumber();
        
        CExpression.bind("fib",bc);
        
        assertEquals("6",CExpression.evaluate("5+fib(1,1,0)").toString());
        assertEquals("7",CExpression.evaluate("5+fib(1,1,1)").toString());
        assertEquals("8",CExpression.evaluate("5+fib(1,1,2)").toString());
        assertEquals("10",CExpression.evaluate("5+fib(1,1,3)").toString());
        assertEquals("13",CExpression.evaluate("5+fib(1,1,4)").toString());
        assertEquals("18",CExpression.evaluate("5+fib(1,1,5)").toString());
        assertEquals("18",CExpression.evaluate("5+fib(1,1,2+6/2)").toString());
        assertEquals(0,CError.errorCode());
        
        CExpression.unbind("fib");

        assertEquals("",CExpression.evaluate("5+fib(1,1,2+6/2)").toString());
        assertEquals(801,CError.errorCode());
    }

    public void testBindGroup()
    {
        ClarionNumber cn1 = Clarion.newNumber().setName("N1");
        ClarionNumber cn2 = Clarion.newNumber().setName("N2");
        ClarionNumber cn3 = Clarion.newNumber();
        
        ClarionGroup cg = new ClarionGroup();
        cg.addVariable("cn1",cn1);
        cg.addVariable("cn2",cn2);
        cg.addVariable("cn3",cn3);
        cg.setPrefix("x");
        
        cn1.setValue(3);
        cn2.setValue(5);
        cn3.setValue(7);
        
        CExpression.bind(cg);

        assertEquals("",CExpression.evaluate("N1").toString());
        assertEquals("",CExpression.evaluate("n1").toString());
        assertEquals("",CExpression.evaluate("n2").toString());
        assertEquals("",CExpression.evaluate("N2").toString());
        assertEquals("3",CExpression.evaluate("x:cn1").toString());
        assertEquals("3",CExpression.evaluate("x:cN1").toString());
        assertEquals("5",CExpression.evaluate("x:cn2").toString());
        assertEquals("5",CExpression.evaluate("x:cN2").toString());

        assertEquals("7",CExpression.evaluate("x:cN3").toString());
        
        assertEquals("8",CExpression.evaluate("x:cN2+x:cn1").toString());
        assertEquals("",CExpression.evaluate("x:cN2+cn1").toString());

        assertEquals("",CExpression.evaluate("x:N2").toString());
        assertEquals(801,CError.errorCode());
        assertEquals("",CExpression.evaluate("x:N3").toString());
        assertEquals(801,CError.errorCode());
        assertEquals("",CExpression.evaluate("x:N3").toString());
        assertEquals(801,CError.errorCode());
        
        CExpression.unbind(cg);

        assertEquals("",CExpression.evaluate("N1").toString());
        assertEquals("",CExpression.evaluate("n1").toString());
        assertEquals("",CExpression.evaluate("n2").toString());
        assertEquals("",CExpression.evaluate("N2").toString());
        assertEquals("",CExpression.evaluate("x:cn1").toString());
        assertEquals("",CExpression.evaluate("x:cN1").toString());
        assertEquals("",CExpression.evaluate("x:cn2").toString());
        assertEquals("",CExpression.evaluate("x:cN2").toString());
    }

    public void testBindStacksNewVars()
    {
        ClarionNumber cn1 = Clarion.newNumber().setName("N1");
        ClarionNumber cn2 = Clarion.newNumber().setName("N2");
        ClarionNumber cn3 = Clarion.newNumber();
        
        cn1.setValue(2);
        cn2.setValue(3);
        cn3.setValue(5);
        
        CExpression.bind("p1",cn1);
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        
        CExpression.pushBind(true);
        CExpression.bind("p2",cn2);
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("3",CExpression.evaluate("p2").toString());
        
        CExpression.popBind();
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        
    }

    public void testBindStacksClear()
    {
        ClarionNumber cn1 = Clarion.newNumber().setName("N1");
        ClarionNumber cn2 = Clarion.newNumber().setName("N2");
        ClarionNumber cn3 = Clarion.newNumber();
        
        cn1.setValue(2);
        cn2.setValue(3);
        cn3.setValue(5);
        
        CExpression.bind("p1",cn1);
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        
        CExpression.pushBind(false);
        CExpression.bind("p2",cn2);
        assertEquals("",CExpression.evaluate("p1").toString());
        assertEquals("3",CExpression.evaluate("p2").toString());
        
        CExpression.popBind();
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        
    }
    
    public void testBindStacksOverride() 
    {
        ClarionNumber cn1 = Clarion.newNumber().setName("N1");
        ClarionNumber cn2 = Clarion.newNumber().setName("N2");
        ClarionNumber cn3 = Clarion.newNumber();
        
        cn1.setValue(2);
        cn2.setValue(3);
        cn3.setValue(5);
        
        CExpression.bind("p1",cn1);
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        
        CExpression.pushBind(false);
        CExpression.bind("p2",cn2);
        CExpression.bind("p1",cn3);
        assertEquals("5",CExpression.evaluate("p1").toString());
        assertEquals("3",CExpression.evaluate("p2").toString());
        
        CExpression.popBind();
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        
    }
    
    public void testBindManyStacks() 
    {
        ClarionNumber cn1 = Clarion.newNumber().setName("N1");
        ClarionNumber cn2 = Clarion.newNumber().setName("N2");
        ClarionNumber cn3 = Clarion.newNumber();
        
        cn1.setValue(2);
        cn2.setValue(3);
        cn3.setValue(5);
        
        CExpression.bind("p1",cn1);
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        assertEquals("",CExpression.evaluate("p3").toString());
        
        CExpression.pushBind(true);
        CExpression.bind("p2",cn2);
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("3",CExpression.evaluate("p2").toString());
        assertEquals("",CExpression.evaluate("p3").toString());

        CExpression.pushBind(true);
        CExpression.bind("p3",cn3);
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("3",CExpression.evaluate("p2").toString());
        assertEquals("5",CExpression.evaluate("p3").toString());
        
        
        CExpression.popBind();
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("3",CExpression.evaluate("p2").toString());
        assertEquals("",CExpression.evaluate("p3").toString());

        CExpression.popBind();
        assertEquals("2",CExpression.evaluate("p1").toString());
        assertEquals("",CExpression.evaluate("p2").toString());
        assertEquals("",CExpression.evaluate("p3").toString());
        
    }
    
}
