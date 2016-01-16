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

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.print.PageFormat;
import java.awt.print.Pageable;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.runtime.CWin;


public abstract class PageBook implements Printable, Pageable
{
    public abstract int getPageCount();
    public abstract Page getPage(int page);
    private byte[] cachePDF;
    private List<Page> printingPages;
    
    public byte[] getCachedPDF()
    {
        return cachePDF;
    }
    
    public void cachePDF(byte[] bytes)
    {
        cachePDF=bytes;
    }
    
    private long start=0;
    private ClarionWindow spooler;
    private ProgressControl progress;

    public void init()
    {
        start=System.currentTimeMillis();
    }
    
    public void finish()
    {
        if (spooler!=null) {
            spooler.close();
            spooler=null;
        }
        start=0;
    }
    
    @Override
    public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException
    {
        if (printingPages==null) {
            printingPages=new ArrayList<Page>();
            for (int scan=0;scan<getPageCount();scan++) {
                Page p = getPage(scan);
                if (p.isDeleted()) continue;
                printingPages.add(p);
            }
        }
        
        if (start==0) {
            start=System.currentTimeMillis();
        }
        
        if (spooler==null && System.currentTimeMillis()>start+2000) {
            
            spooler = new ClarionWindow();
            spooler.setText("Spooling Print Job");
            spooler.setAt(null,null,160,30);
            spooler.setCenter();
            spooler.setMDI();
            progress=new ProgressControl();
            progress.use(new ClarionNumber());
            progress.setAt(5,5,150,20);
            progress.setRange(0,printingPages.size());
            spooler.add(progress);
            
            spooler.open();
            spooler.accept();
            spooler.consumeAccept();
        }
        
        
        if (pageIndex>=printingPages.size()) return Printable.NO_SUCH_PAGE;
        
        if (spooler!=null) {
            progress.getUseObject().setValue(pageIndex);
            CWin.display();
        }
        
        printingPages.get(pageIndex).print(new AWTPrintContext((Graphics2D)graphics));
        return Printable.PAGE_EXISTS;
    }
    
    @Override
    public int getNumberOfPages() {
        return getPageCount();
    }
    
    @Override
    public PageFormat getPageFormat(int pageIndex)
            throws IndexOutOfBoundsException 
    {
        return getPage(pageIndex).getPageFormat();
    }
    
    @Override
    public Printable getPrintable(int pageIndex) throws IndexOutOfBoundsException
    {
        return this;
    }
    
    
}
