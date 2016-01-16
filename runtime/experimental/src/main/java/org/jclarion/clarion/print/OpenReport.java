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

import java.awt.Font;
import java.awt.Point;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionPrinter;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.PropertyObjectListener;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.AbstractReportControl;
import org.jclarion.clarion.control.ControlIterator;
import org.jclarion.clarion.control.ReportBreak;
import org.jclarion.clarion.control.ReportContainer;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportForm;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;

/**
 * Manage printing of report
 * 
 * Some notes about clarion reports:
 *   Withprior and withnext are cumulative.
 *   
 *   withprior and withnext will not force a page to completely empty
 *
 *   In clarion implementation - withprior will consider add added
 *   item and recursively scan back. If recursive scan back results in
 *   prior page being completely emptied, then withprior is ignored
 *   
 *   In clarion implementation - withnext appears to trigger when
 *   the page is closed. System will identify items on page to move onto
 *   next page based on withnext setting. If withnext would result in 
 *   page being completely emptied then withnext skips
 * 
 *   Group headers and footers are printed on use var breaks only and
 *   does not pay attention to page breaks
 *
 *   For aggregate activity as follows:
 *   ---
 *   Firstly the rules taken from clarion documentation:
 *    Options include: SUM, COUNT, MAX, MIN, AVE
 *    
 *    When in a detail structure - is evaluated every time detail structure prints
 *    so provides running value
 *    
 *    In group footer - based on detail structures for any detail within the break
 *    that is printed.
 *    
 *    In footer - based on any detail on that page only
 *    
 *   RESET option specifies break control on which statistic resets.
 *   
 *   TALLY option specifies when counting occurs.
 *   
 *   PAGE option specifies that statistic resets when page break occurs.
 *   
 *   PAGENO option specifies that string is to contain the page number
 *
 * There are a couple of aspects of the implementation that I am not fully happy
 * with. Main item is how paging is setup. Paging occurs after individual printing
 * blocks - details, headers, footers, etc are laid out. As such a second cycle
 * occurs where things like PROP:PAGENO are recalculated and also SUM, CNT etc are
 * implemented on page footers. Result is that following are misimplemented:
 *   PROP:PAGE does not work at all
 *   RESET/TALLY on page footers do not work at all 
 *   
 * Ideally we want to do two passes - pass one does basic layouts taking items
 * like withprior and withnext into consideration and  and pass two performs 
 * aggregation and aggregation can also tally/reset based on page break activity result
 * is that PAGE becomes a meaningful reset property for all aggregations and
 * all agregations are implemented the same - unlike right now where aggregations in
 * detail and break footers are different from aggregations in the page footer.
 * 
 * But there are even challenges with this - because aggregate result and influence
 * how blocks on a page layout and thus influence page break triggers. i.e. you can
 * setup a break on VARX and VARX forms MAX(VARX) so aggregate triggers decision
 * to break or not which in turn influences page layout in this case - printing of 
 * break headers/footers. Problem - if required to be solved - needs more thought.
 * 
 * @author barney
 *
 */

public class OpenReport implements PropertyObjectListener
{
    public static ReportDetail NEWPAGE = new ReportDetail();

    private static class Element
    {
        private PrintObject detail;
        private Element prior;
        private Element next;
    }

    
    private ClarionReport report;
    
    private int x;
    private int y;
    private int width;
    private int height;
    
    private double xscale;  // adjustors to convert from clarion size to /72th of an inch
    private double yscale;  // adjustors to convert from clarion size to /72th of an inch
    
    //private PrinterJob job;
    //private PrintRequestAttributeSet printAttribute;

    private Map<AbstractReportControl,ReportStatistics> tally=new IdentityHashMap<AbstractReportControl, ReportStatistics>(); 
    private Map<AbstractReportControl,ReportStatistics> reset=new IdentityHashMap<AbstractReportControl, ReportStatistics>(); 

    private Map<AbstractControl,ReportStatistic> stats=new IdentityHashMap<AbstractControl, ReportStatistic>();

