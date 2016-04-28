package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class ProcessView_5 extends ClarionView
{

	public ProcessView_5()
	{
		setTable(Main.customers);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.address1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.address2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.city}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.company}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.extension}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.firstName}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.lastName}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.mi}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.phoneNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.state}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.customers.zipCode}));
	}
}
