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

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.expr.CExpr;

import junit.framework.TestCase;

public class CSQLExpressionTest extends TestCase {
    
    public void testSimpleConditionals() 
    {
        assertSQL("1>2","1>2",true);
        assertSQL("1<2","1<2",true);
        assertSQL("1=2","1=2",true);
        assertSQL("1<>2","1<>2",true);
        assertSQL("1>=2","1>=2",true);
        assertSQL("1<=2","1<=2",true);
        assertSQL("","1&=2",true);
        assertSQL("1&=2","1&=2",false);
    }

    public void testSimpleStrings() 
    {
        assertSQL("'hello'","'hello'",true);
    }

    public void testSimpleNumbers() 
    {
        assertSQL("12","12",true);

        assertSQL("13.2","13.2",true);

        assertSQL("-13.2","-13.2",true);
    }

    public void testSimpleMath() 
    {
        assertSQL("12+5-4","12+5-4",true);

        assertSQL("12*6/3.0","12*6/3.0",true);

        assertSQL("12*(6/3.0)","12*(6/3.0)",true);
        
        assertSQL("12+5-4","12+(5-4)",true);

        assertSQL("12+5*4","12+(5*4)",true);

        assertSQL("(12+5)*4","(12+5)*4",true);
        
        assertSQL("","12%10",true);

        assertSQL("","12^10",true);
    }

    public void testConcat() 
    {
        assertSQL("12||10","12&10",true);
    }

    public void testNot() 
    {
        assertSQL(" NOT 12","~12",true);
        assertSQL(" NOT 12","NOT 12",true);
    }

    public void testBool() 
    {
        
        assertSQL("1>2 AND 2>3","1>2 AND 2>3",true);
        assertSQL("1>2 OR 2>3","1>2 OR 2>3",true);

        assertSQL("1>2 OR 2>3 AND 4>5","1>2 OR 2>3 AND 4>5",true);
        assertSQL("1>2 OR 2>3 AND 4>5","1>2 OR (2>3 AND 4>5)",true);
        assertSQL("(1>2 OR 2>3) AND 4>5","(1>2 OR 2>3) AND 4>5",true);

        assertSQL("1>2","1>2 OR 2>3 AND 4%5",true);
        assertSQL("2>3 AND 4/5","1%2 OR 2>3 AND 4/5",true);
        assertSQL("1>2","1>2 OR 2%3 AND 4>5",true);
        assertSQL("1>2 OR 6/7","1>2 OR 2%3 AND 4>5 OR 6/7",true);
        assertSQL("1>2","1>2 OR 2%3 AND (4>5 OR 6/7)",true);
        assertSQL("1>2","1>2 OR 2%3 AND 4>5 OR 6%7",true);
        assertSQL("1>2 OR 6/7","1>2 OR 2%3 AND 4%5 OR 6/7",true);
        assertSQL("1>2 OR 6/7 OR 8/9","1>2 OR 2%3 AND 4%5 OR 6/7 OR 8/9",true);
        assertSQL("1>2 OR 6/7 OR 8/9 AND 10/11","1>2 OR 2%3 AND 4%5 OR 6/7 OR 8/9 AND 10/11",true);
        assertSQL("(1>2) AND 4>5 OR 6/7","((1>2 OR 2%3) AND 4>5) OR 6/7",true);
    }

    public void testBinds() 
    {
        CExpression.pushBind();
        try {
            ClarionNumber cn = new ClarionNumber();
            ClarionString cs = new ClarionString();
            
            CExprImpl.getInstance().bind("cn",cn);
            CExprImpl.getInstance().bind("cs",cs);
            
            cn.setValue(5);
            cs.setValue("Hello");
            
            assertSQL("5","cn",true);
            assertSQL("'Hello'","cs",true);
        } finally {
            CExpression.popBind();
        }
    }

    public void testColumnBinds() 
    {
        CExpression.pushBind();
        try {
            ClarionNumber cn = new ClarionNumber();
            ClarionString cs = new ClarionString();
            
            CExprImpl.getInstance().bind("cn",cn,"A.qtyjan",java.sql.Types.SMALLINT);
            CExprImpl.getInstance().bind("cs",cs);
            
            cn.setValue(5);
            cs.setValue("Hello");
            
            assertSQL("A.qtyjan","cn",true);
            assertSQL("'Hello'","cs",true);

            assertSQL("A.qtyjan>0","cn>cs",true);
            assertSQL("A.qtyjan>0 AND A.qtyjan=2","cn>cs AND cn=2",true);
        } finally {
            CExpression.popBind();
        }
    }

    public void testColumnFunctionBinds() 
    {
        CExpression.pushBind();
        try {
            ClarionString format = new ClarionString();
            ClarionString v = new ClarionString();
            
            CExprImpl.getInstance().bind("format",format,"A.format",java.sql.Types.VARCHAR);
            CExprImpl.getInstance().bind("v",v);
            
            format.setValue("ABC123");
            v.setValue("TTT");
            
            assertSQL("A.format","format",true);
            assertSQL("UPPER(A.format)","Upper(format)",true);
            assertSQL("'TTT'","v",true);

            assertSQL("UPPER(A.format)>'TTT'","upper(format)>v",true);
            assertSQL("UPPER(A.format)>'UUU'","upper(format)>'UUU'",true);
        } finally {
            CExpression.popBind();
        }
    }
    
    public void testColumnDateBinds() 
    {
        CExpression.pushBind();
        try {
            ClarionNumber cn = new ClarionNumber();
            ClarionNumber v = new ClarionNumber();
            
            CExprImpl.getInstance().bind("cn",cn,"A.date",java.sql.Types.DATE);
            CExprImpl.getInstance().bind("v",v);
            
            cn.setValue(5);
            v.setValue(CDate.date(1,20,2009));
            
            assertSQL("A.date","cn",true);
            assertSQL(""+CDate.date(1,20,2009),"v",true);

            assertSQL("A.date>'2009-04-06'","cn>"+CDate.date(4,6,2009),true);
            assertSQL("A.date>'2009-01-20'","cn>v",true);
        } finally {
            CExpression.popBind();
        }
    }

    public void testColumnBinds2() 
    {
        CExpression.pushBind();
        try {
            ClarionString df = new ClarionString();
            ClarionString cs = new ClarionString();
            
            CExprImpl.getInstance().bind("cn",df,"A.qtyjan",java.sql.Types.VARCHAR);
            CExprImpl.getInstance().bind("cs",cs);
            
            df.setValue(5);
            cs.setValue("Hello");
            
            assertSQL("A.qtyjan","cn",true);
            assertSQL("'Hello'","cs",true);

            assertSQL("A.qtyjan>'Hello'","cn>cs",true);
        } finally {
            CExpression.popBind();
        }
    }
    
    public void assertSQL(String sql,String exp,boolean strict)
    {
        CExpr e = CExprImpl.getInstance().compile(exp);
        StringBuilder r = new StringBuilder();
        e.generateString(r, strict);
        
        assertEquals(sql,r.toString());
    }
}
