package clarion.invoi001;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw1ViewBrowse_3 extends ClarionView
{

	public Brw1ViewBrowse_3()
	{
		setTable(Main.customers);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.firstname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.mi}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.lastname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.company}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.state}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.zipcode}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.address1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.address2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.city}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.phonenumber}));
	}
}
