package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Crossref extends ClarionSQLFile
{
	public ClarionString kataloga_nr=Clarion.newString(22);
	public ClarionString raz_k=Clarion.newString(3);
	public ClarionString nos_s=Clarion.newString(16);
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey kat_key=new ClarionKey("KAT_Key");
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");

	public Crossref()
	{
		setPrefix("CRO");
		setName(Clarion.newString("crossref"));
		setCreate();
		this.addVariable("KATALOGA_NR",this.kataloga_nr);
		this.addVariable("RAZ_K",this.raz_k);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		kat_key.setDuplicate().setNocase().addAscendingField(kataloga_nr);
		this.addKey(kat_key);
		nom_key.setDuplicate().setNocase().setOptional().addAscendingField(nomenklat);
		this.addKey(nom_key);
	}
}
