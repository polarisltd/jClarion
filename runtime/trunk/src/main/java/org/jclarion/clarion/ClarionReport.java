/**
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion;

import java.io.IOException;
import java.util.logging.Logger;

import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ReportContainer;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportForm;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.file.FileFactoryRepository;
import org.jclarion.clarion.file.MemoryFile;
import org.jclarion.clarion.print.OpenReport;
import org.jclarion.clarion.print.QueuePrintBook;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.util.PDFPreviewer;

/**
 * Model a report
 * 
 * @author barney
 *
 */
public class ClarionReport extends AbstractTarget implements ReportContainer
{
    private static Logger log = Logger.getLogger(ClarionReport.class.getName());	

	/**
     * Set default font
     * 
     * @param typeface
     * @param size
     * @param color
     * @param style
     * @param charset
     * @return
     */
    public ClarionReport setFont(String typeface,Integer size,Integer color,Integer style,Integer charset)
    {
        setProperty(Prop.FONTNAME,typeface);
        setProperty(Prop.FONTSIZE,size);
        setProperty(Prop.FONTCOLOR,color);
        setProperty(Prop.FONTSTYLE,style);
        return this;
    }
    
    /**
     * Set page positioning and size
     * 
     * @param x
     * @param y
     * @param width
     * @param height
     * @return
     */
    public ClarionReport setAt(Integer x,Integer y,Integer width,Integer height)
    {
        setProperty(Prop.XPOS,x);
        setProperty(Prop.YPOS,y);
        setProperty(Prop.WIDTH,width);
        setProperty(Prop.HEIGHT,height);
        return this;
    }

    /**
     * Set dimensions - thousanths of an inch
     * @return
     */
    public ClarionReport setThous()
    {
        setProperty(Prop.THOUS,1);
        return this;
    }

    /**
     * Set dimensions - thousanths of an inch
     * @return
     */
    public ClarionReport setMM()
    {
        setProperty(Prop.MM,1);
        return this;
    }
    
    /**
     * Set report title - i.e what ends up in report job spool
     * @param text
     * @return
     */
    public ClarionReport setText(String text)
    {
        setProperty(Prop.TEXT,text);
        return this;
    }

    /**
     * Set landscape printing
     * @return
     */
    public ClarionReport setLandscape()
    {
        setProperty(Prop.LANDSCAPE,true);
        return this;
    }

    /**
     * Set paper type
     * 
     * @param type
     * @param width
     * @param height
     * @return
     */
    public ClarionReport setPaper(Integer type,Integer width,Integer height)
    {
        setProperty(Propprint.PAPER,type);
        setProperty(Propprint.PAPERWIDTH,width);
        setProperty(Propprint.PAPERHEIGHT,height);
        return this;
    }
    
    private ClarionQueue preview; 

    /**
     * Set buffer we want to write preview results (in .wmf format) into. Dunno if we actually want
     * to physically write files to file system.
     */
    public ClarionReport setPreview(ClarionQueue queue)
    {
        this.preview=queue;
        return this;
    }
    
    public ClarionQueue getPreview()
    {
        return this.preview;
    }

    private OpenReport open;
    
    /**
     * Open report - start print job
     * 
     */
    public void open()
    {
        open=new OpenReport(this);
        this.addListener(open);
    }
    
    public OpenReport getOpenReport()
    {
        return open;
    }
    
    private QueuePrintBook previewBook;
    
    public QueuePrintBook getPreviewBook()
    {
        if (previewBook==null && preview!=null) {
            previewBook=new QueuePrintBook(preview);
        }
        return previewBook;
    }
    
    public void printByAnyMeans()
    {
        if (open!=null) {
            close();
            return;
        }
        if (getPreviewBook()!=null) { 
        	ClarionPrinter.getInstance().print(this,getPreviewBook());
            previewBook=null;
        }
    }
    
    public String getPDF()
    {
        if (open!=null) {
            return "print:/"+CMemory.address(open.getBook());
        }
        
        if (getPreviewBook()!=null) {
            return "print:/"+CMemory.address(getPreviewBook());
        }
        
        return null;
    }

    
    public String writePDF()
    {
        String name = getPDF();
        try {
            ClarionRandomAccessFile cff;
            cff = FileFactoryRepository.getInstance().getRandomAccessFile(name);
            if (cff==null) return "";
            MemoryFile mf = new MemoryFile(cff);    // within constructor file has been read and stored into payload.
            int sz = mf.getPayload().getSize();     // payload=new MemoryFileSystem();
            log.fine(" pdf size "+sz);
            mf.getPayload().writeToFile("temp.pdf"); 
            return "";
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }
    
    public String previewPDF()
    {
        String name = getPDF();
        try {
            ClarionRandomAccessFile cff;
            cff = FileFactoryRepository.getInstance().getRandomAccessFile(name);
            if (cff==null) return "";
            MemoryFile mf = new MemoryFile(cff);    // within constructor file has been read and stored into payload.
            int sz = mf.getPayload().getSize();     // payload=new MemoryFileSystem();
            log.fine(" pdf size "+sz);
            byte[] buf = new byte[sz];
            mf.getPayload().read(0,buf,0,sz); 
            new PDFPreviewer(buf).run();
            return "";
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }
    
    
    
    
    public void cancelPrint()
    {
        if (open==null) return;
        CWin.closeTarget(this);
        this.removeListener(open);
        open=null;
    }
    
    /**
     * Close report - finish print job
     */
    public void close()
    {
        previewBook=null;
        if (open==null) return;
        if (preview!=null) {
            if (isProperty(Prop.FLUSHPREVIEW)) {
                open.print();
                setProperty(Prop.FLUSHPREVIEW,false);
            }
            preview.free();
        } else {
            open.print();
        }
        CWin.closeTarget(this);
        this.removeListener(open);
        open=null;
    }

    /**
     * force end of page
     */
    public void endPage()
    {
        if (open!=null) {
            open.pageBreak();
        }
    }
    
    public void print(ReportDetail detail)
    {
        open.print(detail);
    }

    @Override
    public ReportFooter getFooter() {
        for (AbstractControl ac : getControls() ) {
            if (ac instanceof ReportFooter) {
                return (ReportFooter)ac;
            }
        }
        return null;
    }

    @Override
    public ReportHeader getHeader() {
        for (AbstractControl ac : getControls() ) {
            if (ac instanceof ReportHeader) {
                return (ReportHeader)ac;
            }
        }
        return null;
    }

    public ReportForm getForm() {
        for (AbstractControl ac : getControls() ) {
            if (ac instanceof ReportForm) {
                return (ReportForm)ac;
            }
        }
        return null;
    }
    
    @Override
    public ReportContainer getContainer() {
        return null;
    }

    @Override
    public ClarionReport getReport() {
        return this;
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
    }

	@Override
	protected void notifyLocalChange(int indx, ClarionObject value) {
		if (indx==Prop.PREVIEW) {
			if (value==null) {
				preview=null;
			} else {
				if (value.getOwner()!=null && value.getOwner() instanceof ClarionQueue) {
					preview=(ClarionQueue)value.getOwner();
				}
			}
			if (open!=null) {
				open.initReportPreview();
			}
		}
		super.notifyLocalChange(indx, value);
	}

	
// robertsp pdf previewer
	
	
	
	
	
	
	
	
	
    
}
