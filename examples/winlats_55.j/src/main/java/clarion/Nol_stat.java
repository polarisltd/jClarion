package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nol_stat extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString kataloga_nr=Clarion.newString(22);
	public ClarionNumber redzamiba=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber atbildigais=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString nos_s=Clarion.newString(16);
	public ClarionArray<ClarionArray<ClarionNumber>> daudzums=Clarion.newNumber().setEncoding(ClarionNumber.LONG).dim(15).dim(12);
	public ClarionArray<ClarionArray<ClarionDecimal>> summa=Clarion.newDecimal(9,2).dim(15).dim(12);
	public ClarionKey nom_key=new ClarionKey("NOM_key");
	public ClarionKey atb_key=new ClarionKey("ATB_KEY");

	public Nol_stat()
	{
		setName(Clarion.newString("NOL_STAT"));
		setPrefix("STAT");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("KATALOGA_NR",this.kataloga_nr);
		this.addVariable("REDZAMIBA",this.redzamiba);
		this.addVariable("ATBILDIGAIS",this.atbildigais);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("DAUDZUMS",this.daudzums);
		this.addVariable("SUMMA",this.summa);
		nom_key.setDuplicate().setNocase().setOptional().addAscendingField(nomenklat);
		this.addKey(nom_key);
		atb_key.setDuplicate().setNocase().setOptional().addAscendingField(atbildigais).addAscendingField(nomenklat);
		this.addKey(atb_key);
	}
}