    private Map<ClarionObject,Boolean> isAggregatingField=new IdentityHashMap<ClarionObject, Boolean>();

    private Map<ReportBreak,ClarionObject> breakValues=new IdentityHashMap<ReportBreak, ClarionObject>();
    
    private Element firstDetail;
    private Element lastDetail;
    private Element position;

    private List<Page> pages;
    
    private PrintContext graphics;
    //private PageFormat   page;

    private ReportDetail lastPrintedItem;

    private Page currentPage;
    
    
    public OpenReport(ClarionReport report)
    {
        this.report=report;
        
        xscale=1;
        yscale=1;
        
        if (report!=null) {
            x=report.getProperty(Prop.XPOS).intValue();
            y=report.getProperty(Prop.YPOS).intValue();
            width=report.getProperty(Prop.WIDTH).intValue();
            height=report.getProperty(Prop.HEIGHT).intValue();

            if (report.isProperty(Prop.THOUS)) {
                xscale=yscale=72.0/1000;
            } else if (report.isProperty(Prop.MM)) {
                xscale=yscale=72.0/25.4;
            } else if (report.isProperty(Prop.POINTS)) {
            
            } else {
                Font f = CWin.getInstance().getFontOnly(null,report);
                if (f!=null) {
                    xscale=f.getSize()/4.0;
                    yscale=f.getSize()/8.0;
                }
            }
            
            if (report.getPreview()!=null) {
                init();
            }
        }
        
        xscale=xscale*10.0;
        yscale=yscale*10.0;
        
        refreshTallyDependencies();
    }

    public ClarionReport getReport()
    {
        return report;
    }
    
    @Override
    public Object getProperty(PropertyObject owner, int property) {
        return null;
    }

    @Override
    public void propertyChanged(PropertyObject owner, int property,
            ClarionObject value) {
        switch(property) {
            case Prop.LANDSCAPE:
                break;
            case Prop.XPOS:
                x=value.intValue();
                break;
            case Prop.YPOS:
                y=value.intValue();
                break;
            case Prop.WIDTH:
                width=value.intValue();
                break;
            case Prop.HEIGHT:
                height=value.intValue();
                break;
        }
    }
    
    
    public void registerTallyListener(AbstractReportControl control,ReportStatistic statistic)
    {
        register(tally,control,statistic);
    }

    public void registerResetListener(AbstractReportControl control,ReportStatistic statistic)
    {
        register(reset,control,statistic);
    }
    
    private void register(
            Map<AbstractReportControl, ReportStatistics> type,
            AbstractReportControl control, ReportStatistic statistic) 
    {
        
        ReportStatistics rs = type.get(control);
        if (rs==null) {
            rs=new ReportStatistics();
            type.put(control,rs);
        }
        
        rs.add(statistic);
    }

    
    private AbstractReportControl getReportControl(AbstractControl control)
    {
        while ( control!=null ) {
            if (control instanceof AbstractReportControl) return (AbstractReportControl)control;
            control=control.getParent();
        }
        return null;
    }

    
    public boolean isAggregatingField(ClarionObject field)
    {
        return isAggregatingField.containsKey(field);
    }
    
