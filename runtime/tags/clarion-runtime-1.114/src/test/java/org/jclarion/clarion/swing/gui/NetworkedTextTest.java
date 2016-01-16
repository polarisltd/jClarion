
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.TextTest;
public class NetworkedTextTest extends TextTest
{
	public NetworkedTextTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	