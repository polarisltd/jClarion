package org.jclarion.clarion;

import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;

public class ClarionBasicFileTestUTF16ENC extends ClarionBasicFileTest
{
    private String encoding;
    
    private String test= "UTF-16"; 
    
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

    public void testThis()
    {
        Charset cs = Charset.forName("UTF-16");
        CharBuffer cb=CharBuffer.wrap(new char[0]);
        ByteBuffer bb=ByteBuffer.wrap(new byte[16]);
        cs.newEncoder().encode(cb,bb,false);
        System.out.println(bb.position());
    }
    
    protected String getCharSetName()
    {
        return test;
    }
    
}
