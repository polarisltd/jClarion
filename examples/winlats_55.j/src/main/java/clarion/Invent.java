package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Invent extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionDecimal kods=Clarion.newDecimal(13,0);
	public ClarionString kataloga_nr=Clarion.newString(22);
	public ClarionString nosaukums=Clarion.newString(50);
	public ClarionString nos_a=Clarion.newString(6);
	public ClarionDecimal cena=Clarion.newDecimal(11,3);
	public ClarionDecimal atlikums=Clarion.newDecimal(11,3);
	public ClarionDecimal atlikums_f=Clarion.newDecimal(11,3);
	public ClarionNumber x=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");
	public ClarionKey kod_key=new ClarionKey("KOD_KEY");
	public ClarionKey kat_key=new ClarionKey("KAT_KEY");
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");

	public Invent()
	{
		setName(Main.invname);
		setPrefix("INV");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("KODS",this.kods);
		this.addVariable("KATALOGA_NR",this.kataloga_nr);
		this.addVariable("NOSAUKUMS",this.nosaukums);
		this.addVariable("NOS_A",this.nos_a);
		this.addVariable("CENA",this.cena);
		this.addVariable("ATLIKUMS",this.atlikums);
		this.addVariable("ATLIKUMS_F",this.atlikums_f);
		this.addVariable("X",this.x);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nom_key.setNocase().setOptional().addAscendingField(nomenklat);
		this.addKey(nom_key);
		kod_key.setNocase().setOptional().addAscendingField(kods);
		this.addKey(kod_key);
		kat_key.setDuplicate().setNocase().addAscendingField(kataloga_nr);
		this.addKey(kat_key);
		nos_key.setDuplicate().setNocase().addAscendingField(nos_a);
		this.addKey(nos_key);
	}
}
