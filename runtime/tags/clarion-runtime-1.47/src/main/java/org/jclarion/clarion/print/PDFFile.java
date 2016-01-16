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

import java.awt.print.PageFormat;
import java.io.FileOutputStream;
import java.io.IOException;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.util.SharedOutputStream;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.PageSize;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfWriter;

public class PDFFile extends ClarionRandomAccessFile 
{
    private byte[] pdf;
    private int seekpos;
    private String name;

    public static void save(ClarionReport r,String out)
    {
        PDFFile f = new PDFFile(r,true);
        try {
            FileOutputStream fos = new FileOutputStream(out);
            fos.write(f.pdf);
            fos.close();
        } catch (IOException ex) {}
    }
    
    private PDFFile(ClarionReport r,boolean preview) {        
        generate(r.getOpenReport(),r.getPreviewBook());
    }

    public PDFFile(ClarionReport r) {
        name=r.getProperty(Prop.TEXT).toString().trim();
        generate(r.getOpenReport(),r.getOpenReport().getBook());
    }

    public PDFFile(String file) {
        name=file;
        int page = Integer.parseInt(file.trim().substring(7));
        Object o = CMemory.resolveAddress(page);
        PageBook book=null;;
        OpenReport or=null;
        if (o instanceof OpenReport) {
            or = (OpenReport)o;
            book=or.getBook();
        }
        if (o instanceof PageBook) {
            book=(PageBook)o;
        }
        if (o instanceof Page) {
            book=((Page)o).getBook();
        }
        generate(or,book);
    }
    
    public void generate(OpenReport or, PageBook book)
    {
        pdf=book.getCachedPDF();
        if (pdf!=null) {
            seekpos=0;
            return;
        }
        
        Rectangle portrait = PageSize.A4;
        Rectangle landscape = portrait.rotate();
        SharedOutputStream sos = new SharedOutputStream();

        Document document = new Document();
        try {
            PdfWriter writer = PdfWriter.getInstance(document,sos);
            document.open();
            
            boolean any=false;
            for (int scan=0;scan<book.getPageCount();scan++) {
                Page p = book.getPage(scan);
                if (p.isDeleted()) continue;

                if (p.getOrientation()==PageFormat.PORTRAIT) {
                    document.setPageSize(portrait);
                } else {
                    document.setPageSize(landscape);
                }
                document.newPage();
                
                if (!any) {
                    if (or!=null && !or.isInit()) {
                        or.init(new PdfPrintContext(document,writer.getDirectContent()));
                    }
                }
                p.print(new PdfPrintContext(document,writer.getDirectContent()));
                any=true;
            }
            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        
        pdf = sos.toByteArray();
        seekpos = 0;
        book.cachePDF(pdf);
    }

    @Override
    public void close() throws IOException {
    }

    @Override
    public long length() throws IOException {
        return pdf.length;
    }

    @Override
    public int read(byte[] get_buffer, int ofs, int len) throws IOException {
        if (seekpos == pdf.length)
            return -1;

        if (seekpos + len > pdf.length) {
            len = pdf.length - seekpos;
        }
        if (len <= 0)
            return len;
        System.arraycopy(pdf, seekpos, get_buffer, ofs, len);
        seekpos += len;
        return len;
    }

    @Override
    public void seek(long l) throws IOException {
        seekpos = (int) l;
    }

    @Override
    public void write(byte[] bytes, int i, int size) throws IOException {
        throw new IOException("Not supported");
    }
    
    public byte[] getPDFFile()
    {
        return pdf; 
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public long position() throws IOException {
        return seekpos;
    }
}
