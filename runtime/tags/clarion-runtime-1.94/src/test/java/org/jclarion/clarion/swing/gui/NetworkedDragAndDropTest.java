
package org.jclarion.clarion.swing.gui;
import org.jclarion.clarion.swing.DragAndDropTest;
public class NetworkedDragAndDropTest extends DragAndDropTest
{
	public NetworkedDragAndDropTest(String name)
	{
		super(name);
	}

	public void setUp()  throws Exception
	{
		createFactory=true;
		super.setUp();
	}
}
	