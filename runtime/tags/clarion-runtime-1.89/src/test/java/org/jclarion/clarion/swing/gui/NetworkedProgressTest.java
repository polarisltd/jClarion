
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.ProgressTest;
public class NetworkedProgressTest extends ProgressTest
{
	public NetworkedProgressTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	