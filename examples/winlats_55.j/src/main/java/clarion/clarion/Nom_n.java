package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nom_n extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString statuss=Clarion.newString(1);
	public ClarionNumber daudzums=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString komentars=Clarion.newString(50);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey kat_key=new ClarionKey("KAT_KEY");

	public Nom_n()
	{
		setName(Clarion.newString("NOM_N"));
		setPrefix("NON");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("STATUSS",this.statuss);
		this.addVariable("DAUDZUMS",this.daudzums);
		this.addVariable("KOMENTARS",this.komentars);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		kat_key.setDuplicate().setNocase().addAscendingField(nomenklat);
		this.addKey(kat_key);
	}
}
