package clarion;

import clarion.HideAccessCustomer;
import clarion.HideAccessOrders;
import clarion.HideAccessStates;
import clarion.HideRelateCustomer;
import clarion.HideRelateOrders;
import clarion.HideRelateStates;
import clarion.Main;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Tutorbc0
{
	public static RefVariable<HideAccessCustomer> _hideAccessCUSTOMER;
	public static RefVariable<HideRelateCustomer> _hideRelateCUSTOMER;
	public static RefVariable<HideAccessOrders> _hideAccessORDERS;
	public static RefVariable<HideRelateOrders> _hideRelateORDERS;
	public static RefVariable<HideAccessStates> _hideAccessStates;
	public static RefVariable<HideRelateStates> _hideRelateStates;

	public static void tUTORBC0DctInit()
	{
		Tutorbc0._hideAccessCUSTOMER.set(new HideAccessCustomer());
		Tutorbc0._hideRelateCUSTOMER.set(new HideRelateCustomer());
		Tutorbc0._hideAccessORDERS.set(new HideAccessOrders());
		Tutorbc0._hideRelateORDERS.set(new HideRelateOrders());
		Tutorbc0._hideAccessStates.set(new HideAccessStates());
		Tutorbc0._hideRelateStates.set(new HideRelateStates());
		Main.relateCUSTOMER.set(Tutorbc0._hideRelateCUSTOMER.get());
		Main.relateORDERS.set(Tutorbc0._hideRelateORDERS.get());
		Main.relateStates.set(Tutorbc0._hideRelateStates.get());
	}
	public static void tUTORBC0DctKill()
	{
		Tutorbc0._hideRelateCUSTOMER.get().kill();
		//Tutorbc0._hideRelateCUSTOMER.get();
		Tutorbc0._hideRelateORDERS.get().kill();
		//Tutorbc0._hideRelateORDERS.get();
		Tutorbc0._hideRelateStates.get().kill();
		//Tutorbc0._hideRelateStates.get();
	}
	public static void tUTORBC0FilesInit()
	{
		Tutorbc0._hideRelateCUSTOMER.get().init();
		Tutorbc0._hideRelateORDERS.get().init();
		Tutorbc0._hideRelateStates.get().init();
	}
}
