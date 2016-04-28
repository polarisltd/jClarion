package clarion;

import clarion.Filemanager;
import clarion.Main;
import org.jclarion.clarion.Clarion;

public class HideAccessOrders extends Filemanager
{
	public HideAccessOrders()
	{
	}

	public void init()
	{
		this.init(Main.orders,Main.globalErrors);
		this.buffer=Main.orders;
		this.create.setValue(0);
		this.lockRecover.setValue(10);
		this.addKey(Main.orders.keyordernumber,Clarion.newString("ORD:KEYORDERNUMBER"),Clarion.newNumber(1));
		this.addKey(Main.orders.keycustnumber,Clarion.newString("ORD:KEYCUSTNUMBER"),Clarion.newNumber(0));
		Main.accessORDERS.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessORDERS.set(null);
	}
}
