
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.CheckTest;
public class NetworkedCheckTest extends CheckTest
{
	public NetworkedCheckTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	