    public ReportStatistic getStatistic(StringControl control)
    {
        ReportStatistic rs = stats.get(control);
        if (rs!=null) return rs;

        if (control.isProperty(Prop.SUM)) {
            rs=ReportStatistic.SUM(null);
        }

        if (control.isProperty(Prop.AVE)) {
            rs=ReportStatistic.AVG(null);
        }

        if (control.isProperty(Prop.CNT)) {
            rs=ReportStatistic.COUNT(null);
        }

        if (control.isProperty(Prop.MIN)) {
            rs=ReportStatistic.MIN(null);
        }

        if (control.isProperty(Prop.MAX)) {
            rs=ReportStatistic.MAX(null);
        }

        if (rs==null) return null;
        stats.put(control, rs);
        rs.setControl(control);
        isAggregatingField.put(control.getUseObject(),true);

        AbstractReportControl container = getReportControl(control);

        // if page footer
        if ((container instanceof ReportFooter)
            && !(container.getContainer() instanceof ReportBreak)) {
            
            rs.setPagedItem();
            
            return rs;
        }
        
        
        // work out tally
        AbstractReportControl tally = control.getTally();
        if (tally != null) {
            registerTallyListener(tally, rs);
        } else {
            
            if (container instanceof ReportDetail) {
                // When in a detail structure - is evaluated every time detail
                // structure prints
                
                registerTallyListener(container, rs);

            } else if ((container instanceof ReportFooter)
                    && (container.getContainer() instanceof ReportBreak)) {

                // In group footer - based on detail structures for any detail
                // within the break
                // that is printed.

                ReportComponentIterator rci = new ReportComponentIterator(
                        (ReportBreak) container.getContainer());
                while (rci.hasNext()) {
                    AbstractReportControl arc = rci.next();
                    if (arc instanceof ReportDetail) {
                        if (arc.containsUse(control.getUseObject())) {
                            registerTallyListener((ReportDetail) arc, rs);
                        }
                    }
                }
            }
        }

        // work out reset
        AbstractReportControl reset = control.getReset();
        if (reset != null) {
            registerResetListener(reset, rs);
        } else {

            if (container instanceof ReportDetail) {
                // never resets
            } else if ((container instanceof ReportFooter)
                    && (container.getContainer() instanceof ReportBreak)) {
                // In group footer - when break resets
                registerResetListener((ReportBreak) container.getContainer(),
                        rs);
            }
        }

        return rs;
    }
    
    
    public void pageBreak()
    {
        pageBreak(false);
    }

    public void pageBreak(boolean open)
    {
        if (!open) {
            printBreaks(null);
        }
        print(NEWPAGE);
    }
    

    public ReportContainer commonAncestor(ReportDetail d1,ReportDetail d2)
    {
        if (d1==null || d2==null) return report;
        
        Map<ReportContainer,Integer> s = new IdentityHashMap<ReportContainer, Integer>();
        
        ReportContainer s1 = d1.getContainer();
        ReportContainer s2 = d1.getContainer();
        
        while (s1 != null && s2 != null ) {
            
            if (s1==s2) return s1;
            
            if (s1!=null && s.containsKey(s1)) return s1;
            if (s2!=null && s.containsKey(s2)) return s2;
            
            if (s1!=null) {
                s.put(s1,null);
                s1=s1.getContainer();
            }
            if (s2!=null) {
                s.put(s2,null);
                s2=s2.getContainer();
            }
        }
        
        return report;
    }
    
    
    private void printBreaks(ReportDetail detail)
    {
        ReportContainer commonAncestor = commonAncestor(detail,lastPrintedItem);
        
        // footers - if break value has changed
        if (lastPrintedItem!=null) {
            ReportContainer scan = lastPrintedItem.getContainer();
            
            // force closure until common ancestor is reached
            while (scan!=commonAncestor && scan!=null && (scan instanceof ReportBreak)) 
            {
                ReportBreak b_scan = (ReportBreak)scan;
                add(b_scan.getFooter());
                
                ReportStatistics rs;
                rs = reset.get(b_scan);
                if (rs!=null) rs.reset();
                rs = tally.get(b_scan);
                if (rs!=null) rs.add();
                
                breakValues.remove(b_scan);
                scan=scan.getContainer();
            }
            
            // build up list of break
            ArrayList<ReportBreak> al = new ArrayList<ReportBreak>();
            while (scan!=null && (scan instanceof ReportBreak)) {
                al.add( (ReportBreak)scan );
                scan=scan.getContainer();
            }
            
            // work out which breaks need resetting
            if (!al.isEmpty()) {
                boolean resetAll=false;
                
                boolean reset[] = new boolean[al.size()];
                
                for (int r_scan = reset.length-1;r_scan>=0;r_scan--) {
                    ReportBreak rb = al.get(r_scan);
                    if (!resetAll) {
                        ClarionObject lastValue = breakValues.get(rb);
                        if (lastValue!=null) {
                            if (!lastValue.equals(rb.getUseObject())) {
                                resetAll=true;
                            }
                        }
                    }
                    if (resetAll) {
                        reset[r_scan]=true;
                    }
                }
                
                for (int r_scan=0;r_scan<reset.length;r_scan++) {
                    if (reset[r_scan]) {
                        ReportBreak rb = al.get(r_scan);
                        add(rb.getFooter());
                        
                        ReportStatistics rs;
                        rs = this.reset.get(rb);
                        if (rs!=null) rs.reset();
                        rs = this.tally.get(rb);
                        if (rs!=null) rs.add();
                        
                        breakValues.remove(rb);
                    }
                }
            }
        }
        
        // headers - if break value is undefined then build header
        if (detail!=null) {
            ArrayList<ReportBreak> al = new ArrayList<ReportBreak>();
            ReportContainer scan = detail.getContainer();
            while (scan!=null) {
                if (scan instanceof ReportBreak) {
                    al.add((ReportBreak)scan);
                }
                scan=scan.getContainer();
            }

            for (int bscan=al.size()-1;bscan>=0;bscan--) {
                ReportBreak rb = al.get(bscan);
                if (breakValues.get(rb)==null) {
                    breakValues.put(rb,rb.getUseObject().genericLike());
                    
                    add(rb.getHeader());
                }
            }
        }
        
        // finally 
        lastPrintedItem = detail;
    }
    
