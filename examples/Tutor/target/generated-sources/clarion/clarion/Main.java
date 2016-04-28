package clarion;

import clarion.Abbrowse;
import clarion.Abeip;
import clarion.Aberror;
import clarion.Abfile;
import clarion.Abfuzzy;
import clarion.Abtoolba;
import clarion.Abutil;
import clarion.Colormap;
import clarion.Colormapgroup;
import clarion.Customer;
import clarion.Day_group;
import clarion.Defaulterrors;
import clarion.Dictionary;
import clarion.Errorclass;
import clarion.Filemanager;
import clarion.Filesmanager;
import clarion.Fuzzyclass;
import clarion.Iniclass;
import clarion.Listboxtips;
import clarion.Month_group;
import clarion.MultiWindow;
import clarion.Orders;
import clarion.Relationmanager;
import clarion.Reltreeboxtips;
import clarion.States;
import clarion.Stderrorfile;
import clarion.Translation;
import clarion.Translatortypemappings;
import clarion.Tutor001;
import clarion.Tutorbc0;
import clarion.TxtWindow;
import clarion.Updatechangetips;
import clarion.Updateinserttips;
import clarion.Updatevcrtips;
import clarion.Window_1;
import clarion.equates.Constants;
import clarion.equates.File;
import clarion.equates.Matchoption;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.crash.Crash;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Main
{
	public static ClarionNumber silentRunning;
	public static Customer customer;
	public static Orders orders;
	public static States states;
	public static RefVariable<Filemanager> accessCUSTOMER;
	public static RefVariable<Relationmanager> relateCUSTOMER;
	public static RefVariable<Filemanager> accessORDERS;
	public static RefVariable<Relationmanager> relateORDERS;
	public static RefVariable<Filemanager> accessStates;
	public static RefVariable<Relationmanager> relateStates;
	public static Fuzzyclass fuzzyMatcher;
	public static Errorclass globalErrors;
	public static Iniclass iNIMgr;
	public static ClarionNumber globalRequest;
	public static ClarionNumber globalResponse;
	public static ClarionNumber vCRRequest;
	public static Dictionary dictionary;
	public static ClarionNumber lCurrentFDSetting;
	public static ClarionNumber lAdjFDSetting;

	public static void init()
	{
		CRun.shutdown();
		silentRunning=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		customer=(Customer)(new Customer()).getThread();
		orders=(Orders)(new Orders()).getThread();
		states=(States)(new States()).getThread();
		accessCUSTOMER=(new RefVariable<Filemanager>(null)).setThread();
		relateCUSTOMER=(new RefVariable<Relationmanager>(null)).setThread();
		accessORDERS=(new RefVariable<Filemanager>(null)).setThread();
		relateORDERS=(new RefVariable<Relationmanager>(null)).setThread();
		accessStates=(new RefVariable<Filemanager>(null)).setThread();
		relateStates=(new RefVariable<Relationmanager>(null)).setThread();
		fuzzyMatcher=new Fuzzyclass();
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
		Tutorbc0._hideAccessCUSTOMER=(new RefVariable<HideAccessCustomer>(null)).setThread();
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
		Abfuzzy.fuzzyObject=null;
		Tutorbc0._hideRelateCUSTOMER=(new RefVariable<HideRelateCustomer>(null)).setThread();
		Tutorbc0._hideAccessORDERS=(new RefVariable<HideAccessOrders>(null)).setThread();
		Tutorbc0._hideRelateORDERS=(new RefVariable<HideRelateOrders>(null)).setThread();
		Tutorbc0._hideAccessStates=(new RefVariable<HideAccessStates>(null)).setThread();
		Tutorbc0._hideRelateStates=(new RefVariable<HideRelateStates>(null)).setThread();
		dictionary=(Dictionary)(new Dictionary()).getThread();
	}
	static { init(); }

	public static void destroy()
	{
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
		fuzzyMatcher.init();
		fuzzyMatcher.setOption(Clarion.newNumber(Matchoption.NOCASE),Clarion.newNumber(1));
		fuzzyMatcher.setOption(Clarion.newNumber(Matchoption.WORDONLY),Clarion.newNumber(0));
		iNIMgr.init(Clarion.newString("TUTOR.INI"),Clarion.newNumber(Constants.NVD_INI));
		// systemparametersinfo(Clarion.newNumber(38).intValue(),Clarion.newNumber(0).intValue(),lCurrentFDSetting.intValue(),Clarion.newNumber(0).intValue());
		if (lCurrentFDSetting.equals(1)) {
			// systemparametersinfo(Clarion.newNumber(37).intValue(),Clarion.newNumber(0).intValue(),lAdjFDSetting.intValue(),Clarion.newNumber(3).intValue());
		}
		Tutor001.main();
		iNIMgr.update();
		if (lCurrentFDSetting.equals(1)) {
			// systemparametersinfo(Clarion.newNumber(37).intValue(),Clarion.newNumber(1).intValue(),lAdjFDSetting.intValue(),Clarion.newNumber(3).intValue());
		}
		iNIMgr.kill();
		fuzzyMatcher.kill();
	}
}
