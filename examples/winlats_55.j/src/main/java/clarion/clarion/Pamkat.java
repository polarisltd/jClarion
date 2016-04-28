package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pamkat extends ClarionSQLFile
{
	public ClarionArray<ClarionNumber> men_skaits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(40);
	public ClarionArray<ClarionArray<ClarionNumber>> gd_pr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> sak_v=Clarion.newDecimal(10,2).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> ieg_v=Clarion.newDecimal(10,2).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> kap_v=Clarion.newDecimal(10,2).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> par_v=Clarion.newDecimal(10,2).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> atl_v=Clarion.newDecimal(9,2).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> korekcija=Clarion.newDecimal(9,2).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> nolietojums=Clarion.newDecimal(10,2).dim(40).dim(6);
	public ClarionArray<ClarionArray<ClarionDecimal>> u_nolietojums=Clarion.newDecimal(10,2).dim(40).dim(6);
	public ClarionArray<ClarionString> lock=Clarion.newString(6).dim(40);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString acc_kods=Clarion.newString(8);

	public Pamkat()
	{
		setName(Main.pamkatname);
		setPrefix("PAK");
		setCreate();
		this.addVariable("MEN_SKAITS",this.men_skaits);
		this.addVariable("GD_PR",this.gd_pr);
		this.addVariable("SAK_V",this.sak_v);
		this.addVariable("IEG_V",this.ieg_v);
		this.addVariable("KAP_V",this.kap_v);
		this.addVariable("PAR_V",this.par_v);
		this.addVariable("ATL_V",this.atl_v);
		this.addVariable("KOREKCIJA",this.korekcija);
		this.addVariable("NOLIETOJUMS",this.nolietojums);
		this.addVariable("U_NOLIETOJUMS",this.u_nolietojums);
		this.addVariable("LOCK",this.lock);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		this.addVariable("ACC_KODS",this.acc_kods);
	}
}
