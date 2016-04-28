package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Amati extends ClarionSQLFile
{
	public ClarionString amats=Clarion.newString(25);
	public ClarionString ama_a=Clarion.newString(5);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString s_a=Clarion.newString(1);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey ams_key=new ClarionKey("AMS_KEY");

	public Amati()
	{
		setPrefix("AMS");
		setName(Clarion.newString("amati"));
		setCreate();
		this.addVariable("AMATS",this.amats);
		this.addVariable("AMA_A",this.ama_a);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("S_A",this.s_a);
		this.addVariable("BAITS",this.baits);
		ams_key.setDuplicate().setNocase().setOptional().addAscendingField(ama_a);
		this.addKey(ams_key);
	}
}
