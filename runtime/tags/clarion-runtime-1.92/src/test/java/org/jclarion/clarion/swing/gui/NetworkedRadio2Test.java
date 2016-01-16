
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.Radio2Test;
public class NetworkedRadio2Test extends Radio2Test
{
	public NetworkedRadio2Test(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	