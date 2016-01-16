
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.ImageTest;
public class NetworkedImageTest extends ImageTest
{
	public NetworkedImageTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	