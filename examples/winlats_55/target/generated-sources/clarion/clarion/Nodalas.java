package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nodalas extends ClarionSQLFile
{
	public ClarionString u_nr=Clarion.newString(2);
	public ClarionString kods=Clarion.newString(6);
	public ClarionString nos_p=Clarion.newString(90);
	public ClarionNumber svars=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("Nr_Key");
	public ClarionKey kods_key=new ClarionKey("KODS_KEY");

	public Nodalas()
	{
		setPrefix("NOD");
		setName(Clarion.newString("nodalas"));
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("KODS",this.kods);
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("SVARS",this.svars);
		this.addVariable("BAITS",this.baits);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		kods_key.setDuplicate().setNocase().setOptional().addAscendingField(kods);
		this.addKey(kods_key);
	}
}
