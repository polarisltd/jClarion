
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.MenuTest;
public class NetworkedMenuTest extends MenuTest
{
	public NetworkedMenuTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	