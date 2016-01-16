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

import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionPrinter;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CWin;

public class QueuePrintBook extends PageBook 
{
    private ClarionQueue queue;

    public QueuePrintBook(ClarionQueue queue)
    {
        this.queue=queue;
    }
    
    @Override
    public Page getPage(int page) {
        this.queue.get(page+1);
        return (Page)CMemory.resolveAddress(Integer.parseInt(queue.what(1).toString().trim().substring(7)));
    }

    @Override
    public int getPageCount() {
        return this.queue.records();
    }
    
    public void print(String jobname)
    {
        init();
        PrinterJob job = ClarionPrinter.getInstance().getJob();
        job.setPageable(this);
        job.setJobName(jobname);
        try {
            job.print();
        } catch (PrinterException e) {
            e.printStackTrace();
            ClarionPrinter.getInstance().notePrintFailure(job);
            CWin.message(
                    Clarion.newString("Print Job Failed\n"+e.getMessage()),
                    Clarion.newString("Print Error"),
                    Icon.HAND);
        }
        finish();
    }
}
