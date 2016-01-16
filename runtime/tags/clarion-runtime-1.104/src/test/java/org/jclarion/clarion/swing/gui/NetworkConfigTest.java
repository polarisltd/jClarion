package org.jclarion.clarion.swing.gui;

import java.io.File;

import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CConfigStore;
import org.jclarion.clarion.swing.SwingTC;

public class NetworkConfigTest extends SwingTC
{
    public NetworkConfigTest(String name) {
		super(name);
	}

	public void setUp()  throws Exception
	{
	    CConfigStore.__unitTestReset();
	    
		createFactory=true;
		super.setUp();
        File f;
        f= new File("test.properties");
        f.delete();
        f = new File("remote-test.properties");
        f.delete();
	}

	public void tearDown()  throws Exception
	{
	    CConfigStore.__unitTestReset();
	    super.tearDown();
	}
	
	public void testConfig()
	{
		CConfigStore.setProperty("s1","k1","v1","test.properties");
		CConfigStore.setProperty("s2","k2","v2","test.properties");
		CConfigStore.setProperty("s2","k2","rv2","remote-test.properties");
		CConfigStore.setProperty("s3","k3","rv3","remote-test.properties");
		
		assertEquals("v1",CConfig.getProperty("s1","k1","","test.properties"));
		assertEquals("rv2",CConfig.getProperty("s2","k2","","test.properties"));
		assertEquals("rv3",CConfig.getProperty("s3","k3","","test.properties"));
		assertEquals("",CConfig.getProperty("s4","k4","","test.properties"));

		CConfig.setProperty("s4","k4","rv4","test.properties");
		waitForEventQueueToCatchup();
		
		assertEquals("",CConfigStore.getProperty("s4","k4","","test.properties"));
		assertEquals("rv4",CConfigStore.getProperty("s4","k4","","remote-test.properties"));
	}

	public void testConfigAgain()
	{
		testConfig();
	}
}
