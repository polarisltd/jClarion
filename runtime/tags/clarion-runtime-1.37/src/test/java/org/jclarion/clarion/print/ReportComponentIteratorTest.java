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
package org.jclarion.clarion.print;


import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ReportBreak;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportForm;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.StringControl;

import junit.framework.TestCase;

public class ReportComponentIteratorTest extends TestCase 
{

    private ClarionReport cr;
    private ReportHeader rh;
    private ClarionString line;
    private ReportForm form;
    private ReportDetail rd;
    private ReportFooter rf;


    private ClarionNumber rb_break;
    private ReportBreak  rb;
    private ReportHeader rb_rh;
    private ClarionString rb_line;
    private ReportDetail rb_rd;
    private ReportFooter rb_rf;
    
    private ClarionString line2;
    private ReportDetail rd2;

    private ClarionString line3;
    private ReportDetail rd3;
    
    private void initReport()
    {
        cr = new ClarionReport();
        cr.setFont("Serif",12,null,null,null);
        cr.setAt(25,25,300,300);
        
        rh = new ReportHeader();
        rh.setAt(0,0,350,25);
        rh.add((new StringControl()).setText("HEADER").setAt(0,0,null,null));
        cr.add(rh);

        line = new ClarionString(40);
        rd = new ReportDetail();
        rd.setAt(0,0,300,40);
        rd.add((new StringControl()).setPicture("@s40").setAt(0,0,null,null).use(line));
        cr.add(rd);

        line2 = new ClarionString(40);
        rd2 = new ReportDetail();
        rd2.setAt(0,0,300,40);
        rd2.add((new StringControl()).setPicture("@s40").setAt(0,0,null,null).use(line2));
        cr.add(rd2);
    
        line3 = new ClarionString(40);
        rd3 = new ReportDetail();
        rd3.setAt(0,0,300,40);
        rd3.add((new StringControl()).setPicture("@s40").setAt(0,0,null,null).use(line3));
        cr.add(rd3);
            
        rf = new ReportFooter();
        rf.setAt(0,325,350,25);
        rf.add((new StringControl()).setText("FOOTER").setAt(0,0,null,null));
        cr.add(rf);

        form = new ReportForm();
        form.setAt(0,0,350,350);
        form.add((new BoxControl()).setLineWidth(4).setColor(0,null,null).setAt(10,10,330,330));
        cr.add(form);

        
        rb_break=new ClarionNumber();
        rb=new ReportBreak();
        rb.use(rb_break);
        cr.add(rb);
        
        rb_rh = new ReportHeader();
        rb_rh.setAt(0,0,300,40);
        rb_rh.add((new StringControl()).setText("BREAK HEADER").setAt(0,0,null,null));
        rb.add(rb_rh);

        rb_line = new ClarionString(40);
        rb_rd = new ReportDetail();
        rb_rd.setAt(0,0,300,40);
        rb_rd.add((new StringControl()).setPicture("@s40").setAt(0,0,null,null).use(rb_line));
        rb.add(rb_rd);
            
        rb_rf = new ReportFooter();
        rb_rf.setAt(0,0,300,40);
        rb_rf.add((new StringControl()).setText("BREAK FOOTER").setAt(0,0,null,null));
        rb.add(rb_rf);
    }
    
    
    public void testSimpleIterate()
    {
        initReport();
        
        ReportComponentIterator rci;
        
        rci=new ReportComponentIterator(rb);
        assertTrue(rci.hasNext());
        assertSame(rb,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rh,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rd,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rf,rci.next());
        assertFalse(rci.hasNext());

        rci=new ReportComponentIterator(rh);
        assertTrue(rci.hasNext());
        assertSame(rh,rci.next());
        assertFalse(rci.hasNext());

        rci=new ReportComponentIterator(rb_rf);
        assertTrue(rci.hasNext());
        assertSame(rb_rf,rci.next());
        assertFalse(rci.hasNext());
    }

