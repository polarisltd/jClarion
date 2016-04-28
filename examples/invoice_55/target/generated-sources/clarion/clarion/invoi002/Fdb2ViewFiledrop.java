package clarion.invoi002;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Fdb2ViewFiledrop extends ClarionView
{

	public Fdb2ViewFiledrop()
	{
		setTable(Main.orders);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.invoicenumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.orderdate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shiptoname}));
	}
}
