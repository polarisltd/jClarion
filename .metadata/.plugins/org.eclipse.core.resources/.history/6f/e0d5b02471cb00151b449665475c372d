package clarion;

import clarion.Abbrowse;
import clarion.Abdrops;
import clarion.Abeip;
import clarion.Aberror;
import clarion.Abfile;
import clarion.Abreport;
import clarion.Abtoolba;
import clarion.Abutil;
import clarion.Abwmfpar;
import clarion.Colormap;
import clarion.Colormapgroup;
import clarion.Company;
import clarion.Customers;
import clarion.Cwutil;
import clarion.Day_group;
import clarion.Defaulterrors;
import clarion.Detail;
import clarion.Dictionary;
import clarion.Errorclass;
import clarion.Filemanager;
import clarion.Filesmanager;
import clarion.Iniclass;
import clarion.Invhist;
import clarion.Invoi001;
import clarion.Invoi003;
import clarion.Invoibc0;
import clarion.Listboxtips;
import clarion.Month_group;
import clarion.MultiWindow;
import clarion.Orders;
import clarion.Products;
import clarion.Relationmanager;
import clarion.Reltreeboxtips;
import clarion.Reportengine;
import clarion.States;
import clarion.Stderrorfile;
import clarion.Translation;
import clarion.Translatortypemappings;
import clarion.TxtWindow;
import clarion.Updatechangetips;
import clarion.Updateinserttips;
import clarion.Updatevcrtips;
import clarion.Window_1;
import clarion.Wmfinfile;
import clarion.Zoompresets;
import clarion.equates.Constants;
import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.crash.Crash;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Main
{
	public static ClarionString gLOTCustName;
	public static ClarionString gLOTShipName;
	public static ClarionString gLOTCustAddress;
	public static ClarionString gLOTShipAddress;
	public static ClarionString gLOTCusCSZ;
	public static ClarionString gLOTShipCSZ;
	public static ClarionString gLOPathname;
	public static ClarionNumber silentRunning;
	public static States states;
	public static Company company;
	public static Products products;
	public static Invhist invHist;
	public static Detail detail;
	public static Orders orders;
	public static Customers customers;
	public static Reportengine re;
	public static RefVariable<Filemanager> accessStates;
	public static RefVariable<Relationmanager> relateStates;
	public static RefVariable<Filemanager> accessCompany;
	public static RefVariable<Relationmanager> relateCompany;
	public static RefVariable<Filemanager> accessProducts;
	public static RefVariable<Relationmanager> relateProducts;
	public static RefVariable<Filemanager> accessInvHist;
	public static RefVariable<Relationmanager> relateInvHist;
	public static RefVariable<Filemanager> accessDetail;
	public static RefVariable<Relationmanager> relateDetail;
	public static RefVariable<Filemanager> accessOrders;
	public static RefVariable<Relationmanager> relateOrders;
	public static RefVariable<Filemanager> accessCustomers;
	public static RefVariable<Relationmanager> relateCustomers;
	public static Errorclass globalErrors;
	public static Iniclass iNIMgr;
	public static ClarionNumber globalRequest;
	public static ClarionNumber globalResponse;
	public static ClarionNumber vCRRequest;
	public static Dictionary dictionary;
	public static ClarionNumber lCurrentFDSetting;
	public static ClarionNumber lAdjFDSetting;
		public static ClarionQueue.Order __CaseInsensitiveCompare=new ClarionQueue.FunctionOrder() {
			@Override
			public int compare(ClarionGroup g1,ClarionGroup g2)
			{
				return (new Abdrops()).caseInsensitiveCompare(g1,g2).intValue();
			}
		};
		public static ClarionQueue.Order __CaseSensitiveCompare=new ClarionQueue.FunctionOrder() {
			@Override
			public int compare(ClarionGroup g1,ClarionGroup g2)
			{
				return (new Abdrops()).caseSensitiveCompare(g1,g2).intValue();
			}
		};

	public static void init()
	{
		CRun.shutdown();
		gLOTCustName=Clarion.newString(35).setThread();
		gLOTShipName=Clarion.newString(35).setThread();
		gLOTCustAddress=Clarion.newString(45).setThread();
		gLOTShipAddress=Clarion.newString(45).setThread();
		gLOTCusCSZ=Clarion.newString(40).setThread();
		gLOTShipCSZ=Clarion.newString(40).setThread();
		gLOPathname=Clarion.newString(50);
		silentRunning=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		states=(States)(new States()).getThread();
		company=(Company)(new Company()).getThread();
		products=(Products)(new Products()).getThread();
		invHist=(Invhist)(new Invhist()).getThread();
		detail=(Detail)(new Detail()).getThread();
		orders=(Orders)(new Orders()).getThread();
		customers=(Customers)(new Customers()).getThread();
		re=new Reportengine();
		accessStates=(new RefVariable<Filemanager>(null)).setThread();
		relateStates=(new RefVariable<Relationmanager>(null)).setThread();
		accessCompany=(new RefVariable<Filemanager>(null)).setThread();
		relateCompany=(new RefVariable<Relationmanager>(null)).setThread();
		accessProducts=(new RefVariable<Filemanager>(null)).setThread();
		relateProducts=(new RefVariable<Relationmanager>(null)).setThread();
		accessInvHist=(new RefVariable<Filemanager>(null)).setThread();
		relateInvHist=(new RefVariable<Relationmanager>(null)).setThread();
		accessDetail=(new RefVariable<Filemanager>(null)).setThread();
		relateDetail=(new RefVariable<Relationmanager>(null)).setThread();
		accessOrders=(new RefVariable<Filemanager>(null)).setThread();
		relateOrders=(new RefVariable<Relationmanager>(null)).setThread();
		accessCustomers=(new RefVariable<Filemanager>(null)).setThread();
		relateCustomers=(new RefVariable<Relationmanager>(null)).setThread();
		Aberror.defaultErrors=new Defaulterrors();
		iNIMgr=new Iniclass();
		globalRequest=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE).setThread();
		globalResponse=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE).setThread();
		vCRRequest=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG).setThread();
		Abfile.filesManager=(Filesmanager)(new Filesmanager()).getThread();
		lCurrentFDSetting=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lAdjFDSetting=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Abfile.epoc=Clarion.newNumber(1).setEncoding(ClarionNumber.LONG).setThread();
		Abfile.szDbTextLog=Clarion.newString(File.MAXFILEPATH+1).setEncoding(ClarionString.CSTRING).setThread();
		Invoibc0._hideAccessStates=(new RefVariable<HideAccessStates>(null)).setThread();
		Abutil.translation=new Translation();
		Abutil.translatorTypeMappings=new Translatortypemappings();
		Abutil.kill_ExtractFilename=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		Abutil.ask_string_number_Day_group=new Day_group();
		Abutil.ask_string_number_Month_group=new Month_group();
		Abtoolba.listBoxTips=new Listboxtips();
		Abtoolba.reltreeBoxTips=new Reltreeboxtips();
		Abtoolba.updateInsertTips=new Updateinserttips();
		Abtoolba.updateChangeTips=new Updatechangetips();
		Abtoolba.updateVCRTips=new Updatevcrtips();
		Abeip.colorMapGroup=new Colormapgroup();
		Abeip.colorQInitialized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Abeip.colorMap=new Colormap();
		Abeip.multiWindow=new MultiWindow();
		Abeip.txtWindow=new TxtWindow();
		Abeip.convertBase_string_number_number_ValA=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG);
		Abbrowse.scrollAlpha=Clarion.newString(ClarionString.staticConcat("  AFANATB BFBNBTC CFCNCT","D DFDNDTE EFENETF FFFNFT","G GFGNGTH HFHNHTI IFINIT","J JFJNJTK KFKNKTL LFLNLT","M MFMNMTN NFNNNTO OFONOT","P PFPNPTQ QNR RFRNRTS SF","SNSTT TFTNTTU UFUNUTV VF","VNVTW WFWNWTX XFXNXTY YF","YNYTZ ZN"));
		Abbrowse.scrollName=Clarion.newString(ClarionString.staticConcat("   ALBAMEARNBAKBATBENBIABOBBRA","BROBUACACCARCENCHRCOECONCORCRU","DASDELDIADONDURELDEVEFELFISFLO","FREFUTGARGIBGOLGOSGREGUTHAMHEM","HOBHOTINGJASJONKAGKEAKIRKORKYO","LATLEOLIGLOUMACMAQMARMAUMCKMER","MILMONMORNATNOLOKEPAGPAUPETPIN","PORPULRAUREYROBROSRUBSALSCASCH","SCRSHASIGSKISNASOUSTESTISUNTAY","TIRTUCVANWACWASWEIWIEWIMWOLYOR"));
		Abbrowse.overrideCharacters=Clarion.newString("`!\"�$%%^&*()'-=_+][#;~@:/.,?\\| ");
		globalErrors=(Errorclass)(new Errorclass()).getThread();
		Aberror.window=new Window_1();
		Aberror.stdErrorFile=(Stderrorfile)(new Stderrorfile()).getThread();
		Cwutil.hexDigitsUp=Clarion.newString("0123456789ABCDEF");
		Cwutil.hexDigitsLow=Clarion.newString("0123456789abcdef");
		Invoibc0._hideRelateStates=(new RefVariable<HideRelateStates>(null)).setThread();
		Invoibc0._hideAccessCompany=(new RefVariable<HideAccessCompany>(null)).setThread();
		Invoibc0._hideRelateCompany=(new RefVariable<HideRelateCompany>(null)).setThread();
		Invoibc0._hideAccessProducts=(new RefVariable<HideAccessProducts>(null)).setThread();
		Invoibc0._hideRelateProducts=(new RefVariable<HideRelateProducts>(null)).setThread();
		Invoibc0._hideAccessInvHist=(new RefVariable<HideAccessInvhist>(null)).setThread();
		Invoibc0._hideRelateInvHist=(new RefVariable<HideRelateInvhist>(null)).setThread();
		Invoibc0._hideAccessDetail=(new RefVariable<HideAccessDetail>(null)).setThread();
		Invoibc0._hideRelateDetail=(new RefVariable<HideRelateDetail>(null)).setThread();
		Invoibc0._hideAccessOrders=(new RefVariable<HideAccessOrders>(null)).setThread();
		Invoibc0._hideRelateOrders=(new RefVariable<HideRelateOrders>(null)).setThread();
		Invoibc0._hideAccessCustomers=(new RefVariable<HideAccessCustomers>(null)).setThread();
		Invoibc0._hideRelateCustomers=(new RefVariable<HideRelateCustomers>(null)).setThread();
		dictionary=(Dictionary)(new Dictionary()).getThread();
		Abdrops.takeNewSelection_number_LastEntry=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		Abwmfpar.wMFInFile=(Wmfinfile)(new Wmfinfile()).getThread();
		Abreport.zoomPresets=new Zoompresets();
	}
	static { init(); }

	public static void destroy()
	{
		re.destruct();
		iNIMgr.destruct();
		Abfile.filesManager.destruct();
		Abeip.multiWindow.close();
		Abeip.txtWindow.close();
		globalErrors.destruct();
		Aberror.window.close();
		dictionary.destruct();
	}
	public static void main(String[] args)
	{
		try { init(); begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { destroy(); }
	}
	public static void begin(String[] args)
	{
		CRun.init(args);
		 // help Clarion.newString("INVOICE.HLP");
		iNIMgr.init(Clarion.newString(".\\invoice.INI"),Clarion.newNumber(Constants.NVD_INI));
		company.open();
		if (CError.errorCode()==2) {
			company.create();
			company.open();
			globalRequest.setValue(Constants.INSERTRECORD);
			Invoi003.updateCompany();
		}
		accessCompany.get().close();
		relateCompany.get().open();
		company.set();
		accessCompany.get().next();
		// systemparametersinfo(Clarion.newNumber(38).intValue(),Clarion.newNumber(0).intValue(),lCurrentFDSetting.intValue(),Clarion.newNumber(0).intValue());
		if (lCurrentFDSetting.equals(1)) {
			// systemparametersinfo(Clarion.newNumber(37).intValue(),Clarion.newNumber(0).intValue(),lAdjFDSetting.intValue(),Clarion.newNumber(3).intValue());
		}
		Invoi001.main();
		iNIMgr.update();
		if (lCurrentFDSetting.equals(1)) {
			// systemparametersinfo(Clarion.newNumber(37).intValue(),Clarion.newNumber(1).intValue(),lAdjFDSetting.intValue(),Clarion.newNumber(3).intValue());
		}
		iNIMgr.kill();
	}
}
