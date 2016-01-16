
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.MessageTest;
public class NetworkedMessageTest extends MessageTest
{
	public NetworkedMessageTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	