
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.RadioTest;
public class NetworkedRadioTest extends RadioTest
{
	public NetworkedRadioTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	