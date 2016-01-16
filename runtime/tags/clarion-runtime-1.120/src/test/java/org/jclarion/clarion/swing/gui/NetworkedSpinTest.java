
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.SpinTest;
public class NetworkedSpinTest extends SpinTest
{
	public NetworkedSpinTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	