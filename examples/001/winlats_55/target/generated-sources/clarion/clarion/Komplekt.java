package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Komplekt extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString nom_source=Clarion.newString(21);
	public ClarionDecimal daudzums=Clarion.newDecimal(11,3);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");

	public Komplekt()
	{
		setName(Clarion.newString("KOMPLEKT"));
		setPrefix("KOM");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("NOM_SOURCE",this.nom_source);
		this.addVariable("DAUDZUMS",this.daudzums);
		this.addVariable("BAITS",this.baits);
		nom_key.setNocase().addAscendingField(nomenklat).addAscendingField(nom_source);
		this.addKey(nom_key);
	}
}
