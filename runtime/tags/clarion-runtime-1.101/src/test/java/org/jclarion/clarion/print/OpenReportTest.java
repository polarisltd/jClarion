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

import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.io.FileOutputStream;
import java.util.Iterator;

import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.border.LineBorder;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.ReportBreak;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportForm;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TextControl;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;

import junit.framework.TestCase;

public class OpenReportTest extends TestCase 
{
    
    public void testNavigation()
    {
        OpenReport or = new OpenReport(null);
        ReportDetail rd[] = new ReportDetail[10];
        for (int scan=0;scan<rd.length;scan++) {
            rd[scan]=new ReportDetail();
            or.print(rd[scan]);
        }
        
        assertNull(or.current());
        assertSame(rd[0],or.next().getControl());
        assertSame(rd[1],or.next().getControl());
        assertSame(rd[2],or.next().getControl());
        assertSame(rd[3],or.next().getControl());
        assertSame(rd[4],or.next().getControl());
        assertSame(rd[4],or.current().getControl());
        assertSame(rd[4],or.peek(0).getControl());
        assertSame(rd[5],or.peek(1).getControl());
        assertSame(rd[3],or.peek(-1).getControl());
        assertSame(rd[0],or.peek(-4).getControl());
        assertNull(or.peek(-5));
        assertNull(or.peek(+6));
        assertSame(rd[3],or.previous().getControl());
        assertSame(rd[2],or.previous().getControl());
        assertSame(rd[1],or.previous().getControl());
        assertSame(rd[0],or.previous().getControl());
        assertSame(rd[1],or.peek(1).getControl());
        assertNull(or.previous());
        assertSame(rd[9],or.previous().getControl());
        assertNull(or.next());
        assertSame(rd[0],or.next().getControl());
        assertSame(rd[1],or.next().getControl());
    }

    private BufferedImage bi;
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

    protected boolean preInit()
    {
        return false;
    }
    
    protected void setup(OpenReport or) 
    {
        if (preInit()) {
            ((Graphics2D)bi.getGraphics()).scale(10,10);
            or.init();
        }
    }
    
    private void initReport()
    {
        bi = new BufferedImage(350,350,BufferedImage.TYPE_4BYTE_ABGR);

        cr = new ClarionReport();
        cr.setFont("Serif",12,null,null,null);
        cr.setAt(25,25,300,300);
        cr.setProperty(Prop.POINTS,1);
        
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

    public void testPrintDetailIsExactSameSizeAsReport() throws PrinterException
    {
        bi = new BufferedImage(350,350,BufferedImage.TYPE_4BYTE_ABGR);

        cr = new ClarionReport();
        cr.setFont("Serif",12,null,null,null);
        cr.setAt(0,0,210,295);
        cr.setProperty(Prop.MM,1);
        
        rd = new ReportDetail();
        rd.setAt(null,null,210,295);
        rd.setAbsolute();
        cr.add(rd);
        
        OpenReport or = new OpenReport(cr);
        setup(or);
        or.print(rd);
        or.pageBreak();

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));

