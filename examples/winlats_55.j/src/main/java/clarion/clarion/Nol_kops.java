package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nol_kops extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString kataloga_nr=Clarion.newString(22);
	public ClarionString nos_s=Clarion.newString(16);
	public ClarionArray<ClarionArray<ClarionNumber>> statuss=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(25).dim(18);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey nom_key=new ClarionKey("NOM_key");

	public Nol_kops()
	{
		setName(Clarion.newString("NOL_KOPS"));
		setPrefix("KOPS");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("KATALOGA_NR",this.kataloga_nr);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("STATUSS",this.statuss);
		this.addVariable("BAITS",this.baits);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		nom_key.setDuplicate().setNocase().setOptional().addAscendingField(nomenklat);
		this.addKey(nom_key);
	}
}
