package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nom_c extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString nosaukums_c=Clarion.newString(50);
	public ClarionString nosaukums_a=Clarion.newString(50);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");

	public Nom_c()
	{
		setName(Clarion.newString("NOM_C"));
		setPrefix("NOC");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("NOSAUKUMS_C",this.nosaukums_c);
		this.addVariable("NOSAUKUMS_A",this.nosaukums_a);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nom_key.setDuplicate().setNocase().addAscendingField(nomenklat);
		this.addKey(nom_key);
	}
}
