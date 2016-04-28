package clarion.invoi002;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class ProcessView_3 extends ClarionView
{

	public ProcessView_3()
	{
		setTable(Main.orders);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.custnumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.ordernumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipaddress1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipaddress2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipcity}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipstate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shiptoname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipzip}));
	}
}
