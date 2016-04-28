package clarion.invoibc0;

import clarion.Main;
import clarion.invoibc0.HideAccessCompany;
import clarion.invoibc0.HideAccessCustomers;
import clarion.invoibc0.HideAccessDetail;
import clarion.invoibc0.HideAccessInvhist;
import clarion.invoibc0.HideAccessOrders;
import clarion.invoibc0.HideAccessProducts;
import clarion.invoibc0.HideAccessStates;
import clarion.invoibc0.HideRelateCompany;
import clarion.invoibc0.HideRelateCustomers;
import clarion.invoibc0.HideRelateDetail;
import clarion.invoibc0.HideRelateInvhist;
import clarion.invoibc0.HideRelateOrders;
import clarion.invoibc0.HideRelateProducts;
import clarion.invoibc0.HideRelateStates;

@SuppressWarnings("all")
public class Invoibc0
{
	public static HideAccessStates hideAccessStates;
	public static HideRelateStates hideRelateStates;
	public static HideAccessCompany hideAccessCompany;
	public static HideRelateCompany hideRelateCompany;
	public static HideAccessProducts hideAccessProducts;
	public static HideRelateProducts hideRelateProducts;
	public static HideAccessInvhist hideAccessInvhist;
	public static HideRelateInvhist hideRelateInvhist;
	public static HideAccessDetail hideAccessDetail;
	public static HideRelateDetail hideRelateDetail;
	public static HideAccessOrders hideAccessOrders;
	public static HideRelateOrders hideRelateOrders;
	public static HideAccessCustomers hideAccessCustomers;
	public static HideRelateCustomers hideRelateCustomers;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		Main.__register_destruct(new Runnable() { public void run() { __static_destruct(); } });
		__static_init();
	}

	public static void __static_init() {
		hideAccessStates=new HideAccessStates();
		hideRelateStates=new HideRelateStates();
		hideAccessCompany=new HideAccessCompany();
		hideRelateCompany=new HideRelateCompany();
		hideAccessProducts=new HideAccessProducts();
		hideRelateProducts=new HideRelateProducts();
		hideAccessInvhist=new HideAccessInvhist();
		hideRelateInvhist=new HideRelateInvhist();
		hideAccessDetail=new HideAccessDetail();
		hideRelateDetail=new HideRelateDetail();
		hideAccessOrders=new HideAccessOrders();
		hideRelateOrders=new HideRelateOrders();
		hideAccessCustomers=new HideAccessCustomers();
		hideRelateCustomers=new HideRelateCustomers();
	}

	public static void __static_destruct() {
		Invoibc0.hideAccessStates.destruct();
		Invoibc0.hideAccessCompany.destruct();
		Invoibc0.hideAccessProducts.destruct();
		Invoibc0.hideAccessInvhist.destruct();
		Invoibc0.hideAccessDetail.destruct();
		Invoibc0.hideAccessOrders.destruct();
		Invoibc0.hideAccessCustomers.destruct();
	}


	public static void invoibc0Dctinit()
	{
		Main.relateStates=Invoibc0.hideRelateStates;
		Main.relateCompany=Invoibc0.hideRelateCompany;
		Main.relateProducts=Invoibc0.hideRelateProducts;
		Main.relateInvhist=Invoibc0.hideRelateInvhist;
		Main.relateDetail=Invoibc0.hideRelateDetail;
		Main.relateOrders=Invoibc0.hideRelateOrders;
		Main.relateCustomers=Invoibc0.hideRelateCustomers;
	}
	public static void invoibc0Dctkill()
	{
		Invoibc0.hideRelateStates.kill();
		Invoibc0.hideRelateCompany.kill();
		Invoibc0.hideRelateProducts.kill();
		Invoibc0.hideRelateInvhist.kill();
		Invoibc0.hideRelateDetail.kill();
		Invoibc0.hideRelateOrders.kill();
		Invoibc0.hideRelateCustomers.kill();
	}
	public static void invoibc0Filesinit()
	{
		Invoibc0.hideRelateStates.init();
		Invoibc0.hideRelateCompany.init();
		Invoibc0.hideRelateProducts.init();
		Invoibc0.hideRelateInvhist.init();
		Invoibc0.hideRelateDetail.init();
		Invoibc0.hideRelateOrders.init();
		Invoibc0.hideRelateCustomers.init();
	}
}
