package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW2ViewBrowse extends ClarionView
{

	public BRW2ViewBrowse()
	{
		setTable(Main.orders);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.custnumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.ordernumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.invoiceamount}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.orderdate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.ordernote}));
	}
}
