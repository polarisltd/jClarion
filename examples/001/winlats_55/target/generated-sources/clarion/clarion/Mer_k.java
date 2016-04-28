package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Mer_k extends ClarionSQLFile
{
	public ClarionString mervien=Clarion.newString(7);
	public ClarionKey mer_key=new ClarionKey("MER_KEY");

	public Mer_k()
	{
		setName(Clarion.newString("MER_K"));
		setPrefix("MER");
		setCreate();
		this.addVariable("MERVIEN",this.mervien);
		mer_key.setDuplicate().setNocase().setOptional().addAscendingField(mervien);
		this.addKey(mer_key);
	}
}
