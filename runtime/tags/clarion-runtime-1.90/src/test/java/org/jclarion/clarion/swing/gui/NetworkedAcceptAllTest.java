
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.AcceptAllTest;
public class NetworkedAcceptAllTest extends AcceptAllTest
{
	public NetworkedAcceptAllTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	