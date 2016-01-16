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
package org.jclarion.clarion;


import java.awt.Component;
import java.awt.Container;
import java.awt.Dialog;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsEnvironment;
import java.awt.HeadlessException;
import java.awt.Rectangle;
import java.awt.Window;
import java.awt.print.PageFormat;
import java.awt.print.Pageable;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.util.HashMap;
import java.util.Map;

import sun.print.ServiceDialog;
import sun.print.SunAlternateMedia;

import javax.print.DocFlavor;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.attribute.Attribute;
import javax.print.attribute.AttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Destination;
import javax.print.attribute.standard.Fidelity;
import javax.print.attribute.standard.MediaSize;
import javax.print.attribute.standard.MediaSizeName;
import javax.print.attribute.standard.OrientationRequested;
import javax.swing.JButton;

import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propprint;
import org.jclarion.clarion.print.AWTPrintContext;
import org.jclarion.clarion.print.Page;
import org.jclarion.clarion.print.PageBook;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionEventQueue;
import org.jclarion.clarion.swing.gui.CommandList;
import org.jclarion.clarion.swing.gui.RemoteWidget;
import org.jclarion.clarion.swing.gui.RemoteTypes;
/** 
 * Model clarion printer
 * 
 * @author barney
 *
 */
public class ClarionPrinter extends PropertyObject implements RemoteWidget
{
    private static ClarionPrinter instance;
    
    private static final long JOB_INACTIVE = 2l*60*60*1000; // if a job is inactive for two hours - then silently reset it 
    
    public static void main(String args[])
    {
        getInstance().getJob();
        getInstance().printerDialog(Clarion.newString("test"),1);
        for (Attribute a : getInstance().attr.toArray()) {
        	System.out.println(a);
        }
    }

    /**
     * Get instance of printer object
     * @return
     */
    public static ClarionPrinter getInstance()
    {
        if (instance==null) {
            synchronized(ClarionPrinter.class) {
                if (instance==null) {
                    instance=new ClarionPrinter();
                    CRun.addShutdownHook(new Runnable() { 
                        public void run()
                        {
                            instance=null;
                        }
                    } );
                }
            }
        }
        return instance;
    }

    private PrintService[]              services;
    private PrintService                service;
    private PrintService                defaultService;
    private PrinterJob                  job;
    private long                        jobLastAccessed;
    private PrintRequestAttributeSet    attr;
    
    public ClarionPrinter()
    {
        CWin.getInstance();
        services=PrinterJob.lookupPrintServices();
        defaultService=PrintServiceLookup.lookupDefaultPrintService();
        if (getJob()!=null) {
            setProperty(Propprint.DEVICE,getJob().getPrintService().getName());
        }
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        return null;
    }
    
    public static final int PRINTER_DIALOG=1;
    public static final int START_PRINT_JOB=2;
    public static final int SPOOL_PAGE=3;

    @Override
	public CommandList getCommandList() {
    	return CommandList.create()
    		.add("PRINTER_DIALOG",1)
    		.add("START_PRINT_JOB",2)
    		.add("SPOOL_PAGE",3)
    	;
    }
    
    @Override
    public boolean isGuiCommand(int command)
    {
    	switch(command) {
    		case START_PRINT_JOB: 
    		case SPOOL_PAGE:
    			return false;
    	}
    	return true;
    }
    
    public int lastJob=0;
    private Map<Integer,CurrentJob> jobs=new HashMap<Integer,CurrentJob>();
    
    public Object command(int command,Object... params)
    {
    	if (command==PRINTER_DIALOG) {
    		return doPrinterDialog((ClarionString)params[0],(Integer)params[1]);
    	}
    	if (command==START_PRINT_JOB) {
    		int id ;
    		synchronized(this) {
    			lastJob++;
        		id = lastJob;
    		}
    		CurrentJob cj  =new CurrentJob(id,getJob(),getAttribute(),(String)params[0],(Integer)params[1]);
    		this.job=null;
    		synchronized(jobs) {
    			jobs.put(id,cj);
    		}
    		cj.start();
    		return id;
    	}
    	if (command==SPOOL_PAGE) {
    		CurrentJob cj=null;
    		synchronized(jobs) {
    			cj=jobs.get((Integer)params[0]);
    		}
    		if (cj!=null) {
    			cj.spoolPage((Integer)params[1],(Page)params[2]);
    		}
    		return null;
    	}
    	return null;
    }
    
    public class CurrentJob extends Thread implements Printable,Pageable
    {
    	private PrintRequestAttributeSet attr;
    	private PrinterJob				 job;
    	private Page	 				 pages[];
    	private ClarionApplication 		 app;
    	private int						 status=0;
    	private int						 id;
    	
