package org.jclarion.clarion;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import junit.framework.TestCase;

import org.jclarion.clarion.runtime.CError;
import org.mortbay.jetty.Connector;
import org.mortbay.jetty.Request;
import org.mortbay.jetty.Server;
import org.mortbay.jetty.handler.AbstractHandler;
import org.mortbay.jetty.nio.SelectChannelConnector;


public class ClarionHttpAsciiFileTest extends TestCase 
{

    public class TestFile extends ClarionAsciiFile
    {
        public ClarionString f1=Clarion.newString(10);
        public ClarionString f2=Clarion.newString(10);
        public ClarionString f3=Clarion.newString(10);
        public ClarionString f4=Clarion.newString(10);
        
        public TestFile()
        {
            addVariable("f1",f1);
            addVariable("f2",f2);
            addVariable("f3",f3);
            addVariable("f4",f4);
        }
    }
    
    private Server server;
    

    private String response;
    //private String request;
    
    public void initServer() throws Exception
    {
        server=new Server();
        Connector connector = new SelectChannelConnector();
        connector.setHost("localhost");
        connector.setPort(8200);
        server.addConnector(connector);
        server.setHandler(new AbstractHandler() {
            @Override
            public void handle(String url, HttpServletRequest req,
                    HttpServletResponse resp, int arg3) throws IOException,
                    ServletException 
            {
                if (response!=null) {
                    resp.setContentType("text/plain");
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write(response);
                    ((Request)req).setHandled(true);
                 }
            } });
        server.start();        
    }

    
    private ClarionFile file;

    public void tearDown() throws IOException
    {
        if (file!=null) {
            file.close();
        }

        try {
            if (server!=null) {
                server.stop();
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void testSimple() throws Exception
    {
        initServer();
        
        TestFile file =new TestFile();
        this.file=file;
        file.setName("http://localhost:8200/mainframe");
        response=
            "f123456789f123456789f123456789f123456789\n"+
            "Hello     Big       Wide      World\n";
        file.open();
        assertEquals(0,CError.errorCode());
        
        
        file.set();
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("f123456789",file.f1.toString().trim());
        assertEquals("f123456789",file.f2.toString().trim());
        assertEquals("f123456789",file.f3.toString().trim());
        assertEquals("f123456789",file.f4.toString().trim());

        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Hello",file.f1.toString().trim());
        assertEquals("Big",file.f2.toString().trim());
        assertEquals("Wide",file.f3.toString().trim());
        assertEquals("World",file.f4.toString().trim());

        file.next();
        assertEquals(33,CError.errorCode());
        
        file.set();
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("f123456789",file.f1.toString().trim());
        assertEquals("f123456789",file.f2.toString().trim());
        assertEquals("f123456789",file.f3.toString().trim());
        assertEquals("f123456789",file.f4.toString().trim());

        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Hello",file.f1.toString().trim());
        assertEquals("Big",file.f2.toString().trim());
        assertEquals("Wide",file.f3.toString().trim());
        assertEquals("World",file.f4.toString().trim());
    }

    private String content[] = {
            "Bouncy Bouncy, Oh such a good time.",
            "Bouncy Bouncy, Shoes all in a line.",
            "Bouncy Bouncy, Everybody summersault, summersault.",
            "Summertime, Everybody sing along.",
            "Bouncy Bouncy, oh such a good time.",
            "Bouncy Bouncy, White socks slipping down.",
            "Bouncy Bouncy, Styletos are a no no.",
            "Bouncy Bouncy oh, Bouncy Bouncy oh.",
            "Everytime i bounce i feel i could touch the skyee"
    };

    ClarionString line;

    public void testMissingFile() throws Exception
    {
        initServer();
        
        file =new ClarionAsciiFile();
        line = new ClarionString();
        file.addVariable("line",line);
        file.setName("http://localhost:8200/404.html");
        response=null;
        file.open();
        assertEquals(2,CError.errorCode());
    }
    
    public void testComplexRandomAccess() throws Exception
    {
        initServer();
        
        file =new ClarionAsciiFile();
        line = new ClarionString();
        file.addVariable("line",line);
        file.setName("http://localhost:8200/crimpGenerator.php");
        StringBuilder build=new StringBuilder();
        for (int scan=0;scan<70000;scan++) {
            build.append(content[scan%content.length]).append("\n");
        }
        response=build.toString();
        file.open();
        assertEquals(0,CError.errorCode());
        

        file.set();
        assertEquals(0,CError.errorCode());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Bouncy Bouncy, Oh such a good time.",line.toString());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Bouncy Bouncy, Shoes all in a line.",line.toString());
        
        file.set();
        assertEquals(0,CError.errorCode());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Bouncy Bouncy, Oh such a good time.",line.toString());
        file.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Bouncy Bouncy, Shoes all in a line.",line.toString());

        file.set();
        assertEquals(0,CError.errorCode());
        
        
        ClarionString pos[];
        
        pos=new ClarionString[70000];
        for (int scan=0;scan<pos.length;scan++) {
            file.next();
            assertEquals(0,CError.errorCode());
            assertEquals(""+scan,content[scan%content.length],line.toString());
            pos[scan]=file.getPosition();
        }

        // test full range
        testRandomRange(1000,0,70000,pos);

        // Operate in a constrained range of <6k
        testRandomRange2(1000,6*1024/358,pos);

        // Operate in a constrained range of <12k
        testRandomRange2(1000,2*1024/358,pos);

        // Operate in a constrained range of <24k
        testRandomRange2(1000,4*1024/358,pos);

        // Operate in a constrained range of <40k
        testRandomRange2(1000,40*1024/358,pos);
        
        
    }
    
    Random r = new Random();
    
    private void testRandomRange2(int count,int upper, ClarionString[] pos) 
    {
        testRandomRange(count,0,upper,pos);
        testRandomRange(count,upper/2,upper*3/2,pos);
        testRandomRange(count,upper,upper*2,pos);
        testRandomRange(count,upper*2,upper*3,pos);
    }

    private void testRandomRange(int count, int lower, int upper, ClarionString[] pos) 
    {
        for (int scan=0;scan<count;scan++) {
            int idx = r.nextInt(upper-lower)+lower;
            file.reget(pos[idx]);
            assertEquals(""+scan,0,CError.errorCode());
            assertEquals(""+scan,content[idx%content.length],line.toString());
        }
    }
    
}
