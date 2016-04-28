package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Automarkas extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString marka=Clarion.newString(30);
	public ClarionString gnet_flag=Clarion.newString(2);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey keymarka=new ClarionKey("KeyMARKA");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Automarkas()
	{
		setName(Clarion.newString("AUTOMARK"));
		setPrefix("AMA");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("MARKA",this.marka);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		nr_key.setNocase().addAscendingField(u_nr);
		this.addKey(nr_key);
		keymarka.setNocase().setOptional().addAscendingField(marka);
		this.addKey(keymarka);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
