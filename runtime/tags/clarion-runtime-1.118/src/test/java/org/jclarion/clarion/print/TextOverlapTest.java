package org.jclarion.clarion.print;

import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Iterator;

import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.border.LineBorder;

import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TextControl;

import junit.framework.TestCase;

public class TextOverlapTest extends TestCase
{
    private ClarionReport cr;
    private ReportHeader rh;
    private ClarionString line;
    private ReportDetail rd;

    public void doInit()
	{
        cr = new ClarionReport();
        cr.setFont("Serif",12,null,null,null);
        cr.setAt(25,25,300,300);
        cr.setProperty(Prop.POINTS,1);

        rh = new ReportHeader();
        rh.setAt(0,0,350,25);
        rh.add((new StringControl()).setText("HEADER").setAt(0,0,null,null));
        cr.add(rh);
        
        rd = new ReportDetail();
        rd.setAt(0,0,300,40);
        rd.add((new LineControl()).setLineWidth(5).setAt(10,0,280,0));

        line=new ClarionString();
        rd.add((new TextControl()).setResize().setAt(0,4,300,null).use(line));
        cr.add(rd);
        
	}
    
    public void testOverlap() throws InterruptedException
    {
    	doInit();
    	
    	OpenReport or = new OpenReport(cr);
    	line.setValue(lineGen(0,100));
    	or.print(rd);
    	or.pageBreak();
    	
    	Iterator<Page> p = or.getPages().iterator();

    	assertPage(p,0,19);
    	assertPage(p,20,39);
    	assertPage(p,40,59);
    	assertPage(p,60,79);
    	assertPage(p,80,99);
    	assertPage(p,100,100);
    	assertFalse(p.hasNext());

    	BufferedImage bi = new BufferedImage(350,350,BufferedImage.TYPE_4BYTE_ABGR);
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

        Graphics2D g = (Graphics2D)bi.getGraphics();
        
    	for (Page p1 : or.getPages()) {
    		g.setBackground(Color.WHITE);
    		g.fillRect(0,0,350,350);
        	p1.print(new AWTPrintContext((Graphics2D)bi.getGraphics()));
        	jl.repaint();
            Thread.sleep(500);
    	}

    	jd.dispose();
        t.join();
    }


    public void testTextFlowOverlap() throws InterruptedException
    {
    	doInit();
    	
    	OpenReport or = new OpenReport(cr);
    	
    	String content=
                "Bouncy Bouncy, Oh such a good time."+
                "Bouncy Bouncy, Shoes all in a line."+
                "Bouncy Bouncy, Everybody summersault, summersault.\n"+
                "Summertime, Everybody sing along."+
                "Bouncy Bouncy, oh such a good time."+
                "Bouncy Bouncy, White socks slipping down."+
                "Bouncy Bouncy, Styletos are a no no.\n"+
                "Bouncy Bouncy oh, Bouncy Bouncy oh."+
                "Everytime i bounce i feel i could touch the skyee\n";

    	line.setValue(content+content+content+content+content+content);
    	or.print(rd);
    	or.pageBreak();
    	
    	Iterator<Page> p = or.getPages().iterator();

    	assertPage(p,"Bouncy Bouncy, Oh such a good time.Bouncy\n"+
			"Bouncy, Shoes all in a line.Bouncy Bouncy,\n"+
			"Everybody summersault, summersault.\n"+
			"Summertime, Everybody sing along.Bouncy\n"+
			"Bouncy, oh such a good time.Bouncy Bouncy,\n"+
			"White socks slipping down.Bouncy Bouncy,\n"+
			"Styletos are a no no.\n"+
			"Bouncy Bouncy oh, Bouncy Bouncy oh.Everytime\n"+
			"i bounce i feel i could touch the skyee\n"+
			"Bouncy Bouncy, Oh such a good time.Bouncy\n"+
			"Bouncy, Shoes all in a line.Bouncy Bouncy,\n"+
			"Everybody summersault, summersault.\n"+
			"Summertime, Everybody sing along.Bouncy\n"+
			"Bouncy, oh such a good time.Bouncy Bouncy,\n"+
			"White socks slipping down.Bouncy Bouncy,\n"+
			"Styletos are a no no.\n"+
			"Bouncy Bouncy oh, Bouncy Bouncy oh.Everytime\n"+
			"i bounce i feel i could touch the skyee\n"+
			"Bouncy Bouncy, Oh such a good time.Bouncy\n"+
			"Bouncy, Shoes all in a line.Bouncy Bouncy,");
    	
    	assertPage(p,"Everybody summersault, summersault.\n"+
			"Summertime, Everybody sing along.Bouncy\n"+
			"Bouncy, oh such a good time.Bouncy Bouncy,\n"+
			"White socks slipping down.Bouncy Bouncy,\n"+
			"Styletos are a no no.\n"+
			"Bouncy Bouncy oh, Bouncy Bouncy oh.Everytime\n"+
			"i bounce i feel i could touch the skyee\n"+
			"Bouncy Bouncy, Oh such a good time.Bouncy\n"+
			"Bouncy, Shoes all in a line.Bouncy Bouncy,\n"+
			"Everybody summersault, summersault.\n"+
			"Summertime, Everybody sing along.Bouncy\n"+
			"Bouncy, oh such a good time.Bouncy Bouncy,\n"+
			"White socks slipping down.Bouncy Bouncy,\n"+
			"Styletos are a no no.\n"+
			"Bouncy Bouncy oh, Bouncy Bouncy oh.Everytime\n"+
			"i bounce i feel i could touch the skyee\n"+
			"Bouncy Bouncy, Oh such a good time.Bouncy\n"+
			"Bouncy, Shoes all in a line.Bouncy Bouncy,\n"+
			"Everybody summersault, summersault.\n"+
			"Summertime, Everybody sing along.Bouncy");
    	
    	assertPage(p,
   			"Bouncy, oh such a good time.Bouncy Bouncy,\n"+
			"White socks slipping down.Bouncy Bouncy,\n"+
			"Styletos are a no no.\n"+
			"Bouncy Bouncy oh, Bouncy Bouncy oh.Everytime\n"+
			"i bounce i feel i could touch the skyee\n"+
			"Bouncy Bouncy, Oh such a good time.Bouncy\n"+
			"Bouncy, Shoes all in a line.Bouncy Bouncy,\n"+
			"Everybody summersault, summersault.\n"+
			"Summertime, Everybody sing along.Bouncy\n"+
   			"Bouncy, oh such a good time.Bouncy Bouncy,\n"+
			"White socks slipping down.Bouncy Bouncy,\n"+
			"Styletos are a no no.\n"+
			"Bouncy Bouncy oh, Bouncy Bouncy oh.Everytime\n"+
			"i bounce i feel i could touch the skyee");
    	
    	assertFalse(p.hasNext());
    	
    	BufferedImage bi = new BufferedImage(350,350,BufferedImage.TYPE_INT_ARGB);
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

        Graphics2D g = (Graphics2D)bi.getGraphics();
        
    	for (Page p1 : or.getPages()) {
    		g.setBackground(Color.WHITE);
    		g.fillRect(0,0,350,350);
        	p1.print(new AWTPrintContext((Graphics2D)bi.getGraphics()));
        	jl.repaint();
            Thread.sleep(500);
    	}

    	jd.dispose();
        t.join();
    }
    
    
    public void test30PercentOverlap() throws InterruptedException
    {
    	doInit();
    	
    	OpenReport or = new OpenReport(cr);
    	line.setValue(lineGen(0,12));
    	or.print(rd);
    	line.setValue(lineGen(0,100));
    	or.print(rd);
    	or.pageBreak();
    	
    	Iterator<Page> p = or.getPages().iterator();

    	assertTrue(p.hasNext());
    	Page pg = p.next();
    	assertEquals(2,pg.getMoveableCount());
    	PrintObject po = pg.getMoveableObjects()[0];
    	assertEquals(2,po.getElementCount());
    	assertEquals(lineGen(0,12),((TextArea)po.getElement(1)).getText());    	
    	po = pg.getMoveableObjects()[1];
    	assertEquals(2,po.getElementCount());
    	assertEquals(lineGen(0,6),((TextArea)po.getElement(1)).getText());    	
    	
    	assertPage(p,7,26);
    	assertPage(p,27,46);
    	assertPage(p,47,66);
    	assertPage(p,67,86);
    	assertPage(p,87,100);
    	assertFalse(p.hasNext());

    	BufferedImage bi = new BufferedImage(350,350,BufferedImage.TYPE_4BYTE_ABGR);
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

        Graphics2D g = (Graphics2D)bi.getGraphics();
        
    	for (Page p1 : or.getPages()) {
    		g.setBackground(Color.WHITE);
    		g.fillRect(0,0,350,350);
        	p1.print(new AWTPrintContext((Graphics2D)bi.getGraphics()));
        	jl.repaint();
            Thread.sleep(500);
    	}

    	jd.dispose();
        t.join();
    }

