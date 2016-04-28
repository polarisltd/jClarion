package org.jclarion.clarion.util;

import java.awt.Dimension;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.swing.JFrame;
import javax.swing.JPanel;
import org.apache.pdfbox.pdfviewer.PDFPagePanel;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.interactive.action.type.PDActionGoTo;
import org.apache.pdfbox.pdmodel.interactive.documentnavigation.destination.PDPageXYZDestination;



public class PDFPreviewer {
    String path;
    byte[] buf;
    public static void main(String[] args) throws IOException{
        // Get a file from the command line to open
        System.out.println(args.length);
        new PDFPreviewer(args[0]).run();

    }

public PDFPreviewer(String path){ 
    this.path = path;
}
public PDFPreviewer(byte[] buf){ 
    this.buf = buf;
}

    
public void run() throws IOException{    

final PDDocument inputPDF=loadDoc();	
List<PDPage> allPages = inputPDF.getDocumentCatalog().getAllPages();





PDPage testPage = (PDPage)allPages.get(0);

//
PDPageXYZDestination dest = new PDPageXYZDestination();
dest.setPageNumber(0);
dest.setZoom(1);
dest.setTop(new Float(PDPage.PAGE_SIZE_LETTER.getHeight()).intValue());
//testPage.get


//
JFrame testFrame = new JFrame();
//testFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

testFrame.addWindowListener(new java.awt.event.WindowAdapter() {
    @Override
    public void windowClosing(java.awt.event.WindowEvent windowEvent) {
        try{
         System.out.println("closing pdf");   
         inputPDF.close(); 
         // System.exit(0);  we shouldnt close app!
        }catch(Exception ioe){}
    }
});
/*
PDFBox indicates zooming is capable using PDPageXYZDestination, however I'm really struggling to make it work. 
An example would be helpful, including where to make calls to this class. 
The following was posted in another thread, however there's no indicator of exactly where to put this code:

   PDPageXYZDestination dest = new PDPageXYZDestination();
    dest.setPageNumber(0);
    dest.setZoom(1);
    dest.setTop(new Float(PDPage.PAGE_SIZE_LETTER.getHeight()).intValue());
    PDActionGoTo action = new PDActionGoTo();
    action.setDestination(dest);    
    document.getDocumentCatalog().setOpenAction(action);`
  
  
  
PDDocument document = null;
            try
            {
                document = PDDocument.load( args[0] );
                if( document.isEncrypted() )
                {
                    System.err.println( "Error: Cannot add bookmark destination to encrypted documents." );
                    System.exit( 1 );
                }

                List pages = document.getDocumentCatalog().getAllPages();
                if( pages.size() < 2 )
                {
                    throw new IOException( "Error: The PDF must have at least 2 pages.");
                }
                PDDocumentOutline bookmarks = document.getDocumentCatalog().getDocumentOutline();
                if( bookmarks == null )
                {
                    throw new IOException( "Error: The PDF does not contain any bookmarks" );
                }
                PDOutlineItem item = bookmarks.getFirstChild().getNextSibling();
                PDDestination dest = item.getDestination();
                PDActionGoTo action = new PDActionGoTo();
                action.setDestination(dest);
                document.getDocumentCatalog().setOpenAction(action);

                document.save( args[1] );
            }
            finally
            {
                if( document != null )
                {
                    document.close();
                }
            }  
  
  
 
*/

PDFPagePanel pdfPanel = new PDFPagePanel();
pdfPanel.setPage(testPage);
Dimension d = new Dimension(400,200);
pdfPanel.setSize(d);
testFrame.add(pdfPanel);
testFrame.setBounds(40, 40, pdfPanel.getWidth(), pdfPanel.getHeight());
testFrame.setVisible(true);    
}    

PDDocument loadDoc() throws IOException{
   if(path!=null){	
	  File pdfPath = new File(path);
	  return PDDocument.load(pdfPath);
	}else if(buf!=null){
	  InputStream is = new ByteArrayInputStream(buf);
	  return PDDocument.load(is,true);
	}else
       return null;
}



    
}
