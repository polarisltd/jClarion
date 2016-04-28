package clarion.abbrowse;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Abbrowse
{
	public static ClarionString scrollAlpha;
	public static ClarionString scrollName;
	public static ClarionString overridecharacters;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		scrollAlpha=Clarion.newString(ClarionString.staticConcat("  AFANATB BFBNBTC CFCNCT","D DFDNDTE EFENETF FFFNFT","G GFGNGTH HFHNHTI IFINIT","J JFJNJTK KFKNKTL LFLNLT","M MFMNMTN NFNNNTO OFONOT","P PFPNPTQ QNR RFRNRTS SF","SNSTT TFTNTTU UFUNUTV VF","VNVTW WFWNWTX XFXNXTY YF","YNYTZ ZN"));
		scrollName=Clarion.newString(ClarionString.staticConcat("   ALBAMEARNBAKBATBENBIABOBBRA","BROBUACACCARCENCHRCOECONCORCRU","DASDELDIADONDURELDEVEFELFISFLO","FREFUTGARGIBGOLGOSGREGUTHAMHEM","HOBHOTINGJASJONKAGKEAKIRKORKYO","LATLEOLIGLOUMACMAQMARMAUMCKMER","MILMONMORNATNOLOKEPAGPAUPETPIN","PORPULRAUREYROBROSRUBSALSCASCH","SCRSHASIGSKISNASOUSTESTISUNTAY","TIRTUCVANWACWASWEIWIEWIMWOLYOR"));
		overridecharacters=Clarion.newString("`!\"�$%%^&*()'-=_+][#;~@:/.,?\\| ");
	}

}
