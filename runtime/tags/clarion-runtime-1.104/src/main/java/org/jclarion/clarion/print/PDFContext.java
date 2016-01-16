package org.jclarion.clarion.print;

import java.awt.Image;
import java.util.HashMap;
import java.util.Map;

import com.lowagie.text.Document;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfWriter;

public class PDFContext {
	
	public Document document;
	public PdfContentByte cb;
	public PdfWriter writer;
	public Map<java.awt.Image,com.lowagie.text.Image> cache=new HashMap<Image, com.lowagie.text.Image>();

	public PDFContext(Document document, PdfWriter writer) 
	{
		this.document=document;
		this.writer=writer;
		this.cb=writer.getDirectContent();
	}
}
