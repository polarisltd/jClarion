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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;

import sun.print.ServiceDialog;
import sun.print.SunAlternateMedia;

import javax.print.DocFlavor;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.attribute.Attribute;
import javax.print.attribute.AttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.PrintServiceAttributeSet;
import javax.print.attribute.standard.Destination;
import javax.print.attribute.standard.Fidelity;
import javax.print.attribute.standard.Media;
import javax.print.attribute.standard.MediaPrintableArea;
import javax.print.attribute.standard.MediaSize;
import javax.print.attribute.standard.MediaSizeName;
import javax.print.attribute.standard.OrientationRequested;
import javax.swing.JButton;

import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Paper;
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
    private static Logger log = Logger.getLogger(ClarionPrinter.class.getName());
    
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

    private boolean clearServices;
    private PrintService[]              services;
    private PrintService                service;
    private PrintService                defaultService;
    private PrinterJob                  job;
    private String						lastJobError;
    private long                        jobLastAccessed;
    private PrintRequestAttributeSet    attr;
    
    public ClarionPrinter()
    {
        CWin.getInstance();
        getServices();
        if (getJob()!=null) {
            setProperty(Propprint.DEVICE,getJob().getPrintService().getName());
        }    		
    }
    
    public void clearServices()
    {        
    	synchronized(this) {
    		clearServices=true;
    	}
    }
    
    private void getServices()
    {
    	boolean reset=false;
    	synchronized(this) {
    		reset=clearServices;
    		clearServices=false;
    	}
    	
    	if (reset) {
    		if (job!=null) {
    			job.cancel();
    		}
    		job=null;
    		services=null;
    		defaultService=null;
    	}
    	
    	if (services==null) {
    		services=PrinterJob.lookupPrintServices();
    		defaultService=PrintServiceLookup.lookupDefaultPrintService();
    	}
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        return null;
    }
    
    public static final int PRINTER_DIALOG=1;
    public static final int START_PRINT_JOB=2;
    public static final int SPOOL_PAGE=3;
    public static final int MEDIA_LIST=4;

    @Override
	public CommandList getCommandList() {
    	return CommandList.create()
    		.add("PRINTER_DIALOG",1)
    		.add("START_PRINT_JOB",2)
    		.add("SPOOL_PAGE",3)
    		.add("MEDIA_LIST",4)
    	;
    }
    
    @Override
    public boolean isGuiCommand(int command)
    {
    	switch(command) {
    		case START_PRINT_JOB: 
    		case SPOOL_PAGE:
    		case MEDIA_LIST:
    			return false;
    	}
    	return true;
    }
    
    public int lastJob=0;
    private Map<Integer,CurrentJob> jobs=new HashMap<Integer,CurrentJob>();
    
    public void remove(int id)
    {
    	synchronized(jobs) {
    		jobs.remove(id);
    	}
    }
    
    public void getMediaList(ClarionQueue queue)
    {
    	@SuppressWarnings("unchecked")
		List<String> media = (List<String>)CWinImpl.runNow(this,MEDIA_LIST);
    	for (String s : media) {
    		queue.what(1).setValue(s);
    		queue.add();
    	}
    }
    
    public Object command(int command,Object... params)
    {
    	if (command==MEDIA_LIST) {
    		ArrayList<String> result = new ArrayList<String>();    		
			PrintService service = getService();
			if (service!=null) {
				Media[] ma =(Media[])service.getSupportedAttributeValues(Media.class,null,null);
				if (ma!=null) {
					for (Media m : ma) {
						result.add(m.toString());
					}
				}
			}
			return result;
    	}
    	if (command==PRINTER_DIALOG) {
    		return doPrinterDialog((ClarionString)params[0],(Integer)params[1]);
    	}
    	if (command==START_PRINT_JOB) {
    		int id ;
    		synchronized(this) {
    			lastJob++;
        		id = lastJob;
    		}
    		PrinterJob pj = getJob();
    		if (pj==null) {
    			if (lastJobError==null) {
    				CWin.message(	
						Clarion.newString("Print Job Failed. Could not start print. Maybe Printer is offline?"),
						Clarion.newString("Printer Error"),
						Icon.EXCLAMATION);
    			} else {
    				CWin.message(	
    						Clarion.newString("Print Job Failed. Could not start print. "+lastJobError),
    						Clarion.newString("Printer Error"),
    						Icon.EXCLAMATION);    			
    			}
    			return -1;
    		}
    		CurrentJob cj  =new CurrentJob(id,pj,getAttribute(),(String)params[0],(Integer)params[1]);
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
    
    public static class CurrentJob extends Thread implements Printable,Pageable
    {
    	private PrintRequestAttributeSet att;
    	private PrinterJob				 job;
    	private Page	 				 pages[];
    	private ClarionApplication 		 app;
    	private int						 status=0;
    	private int						 id;
    	
    	public CurrentJob(int id,PrinterJob job,PrintRequestAttributeSet a,String name,int count)
    	{
    		this.id=id;
    		att=new HashPrintRequestAttributeSet();
    		att.addAll(a);
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

			HashPrintRequestAttributeSet tattr=new HashPrintRequestAttributeSet();
    		tattr.addAll(att);
			
	        if (p.getLandscape()>0) {
	            tattr.add(OrientationRequested.LANDSCAPE);
	        } else {
	            tattr.add(OrientationRequested.PORTRAIT);
	        }
	        
	        boolean found=false;
	        if (p.getMedia()!=null) {
				PrintService service = job.getPrintService();
				if (service!=null) {
					Media[] ma =(Media[])service.getSupportedAttributeValues(Media.class,null,null);
					if (ma!=null) {
						for (Media m : ma) {
							if (m==null) continue;
							if (!(m instanceof MediaSizeName))  continue;
							if (m.toString().equals(p.getMedia())) {
		               			try {
		              				tattr.add(m);
		               			} catch (Exception ex) { 
		               				ex.printStackTrace();
		               			}
		               			               		
		        				MediaPrintableArea mpa[] = (MediaPrintableArea[])job.getPrintService().getSupportedAttributeValues(MediaPrintableArea.class,null,tattr);
		        				if (mpa!=null && mpa.length>0) {
		        					tattr.add(mpa[0]);
		        				}
		        				found=true;
		        				break;
							}
						}
					}
				}
	        }
	        
	        if (!found)
	        switch(p.getPaper()) {
	            case org.jclarion.clarion.constants.Paper.A4:
	                tattr.add(MediaSizeName.ISO_A4);
	                break;
	            case org.jclarion.clarion.constants.Paper.LEGAL:
	            	tattr.add(MediaSizeName.NA_LEGAL);
	                break;
	            case org.jclarion.clarion.constants.Paper.LETTER:
	            	tattr.add(MediaSizeName.NA_LETTER);
	                break;
	            case org.jclarion.clarion.constants.Paper.USER:
	            case org.jclarion.clarion.constants.Paper.FIXED:
	            {
	            	
                    float width= (float)(p.getPaperWidth()*p.getXScale()/720.0);
                    float height= (float)(p.getPaperHeight()*p.getYScale()/720.0);
                    
                    
               		Media m = getBestMedia(width,height);
               		if (m!=null) {
               			try {
              				tattr.add(m);
               			} catch (Exception ex) { 
               				ex.printStackTrace();
               			}
               			               		
        				MediaPrintableArea mpa[] = (MediaPrintableArea[])job.getPrintService().getSupportedAttributeValues(MediaPrintableArea.class,null,tattr);
        				if (mpa!=null && mpa.length>0) {
        					tattr.add(mpa[0]);
        				}
               		}
                	
        			try {
        				if (width<=height) {
        					tattr.add(new MediaSize(width,height,MediaSize.INCH));
        				} else {
        					//tattr.add(new MediaSize(width,height,MediaSize.INCH));        					
        				}
        			} catch (Exception ex) { 
        				ex.printStackTrace();
        			}
	                break;
	            }
	            case 0:
	                break;
	            default:
	            	break;
	        }
	        
	        PageFormat pf;
	        if (p.getPaper()==Paper.FIXED) {
	        	pf=new PageFormat();
	        	java.awt.print.Paper newPaper = new java.awt.print.Paper();
                double width= p.getPaperWidth()*p.getXScale()/720.0;
                double height= p.getPaperHeight()*p.getYScale()/720.0;
                newPaper.setSize(width, height);
                newPaper.setImageableArea(0,0, width, height);
                pf.setPaper(newPaper);
	        } else {
	        	pf =job.getPageFormat(tattr);
	        }
	        
	        if ((pf.getImageableWidth()<=0 || pf.getImageableHeight()<=0) || (p.getPaper()==org.jclarion.clarion.constants.Paper.USER) || (p.getMedia()!=null)) {
	        	java.awt.print.Paper paper = pf.getPaper();
	        	log.warning("Current paper:"+logPaper(paper));
	        	java.awt.print.Paper newPaper = new java.awt.print.Paper();
	        	
	        	if (paper.getWidth()<=0 || paper.getHeight()<=0) {
		        	log.warning("PageFormat is invalid trying to resize");
	        		if (p.getPaper()==org.jclarion.clarion.constants.Paper.USER) {
	        			double w=paper.getWidth();
	        			double h=paper.getHeight();
	                    double pw= p.getPaperWidth()*p.getXScale()/720.0;
	                    double ph= p.getPaperHeight()*p.getYScale()/720.0;
	                    if (pw>=w) w=pw;
	                    if (ph>=h) h=ph;
	                    newPaper.setSize(w,h);
	        		}
	        	} else {
	        		newPaper.setSize(paper.getWidth(), paper.getHeight());	
	        	}
	        	
	        	newPaper.setImageableArea(0, 0, newPaper.getWidth(), newPaper.getHeight());
	        	pf.setPaper(newPaper);
	        	log.warning("New paper:"+logPaper(newPaper));
	        }
	        
	        
	        if (pf.getImageableWidth()<=0 || pf.getImageableHeight()<=0) {
	        	log.warning("PageFormat is invalid - using default attributes");
	        	pf=job.getPageFormat(att);
		        if (pf.getImageableWidth()<=0 || pf.getImageableHeight()<=0) {
		        	log.warning("PageFormat is invalid - using default page");
		        	pf=job.getPageFormat(null);
		        }
	        }
	        
	        
	        return pf; 
		}

		private String logPaper(java.awt.print.Paper paper) {
			return paper.getWidth()+"x"+paper.getHeight()+" ["+paper.getImageableX()+"."+paper.getImageableY()+" => "
					+paper.getImageableWidth()+"x"+paper.getImageableHeight();
		}

		private static Set<String> logged=new HashSet<String>();

		private Media getBestMedia(float width, float height) 
		{
			if (job==null) return null;
			PrintService service = job.getPrintService();
			if (service==null) return null;
			
			String key = service.getName()+" ("+width+"x"+height+")";						
			
			Media[] ma =(Media[])service.getSupportedAttributeValues(Media.class,null,null);
			if (ma==null) return null;
			
			float area = width*height;
			Media best[]=new Media[3];
			float match[]=new float[3];
			MediaSize size[]=new MediaSize[3];
			MediaPrintableArea marea[]=new MediaPrintableArea[3];
			
			for (Media m : ma) {
				if (m==null) continue;
				if (!(m instanceof MediaSizeName))  continue;
				MediaSize ms = MediaSize.getMediaSizeForName((MediaSizeName)m);
				if (ms==null) continue;

				float pagex=ms.getX(MediaSize.INCH);
				float pagey=ms.getY(MediaSize.INCH);

				int offset=0;
				
				HashPrintRequestAttributeSet tattr=new HashPrintRequestAttributeSet();
				tattr.add(m);
				MediaPrintableArea mpa=null;
				MediaPrintableArea mpaa[] = (MediaPrintableArea[])service.getSupportedAttributeValues(MediaPrintableArea.class,null,tattr);
				if (mpaa!=null && mpaa.length>0) {
					mpa=mpaa[0];
					pagex=mpa.getWidth(MediaPrintableArea.INCH);
					pagey=mpa.getHeight(MediaPrintableArea.INCH);
					if (mpa.getX(MediaPrintableArea.INCH)>0 || mpa.getY(MediaPrintableArea.INCH)>0) {
						offset=1;
					}
				}
				
				if (pagex<width || pagey<height) {
					offset=2;
				}
					
				float test=Math.abs(pagex*pagey-area);
				if (test<match[offset] || best[offset]==null) {
					best[offset]=m;
					match[offset]=test;
					size[offset]=ms;
					marea[offset]=mpa;
				}
			}
			for (int scan=0;scan<3;scan++) {
				if (best[scan]!=null) {
					if (!logged.contains(key)) {
						StringBuilder l = new StringBuilder();
						l.append(key).append(" Recommends confidence:").append(scan);
						l.append(" media:").append(best[scan]);
						l.append(" mediaSize:");
						if (size[scan]!=null) {
							l.append(size[scan].getX(MediaSize.INCH));							
							l.append("x").append(size[scan].getY(MediaSize.INCH));							
						}
						l.append(" area:");
						if (marea[scan]!=null) {
							l.append(marea[scan].getX(MediaPrintableArea.INCH));							
							l.append(".").append(marea[scan].getY(MediaSize.INCH));							
							l.append("->").append(marea[scan].getWidth(MediaSize.INCH));							
							l.append(".").append(marea[scan].getHeight(MediaSize.INCH));							
						}
						log.info(l.toString());
						logged.add(key);
					}
					return best[scan];
				}
			}
			if (!logged.contains(key)) {
				logged.add(key);
				log.info(key+" recommends nothing");
			}
			return null;
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

	        PageFormat pf =job.getPageFormat(att);
	        if (pf.getImageableWidth()<=0) {
	        	pf=job.getPageFormat(null);
	        }	        
	        
	        if (pf.getImageableWidth()<=0) {
	        	
	        	boolean useAnyway=false;
	        	if (getPage(0)!=null) {
	        		if (getPage(0).getPaper()==Paper.USER) useAnyway=true;
	        		if (getPage(0).getPaper()==Paper.FIXED) useAnyway=true;
	        		if (getPage(0).getMedia()!=null) useAnyway=true;
	        		log.warning("****: "+getPage(0).getPaper()+" "+getPage(0).getMedia());
	        	}
	        	
	        	if (useAnyway) {
	        		log.warning("PageFormat is invalid - but is user so trying anyway");
	        		job.setPageable(this);
	        	} else {
	        		log.warning("PageFormat is invalid - printing without pageable setting");
	        		PrintServiceAttributeSet pas = job.getPrintService().getAttributes();
	        		if (pas!=null) {
	        			for (Attribute a : pas.toArray()) {
	        				log.info(a.getName()+" "+a.getCategory()+" "+a);
	        			}
	        		}
	        		job.setPrintable(this);
	        	}
	        } else {
	        	job.setPageable(this);
	        }
			try {
				job.print(att);
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
					getInstance().clearServices();
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
			ClarionPrinter.getInstance().remove(id);
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
    	if (id==-1) {
    		return;
    	}
    	int pageno=0;
    	for (int scan=0;scan<book.getPageCount();scan++) {
    		if (book.getPage(scan).isDeleted()) continue;
        	CWinImpl.run(this,SPOOL_PAGE,id,pageno++,book.getPage(scan));
    	}
    }
        
    private PrinterJob getJob()
    {
        getServices();
        
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
                    lastJobError=null;
                } catch (PrinterException e) {
                	lastJobError=e.getMessage();
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
    
    @SuppressWarnings({ "rawtypes" })
    private PrintService printDialog(
            String title,Integer mode,
            GraphicsConfiguration gc, int x,
            int y, PrintService[] services, PrintService defaultService,
            DocFlavor flavor, PrintRequestAttributeSet attributes)
            throws HeadlessException 
    {
        int defaultIndex = -1;

        getServices();
        
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
    @SuppressWarnings({ "unchecked", "rawtypes" })
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
