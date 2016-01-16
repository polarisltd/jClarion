
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.ClarionApplicationTest;
public class NetworkedClarionApplicationTest extends ClarionApplicationTest
{
	public NetworkedClarionApplicationTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}	
}
	