    public void print(ReportDetail detail)
    {
        // handle group headers and footers
        if (detail!=NEWPAGE) {
            printBreaks(detail);
        }
        
        add(detail);
        printItems();
    }
    
    private void add(AbstractReportControl detail)
    {
        if (detail==null) return;
        
        ReportStatistics rs;
        
        rs = tally.get(detail);
        if (rs!=null) {
            rs.add();
        }

        rs = reset.get(detail);
        if (rs!=null) rs.reset();
        
        Element e = new Element();
        e.detail=new PrintObject(detail,this,CWin.getInstance());
        e.prior=lastDetail;
        e.next=null;
        
        if (lastDetail==null) {
            lastDetail=e;
            firstDetail=e;
        } else {
            lastDetail.next=e;
        }
        
        lastDetail=e;
    }
    
    public void reset()
    {
        position=null;
    }
    
    public PrintObject next()
    {
        if (position==null) {
            position=firstDetail;
        } else {
            position=position.next;
        }
        if (position==null) return null;
        return position.detail;
    }

    public PrintObject previous()
    {
        if (position==null) {
            position=lastDetail;
        } else {
            position=position.prior;
        }
        if (position==null) return null;
        return position.detail;
    }
    
    public PrintObject current()
    {
        if (position==null) return null;
        return position.detail;
    }
    
    public PrintObject peek(int offset)
    {
        Element scan = position;
        if (scan==null) {
            if (offset>0) {
                scan=firstDetail;
                offset--;
            } else {
                scan=lastDetail;
                offset++;
            }
        }
        
        while (offset>0 && scan!=null) {
            scan=scan.next;
            offset--;
        }
        while (offset<0 && scan!=null) {
            scan=scan.prior;
            offset++;
        }
        if (scan==null) return null;
        return scan.detail;
    }

    public Iterable<Page> getPages()
    {
        if (pages==null) init();
        return pages;
    }
   
    /*
    public Page getPage(int page)
    {
        if (pages==null) init();
        return pages.get(page);
    }
    */
    
    /**
    public int getPageCount()
    {
        if (pages==null) init();
        return pages.size();
    }*/

    public void refreshTallyDependencies()
    {
        if (report==null) return;
        ControlIterator ci = new ControlIterator(report);
        ci.setLoop(false);
        ci.setScanDisabled(true);
        ci.setScanHidden(true);
        ci.setScanSheets(true);
        while (ci.hasNext()) {
            AbstractControl ac = ci.next();
            if (ac instanceof StringControl) {
                getStatistic((StringControl)ac);
            }
        }
    }
    
