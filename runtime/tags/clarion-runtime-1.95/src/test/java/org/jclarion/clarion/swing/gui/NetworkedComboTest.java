
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.ComboTest;
public class NetworkedComboTest extends ComboTest
{
	public NetworkedComboTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	