    public void testInterestingIterate()
    {
        initReport();

        ReportBreak rb2=new ReportBreak();
        ReportHeader rh2=new ReportHeader();
        ReportDetail rd2_a=new ReportDetail();
        ReportDetail rd2_b=new ReportDetail();
        ReportFooter rf2=new ReportFooter();
        rb2.add(rh2).add(rd2_a).add(rd2_b).add(rf2);

        ReportBreak rb3=new ReportBreak();
        ReportHeader rh3=new ReportHeader();
        ReportDetail rd3_a=new ReportDetail();
        ReportDetail rd3_b=new ReportDetail();
        ReportFooter rf3=new ReportFooter();
        rb3.add(rh3).add(rd3_a).add(rd3_b).add(rf3);
        
        rb.add(rb2).add(rb3);
        ReportComponentIterator rci;
        
        rci=new ReportComponentIterator(rb);
        assertTrue(rci.hasNext());
        assertSame(rb,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rh,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rd,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rf,rci.next());
        
        assertTrue(rci.hasNext());
        assertSame(rb2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_b,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rf2,rci.next());

        assertTrue(rci.hasNext());
        assertSame(rb3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_b,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rf3,rci.next());
        
        assertFalse(rci.hasNext());
        
        rci=new ReportComponentIterator(rb2);
        assertTrue(rci.hasNext());
        assertSame(rb2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_b,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rf2,rci.next());
        assertFalse(rci.hasNext());
        
        rci=new ReportComponentIterator(rb3);
        assertTrue(rci.hasNext());
        assertSame(rb3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_b,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rf3,rci.next());
        
        assertFalse(rci.hasNext());
    }
    
    public void testInterestingIterate2()
    {
        initReport();

        ReportBreak rb2=new ReportBreak();
        ReportHeader rh2=new ReportHeader();
        ReportDetail rd2_a=new ReportDetail();
        ReportDetail rd2_b=new ReportDetail();
        ReportFooter rf2=new ReportFooter();
        rb2.add(rh2).add(rd2_a).add(rd2_b).add(rf2);

        ReportBreak rb3=new ReportBreak();
        ReportHeader rh3=new ReportHeader();
        ReportDetail rd3_a=new ReportDetail();
        ReportDetail rd3_b=new ReportDetail();
        ReportFooter rf3=new ReportFooter();
        rb3.add(rh3).add(rd3_a).add(rd3_b).add(rf3);
        
        rb.add(rb2);
        rb2.add(rb3);
        ReportComponentIterator rci;
        
        ReportFooter f = new ReportFooter();
        rb.add(f);
        
        rci=new ReportComponentIterator(rb);
        assertTrue(rci.hasNext());
        assertSame(rb,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rh,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rd,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rf,rci.next());
        
        assertTrue(rci.hasNext());
        assertSame(rb2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_b,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rf2,rci.next());

        assertTrue(rci.hasNext());
        assertSame(rb3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_b,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rf3,rci.next());
        
        assertTrue(rci.hasNext());
        assertSame(f,rci.next());
        
        assertFalse(rci.hasNext());
    }
    
    public void testInterestingIterate3()
    {
        initReport();

        ReportBreak rb2=new ReportBreak();
        ReportHeader rh2=new ReportHeader();
        ReportDetail rd2_a=new ReportDetail();
        ReportDetail rd2_b=new ReportDetail();
        ReportFooter rf2=new ReportFooter();

        ReportBreak rb3=new ReportBreak();
        ReportHeader rh3=new ReportHeader();
        ReportDetail rd3_a=new ReportDetail();
        ReportDetail rd3_b=new ReportDetail();
        ReportFooter rf3=new ReportFooter();

        rb3.add(rh3).add(rd3_a).add(rd3_b).add(rf3);
        rb2.add(rh2).add(rd2_a).add(rd2_b).add(rb3).add(rf2);
        
        rb.add(rb2);
        ReportComponentIterator rci;
        
        ReportFooter f = new ReportFooter();
        rb.add(f);
        
        rci=new ReportComponentIterator(rb);
        assertTrue(rci.hasNext());
        assertSame(rb,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rh,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rd,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rb_rf,rci.next());
        
        assertTrue(rci.hasNext());
        assertSame(rb2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh2,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd2_b,rci.next());

        assertTrue(rci.hasNext());
        assertSame(rb3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rh3,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_a,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rd3_b,rci.next());
        assertTrue(rci.hasNext());
        assertSame(rf3,rci.next());
        
        assertTrue(rci.hasNext());
        assertSame(rf2,rci.next());
        
        assertTrue(rci.hasNext());
        assertSame(f,rci.next());
        
        assertFalse(rci.hasNext());
    }
    
}
