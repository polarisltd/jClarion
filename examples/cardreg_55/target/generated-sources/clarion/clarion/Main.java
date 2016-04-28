package clarion;

import clarion.Abbrowse;
import clarion.Abeip;
import clarion.Aberror;
import clarion.Abfile;
import clarion.Abfuzzy;
import clarion.Abreport;
import clarion.Abtoolba;
import clarion.Abutil;
import clarion.Accounts;
import clarion.Cardr001;
import clarion.Cardrbc;
import clarion.Cardrbc0;
import clarion.Colormap;
import clarion.Colormapgroup;
import clarion.Defaulterrors;
import clarion.Errorclass;
import clarion.Filemanager;
import clarion.Filemapping;
import clarion.Filesmanager;
import clarion.Fuzzyclass;
import clarion.HideAccessAccounts;
import clarion.HideAccessTransactions;
import clarion.HideRelateAccounts;
import clarion.HideRelateTransactions;
import clarion.Iniclass;
import clarion.Listboxtips;
import clarion.MultiWindow;
import clarion.Relationmanager;
import clarion.Reltreeboxtips;
import clarion.Statusq;
import clarion.Stderrorfile;
import clarion.Transactions;
import clarion.Translation;
import clarion.Translatortypemappings;
import clarion.TxtWindow;
import clarion.Updatechangetips;
import clarion.Updateinserttips;
import clarion.Window;
import clarion.Zoompresets;
import clarion.equates.Constants;
import clarion.equates.File;
import clarion.equates.Matchoption;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.crash.Crash;
import org.jclarion.clarion.runtime.CRun;

public class Main
{
	public static ClarionString gLOCardTypeDescription;
	public static ClarionNumber gLOTodaysDate;
	public static ClarionNumber gLOCurrentSysid;
	public static ClarionNumber gLOLowDate;
	public static ClarionNumber gLOHighDate;
	public static ClarionNumber gLOSysID;
	public static ClarionString gLOTransactionTypeDescription;
	public static ClarionNumber gLORunTranHistRpt;
	public static ClarionString gLORunPurchasesRpt;
	public static ClarionNumber gLOMakePayment;
	public static ClarionDecimal gLOHoldTransactionAmount;
	public static ClarionWindow appWindowRef;
	public static ClarionNumber gLOButton1;
	public static ClarionNumber gLOButton2;
	public static ClarionNumber gLOButton3;
	public static ClarionNumber gLOButton4;
	public static ClarionReal gloTotal;
	public static ClarionNumber silentRunning;
	public static Accounts accounts;
	public static Transactions transactions;
	public static Filemanager accessAccounts;
	public static Relationmanager relateAccounts;
	public static Filemanager accessTransactions;
	public static Relationmanager relateTransactions;
	public static Fuzzyclass fuzzyMatcher;
	public static Errorclass globalErrors;
	public static Iniclass iNIMgr;
	public static ClarionNumber globalRequest;
	public static ClarionNumber globalResponse;
	public static ClarionNumber vCRRequest;
	public static ClarionNumber lCurrentFDSetting;
	public static ClarionNumber lAdjFDSetting;

