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

import java.io.FileOutputStream;

import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.constants.Paper;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.swing.SimpleComboQueue;

import junit.framework.TestCase;

public class QueuePrintBookTest extends TestCase {

    public void testMultiReport()
    {
        SimpleComboQueue myqueue = new SimpleComboQueue();
        
        ClarionReport p = new ClarionReport();
        p.setPaper(Paper.A4,null,null);
        p.setThous();
        p.setAt(1000,1000,6000,9000);
        p.setFont("Serif",12,null,null,null);
        p.setPreview(myqueue);
        ReportDetail pd = new ReportDetail();
        pd.setAt(0,0,null,null);
        pd.add((new BoxControl()).setAt(0,0,5500,1000));
        pd.add((new StringControl()).setText("Portrait").setAt(0,1100,null,null));
        p.add(pd);
                

        ClarionReport l = new ClarionReport();
        l.setPaper(Paper.A4,null,null);
        l.setThous();
        l.setAt(1000,1000,9000,6000);
        l.setFont("Serif",12,null,null,null);
        l.setPreview(myqueue);
        l.setLandscape();
        ReportDetail ld = new ReportDetail();
        ld.setAt(0,0,null,null);
        ld.add((new BoxControl()).setAt(0,0,8500,1000));
        ld.add((new StringControl()).setText("Landscape").setAt(0,1100,null,null));
        l.add(ld);

        p.open();
        pd.print();
        pd.print();
        p.endPage();
        pd.print();
        p.endPage();
        
        l.open();
        ld.print();
        l.endPage();
        l.cancelPrint();
        l.close();
        
        pd.print();
        p.endPage();
        p.cancelPrint();
        p.close();

        assertEquals(4,myqueue.records());
        
        QueuePrintBook qpb = new QueuePrintBook(myqueue);
        PDFFile pf = new PDFFile("print:/"+CMemory.address(qpb));
        assertTrue(pf.getPDFFile().length>0);
        
        try {
            FileOutputStream fos;
            fos = new FileOutputStream("test2.pdf");
            fos.write(pf.getPDFFile());
            fos.close();
        } catch (java.io.IOException e) {
            e.printStackTrace();
        }
        
        myqueue.free();
        p.open();
        pd.print();
        p.endPage();
        assertEquals(1,myqueue.records());
        p.close();
        assertEquals(0,myqueue.records());
    }
}
