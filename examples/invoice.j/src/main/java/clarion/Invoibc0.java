package clarion;

import clarion.HideAccessCompany;
import clarion.HideAccessCustomers;
import clarion.HideAccessDetail;
import clarion.HideAccessInvhist;
import clarion.HideAccessOrders;
import clarion.HideAccessProducts;
import clarion.HideAccessStates;
import clarion.HideRelateCompany;
import clarion.HideRelateCustomers;
import clarion.HideRelateDetail;
import clarion.HideRelateInvhist;
import clarion.HideRelateOrders;
import clarion.HideRelateProducts;
import clarion.HideRelateStates;
import clarion.Main;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Invoibc0
{
	public static RefVariable<HideAccessStates> _hideAccessStates;
	public static RefVariable<HideRelateStates> _hideRelateStates;
	public static RefVariable<HideAccessCompany> _hideAccessCompany;
	public static RefVariable<HideRelateCompany> _hideRelateCompany;
	public static RefVariable<HideAccessProducts> _hideAccessProducts;
	public static RefVariable<HideRelateProducts> _hideRelateProducts;
	public static RefVariable<HideAccessInvhist> _hideAccessInvHist;
	public static RefVariable<HideRelateInvhist> _hideRelateInvHist;
	public static RefVariable<HideAccessDetail> _hideAccessDetail;
	public static RefVariable<HideRelateDetail> _hideRelateDetail;
	public static RefVariable<HideAccessOrders> _hideAccessOrders;
	public static RefVariable<HideRelateOrders> _hideRelateOrders;
	public static RefVariable<HideAccessCustomers> _hideAccessCustomers;
	public static RefVariable<HideRelateCustomers> _hideRelateCustomers;

	public static void iNVOIBC0DctInit()
	{
		Invoibc0._hideAccessStates.set(new HideAccessStates());
		Invoibc0._hideRelateStates.set(new HideRelateStates());
		Invoibc0._hideAccessCompany.set(new HideAccessCompany());
		Invoibc0._hideRelateCompany.set(new HideRelateCompany());
		Invoibc0._hideAccessProducts.set(new HideAccessProducts());
		Invoibc0._hideRelateProducts.set(new HideRelateProducts());
		Invoibc0._hideAccessInvHist.set(new HideAccessInvhist());
		Invoibc0._hideRelateInvHist.set(new HideRelateInvhist());
		Invoibc0._hideAccessDetail.set(new HideAccessDetail());
		Invoibc0._hideRelateDetail.set(new HideRelateDetail());
		Invoibc0._hideAccessOrders.set(new HideAccessOrders());
		Invoibc0._hideRelateOrders.set(new HideRelateOrders());
		Invoibc0._hideAccessCustomers.set(new HideAccessCustomers());
		Invoibc0._hideRelateCustomers.set(new HideRelateCustomers());
		Main.relateStates.set(Invoibc0._hideRelateStates.get());
		Main.relateCompany.set(Invoibc0._hideRelateCompany.get());
		Main.relateProducts.set(Invoibc0._hideRelateProducts.get());
		Main.relateInvHist.set(Invoibc0._hideRelateInvHist.get());
		Main.relateDetail.set(Invoibc0._hideRelateDetail.get());
		Main.relateOrders.set(Invoibc0._hideRelateOrders.get());
		Main.relateCustomers.set(Invoibc0._hideRelateCustomers.get());
	}
	public static void iNVOIBC0DctKill()
	{
		Invoibc0._hideRelateStates.get().kill();
		//Invoibc0._hideRelateStates.get();
		Invoibc0._hideRelateCompany.get().kill();
		//Invoibc0._hideRelateCompany.get();
		Invoibc0._hideRelateProducts.get().kill();
		//Invoibc0._hideRelateProducts.get();
		Invoibc0._hideRelateInvHist.get().kill();
		//Invoibc0._hideRelateInvHist.get();
		Invoibc0._hideRelateDetail.get().kill();
		//Invoibc0._hideRelateDetail.get();
		Invoibc0._hideRelateOrders.get().kill();
		//Invoibc0._hideRelateOrders.get();
		Invoibc0._hideRelateCustomers.get().kill();
		//Invoibc0._hideRelateCustomers.get();
	}
	public static void iNVOIBC0FilesInit()
	{
		Invoibc0._hideRelateStates.get().init();
		Invoibc0._hideRelateCompany.get().init();
		Invoibc0._hideRelateProducts.get().init();
		Invoibc0._hideRelateInvHist.get().init();
		Invoibc0._hideRelateDetail.get().init();
		Invoibc0._hideRelateOrders.get().init();
		Invoibc0._hideRelateCustomers.get().init();
	}
}
