package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Kat_k extends ClarionSQLFile
{
	public ClarionString kat=Clarion.newString(3);
	public ClarionString iiv=Clarion.newString(2);
	public ClarionString grupa=Clarion.newString(2);
	public ClarionDecimal likme=Clarion.newDecimal(3,0);
	public ClarionDecimal gadi=Clarion.newDecimal(3,1);
	public ClarionDecimal aplkoef=Clarion.newDecimal(3,1);
	public ClarionString kods=Clarion.newString("@p#.##.#p");
	public ClarionString nosaukums=Clarion.newString(72);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Kat_k()
	{
		setName(Clarion.newString("KAT_K"));
		setPrefix("KAT");
		setCreate();
		this.addVariable("KAT",this.kat);
		this.addVariable("IIV",this.iiv);
		this.addVariable("GRUPA",this.grupa);
		this.addVariable("LIKME",this.likme);
		this.addVariable("GADI",this.gadi);
		this.addVariable("APLKOEF",this.aplkoef);
		this.addVariable("KODS",this.kods);
		this.addVariable("NOSAUKUMS",this.nosaukums);
		nr_key.setNocase().addAscendingField(kat);
		this.addKey(nr_key);
	}
}
