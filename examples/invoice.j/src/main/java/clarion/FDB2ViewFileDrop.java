package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class FDB2ViewFileDrop extends ClarionView
{

	public FDB2ViewFileDrop()
	{
		setTable(Main.orders);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.invoiceNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.orderDate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipToName}));
	}
}
