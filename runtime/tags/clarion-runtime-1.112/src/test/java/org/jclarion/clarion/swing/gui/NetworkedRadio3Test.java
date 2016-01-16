
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.Radio3Test;
public class NetworkedRadio3Test extends Radio3Test
{
	public NetworkedRadio3Test(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	