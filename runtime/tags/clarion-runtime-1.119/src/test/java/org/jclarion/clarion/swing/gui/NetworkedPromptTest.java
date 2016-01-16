
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.PromptTest;
public class NetworkedPromptTest extends PromptTest
{
	public NetworkedPromptTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	