    public void test20PercentNoOverlap() throws InterruptedException
    {
    	doInit();
    	
    	OpenReport or = new OpenReport(cr);
    	line.setValue(lineGen(0,16));
    	or.print(rd);
    	line.setValue(lineGen(0,100));
    	or.print(rd);
    	or.pageBreak();
    	
    	Iterator<Page> p = or.getPages().iterator();

    	assertPage(p,0,16);
    	assertPage(p,0,19);
    	assertPage(p,20,39);
    	assertPage(p,40,59);
    	assertPage(p,60,79);
    	assertPage(p,80,99);
    	assertPage(p,100,100);
    	assertFalse(p.hasNext());

    	BufferedImage bi = new BufferedImage(350,350,BufferedImage.TYPE_4BYTE_ABGR);
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

        Graphics2D g = (Graphics2D)bi.getGraphics();
        
    	for (Page p1 : or.getPages()) {
    		g.setBackground(Color.WHITE);
    		g.fillRect(0,0,350,350);
        	p1.print(new AWTPrintContext((Graphics2D)bi.getGraphics()));
        	jl.repaint();
            Thread.sleep(500);
    	}

    	jd.dispose();
        t.join();
    }
    
	private void assertPage(Iterator<Page> p, int i, int j) {
    	assertTrue(p.hasNext());
    	Page pg = p.next();
    	assertEquals(1,pg.getMoveableCount());
    	PrintObject po = pg.getLastMoveable();
    	assertEquals(2,po.getElementCount());
    	assertEquals(lineGen(i,j),((TextArea)po.getElement(1)).getText());
	}

	private void assertPage(Iterator<Page> p,String content) {
    	assertTrue(p.hasNext());
    	Page pg = p.next();
    	assertEquals(1,pg.getMoveableCount());
    	PrintObject po = pg.getLastMoveable();
    	assertEquals(2,po.getElementCount());

    	/*
    	String x = ((TextArea)po.getElement(1)).getText();
    	x=x.replaceAll("\n","\\\\n\"+\n\t\t\t\"");
    	System.out.println(x);
    	*/
    	
    	assertEquals(content,((TextArea)po.getElement(1)).getText());
	}

	private String lineGen(int i, int j) {
		StringBuilder lines=new StringBuilder();
    	for (int scan=i;scan<=j;scan++) {
    		if (scan>i) lines=lines.append('\n');
    		lines.append("This is line #").append(scan);
    	}
    	return lines.toString();
	}

}
