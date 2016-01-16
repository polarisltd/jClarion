package org.jclarion.clarion.runtime;

import java.io.File;

import junit.framework.TestCase;

public class JavaSysConfigTest extends TestCase
{
	public void testRead()
	{
		assertEquals("Sun Microsystems Inc.",CConfig.getProperty("java","specification.vendor","","java-syscfg.properties"));
		assertEquals("",CConfig.getProperty("java","specification.vendorx","","java-syscfg.properties"));
	}

	public void testUpdate()
	{
		System.clearProperty("test.property");
		assertEquals("",CConfig.getProperty("test","property","","java-syscfg.properties"));
		assertNull(System.getProperty("test.property"));
		CConfig.setProperty("test","property","Y","java-syscfg.properties");
		assertEquals("Y",CConfig.getProperty("test","property","","java-syscfg.properties"));
		assertEquals("Y",System.getProperty("test.property"));

		System.clearProperty("test.property");
		assertNull(System.getProperty("test.property"));
		CConfig.__unitTestReset();
		assertEquals("Y",CConfig.getProperty("test","property","","java-syscfg.properties"));
		assertEquals("Y",System.getProperty("test.property"));

		System.clearProperty("test.property");
		assertNull(System.getProperty("test.property"));
		CConfig.__unitTestReset();
		(new File("java-syscfg.properties")).delete();
		assertEquals("",CConfig.getProperty("test","property","","java-syscfg.properties"));
		assertNull(System.getProperty("test.property"));
	}
}
