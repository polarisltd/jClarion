package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Cenuvest extends ClarionSQLFile
{
	public ClarionString kataloga_nr=Clarion.newString(22);
	public ClarionString nos_u=Clarion.newString(3);
	public ClarionNumber skaits=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionDecimal cena=Clarion.newDecimal(9,2);
	public ClarionString valuta=Clarion.newString(3);
	public ClarionDecimal cena1=Clarion.newDecimal(7,2);
	public ClarionDecimal cena2=Clarion.newDecimal(7,2);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString keksis=Clarion.newString(1);
	public ClarionKey kat_key=new ClarionKey("KAT_KEY");

	public Cenuvest()
	{
		setName(Clarion.newString("CENUVEST"));
		setPrefix("CEN");
		setCreate();
		this.addVariable("KATALOGA_NR",this.kataloga_nr);
		this.addVariable("NOS_U",this.nos_u);
		this.addVariable("SKAITS",this.skaits);
		this.addVariable("CENA",this.cena);
		this.addVariable("VALUTA",this.valuta);
		this.addVariable("CENA1",this.cena1);
		this.addVariable("CENA2",this.cena2);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("KEKSIS",this.keksis);
		kat_key.setDuplicate().setNocase().setOptional().addAscendingField(kataloga_nr).addAscendingField(nos_u).addAscendingField(datums);
		this.addKey(kat_key);
	}
}
