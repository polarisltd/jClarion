package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Par_e extends ClarionSQLFile
{
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber ema_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString email=Clarion.newString(30);
	public ClarionString amats=Clarion.newString(20);
	public ClarionString kontakts=Clarion.newString(25);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Par_e()
	{
		setPrefix("EMA");
		setName(Clarion.newString("par_e"));
		setCreate();
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("EMA_NR",this.ema_nr);
		this.addVariable("EMAIL",this.email);
		this.addVariable("AMATS",this.amats);
		this.addVariable("KONTAKTS",this.kontakts);
		nr_key.setNocase().setOptional().addAscendingField(par_nr).addAscendingField(ema_nr);
		this.addKey(nr_key);
	}
}
