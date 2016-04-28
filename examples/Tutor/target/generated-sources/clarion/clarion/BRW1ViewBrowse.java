package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse extends ClarionView
{

	public BRW1ViewBrowse()
	{
		setTable(Main.customer);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.custnumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.company}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.firstname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.lastname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.address}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.city}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.state}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customer.zipcode}));
	}
}
