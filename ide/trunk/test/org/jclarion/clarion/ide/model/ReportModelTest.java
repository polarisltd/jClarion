package org.jclarion.clarion.ide.model;

import java.io.FileNotFoundException;
import java.io.FileReader;

import junit.framework.TestCase;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.ide.Compiler;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;


public class ReportModelTest extends TestCase
{
	private AbstractTarget window;

	public void setUp() throws FileNotFoundException
	{
		window=(new Compiler()).compile(new FileReader("test/res/report.inc"));		
		ExtendProperties ep = ExtendProperties.get(window);
		window.setExtend(ep);
		ep.setUsevar("window");
	}
	
	public void testStructure()
	{
		System.out.println(window.getChildren());
	}

}
