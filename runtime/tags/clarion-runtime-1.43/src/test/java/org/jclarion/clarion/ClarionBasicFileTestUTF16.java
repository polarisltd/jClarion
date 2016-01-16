package org.jclarion.clarion;

import java.nio.ByteOrder;

public class ClarionBasicFileTestUTF16 extends ClarionBasicFileTest
{
    private String encoding;
    
    private String test= ByteOrder.nativeOrder()==ByteOrder.BIG_ENDIAN ? "UTF-16BE" : "UTF-16LE"; 
    
    public void setUp()
    {
        encoding=System.getProperties().getProperty("file.encoding");
        System.getProperties().setProperty("file.encoding",test);
        super.setUp();
    }

    public void tearDown()
    {
        super.tearDown();
        System.getProperties().setProperty("file.encoding",encoding);
    }
    
    protected String getCharSetName()
    {
        return test;
    }
    
}
