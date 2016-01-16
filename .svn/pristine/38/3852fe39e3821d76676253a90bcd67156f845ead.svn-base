package org.jclarion.clarion.runtime;

import java.io.File;

import junit.framework.TestCase;

public class JavaSysConfigTest extends TestCase
{
	public void testRead()
	{
		assertEquals("Sun Microsystems Inc.",CConfigStore.getProperty("java","specification.vendor","","java-syscfg.properties"));
		assertEquals("",CConfigStore.getProperty("java","specification.vendorx","","java-syscfg.properties"));
	}

	public void testUpdate()
	{
		System.clearProperty("test.property");
		assertEquals("",CConfigStore.getProperty("test","property","","java-syscfg.properties"));
		assertNull(System.getProperty("test.property"));
		CConfigStore.setProperty("test","property","Y","java-syscfg.properties");
		assertEquals("Y",CConfigStore.getProperty("test","property","","java-syscfg.properties"));
		assertEquals("Y",System.getProperty("test.property"));

		System.clearProperty("test.property");
		assertNull(System.getProperty("test.property"));
		CConfigStore.__unitTestReset();
		assertEquals("Y",CConfigStore.getProperty("test","property","","java-syscfg.properties"));
		assertEquals("Y",System.getProperty("test.property"));

		System.clearProperty("test.property");
		assertNull(System.getProperty("test.property"));
		CConfigStore.__unitTestReset();
		(new File("java-syscfg.properties")).delete();
		assertEquals("",CConfigStore.getProperty("test","property","","java-syscfg.properties"));
		assertNull(System.getProperty("test.property"));
	}
}
