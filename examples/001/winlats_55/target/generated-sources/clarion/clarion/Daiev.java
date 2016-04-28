package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Daiev extends ClarionSQLFile
{
	public ClarionDecimal kods=Clarion.newDecimal(3,0);
	public ClarionString nosaukums=Clarion.newString(35);
	public ClarionString f=Clarion.newString(3);
	public ClarionString t=Clarion.newString(1);
	public ClarionNumber ienak_veids=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString g=Clarion.newString(4);
	public ClarionString arg_nos=Clarion.newString(10);
	public ClarionDecimal tarl=Clarion.newDecimal(9,4);
	public ClarionDecimal alga=Clarion.newDecimal(7,2);
	public ClarionDecimal proc=Clarion.newDecimal(3,1);
	public ClarionArray<ClarionDecimal> f_daierez=Clarion.newDecimal(3,0).dim(10);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionString dkk=Clarion.newString(5);
	public ClarionString kkk=Clarion.newString(5);
	public ClarionString socyn=Clarion.newString(1);
	public ClarionString ienyn=Clarion.newString(1);
	public ClarionString sliyn=Clarion.newString(1);
	public ClarionString atvyn=Clarion.newString(1);
	public ClarionString vidyn=Clarion.newString(1);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey kod_key=new ClarionKey("KOD_KEY");

	public Daiev()
	{
		setName(Clarion.newString("DAIEV"));
		setPrefix("DAI");
		setCreate();
		this.addVariable("KODS",this.kods);
		this.addVariable("NOSAUKUMS",this.nosaukums);
		this.addVariable("F",this.f);
		this.addVariable("T",this.t);
		this.addVariable("IENAK_VEIDS",this.ienak_veids);
		this.addVariable("G",this.g);
		this.addVariable("ARG_NOS",this.arg_nos);
		this.addVariable("TARL",this.tarl);
		this.addVariable("ALGA",this.alga);
		this.addVariable("PROC",this.proc);
		this.addVariable("F_DAIEREZ",this.f_daierez);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("DKK",this.dkk);
		this.addVariable("KKK",this.kkk);
		this.addVariable("SOCYN",this.socyn);
		this.addVariable("IENYN",this.ienyn);
		this.addVariable("SLIYN",this.sliyn);
		this.addVariable("ATVYN",this.atvyn);
		this.addVariable("VIDYN",this.vidyn);
		this.addVariable("BAITS",this.baits);
		kod_key.setNocase().addAscendingField(kods);
		this.addKey(kod_key);
	}
}
