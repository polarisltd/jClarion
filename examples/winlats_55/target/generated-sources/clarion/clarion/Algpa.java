package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Algpa extends ClarionSQLFile
{
	public ClarionNumber yyyymm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString statuss=Clarion.newString(40);
	public ClarionNumber stat=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal apriin=Clarion.newDecimal(9,2);
	public ClarionDecimal ietiin=Clarion.newDecimal(9,2);
	public ClarionDecimal parskaitit=Clarion.newDecimal(10,2);
	public ClarionDecimal izmaksat=Clarion.newDecimal(10,2);
	public ClarionDecimal apgadsum=Clarion.newDecimal(6,2);
	public ClarionDecimal at_inv1=Clarion.newDecimal(6,2);
	public ClarionDecimal at_inv2=Clarion.newDecimal(6,2);
	public ClarionDecimal at_inv3=Clarion.newDecimal(6,2);
	public ClarionDecimal at_polr=Clarion.newDecimal(6,2);
	public ClarionDecimal at_polrnp=Clarion.newDecimal(6,2);
	public ClarionDecimal mia=Clarion.newDecimal(6,2);
	public ClarionDecimal mina=Clarion.newDecimal(6,2);
	public ClarionDecimal mins=Clarion.newDecimal(5,3);
	public ClarionNumber pr_pam=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber pr_pap=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey yyyymm_key=new ClarionKey("YYYYMM_KEY");

	public Algpa()
	{
		setName(Main.alpaname);
		setPrefix("ALP");
		setCreate();
		this.addVariable("YYYYMM",this.yyyymm);
		this.addVariable("STATUSS",this.statuss);
		this.addVariable("STAT",this.stat);
		this.addVariable("APRIIN",this.apriin);
		this.addVariable("IETIIN",this.ietiin);
		this.addVariable("PARSKAITIT",this.parskaitit);
		this.addVariable("IZMAKSAT",this.izmaksat);
		this.addVariable("APGADSUM",this.apgadsum);
		this.addVariable("AT_INV1",this.at_inv1);
		this.addVariable("AT_INV2",this.at_inv2);
		this.addVariable("AT_INV3",this.at_inv3);
		this.addVariable("AT_POLR",this.at_polr);
		this.addVariable("AT_POLRNP",this.at_polrnp);
		this.addVariable("MIA",this.mia);
		this.addVariable("MINA",this.mina);
		this.addVariable("MINS",this.mins);
		this.addVariable("PR_PAM",this.pr_pam);
		this.addVariable("PR_PAP",this.pr_pap);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		yyyymm_key.setDuplicate().setNocase().setOptional().addDescendingField(yyyymm);
		this.addKey(yyyymm_key);
	}
}
