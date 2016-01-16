
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.LineTest;
public class NetworkedLineTest extends LineTest
{
	public NetworkedLineTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	