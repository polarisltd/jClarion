package clarion.invoi002;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class ProcessView extends ClarionView
{

	public ProcessView()
	{
		setTable(Main.customers);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.city}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.company}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.extension}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.firstname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.lastname}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.phonenumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.state}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.zipcode}));
	}
}