    public boolean isInit()
    {
        return (pages!=null);
    }
    
    public void init()
    {
        if (pages!=null) return;
        init(new AWTPrintContext((new BufferedImage(1,1,BufferedImage.TYPE_INT_ARGB)).createGraphics()));
    }
    
    public void init(PrintContext graphics)
    {
        this.graphics=graphics;
        if (pages!=null) return;
        pages=new ArrayList<Page>();
        currentPage = null;
        reset();
        printItems();
    }

    private void finishPrint()
    {
        printBreaks(null);
        printItems();
        currentPage=finalizePage(currentPage);
        currentPage=finalizePage(currentPage);
    }
    

    private void printItems()
    {
        if (pages==null) return; // not yet!
        
        while (peek(1)!=null) {
            next();
            
            if (current().getControl()==NEWPAGE) {
                currentPage=finalizePage(currentPage,true);
                continue;
            }
            currentPage = doAddElement(currentPage,current());
        }
    }
    
    private Page doAddElement(Page currentPage, PrintObject current) 
    {
        if (currentPage==null) {
            currentPage=doNewPage();  
        }
        
        if (current.getControl().isProperty(Prop.PAGEBEFORE)) {
        	int count = current.getControl().getProperty(Prop.PAGEBEFORENUM).intValue();
        	if (count!=0) {
        		if (currentPage.getMoveableCount()>0) {
                    currentPage = finalizePage(currentPage);
                    if (currentPage==null) {
                    	currentPage=doNewPage();
                    }
        			currentPage.setReNumber(count);
        		}
        	}
        }
        
        if (!currentPage.layout(graphics,current)) {
            currentPage = finalizePage(currentPage);
            if (currentPage==null) {
                currentPage = doNewPage();
            }
            currentPage.layout(graphics,current);
        }
        
        ClarionObject o_prior = current.getControl().getRawProperty(Prop.WITHPRIOR);
        if (o_prior!=null && o_prior.intValue()>0) {
            int prior=o_prior.intValue();
            
            if (prior>=currentPage.getMoveableCount() && pages.size()>0) {
                int raid = prior-currentPage.getMoveableCount()+1;
                
                Page priorPage = pages.get(pages.size()-1);
                PrintObject priorBits[] = priorPage.getMoveableObjects();
                
                int scan=priorBits.length-1;
                
                // end represents the index of first element to put on
                // the next page
                int end = priorBits.length-raid;
                
                // scan through items checking for cumulative priors
                while (scan>=0) {
                    if (scan<end) break;
                    
                    int nestedPrior = priorBits[scan].getControl().getProperty(Prop.WITHPRIOR).intValue();
                    if (scan-nestedPrior<end) {
                        end = scan-nestedPrior;
                        if (end<=0) break;
                    }
                    
                    scan--;
                }
                
                // only if end is not the first element do we consider
                // relocating
                
                if (end>0) {

                    // create a new page and have a go add adding 
                    // prior bits and new bits. If not all fit then
                    // we want to rollback
                    
                    boolean rollback=false;
                    Page altPage = doNewPage();

                    PrintObject currentBits[] = currentPage.getMoveableObjects();
                    ArrayList<Point> points = new ArrayList<Point>(priorBits.length-end+currentBits.length);
                    
                    for (scan=end;scan<priorBits.length;scan++) {
                        points.add(priorBits[scan].getPosition());
                        if (!altPage.layout(graphics,priorBits[scan])) {
                            rollback=true;
                            break;
                        }
                    }
                    
                    if (!rollback) {
                        for (scan=0;scan<currentBits.length;scan++) {
                            points.add(currentBits[scan].getPosition());
                            if (!altPage.layout(graphics,currentBits[scan])) {
                                rollback=true;
                                break;
                            }
                        }
                    }
                    
                    if (!rollback) {
                        for (scan=end;scan<priorBits.length;scan++) {
                            priorPage.removeLastMoveable();
                        }
                        currentPage=altPage;
                    } else {
                        // rollback original positions calculated
                        Iterator<Point> rscan=points.iterator();
                        for (scan=end;scan<priorBits.length && rscan.hasNext();scan++) {
                            priorBits[scan].setPosition(rscan.next());
                        }
                        for (scan=0;scan<currentBits.length && rscan.hasNext();scan++) {
                            currentBits[scan].setPosition(rscan.next());
                        }
                    }
                }
                priorPage.update();
            }
        }
        
        
        if (current.getControl().isProperty(Prop.PAGEAFTER)) {
        	int count = current.getControl().getProperty(Prop.PAGEAFTERNUM).intValue();
        	if (count!=0) {
        		if (currentPage.getMoveableCount()>0) {
                    currentPage = finalizePage(currentPage);
                    if (currentPage==null) {
                    	currentPage=doNewPage();
                    }
        			currentPage.setReNumber(count);
        		}
        	}
        }
        
        return currentPage;
    }