	public static void init()
	{
		CRun.shutdown();
		gLOCardTypeDescription=Clarion.newString(16);
		gLOTodaysDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOCurrentSysid=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOLowDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOHighDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOSysID=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOTransactionTypeDescription=Clarion.newString(10);
		gLORunTranHistRpt=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		gLORunPurchasesRpt=Clarion.newString("0                   ");
		gLOMakePayment=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		gLOHoldTransactionAmount=Clarion.newDecimal(7,2);
		appWindowRef=null;
		gLOButton1=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOButton2=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOButton3=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gLOButton4=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		gloTotal=Clarion.newReal();
		silentRunning=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		accounts=(Accounts)(new Accounts()).getThread();
		transactions=(Transactions)(new Transactions()).getThread();
		accessAccounts=null;
		relateAccounts=null;
		accessTransactions=null;
		relateTransactions=null;
		fuzzyMatcher=new Fuzzyclass();
		globalErrors=new Errorclass();
		iNIMgr=new Iniclass();
		globalRequest=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE).setThread();
		globalResponse=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE).setThread();
		vCRRequest=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG).setThread();
		lCurrentFDSetting=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lAdjFDSetting=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Abfile.fileMapping=new Filemapping();
		Abfile.epoc=Clarion.newNumber(1).setEncoding(ClarionNumber.LONG);
		Abfile.statusQ=new Statusq();
		Abfile.filesManager=new Filesmanager();
		Abfile.szDbTextLog=Clarion.newString(File.MAXFILEPATH+1).setEncoding(ClarionString.CSTRING);
		Abutil.translation=new Translation();
		Abutil.translatorTypeMappings=new Translatortypemappings();
		Abutil.kill_ExtractFilename=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		Abutil.translateString_string_Recurse=Clarion.newNumber(Constants.MAXRECURSION).setEncoding(ClarionNumber.SHORT);
		Abtoolba.listBoxTips=new Listboxtips();
		Abtoolba.reltreeBoxTips=new Reltreeboxtips();
		Abtoolba.updateInsertTips=new Updateinserttips();
		Abtoolba.updateChangeTips=new Updatechangetips();
		Abeip.colorMapGroup=new Colormapgroup();
		Abeip.colorQInitialized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Abeip.colorMap=new Colormap();
		Abeip.multiWindow=new MultiWindow();
		Abeip.txtWindow=new TxtWindow();
		Abeip.convertBase_string_number_number_ValA=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG);
		Abbrowse.scrollAlpha=Clarion.newString(ClarionString.staticConcat("  AFANATB BFBNBTC CFCNCT","D DFDNDTE EFENETF FFFNFT","G GFGNGTH HFHNHTI IFINIT","J JFJNJTK KFKNKTL LFLNLT","M MFMNMTN NFNNNTO OFONOT","P PFPNPTQ QNR RFRNRTS SF","SNSTT TFTNTTU UFUNUTV VF","VNVTW WFWNWTX XFXNXTY YF","YNYTZ ZN"));
		Abbrowse.scrollName=Clarion.newString(ClarionString.staticConcat("   ALBAMEARNBAKBATBENBIABOBBRA","BROBUACACCARCENCHRCOECONCORCRU","DASDELDIADONDURELDEVEFELFISFLO","FREFUTGARGIBGOLGOSGREGUTHAMHEM","HOBHOTINGJASJONKAGKEAKIRKORKYO","LATLEOLIGLOUMACMAQMARMAUMCKMER","MILMONMORNATNOLOKEPAGPAUPETPIN","PORPULRAUREYROBROSRUBSALSCASCH","SCRSHASIGSKISNASOUSTESTISUNTAY","TIRTUCVANWACWASWEIWIEWIMWOLYOR"));
		Abbrowse.overrideCharacters=Clarion.newString("`!\"�$%%^&*()'-=_+][#;~@:/.,?\\| ");
		Aberror.defaultErrors=new Defaulterrors();
		Aberror.window=new Window();
		Aberror.stdErrorFile=new Stderrorfile();
		Abfuzzy.fuzzyObject=null;
		Cardrbc0.hideAccessAccounts=new HideAccessAccounts();
		Cardrbc0.hideRelateAccounts=new HideRelateAccounts();
		Cardrbc0.hideAccessTransactions=new HideAccessTransactions();
		Cardrbc0.hideRelateTransactions=new HideRelateTransactions();
		Abreport.zoomPresets=new Zoompresets();
	}
	static { init(); }

	public static void destroy()
	{
		Abfile.filesManager.destruct();
		Abeip.multiWindow.close();
		Abeip.txtWindow.close();
		Aberror.window.close();
		Cardrbc0.hideAccessAccounts.destruct();
		Cardrbc0.hideAccessTransactions.destruct();
	}
	public static void main(String[] args)
	{
		try { init(); begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { destroy(); }
	}
	public static void begin(String[] args)
	{
		CRun.init(args);
		 // help Clarion.newString("CARDREG.HLP");
		globalErrors.init();
		Cardrbc.dctInit();
		fuzzyMatcher.init();
		fuzzyMatcher.setOption(Clarion.newNumber(Matchoption.NOCASE),Clarion.newNumber(1));
		fuzzyMatcher.setOption(Clarion.newNumber(Matchoption.WORDONLY),Clarion.newNumber(0));
		iNIMgr.init(Clarion.newString(".cardreg.ini"));
		// systemparametersinfo(38,0,lCurrentFDSetting.intValue(),0);
		if (lCurrentFDSetting.equals(1)) {
			// systemparametersinfo(37,0,lAdjFDSetting.intValue(),3);
		}
		Cardr001.main();
		iNIMgr.update();
		if (lCurrentFDSetting.equals(1)) {
			// systemparametersinfo(37,1,lAdjFDSetting.intValue(),3);
		}
		iNIMgr.kill();
		fuzzyMatcher.kill();
		Cardrbc.dctKill();
		globalErrors.kill();
	}
}
