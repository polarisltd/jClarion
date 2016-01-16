package org.jclarion.clarion.ide.model;
import java.io.FileNotFoundException;
import java.io.FileReader;

import junit.framework.TestCase;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Color;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.ide.Compiler;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;


public class PropertyObjectNavigatorTest extends TestCase
{

	private AbstractTarget window;

	public void setUp() throws FileNotFoundException
	{
		window=(new Compiler()).compile(new FileReader("test/res/window.inc"));
		ExtendProperties ep = new ExtendProperties(window);
		window.setExtend(ep);
		ep.setUsevar("window");
	}
	
	public void testColor()
	{
		PropertyObject po = getUse(window,"?HeaderString");
		assertEquals(Color.BLUE,po.getProperty(Prop.FILLCOLOR).intValue());
		assertTrue(po.isProperty(Prop.CENTER));
	}
	
	public void testPrevious() {
		assertPrevious("?HeaderString:Top","?window",0);
		assertPrevious("?HeaderString",null,0);
		assertPrevious("?Sheet1","?window",1);
		assertPrevious("?Tab1",null,0);
		assertPrevious("?GroupSimple:1","?window",2);
		assertPrevious("?ButtonSimple:1","?Tab1",0);
		assertPrevious("?GroupSimple:2","?GroupSimple:1",1);
		assertPrevious("?amount:1","?GroupMulti:1",0);
		assertPrevious("?Tab2","?Sheet1",0);
		assertPrevious("?GroupMulti:1","?Tab1",9);
	}

	public void testNext() {
		assertNext("?HeaderString","?window",2);
		assertNext("?HeaderString:Top","?Tab1",0);
		assertNext("?Sheet1",null,0);
		assertNext("?Tab1","?Sheet1",2);
		assertNext("?GroupSimple:1","?GroupSimple:2",0);
		assertNext("?ButtonSimple:1","?Tab1",1);
		assertNext("?BOTTOM:1","?Tab2",0);
		assertNext("?Tab2",null,0);
		assertNext("?method:4","?GroupMulti:4",2);
		assertNext("?amount:4","?Tab2",4);
	}
	
	private void assertPrevious(String from, String parent, int i) 
	{
		PropertyObject p_from = from==null ? null : getUse(window,from);
		PropertyObject p_to = parent==null ? null : getUse(window,parent);
		
		PropertyObjectNavigator n = new PropertyObjectNavigator();
		n.set(p_from);
		n.previous();
		assertSame(p_to,n.getObject());
		assertEquals(i,n.getIndex());
	}
	
	private void assertNext(String from, String parent, int i) 
	{
		PropertyObject p_from = from==null ? null : getUse(window,from);
		PropertyObject p_to = parent==null ? null : getUse(window,parent);
		
		PropertyObjectNavigator n = new PropertyObjectNavigator();
		n.set(p_from);
		n.next();
		assertSame(p_to,n.getObject());
		assertEquals(i,n.getIndex());
	}
	
	
	private PropertyObject getUse(PropertyObject scan,String use)
	{
		if (scan.getExtend()==null) {
			return null;
		}
		String usevar=((ExtendProperties)scan.getExtend()).getUsevar();
		if ( use.equals(usevar)) {
			return scan;
		}
		
		for (PropertyObject child : scan.getChildren()) {
			PropertyObject test = getUse(child,use);
			if (test!=null) return test;
		}
		return null;
	}

}
