package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Projekti extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString kods=Clarion.newString(9);
	public ClarionString nos_p=Clarion.newString(105);
	public ClarionString nos_a=Clarion.newString(6);
	public ClarionNumber svars=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_Key");
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");

	public Projekti()
	{
		setName(Clarion.newString("PROJEKTI"));
		setPrefix("PRO");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("KODS",this.kods);
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("NOS_A",this.nos_a);
		this.addVariable("SVARS",this.svars);
		this.addVariable("BAITS",this.baits);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		nos_key.setDuplicate().setNocase().setOptional().addAscendingField(nos_a);
		this.addKey(nos_key);
	}
}
