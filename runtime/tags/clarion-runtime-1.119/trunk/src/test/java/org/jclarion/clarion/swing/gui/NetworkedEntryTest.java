
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.EntryTest;
public class NetworkedEntryTest extends EntryTest
{
	public NetworkedEntryTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	