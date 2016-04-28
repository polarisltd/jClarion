package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nom_p extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionNumber nol_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString plaukts=Clarion.newString(15);
	public ClarionString komentars=Clarion.newString(25);
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");

	public Nom_p()
	{
		setPrefix("NOP");
		setName(Clarion.newString("nom_p"));
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("NOL_NR",this.nol_nr);
		this.addVariable("PLAUKTS",this.plaukts);
		this.addVariable("KOMENTARS",this.komentars);
		nom_key.setDuplicate().setNocase().addAscendingField(nomenklat);
		this.addKey(nom_key);
	}
}
