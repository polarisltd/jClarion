package clarion.invoi001;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw1ViewBrowse_2 extends ClarionView
{

	public Brw1ViewBrowse_2()
	{
		setTable(Main.orders);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.ordernumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.orderdate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.ordernote}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shiptoname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipaddress1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipaddress2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipcity}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipstate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipzip}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.invoicenumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.custnumber}));
	}
}
