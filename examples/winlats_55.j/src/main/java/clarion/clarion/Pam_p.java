package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pam_p extends ClarionSQLFile
{
	public ClarionDecimal u_nr=Clarion.newDecimal(6,0);
	public ClarionString vieta=Clarion.newString(25);
	public ClarionString komentars=Clarion.newString(25);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Pam_p()
	{
		setPrefix("PAP");
		setName(Clarion.newString("pam_p"));
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("VIETA",this.vieta);
		this.addVariable("KOMENTARS",this.komentars);
		nr_key.setDuplicate().setNocase().addAscendingField(u_nr);
		this.addKey(nr_key);
	}
}
