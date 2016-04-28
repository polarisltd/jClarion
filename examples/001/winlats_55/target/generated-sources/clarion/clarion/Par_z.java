package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Par_z extends ClarionSQLFile
{
	public ClarionNumber nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString teksts=Clarion.newString(40);
	public ClarionString warlevel=Clarion.newString(1);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Par_z()
	{
		setPrefix("ATZ");
		setName(Clarion.newString("par_z"));
		setCreate();
		this.addVariable("NR",this.nr);
		this.addVariable("TEKSTS",this.teksts);
		this.addVariable("WARLEVEL",this.warlevel);
		nr_key.setNocase().addAscendingField(nr);
		this.addKey(nr_key);
	}
}
