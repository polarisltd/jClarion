package org.jclarion.clarion.test;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

import org.jclarion.clarion.control.ReportForm;
import org.jclarion.clarion.print.Page;
import org.jclarion.clarion.print.PrintElement;
import org.jclarion.clarion.print.PrintObject;
import org.jclarion.clarion.print.TextElement;
import org.jclarion.clarion.print.text.Column;
import org.jclarion.clarion.print.text.ColumnList;
import org.jclarion.clarion.print.text.TEComparator;
import org.jclarion.clarion.runtime.format.NumberFormat;

public class PageToText {

	public PageToText()
	{
	}
	
	public void extract(Page p)
	{
		ColumnList list = new ColumnList();
		
		for (PrintObject po : p.getPrintObjects() ) {
			if (po.getControl() instanceof ReportForm) continue;
			for (PrintElement pe : po.getElements() ) {
				if (!(pe instanceof TextElement)) continue;
				TextElement te = (TextElement)pe;
				if (te.getText().length()==0) continue;
				Column k = new Column(po,te);
				list.add(k);
			}
		}

		list.finish();
		
		for (PrintObject po : p.getPrintObjects() ) {
				
			if (po.getControl() instanceof ReportForm) continue;
				
			String cols[]=new String[32];
			int len=0;
			int ypos=0;

			TreeSet<TextElement> telist = new TreeSet<TextElement>(new TEComparator());
				
			for (PrintElement pe : po.getElements() ) {
				if (!(pe instanceof TextElement)) continue;
				TextElement te = (TextElement)pe;
				if (te.getText().length()==0) continue;
				telist.add(te);
			}
			
			for (TextElement te : telist) {
				int y = te.getDimension().y;
				Column c = new Column(po,te);
					
				if (y/50 != ypos) {
					ypos=y/50;
					writeLine(cols,len);
					len=0;
				}
	
				int xpos = list.getPosition(c);
					
				if (cols.length<=xpos) {
					int k  =cols.length;
					while (k<=xpos) {
						k=k<<1;
					}
					String nc[]=new String[k];
					System.arraycopy(cols,0,nc,0,len);
					cols=nc;
				}
				while (len<xpos) {
					cols[len++]=null;
				}
					
				String text = te.getText();
				if (te.getFormatter()!=null && te.getFormatter() instanceof NumberFormat) {
					text=te.getUnformattedText();
				}
				
				if (len==xpos) {
					cols[len++]=text;
				} else {
					if (text.length()>0) {
						if (cols[xpos]==null || cols[xpos].length()==0) {
							cols[xpos]=text;
						} else {
							cols[xpos]=cols[xpos]+text;								
						}
					}
				}
				writeLine(cols,len);				
			}
		}
	}

	private List<String[]> lines=new ArrayList<String[]>();
	
	private void writeLine(String[] cols, int len) 
	{
		String n[] = new String[len];
		System.arraycopy(cols,0,n,0,len);
		lines.add(n);
	}
	
	public List<String[]> getLines()
	{
		return lines;
	}
}
