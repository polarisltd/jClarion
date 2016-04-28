package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse_2 extends ClarionView
{

	public BRW1ViewBrowse_2()
	{
		setTable(Main.orders);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.orderNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.orderDate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.orderNote}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipToName}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipAddress1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipAddress2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipCity}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipState}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.shipZip}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.invoiceNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.orders.custNumber}));
	}
}