        Page p = or.getBook().getPage(0);
        
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
        assertSame(rd,po.next().getControl());
        assertFalse(po.hasNext());

        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,1));
    }
    
    
    
    public void testSimpleHeaderFooterFormPrint() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        
        final JDialog jd = new JDialog();
        jd.setModal(true);
        jd.setSize(400,400);
        JLabel jl = new JLabel(new ImageIcon(bi));
        jl.setBorder(new LineBorder(Color.blue,2));
        jd.getContentPane().add(jl);
        jd.getContentPane().setLayout(new FlowLayout());
        
        Thread t = new Thread() { 
            public void run() {
                jd.setVisible(true);
            }
        };
        t.start();
        Thread.sleep(1500);
        jd.dispose();
        t.join();

        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,1));
        
        Page p = or.getBook().getPage(0);
     
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertSame(rf,po.next().getControl());
    }

    
    public void testDynamicManipulation() throws InterruptedException, PrinterException
    {
        initReport();

        OpenReport or = new OpenReport(cr);
        setup(or);

        CWin.setTarget(cr);
        for (int scan=0;scan<=200;scan+=10) {
            
            int id = CWin.createControl(0,Create.LINE,rd.getUseID());
            
            CWin.getControl(id).setProperty(Prop.XPOS,0);
            CWin.getControl(id).setProperty(Prop.YPOS,scan);
            CWin.getControl(id).setProperty(Prop.WIDTH,scan);
            CWin.getControl(id).setProperty(Prop.HEIGHT,200-scan);
            CWin.unhide(id);
        }

        CWin.setTarget();

        line.setValue("Line A");
        or.print(rd);
        
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        
        final JDialog jd = new JDialog();
        jd.setModal(true);
        jd.setSize(400,400);
        JLabel jl = new JLabel(new ImageIcon(bi));
        jl.setBorder(new LineBorder(Color.blue,2));
        jd.getContentPane().add(jl);
        jd.getContentPane().setLayout(new FlowLayout());
        
        Thread t = new Thread() { 
            public void run() {
                jd.setVisible(true);
            }
        };
        t.start();
        Thread.sleep(1500);
        jd.dispose();
        t.join();
        
    }
    
    public void testPageOverflow() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertSame(rf,po.next().getControl());
    }

    public void testMissingDetailWidthAssumesFullWidth() throws InterruptedException, PrinterException
    {
        initReport();
        
        rd = new ReportDetail();
        rd.setAt(0,0,null,40);
        rd.add((new StringControl()).setPicture("@s6").setAt(0,0,120,null).use(line));
        cr.add(rd);
        
        rd.setProperty(Prop.WIDTH,null);
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertSame(rf,po.next().getControl());
    }

    public void testReducedDetailWidthDoesNotAssumeFullWidth() throws InterruptedException, PrinterException
    {
        initReport();
        
        rd = new ReportDetail();
        rd.setAt(0,0,130,40);
        rd.add((new StringControl()).setPicture("@s6").setAt(0,0,120,null).use(line));
        cr.add(rd);
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,1));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",130+25,25,po);
        
        assertDetail("Line C",25,65,po);
        assertDetail("Line D",130+25,65,po);

        assertDetail("Line E",25,105,po);
        assertDetail("Line F",130+25,105,po);

        assertDetail("Line G",25,145,po);
        assertDetail("Line H",130+25,145,po);

        assertDetail("Line I",25,185,po);
        
        assertSame(rf,po.next().getControl());
        
    }
    
    public void testWithNextEverything() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rd.setWithNext(3);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertSame(rf,po.next().getControl());
    }
    
    public void testSimpleWithNextTriggersOverflow() throws InterruptedException, PrinterException
    {
        initReport();
        
        rd2.setWithNext(1);
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line2.setValue("Line G");
        or.print(rd2);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line G",25,25,po);
        assertDetail("Line H",25,65,po);
        assertDetail("Line I",25,105,po);
        assertSame(rf,po.next().getControl());
    }

    public void testDeepNextTriggersOverflow() throws InterruptedException, PrinterException
    {
        initReport();
        
        rd2.setWithNext(2);
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line2.setValue("Line F");
        or.print(rd2);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line F",25,25,po);
        assertDetail("Line G",25,65,po);
        assertDetail("Line H",25,105,po);
        assertDetail("Line I",25,145,po);
        assertSame(rf,po.next().getControl());
    }

    public void testDeepNextDoesNotTriggerOverflow() throws InterruptedException, PrinterException
    {
        initReport();
        
        rd2.setWithNext(1);
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line2.setValue("Line F");
        or.print(rd2);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertSame(rf,po.next().getControl());
    }

    public void testWithPrior() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rd2.setWithPrior(1);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line2.setValue("Line H");
        or.print(rd2);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line G",25,25,po);
        assertDetail("Line H",25,65,po);
        assertDetail("Line I",25,105,po);
        assertSame(rf,po.next().getControl());
    }

    public void testWithPriorAll() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rd.setWithPrior(1);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertSame(rf,po.next().getControl());
    }

    public void testWithPriorInsufficientSpace() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rd.setWithPrior(1);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertSame(rf,po.next().getControl());
    }
    
    public void testWithPriorDeep() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rd2.setWithPrior(2);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line2.setValue("Line H");
        or.print(rd2);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line F",25,25,po);
        assertDetail("Line G",25,65,po);
        assertDetail("Line H",25,105,po);
        assertDetail("Line I",25,145,po);
        assertSame(rf,po.next().getControl());
    }

    public void testWithPriorDeepCascade() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);
 
        rd2.setWithPrior(2);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line2.setValue("Line G");
        or.print(rd2);
        line2.setValue("Line H");
        or.print(rd2);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line E",25,25,po);
        assertDetail("Line F",25,65,po);
        assertDetail("Line G",25,105,po);
        assertDetail("Line H",25,145,po);
        assertDetail("Line I",25,185,po);
        assertSame(rf,po.next().getControl());
    }

    public void testWithPriorDeepCascade2() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rd2.setWithPrior(7);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line2.setValue("Line I");
        or.print(rd2);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertSame(rf,po.next().getControl());
    }

    public void testWithPriorNoCascadeBackRequired() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rd2.setWithPrior(6);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line2.setValue("Line I");
        or.print(rd2);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("Line C",25,25,po);
        assertDetail("Line D",25,65,po);
        assertDetail("Line E",25,105,po);
        assertDetail("Line F",25,145,po);
        assertDetail("Line G",25,185,po);
        assertDetail("Line H",25,225,po);
        assertDetail("Line I",25,265,po);
        assertSame(rf,po.next().getControl());

    }

    public void testSimpleBreak() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,1));

        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("BREAK FOOTER",25,185,po);
        assertSame(rf,po.next().getControl());
    }

    
    public void testPrintDetailTriggersBreak() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        line.setValue("INTRUDER!");
        or.print(rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));

        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertDetail("INTRUDER!",25,185,po);
        assertDetail("BREAK HEADER",25,225,po);
        assertDetail("LINE C",25,265,po);
        assertSame(rf,po.next().getControl());

        po = or.getBook().getPage(1).getPrintObjects().iterator(); 
        
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK FOOTER",25,25,po);
        assertSame(rf,po.next().getControl());
    }

    public void testChangeValueTriggersBreak() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        rb_break.setValue(2);
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,1));

        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertDetail("BREAK HEADER",25,185,po);
        assertDetail("LINE C",25,225,po);
        assertDetail("BREAK FOOTER",25,265,po);
        assertSame(rf,po.next().getControl());
    }
    
    public void testPageNoPrinting() throws InterruptedException, PrinterException
    {
        initReport();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertDetail("1",0,0,po);
        assertDetail("Line A",25,25,po);
        assertDetail("Line B",25,65,po);
        assertDetail("Line C",25,105,po);
        assertDetail("Line D",25,145,po);
        assertDetail("Line E",25,185,po);
        assertDetail("Line F",25,225,po);
        assertDetail("Line G",25,265,po);
        assertDetail("1",0,0,po);
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertDetail("2",0,0,po);
        assertDetail("Line H",25,25,po);
        assertDetail("Line I",25,65,po);
        assertDetail("2",0,0,po);
    }

    public void testDetailSumming() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        for (int scan=0;scan<9;scan++) {
            number.increment(1);
            or.print(rd);
        }
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("1",25,25,po);
        assertDetail("3",25,65,po);
        assertDetail("6",25,105,po);
        assertDetail("10",25,145,po);
        assertDetail("15",25,185,po);
        assertDetail("21",25,225,po);
        assertDetail("28",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("36",25,25,po);
        assertDetail("45",25,65,po);
        assertSame(rf,po.next().getControl());
    }

    
    public void testBreakFooterAgg() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rb_rf.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        
        cs= (StringControl)rb_rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        number.setValue("10");
        or.print(rb_rd);
        number.setValue("15");
        or.print(rb_rd);
        number.setValue("20");
        or.print(rb_rd);

        rb_break.setValue(2);
        number.setValue("21");
        or.print(rb_rd);
        number.setValue("22");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("10",25,65,po);
        assertDetail("15",25,105,po);
        assertDetail("20",25,145,po);
        assertDetail("45",25,185,po);
        assertDetail("BREAK HEADER",25,225,po);
        assertDetail("21",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("22",25,25,po);
        assertDetail("43",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }

    public void testBreakFooterAggAltDetail() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rb_rf.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        
        cs= (StringControl)rb_rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        
        ReportDetail rb_rd2 = new ReportDetail();
        rb_rd2.setAt(0,0,300,40);
        rb_rd2.add((new StringControl()).setPicture("@s40").setAt(0,0,null,null).use(number));
        rb.add(rb_rd2);
        
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        number.setValue("10");
        or.print(rb_rd);
        number.setValue("15");
        or.print(rb_rd2);
        number.setValue("20");
        or.print(rb_rd);

        rb_break.setValue(2);
        number.setValue("21");
        or.print(rb_rd);
        number.setValue("22");
        or.print(rb_rd2);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("10",25,65,po);
        assertDetail("15",25,105,po);
        assertDetail("20",25,145,po);
        assertDetail("45",25,185,po);
        assertDetail("BREAK HEADER",25,225,po);
        assertDetail("21",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("22",25,25,po);
        assertDetail("43",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }

    public void testBreakFooterAggAltDetailAggOneOnly() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rb_rf.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        cs.setTally(rb_rd);
        
        cs= (StringControl)rb_rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        
        ReportDetail rb_rd2 = new ReportDetail();
        rb_rd2.setAt(0,0,300,40);
        rb_rd2.add((new StringControl()).setPicture("@s40").setAt(0,0,null,null).use(number));
        rb.add(rb_rd2);
        
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        number.setValue("10");
        or.print(rb_rd);
        number.setValue("15");
        or.print(rb_rd2);
        number.setValue("20");
        or.print(rb_rd);

        rb_break.setValue(2);
        number.setValue("21");
        or.print(rb_rd);
        number.setValue("22");
        or.print(rb_rd2);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("10",25,65,po);
        assertDetail("15",25,105,po);
        assertDetail("20",25,145,po);
        assertDetail("30",25,185,po);
        assertDetail("BREAK HEADER",25,225,po);
        assertDetail("21",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("22",25,25,po);
        assertDetail("21",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }
    
    public void testBreakFooterAndDetailAgg() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rb_rf.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        
        cs= (StringControl)rb_rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        number.setValue("10");
        or.print(rb_rd);
        number.setValue("15");
        or.print(rb_rd);
        number.setValue("20");
        or.print(rb_rd);

        rb_break.setValue(2);
        number.setValue("21");
        or.print(rb_rd);
        number.setValue("22");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("10",25,65,po);
        assertDetail("25",25,105,po);
        assertDetail("45",25,145,po);
        assertDetail("45",25,185,po);
        assertDetail("BREAK HEADER",25,225,po);
        assertDetail("66",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("88",25,25,po);
        assertDetail("43",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }
    
    public void testPageAfter() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rf.setPageAfter(-1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("BREAK FOOTER",25,185,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }

    public void testPageAfter_2() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rf.setPageAfter(-1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        rb_line.setValue("LINE C2");
        or.print(rb_rd);
        rb_line.setValue("LINE C3");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("LINE C2",25,185,po);
        assertDetail("LINE C3",25,225,po);
        assertDetail("BREAK FOOTER",25,265,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }
    
    public void testPageAfter_3() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rf.setPageAfter(-1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        rb_line.setValue("LINE C2");
        or.print(rb_rd);
        rb_line.setValue("LINE C3");
        or.print(rb_rd);
        rb_line.setValue("LINE C4");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,2));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,3));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("LINE C2",25,185,po);
        assertDetail("LINE C3",25,225,po);
        assertDetail("LINE C4",25,265,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());

        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator(); 

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK FOOTER",25,25,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(2);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("3",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("3",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }

    public void testPageAfter_ReNumber() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rf.setPageAfter(1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        rb_line.setValue("LINE C2");
        or.print(rb_rd);
        rb_line.setValue("LINE C3");
        or.print(rb_rd);
        rb_line.setValue("LINE C4");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,2));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,3));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("LINE C2",25,185,po);
        assertDetail("LINE C3",25,225,po);
        assertDetail("LINE C4",25,265,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());

        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator(); 

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK FOOTER",25,25,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(2);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }

    
    public void testPageBefore() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rh.setPageBefore(-1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("BREAK FOOTER",25,185,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }

    public void testPageBefore_2() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rh.setPageBefore(-1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        rb_line.setValue("LINE C2");
        or.print(rb_rd);
        rb_line.setValue("LINE C3");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("LINE C2",25,185,po);
        assertDetail("LINE C3",25,225,po);
        assertDetail("BREAK FOOTER",25,265,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }
    
    public void testPageBefore_3() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rh.setPageBefore(-1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        rb_line.setValue("LINE C2");
        or.print(rb_rd);
        rb_line.setValue("LINE C3");
        or.print(rb_rd);
        rb_line.setValue("LINE C4");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,2));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,3));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("LINE C2",25,185,po);
        assertDetail("LINE C3",25,225,po);
        assertDetail("LINE C4",25,265,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());

        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator(); 

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK FOOTER",25,25,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(2);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("3",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("3",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }

    public void testPageBefore_ReNumber() throws InterruptedException, PrinterException
    {
        initReport();
        
        rb_rh.setPageBefore(1);
        rh.getChild(0).setProperty(Prop.PAGENO,true);
        rf.getChild(0).setProperty(Prop.PAGENO,true);

        OpenReport or = new OpenReport(cr);
        setup(or);
        
        rb_break.setValue(1);
        rb_line.setValue("LINE A");
        or.print(rb_rd);
        rb_line.setValue("LINE B");
        or.print(rb_rd);
        rb_line.setValue("LINE C");
        or.print(rb_rd);
        rb_line.setValue("LINE C2");
        or.print(rb_rd);
        rb_line.setValue("LINE C3");
        or.print(rb_rd);
        rb_line.setValue("LINE C4");
        or.print(rb_rd);

        rb_break.setValue(2);
        rb_line.setValue("LINE D");
        or.print(rb_rd);
        rb_line.setValue("LINE E");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,2));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,3));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE A",25,65,po);
        assertDetail("LINE B",25,105,po);
        assertDetail("LINE C",25,145,po);
        assertDetail("LINE C2",25,185,po);
        assertDetail("LINE C3",25,225,po);
        assertDetail("LINE C4",25,265,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());

        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator(); 

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("2",0,0,po).getControl());
        assertDetail("BREAK FOOTER",25,25,po);
        assertSame(rf,assertDetail("2",0,0,po).getControl());
        assertFalse(po.hasNext());
        
        p=or.getBook().getPage(2);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,assertDetail("1",0,0,po).getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("LINE D",25,65,po);
        assertDetail("LINE E",25,105,po);
        assertDetail("BREAK FOOTER",25,145,po);
        assertSame(rf,assertDetail("1",0,0,po).getControl());
        assertFalse(po.hasNext());
        
    }
    
    
    public void testBreakExplicitResetAgg() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rb_rf.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        
        cs= (StringControl)rb_rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        cs.setReset(rb);
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        rb_break.setValue(1);
        number.setValue("10");
        or.print(rb_rd);
        number.setValue("15");
        or.print(rb_rd);
        number.setValue("20");
        or.print(rb_rd);

        rb_break.setValue(2);
        number.setValue("21");
        or.print(rb_rd);
        number.setValue("22");
        or.print(rb_rd);
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("BREAK HEADER",25,25,po);
        assertDetail("10",25,65,po);
        assertDetail("25",25,105,po);
        assertDetail("45",25,145,po);
        assertDetail("45",25,185,po);
        assertDetail("BREAK HEADER",25,225,po);
        assertDetail("21",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("43",25,25,po);
        assertDetail("43",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }

    
    public void testDetailAvg() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rd.getChild(0);
        cs.setText("@n10.2");
        cs.use(number);
        cs.setAverage();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        for (int scan=0;scan<9;scan++) {
            number.increment(1);
            or.print(rd);
        }
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("1.00",25,25,po);
        assertDetail("1.50",25,65,po);
        assertDetail("2.00",25,105,po);
        assertDetail("2.50",25,145,po);
        assertDetail("3.00",25,185,po);
        assertDetail("3.50",25,225,po);
        assertDetail("4.00",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("4.50",25,25,po);
        assertDetail("5.00",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }

    public void testDetailMin() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rd.getChild(0);
        cs.setText("@n-9");
        cs.use(number);
        cs.setMin();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        int val[] = { 10,12,6,100,56,4,120,115,-2 };
        
        for (int scan=0;scan<9;scan++) {
            number.setValue(val[scan]);
            or.print(rd);
        }
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("10",25,25,po);
        assertDetail("10",25,65,po);
        assertDetail("6",25,105,po);
        assertDetail("6",25,145,po);
        assertDetail("6",25,185,po);
        assertDetail("4",25,225,po);
        assertDetail("4",25,265,po);
        assertSame(rf,po.next().getControl());

        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("4",25,25,po);
        assertDetail("-2",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }

    public void testDetailMax() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rd.getChild(0);
        cs.setText("@n-9");
        cs.use(number);
        cs.setMax();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        int val[] = { 10,12,6,100,56,4,120,115,-2 };
        
        for (int scan=0;scan<9;scan++) {
            number.setValue(val[scan]);
            or.print(rd);
        }
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("10",25,25,po);
        assertDetail("12",25,65,po);
        assertDetail("12",25,105,po);
        assertDetail("100",25,145,po);
        assertDetail("100",25,185,po);
        assertDetail("100",25,225,po);
        assertDetail("120",25,265,po);
        assertSame(rf,po.next().getControl());

        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("120",25,25,po);
        assertDetail("120",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }
    
    public void testDetailCounting() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setCount();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        for (int scan=0;scan<9;scan++) {
            number.increment(1);
            or.print(rd);
        }
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("1",25,25,po);
        assertDetail("2",25,65,po);
        assertDetail("3",25,105,po);
        assertDetail("4",25,145,po);
        assertDetail("5",25,185,po);
        assertDetail("6",25,225,po);
        assertDetail("7",25,265,po);
        assertSame(rf,po.next().getControl());
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("8",25,25,po);
        assertDetail("9",25,65,po);
        assertSame(rf,po.next().getControl());
        
    }

    public void testPageFooterSumming() throws InterruptedException, PrinterException
    {
        initReport();

        ClarionNumber number =new ClarionNumber();
        StringControl cs = (StringControl)rd.getChild(0);
        cs.setText("@n9");
        cs.use(number);

        cs = (StringControl)rf.getChild(0);
        cs.setText("@n9");
        cs.use(number);
        cs.setSum();
        
        OpenReport or = new OpenReport(cr);
        setup(or);

        for (int scan=0;scan<9;scan++) {
            number.increment(1);
            or.print(rd);
        }
        
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        
        Page p = or.getBook().getPage(0);
        Iterator<PrintObject> po = p.getPrintObjects().iterator(); 
    
        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("1",25,25,po);
        assertDetail("2",25,65,po);
        assertDetail("3",25,105,po);
        assertDetail("4",25,145,po);
        assertDetail("5",25,185,po);
        assertDetail("6",25,225,po);
        assertDetail("7",25,265,po);
        assertDetail("28",0,0,po);
        
        p=or.getBook().getPage(1);
        po = p.getPrintObjects().iterator();

        assertSame(form,po.next().getControl());
        assertSame(rh,po.next().getControl());
        assertDetail("8",25,25,po);
        assertDetail("9",25,65,po);
        assertDetail("17",0,0,po);
    }
    
    private class MyQueue extends ClarionQueue
    {
        public ClarionString name = new ClarionString(64);
        
        public MyQueue()
        {
            addVariable("name",name);
        }
    }

    public void testPreview() throws InterruptedException, PrinterException
    {
        initReport();

        MyQueue myqueue = new MyQueue();
        cr.setPreview(myqueue);
        OpenReport or = new OpenReport(cr);
        setup(or);

        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));

        assertEquals(2,myqueue.records());

        myqueue.get(1);
        assertEquals("print:/"+CMemory.address(or.getBook().getPage(0)),myqueue.name.toString().trim());
        myqueue.get(2);
        assertEquals("print:/"+CMemory.address(or.getBook().getPage(1)),myqueue.name.toString().trim());

        ClarionWindow.suppressWindowSizingEvents=true;
        ClarionWindow cw = new ClarionWindow();
        cw.setText("Test");
        cw.setAt(0,0,300,300);
        cw.add((new ImageControl()).setAt(0,0,300,300).setText("print:/"+CMemory.address(or.getBook().getPage(0))));
        
        cw.open();
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();

        cw.setTimer(100);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        cw.close();

        PDFFile pf = new PDFFile("print:/"+CMemory.address(or));
        assertTrue(pf.getPDFFile().length>0);
        
        try {
            FileOutputStream fos;
            fos = new FileOutputStream("test.pdf");
            fos.write(pf.getPDFFile());
            fos.close();
        } catch (java.io.IOException e) {
            e.printStackTrace();
        }
        
    }

    public void testPreviewDetailsRememberedAfterReportIsClosed() throws InterruptedException, PrinterException
    {
        initReport();

        MyQueue myqueue = new MyQueue();
        cr.setPreview(myqueue);
        OpenReport or = new OpenReport(cr);
        setup(or);
        
        line.setValue("Line A");
        or.print(rd);
        line.setValue("Line B");
        or.print(rd);
        line.setValue("Line C");
        or.print(rd);
        line.setValue("Line D");
        or.print(rd);
        line.setValue("Line E");
        or.print(rd);
        line.setValue("Line F");
        or.print(rd);
        line.setValue("Line G");
        or.print(rd);
        line.setValue("Line H");
        or.print(rd);
        line.setValue("Line I");
        or.print(rd);

        /**
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,0));
        assertEquals(Printable.PAGE_EXISTS,or.getBook().print(bi.getGraphics(),null,1));
        assertEquals(Printable.NO_SUCH_PAGE,or.getBook().print(bi.getGraphics(),null,2));
        */

        
        
        or.pageBreak();
        
        assertEquals(2,myqueue.records());

        myqueue.get(1);
        assertEquals("print:/"+CMemory.address(or.getBook().getPage(0)),myqueue.name.toString().trim());
        myqueue.get(2);
        assertEquals("print:/"+CMemory.address(or.getBook().getPage(1)),myqueue.name.toString().trim());

        or=null;
        cr=null;
        bi=null;
        
        myqueue.get(1);
        Object o = CMemory.resolveAddress(Integer.parseInt(myqueue.name.toString().trim().substring(7)));
        assertNotNull(o);
        assertTrue(o instanceof Page);
        o=null;
        
        System.gc();
        Thread.yield();
        Thread.sleep(50);
        
        assertNotNull(CMemory.resolveAddress(Integer.parseInt(myqueue.name.toString().trim().substring(7))));
        
        String address = myqueue.name.toString().trim();
        
        myqueue.free();
        
        System.gc();
        Thread.yield();
        Thread.sleep(50);

        assertNull(CMemory.resolveAddress(Integer.parseInt(address.substring(7))));
    }
    
    public void testPdfOuputRequiresManualInspection() throws InterruptedException, PrinterException
    {
        ClarionReport cr = new ClarionReport();
        cr.setThous();
        cr.setFont("TimesRoman",14,0,org.jclarion.clarion.constants.Font.REGULAR,null);
        cr.setAt(500,500,7000,10000);
        ReportDetail rd = new ReportDetail();
        rd.setAt(0,0,3500,0);
        cr.add(rd);
        rd.add((new StringControl()).setText("Hello World").setAt(100,100,null,null));

        rd.add((new StringControl()).setText("Hello World")
                .setAt(100,300,null,null)
                .setFont("Courier",20,0x0000ff,org.jclarion.clarion.constants.Font.BOLD,null));
        
        rd.add((new StringControl()).setText("Empty Box").setAt(100,800,null,null));
        rd.add((new BoxControl()).setAt(100,900,1000,300));
        rd.add((new StringControl()).setText("Empty Box2").setAt(100,1100,null,null));

        rd.add((new StringControl()).setText("Full Box").setAt(4100,800,null,null));
        rd.add((new BoxControl()).setFillColor(0x00ff00).setColor(0x0000ff,null,null).setAt(4100,900,1000,300));
        rd.add((new StringControl()).setText("Full Box2").setAt(4100,1100,null,null));

        rd.add((new BoxControl()).setLineWidth(50).setAt(2100,900,1000,300));
        rd.add((new BoxControl()).setAt(2000,875,100,50));

        rd.add((new BoxControl()).setRound().setAt(5200,700,1000,300));
        rd.add((new BoxControl()).setRound().setFillColor(0x00ff00).setColor(0x0000ff,null,null).setAt(5200,1100,1000,300));
        
        for (int scan=0;scan<=25;scan++) {
            LineControl lc = new LineControl();
            lc.setLineWidth(scan);
            lc.setColor( scan*8*(0x010101),null,null);
            lc.setAt(0,1500+scan*80,scan*80,2000-scan*80);
            rd.add(lc);
        }
        
        rd.add((new ImageControl()).setText(Icon.EXCLAMATION).setAt(2460,1460,1000,1000));

        rd.add((new ImageControl()).setText("no-such-file.png").setAt(2460,1460,1000,1000));

        ReportDetail rd2 = new ReportDetail();
        rd2.setAt(0,0,3500,0);
        cr.add(rd2);
        
        
        String content=""+
            "Bouncy Bouncy, Oh such a good time."+
            "Bouncy Bouncy, Shoes all in a line."+
            "Bouncy Bouncy, Everybody summersault, summersault.\n"+
            "Summertime, Everybody sing along."+
            "Bouncy Bouncy, oh such a good time."+
            "Bouncy Bouncy, White socks slipping down."+
            "Bouncy Bouncy, Styletos are a no no.\n"+
            "Bouncy Bouncy oh, Bouncy Bouncy oh."+
            "Everytime i bounce i feel i could touch the skyee\n";
        ClarionString cs = new ClarionString(content);
        rd2.add((new TextControl()).setResize().setAt(0,100,3500,0).use(cs));
        rd2.add((new BoxControl()).setAt(0,0,3500,100));

        ReportDetail rd3 = new ReportDetail();
        rd3.setAt(0,0,4000,0);
        cr.add(rd3);
        rd3.add((new BoxControl()).setAt(0,0,2000,2000));
        rd3.add((new StringControl()).setLeft(0).setAt(0,0,2000,0).setText("Left Justified"));
        rd3.add((new StringControl()).setRight(0).setAt(0,300,2000,0).setText("Right Justified"));
        rd3.add((new StringControl()).setCenter(0).setAt(0,600,2000,0).setText("Center Justified"));
        rd3.add((new StringControl()).setCenter(0).setAt(0,900,2000,0).setText("CENTER JUSTIFIED"));
        
        rd3.add((new StringControl()).setCenter(0).setAt(0,1200,2000,0).setText("CENTER JUSTIFIED!")
                .setFont("Monospaced", 10, 0x8080ff,org.jclarion.clarion.constants.Font.BOLD,null));

        rd3.add((new StringControl()).setCenter(0).setAt(0,1300,2000,0).setText("M.M.M.M.M.M.M.M.M")
                .setFont("Monospaced", 10, 0x8080ff,org.jclarion.clarion.constants.Font.BOLD,null));

        rd3.add((new BoxControl()).setAt(2500,0,2000,1000));
        rd3.add((new StringControl()).setDecimal(1000).setAt(2500,0,2000,0).setText("$12,300.12"));
        rd3.add((new StringControl()).setDecimal(1000).setAt(2500,300,2000,0).setText("0.1234553"));
        rd3.add((new StringControl()).setDecimal(1000).setAt(2500,600,2000,0).setText("#####"));
        
        
        cr.open();
        rd.print();
        
        rd2.print();
        
        rd2.setProperty(Prop.FONTSIZE,16);
        rd2.setProperty(Prop.FONTCOLOR,0xff8080);
        rd2.print();
        
        rd3.print();
        
        cr.endPage();
        PDFFile pf = new PDFFile(cr);
        try {
            FileOutputStream fos;
            fos = new FileOutputStream("test.pdf");
            fos.write(pf.getPDFFile());
            fos.close();
        } catch (java.io.IOException e) {
            e.printStackTrace();
        }

        PDFFile pf2 = new PDFFile(cr);
        assertSame(pf2.getPDFFile(),pf.getPDFFile());
    }   
    
    public PrintObject assertDetail(String text,int x,int y,Iterator<PrintObject> po)
    {
        return assertDetail(0,text,x,y,po);
    }
    
    public PrintObject assertDetail(int ofs,String text,int x,int y,Iterator<PrintObject> po)
    {
        assertTrue(po.hasNext());
        PrintObject o = po.next();
        assertNotNull(po);
        assertEquals(text,((Text)o.getElement(ofs)).getText());
        assertEquals(x,o.getPositionedX());
        assertEquals(y,o.getPositionedY());
        return o;
    }

}
