package clarion.winla_ru;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Sav extends ClarionGroup
{
	public ClarionNumber atlU_nr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString gr1Grupa1=Clarion.newString(3);
	public ClarionString nomNomenklat=Clarion.newString(21);
	public ClarionNumber pamU_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);

	public Sav()
	{
		this.addVariable("ATL:U_NR",this.atlU_nr);
		this.addVariable("GR1:GRUPA1",this.gr1Grupa1);
		this.addVariable("NOM:NOMENKLAT",this.nomNomenklat);
		this.addVariable("PAM:U_NR",this.pamU_nr);
	}
}