    	public CurrentJob(int id,PrinterJob job,PrintRequestAttributeSet a,String name,int count)
    	{
    		this.id=id;
    		attr=new HashPrintRequestAttributeSet();
    		attr.addAll(a);
    		this.job=job;
    		this.job.setJobName(name);
    		pages=new Page[count];
    		
    	}
    	    	
		public void spoolPage(int index,Page page) {
			synchronized(pages) {
				pages[index]=page;
				pages.notifyAll();
			}
		}

		@Override
		public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
			if (app!=null) {
				int percent = pageIndex*100/pages.length;
    			app.setProperty(Prop.STATUSTEXT,status,"Spooling "+percent+"%");				
    			app.getStatusPane().notifyStatusChange();
			}
			
			if (pageIndex>=pages.length) return Printable.NO_SUCH_PAGE;
			Page p = getPage(pageIndex);
			p.print(new AWTPrintContext((Graphics2D)graphics));
			return Printable.PAGE_EXISTS;
		}

		@Override
		public int getNumberOfPages() {
			return pages.length;
		}
		
		public Page getPage(int ofs)
		{
			synchronized(pages) {
				while (pages[ofs]==null) {
					try {
						pages.wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
				return pages[ofs];
			}
		}

		@Override
		public PageFormat getPageFormat(int pageIndex) throws IndexOutOfBoundsException {
			Page p = getPage(pageIndex);
			
	        if (p.getLandscape()>0) {
	            attr.add(OrientationRequested.LANDSCAPE);
	        } else {
	            attr.add(OrientationRequested.PORTRAIT);
	        }    	
	        switch(p.getPaper()) {
	            case org.jclarion.clarion.constants.Paper.A4:
	                attr.add(MediaSizeName.ISO_A4);
	                break;
	            case org.jclarion.clarion.constants.Paper.LEGAL:
	            	attr.add(MediaSizeName.NA_LEGAL);
	                break;
	            case org.jclarion.clarion.constants.Paper.LETTER:
	            	attr.add(MediaSizeName.NA_LETTER);
	                break;
	            case org.jclarion.clarion.constants.Paper.USER:
	            {
	                try {
	                    attr.add(new MediaSize(
	                        (float)(p.getPaperWidth()*p.getXScale()),
	                        (float)(p.getPaperHeight()*p.getYScale()),
	                        MediaSize.INCH));
	                } catch (Exception ex) { }
	                break;
	            }
	            case 0:
	                break;
	            default:
	        }
	        
	        return job.getPageFormat(attr);
		}

		@Override
		public Printable getPrintable(int pageIndex) throws IndexOutOfBoundsException {
			return this;
		}

		@Override
		public void run() {

			try {
			
    		app = CWin.getInstance().getGuiApp();
    		if (app!=null) { 
    			if (app.getStatusPane()==null) {
    				app=null;
    			}
    		}
    		if (app!=null) {
    			while ( true ) {
    				status++;
    				int w = app.getProperty(Prop.STATUS,status).intValue();
    				if (w==0) break;
    			}
    			app.setProperty(Prop.STATUS,status,150);
    			app.setProperty(Prop.STATUSTEXT,status,"Spooling...");
    			app.getStatusPane().notifyStatusChange();
    		}
			
			
			job.setPageable(this);
			try {
				job.print(attr);
			} catch (PrinterException e) {
				e.printStackTrace();
				CWin.message(
					Clarion.newString("Print Job Failed:"+e.getMessage()),
					Clarion.newString("Printer Error"),
					Icon.EXCLAMATION);
				try {
					job.print();
				} catch (PrinterException e1) {
					e1.printStackTrace();
					CWin.message(
							Clarion.newString("Print Job Failed On Retry:"+e.getMessage()),
							Clarion.newString("Printer Error"),
							Icon.EXCLAMATION);
				}
			}
			if (app!=null) {
				app.setProperty(Prop.STATUS,status,0);
			}
		} finally {
    		synchronized(jobs) {
    			jobs.remove(id);
    		}			
		}
		}		
    }
    
    public void print(ClarionReport cr,PageBook book)
    {
    	String name = "Clarion Print Job";
    	if (cr!=null) {
    		String newName = cr.getProperty(Prop.TEXT).toString().trim();
    		if (newName.length()>0) name=newName;
    	}
    	int count=0;
    	for (int scan=0;scan<book.getPageCount();scan++) {
    		if (book.getPage(scan).isDeleted()) continue;
    		count++;
    	}
    	if (count==0) return;
    	int id = (Integer)CWinImpl.runNow(this,START_PRINT_JOB,name,count);
    	int pageno=0;
    	for (int scan=0;scan<book.getPageCount();scan++) {
    		if (book.getPage(scan).isDeleted()) continue;
        	CWinImpl.run(this,SPOOL_PAGE,id,pageno++,book.getPage(scan));
    	}
    }
        
    private PrinterJob getJob()
    {
        if (job!=null && jobLastAccessed+JOB_INACTIVE<System.currentTimeMillis()) {
            job.cancel();
            job=null;
        }
        
        if (job==null) {            
            String name = getProperty(Propprint.DEVICE).toString().trim();            
            service=null;            
            for (int scan=0;scan<services.length;scan++) {
                if (services[scan].getName().equals(name)) {
                    service=services[scan];
                    break;
                }
            }            
            if (service==null) {
                service=defaultService;
            }            
            if (service==null && services.length>0) {
                service=services[0];
            }         
            if (service!=null) {
                try {
                    job=PrinterJob.getPrinterJob();
                    job.setPrintService(service);
                } catch (PrinterException e) {
                    e.printStackTrace();
                    job=null;
                }
            }
            
            if (attr==null) {
            	attr=new HashPrintRequestAttributeSet();
            }
        }
        jobLastAccessed=System.currentTimeMillis();
        return job;
    }
    
    public PrintService getService()
    {
        getJob();
        return service;
    }
    
    public PrintRequestAttributeSet getAttribute()
    {
        getJob();
        return attr;
    }
    
    public void setAttribute(PrintRequestAttributeSet printAttribute,PropertyObject report,float xscale,float yscale)
    {
        printAttribute = ClarionPrinter.getInstance().getAttribute();
        if (report.isProperty(Prop.LANDSCAPE)) {
            printAttribute.add(OrientationRequested.LANDSCAPE);
        } else {
            printAttribute.add(OrientationRequested.PORTRAIT);
        }    	
        int type = report.getProperty(Propprint.PAPER).intValue();
        switch(type) {
            case org.jclarion.clarion.constants.Paper.A4:
                printAttribute.add(MediaSizeName.ISO_A4);
                break;
            case org.jclarion.clarion.constants.Paper.LEGAL:
                printAttribute.add(MediaSizeName.NA_LEGAL);
                break;
            case org.jclarion.clarion.constants.Paper.LETTER:
                printAttribute.add(MediaSizeName.NA_LETTER);
                break;
            case org.jclarion.clarion.constants.Paper.USER:
            {
                int pw=report.getProperty(Propprint.PAPERWIDTH).intValue();
                int ph=report.getProperty(Propprint.PAPERHEIGHT).intValue();
                
                try {
                    printAttribute.add(new MediaSize(
                        (float)(pw*72.0*xscale),
                        (float)(ph*72.0*yscale),
                        MediaSize.INCH));
                } catch (Exception ex) { }
                break;
            }
            case 0:
                break;
            default:
                throw new IllegalStateException("Paper Type not supported");
        }
    }

    @Override
    protected void notifyLocalChange(int indx, ClarionObject value) {
        if (indx==Propprint.DEVICE && job!=null && !value.toString().trim().equals(job.getPrintService().getName())) {
            job=null;
        }
        super.notifyLocalChange(indx, value);
    }

    public void notePrintFailure(PrinterJob job) 
    {
        if (job==this.job) {
            this.job.cancel();
            this.job=null;
        }
    }
    
    
    @Override
    public boolean isModalCommand(int command)
    {
    	return true;
    }

    
    private String doPrinterDialog(final ClarionString title,final Integer mode)
    {
		Object lock=new Object();
        ClarionEventQueue.getInstance().setRecordState(false,"Entering printDialog",lock);
        
        PrintService ps = printDialog(title!=null?title.toString():null,
                mode,null,50,50,services,
                getJob()==null? null : getJob().getPrintService(),
                null,getAttribute());
        
        ClarionEventQueue.getInstance().setRecordState(true,"Exiting printDialog",lock);
     
        if (ps==null) return null;
        String name = ps.getName();
        ClarionString cs = new ClarionString(name);
        
        setProperty(Propprint.DEVICE,cs);
        
        return name;
    }
    
    public boolean printerDialog(final ClarionString title,final Integer mode)
    {
        AbstractWindowTarget target = CWin.getWindowTarget();
        
        if (target!=null) {
            target.setActiveState(false);
        }
        
        String name = (String)CWinImpl.runNow(this,PRINTER_DIALOG,title,mode);
        
        if (target!=null) {
            target.setActiveState(true);
        }
        
        if (name!=null) {
            setProperty(Propprint.DEVICE,name);
            return true;
        }
        return false;
    }
    
    @SuppressWarnings("unchecked")
    private PrintService printDialog(
            String title,Integer mode,
            GraphicsConfiguration gc, int x,
            int y, PrintService[] services, PrintService defaultService,
            DocFlavor flavor, PrintRequestAttributeSet attributes)
            throws HeadlessException 
    {
        int defaultIndex = -1;

        if (defaultService != null) {
            for (int i = 0; i < services.length; i++) {
                if (services[i].equals(defaultService)) {
                    defaultIndex = i;
                    break;
                }
            }
            if (defaultIndex < 0) {
                defaultIndex=0;
            }
        } else {
            defaultIndex = 0;
        }

        Window owner = null;
        Rectangle gcBounds = (gc == null) ? GraphicsEnvironment
                .getLocalGraphicsEnvironment().getDefaultScreenDevice()
                .getDefaultConfiguration().getBounds() : gc.getBounds();

        ServiceDialog dialog;
        if (owner instanceof Frame) {
            dialog = new ServiceDialog(gc, x + gcBounds.x, y + gcBounds.y,
                    services, defaultIndex, flavor, attributes, (Frame) owner);
        } else {
            dialog = new ServiceDialog(gc, x + gcBounds.x, y + gcBounds.y,
                    services, defaultIndex, flavor, attributes, (Dialog) owner);
        }

        if (title!=null) dialog.setTitle(title);
        
        if (mode!=null && mode==1) {
            replace(dialog);
        }
        
        dialog.setVisible(true);

        if (dialog.getStatus() == ServiceDialog.APPROVE) {
            PrintRequestAttributeSet newas = dialog.getAttributes();
            Class dstCategory = Destination.class;
            Class amCategory = SunAlternateMedia.class;
            Class fdCategory = Fidelity.class;

            if (attributes.containsKey(dstCategory) && !newas.containsKey(dstCategory)) {
                attributes.remove(dstCategory);
            }

            if (attributes.containsKey(amCategory) && !newas.containsKey(amCategory)) {
                attributes.remove(amCategory);
            }

            attributes.addAll(newas);

            Fidelity fd = (Fidelity) attributes.get(fdCategory);
            if (fd != null) {
                if (fd == Fidelity.FIDELITY_TRUE) {
                    removeUnsupportedAttributes(dialog.getPrintService(),flavor, attributes);
                }
            }
        }

        return dialog.getPrintService();
    }    
    
    private void replace(Component dialog) {
        if (dialog instanceof JButton) {
            JButton b = (JButton)dialog;
            if (b.getText().equals("Print")) b.setText("OK");
        }
        if (dialog instanceof Container) {
            for ( Component child : ((Container)dialog).getComponents() ) {
                replace(child);
            }
        }
    }

    /**
     * Removes any attributes from the given AttributeSet that are 
     * unsupported by the given PrintService/DocFlavor combination.
     */
    @SuppressWarnings("unchecked")
    private void removeUnsupportedAttributes(PrintService ps,
                                                    DocFlavor flavor,
                                                    AttributeSet aset)
    {
        AttributeSet asUnsupported = ps.getUnsupportedAttributes(flavor,
                                                                 aset);

        if (asUnsupported != null) {
        Attribute[] usAttrs = asUnsupported.toArray();

            for (int i=0; i<usAttrs.length; i++) {
                Class category = usAttrs[i].getCategory();

                if (ps.isAttributeCategorySupported(category)) {
                    Attribute attr = 
                        (Attribute)ps.getDefaultAttributeValue(category);

                    if (attr != null) {
                        aset.add(attr);
                    } else {
                        aset.remove(category);
                    }
                } else {
                    aset.remove(category);
                }
            }
        }
    }
    

    @Override
    protected void debugMetaData(StringBuilder sb) {
        // TODO Auto-generated method stub
        
    }

	@Override
	public Iterable<? extends RemoteWidget> getChildWidgets() {
		return null;
	}
	
	private int id;

	@Override
	public int getID() {
		return id;
	}

	@Override
	public void setID(int id) {
		this.id=id;
	}

	@Override
	public void disposeWidget() {
	}

	@Override
	public RemoteWidget getParentWidget()
	{
		return null;
	}

	@Override
	public int getWidgetType() {
		return RemoteTypes.PRINTER;
	}
	@Override
	public void addWidget(RemoteWidget child) {
	}
	
	@Override
	public Map<Integer, Object> getChangedMetaData() {
		return null;
	}

	@Override
	public void setMetaData(Map<Integer, Object> data) {
	}	
}
