package clarion;

import clarion.Company;
import clarion.Customers;
import clarion.Detail;
import clarion.Invhist;
import clarion.Orders;
import clarion.Products;
import clarion.Reportengine;
import clarion.States;
import clarion.aberror.Errorclass;
import clarion.abfile.Filemanager;
import clarion.abfile.Relationmanager;
import clarion.abfuzzy.Fuzzyclass;
import clarion.abutil.Iniclass;
import clarion.equates.Constants;
import clarion.equates.Matchoption;
import clarion.invoi001.Invoi001;
import clarion.invoi002.Invoi002;
import clarion.invoibc.Invoibc;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.crash.Crash;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Main
{
	public static ClarionString glotCustname;
	public static ClarionString glotShipname;
	public static ClarionString glotCustaddress;
	public static ClarionString glotShipaddress;
	public static ClarionString glotCuscsz;
	public static ClarionString glotShipcsz;
	public static ClarionString gloPathname;
	public static ClarionNumber silentrunning;
	public static States states;
	public static Company company;
	public static Products products;
	public static Invhist invhist;
	public static Detail detail;
	public static Orders orders;
	public static Customers customers;
	public static Reportengine re;
	public static Filemanager accessStates;
	public static Relationmanager relateStates;
	public static Filemanager accessCompany;
	public static Relationmanager relateCompany;
	public static Filemanager accessProducts;
	public static Relationmanager relateProducts;
	public static Filemanager accessInvhist;
	public static Relationmanager relateInvhist;
	public static Filemanager accessDetail;
	public static Relationmanager relateDetail;
	public static Filemanager accessOrders;
	public static Relationmanager relateOrders;
	public static Filemanager accessCustomers;
	public static Relationmanager relateCustomers;
	public static Fuzzyclass fuzzymatcher;
	public static Errorclass globalerrors;
	public static Iniclass inimgr;
	public static ClarionNumber globalrequest;
	public static ClarionNumber globalresponse;
	public static ClarionNumber vcrrequest;
	public static ClarionNumber lcurrentfdsetting;
	public static ClarionNumber ladjfdsetting;

	private static java.util.List<Runnable> __static_init_list = new java.util.ArrayList<Runnable>();
	public static void __register_init(Runnable r) {
		__static_init_list.add(r);
	}

	private static java.util.List<Runnable> __static_destruct_list = new java.util.ArrayList<Runnable>();
	public static void __register_destruct(Runnable r) {
		__static_destruct_list.add(r);
	}

	private static boolean __is_init=false;
	static {
		__static_init();
	}

	public static void __static_init() {
		__is_init=true;
		java.util.List<Runnable> __init_list = new java.util.ArrayList<Runnable>(__static_init_list);
		glotCustname=Clarion.newString(35).setThread();
		glotShipname=Clarion.newString(35).setThread();
		glotCustaddress=Clarion.newString(45).setThread();
		glotShipaddress=Clarion.newString(45).setThread();
		glotCuscsz=Clarion.newString(40).setThread();
		glotShipcsz=Clarion.newString(40).setThread();
		gloPathname=Clarion.newString(50);
		silentrunning=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		states=(States)(new States()).getThread();
		company=(Company)(new Company()).getThread();
		products=(Products)(new Products()).getThread();
		invhist=(Invhist)(new Invhist()).getThread();
		detail=(Detail)(new Detail()).getThread();
		orders=(Orders)(new Orders()).getThread();
		customers=(Customers)(new Customers()).getThread();
		re=new Reportengine();
		accessStates=null;
		relateStates=null;
		accessCompany=null;
		relateCompany=null;
		accessProducts=null;
		relateProducts=null;
		accessInvhist=null;
		relateInvhist=null;
		accessDetail=null;
		relateDetail=null;
		accessOrders=null;
		relateOrders=null;
		accessCustomers=null;
		relateCustomers=null;
		fuzzymatcher=new Fuzzyclass();
		globalerrors=new Errorclass();
		inimgr=new Iniclass();
		globalrequest=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE).setThread();
		globalresponse=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE).setThread();
		vcrrequest=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG).setThread();
		lcurrentfdsetting=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ladjfdsetting=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		for (Runnable __scan : __init_list) { __scan.run(); };
	}

	public static void __static_destruct() {
		__is_init=false;
		java.util.List<Runnable> __destruct_list = new java.util.ArrayList<Runnable>(__static_destruct_list);
		re.destruct();
		for (Runnable __scan : __destruct_list) { __scan.run(); };
	}

		public static ClarionQueue.Order __CaseInsensitiveCompare=new ClarionQueue.FunctionOrder() {
			@Override
			public int compare(ClarionGroup g1,ClarionGroup g2)
			{
				return (new Abdrops()).caseinsensitivecompare(g1,g2).intValue();
			}
		};
		public static ClarionQueue.Order __CaseSensitiveCompare=new ClarionQueue.FunctionOrder() {
			@Override
			public int compare(ClarionGroup g1,ClarionGroup g2)
			{
				return (new Abdrops()).casesensitivecompare(g1,g2).intValue();
			}
		};

	public static void main(String[] args)
	{
		try { if (!__is_init) { __static_init(); } begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { __static_destruct(); }
	}
	public static void begin(String[] args)
	{
		CRun.init(args);
		 // help Clarion.newString("INVOICE.HLP");
		globalerrors.init();
		Invoibc.dctinit();
		fuzzymatcher.init();
		fuzzymatcher.setoption(Clarion.newNumber(Matchoption.NOCASE),Clarion.newNumber(1));
		fuzzymatcher.setoption(Clarion.newNumber(Matchoption.WORDONLY),Clarion.newNumber(0));
		inimgr.init(Clarion.newString(".\\Invoice.ini"));
		company.open();
		if (CError.errorCode()==2) {
			company.create();
			company.open();
			globalrequest.setValue(Constants.INSERTRECORD);
			Invoi002.updatecompany();
		}
		accessCompany.close();
		relateCompany.open();
		company.set();
		accessCompany.next();
		Invoi001.main();
		inimgr.update();
		fuzzymatcher.kill();
		Invoibc.dctkill();
		globalerrors.kill();
	}
}