    private Page finalizePage(Page currentPage)
    {
        return finalizePage(currentPage,false);
    }
    
    private Page finalizePage(Page currentPage,boolean force)
    {
        if (currentPage==null) return null;
        ReportFooter rf = report.getFooter();
        if (rf!=null) {
            currentPage.add(graphics,new PrintObject(rf,this,CWin.getInstance(),false));
        }
        if (force || currentPage.getMoveableCount()>0) {
            
            if (currentPage.getReNumber()==-1) {
            	int lastPage=0;
            	if (!pages.isEmpty()) {
            		lastPage=pages.get(pages.size()-1).getPageNo();
            	}
            	currentPage.setPageNo(lastPage+1);
            } else {
            	currentPage.setPageNo(currentPage.getReNumber());
            }
            pages.add(currentPage);

            if (report.getPreview()!=null) {
                report.getPreview().what(1).setValue("print:/"+CMemory.address(currentPage));
                report.getPreview().setNextAnchor(currentPage);
                report.getPreview().add();
            }
            
            // handle withnext 
            PrintObject bits[] = currentPage.getMoveableObjects();
            
            int end = bits.length;
            
            for (int scan=bits.length-1;scan>=0;scan--) {
                int withNext = bits[scan].getControl().getProperty(Prop.WITHNEXT).intValue();
                if (withNext+scan<end) continue;
                end=scan;
            }
            
            if (end>0 && end<bits.length) {

                for (int scan=end;scan<bits.length;scan++) {
                    currentPage.removeLastMoveable();
                }
        
                currentPage.update();
                
                currentPage = doNewPage();
                for (int scan=end;scan<bits.length;scan++) {
                    currentPage.layout(graphics,bits[scan]);
                }
                
                return currentPage;
            }

            currentPage.update();
        }
        
        return null;
    }
    
    private Page doNewPage() 
    {
        Page currentPage=new Page(this);

        ReportForm form = report.getForm();
        if (form!=null) {
            currentPage.add(graphics,new PrintObject(form,this,CWin.getInstance(),false));
        }

        ReportHeader header = report.getHeader();
        if (header!=null) {
            currentPage.add(graphics,new PrintObject(header,this,CWin.getInstance(),false));
        }
        
        return currentPage;
    }

    public void print()
    {
    	ClarionPrinter.getInstance().print(getReport(),getBook());
    }
    
    public int getX() {
        return x;
    }

    public double getXScale() {
        return xscale;
    }

    public double getYScale() {
        return yscale;
    }

    public int getY() {
        return y;
    }

    public int getWidth() {
        return width;
    }

    public int getHeight() {
        return height;
    }

    private PageBook book;
    
    public PageBook getBook() {
        
        final OpenReport report=this;
        
        if (book==null) book=new PageBook() {

            @Override
            public Page getPage(int page) {
                if (pages==null) report.init();
                return pages.get(page);
            }	

            @Override
            public int getPageCount() {
                if (pages==null) report.init();
                finishPrint();
                return pages.size();
            }
        };
        return book;
    }
}
