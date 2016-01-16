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
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsEnvironment;
import java.awt.HeadlessException;
import java.awt.Rectangle;
import java.awt.Window;
import java.awt.image.BufferedImage;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
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
import javax.swing.JButton;

import org.jclarion.clarion.constants.Propprint;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionEventQueue;
/** 
 * Model clarion printer
 * 
 * @author barney
 *
 */
public class ClarionPrinter extends PropertyObject
{
    private static ClarionPrinter instance;
    
    private static final long JOB_INACTIVE = 2l*60*60*1000; // if a job is inactive for two hours - then silently reset it 
    
    public static void main(String args[])
    {
        getInstance().printerDialog(Clarion.newString("test"),1);
    }
    
//    private PrinterData device;
    
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
    private Graphics                    graphics;
    
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
    
    public Graphics getGraphics()
    {
        getJob();
        if (graphics == null) {
            if (job!=null) {
                job.setPrintable(new Printable() {
                    @Override
                    public int print(Graphics aGraphics, PageFormat pageFormat,
                        int pageIndex) throws PrinterException {
                        graphics = aGraphics;
                        return Printable.NO_SUCH_PAGE;
                    }
                });

                try {
                    job.print(attr);
                } catch (PrinterException e) {
                }
            }
            
            if (graphics==null) {
                job=null;
                graphics = (new BufferedImage(128,128,BufferedImage.TYPE_INT_ARGB)).getGraphics();
            }
        }
        return graphics;
    }
    
    public PrinterJob getJob()
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
            if (job!=null) {
                graphics=null;
            }
            attr=new HashPrintRequestAttributeSet();
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
    
    public boolean printerDialog(final ClarionString title,final Integer mode)
    {
        AbstractWindowTarget target = CWin.getWindowTarget();
        
        if (target!=null) {
            target.setActiveState(false);
        }
        
        final PrintService ps[] = new PrintService[1];
        
        Runnable r = new Runnable() {
            public void run()
            {
                ClarionEventQueue.getInstance().setRecordState(false,"Entering printDialog");

                ps[0] = printDialog(title!=null?title.toString():null,
                        mode,null,50,50,services,
                        getJob()==null? null : getJob().getPrintService(),
                        null,getAttribute());
                
                ClarionEventQueue.getInstance().setRecordState(true,"Exiting printDialog");
            }
        };
        CWinImpl.runNow(r);
        

        if (target!=null) {
            target.setActiveState(true);
        }
        
        if (ps[0]!=null) {
            setProperty(Propprint.DEVICE,ps[0].getName());
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
                throw new IllegalArgumentException("services must contain "+ "defaultService");
                        
            }
        } else {
            defaultIndex = 0;
        }

        // For now we set owner to null. In the future, it may be passed
        // as an argument.
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

    
}
