package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse_3 extends ClarionView
{

	public BRW1ViewBrowse_3()
	{
		setTable(Main.customers);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.firstName}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.mi}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.lastName}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.company}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.state}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.zipCode}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.address1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.address2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.city}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.phoneNumber}));
	}
}
