package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Autokra extends ClarionSQLFile
{
	public ClarionString krasa=Clarion.newString(20);
	public ClarionString krasa_a=Clarion.newString(7);
	public ClarionKey kra_key=new ClarionKey("KRA_Key");

	public Autokra()
	{
		setPrefix("KRA");
		setName(Clarion.newString("autokra"));
		setCreate();
		this.addVariable("KRASA",this.krasa);
		this.addVariable("KRASA_A",this.krasa_a);
		kra_key.setDuplicate().setNocase().addAscendingField(krasa_a);
		this.addKey(kra_key);
	}
}
