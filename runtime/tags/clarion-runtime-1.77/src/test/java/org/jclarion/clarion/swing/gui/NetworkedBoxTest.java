
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.BoxTest;
public class NetworkedBoxTest extends BoxTest
{
	public NetworkedBoxTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	