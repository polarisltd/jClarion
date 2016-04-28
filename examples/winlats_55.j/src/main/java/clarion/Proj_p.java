package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Proj_p extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.DATE);
	public ClarionDecimal plans=Clarion.newDecimal(10,2);
	public ClarionString komentars=Clarion.newString(40);
	public ClarionKey nr_key=new ClarionKey("Nr_Key");

	public Proj_p()
	{
		setPrefix("PRP");
		setCreate();
		setName(Clarion.newString("proj_p"));
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("PLANS",this.plans);
		this.addVariable("Komentars",this.komentars);
		nr_key.setNocase().setOptional().addAscendingField(u_nr).addDescendingField(datums);
		this.addKey(nr_key);
	}
}
