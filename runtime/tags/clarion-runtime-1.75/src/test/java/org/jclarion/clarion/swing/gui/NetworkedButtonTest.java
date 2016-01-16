
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.ButtonTest;
public class NetworkedButtonTest extends ButtonTest
{
	public NetworkedButtonTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	