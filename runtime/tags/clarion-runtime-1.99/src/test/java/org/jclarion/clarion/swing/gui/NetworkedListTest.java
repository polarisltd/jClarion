
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.ListTest;
public class NetworkedListTest extends ListTest
{
	public NetworkedListTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	