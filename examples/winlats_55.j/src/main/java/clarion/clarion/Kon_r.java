package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Kon_r extends ClarionSQLFile
{
	public ClarionString ugp=Clarion.newString(1);
	public ClarionNumber kods=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber user=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString nosaukums=Clarion.newString(100);
	public ClarionString nosaukumsa=Clarion.newString(100);
	public ClarionKey ugp_key=new ClarionKey("UGP_KEY");

	public Kon_r()
	{
		setName(Main.konrname);
		setPrefix("KONR");
		setCreate();
		this.addVariable("UGP",this.ugp);
		this.addVariable("KODS",this.kods);
		this.addVariable("USER",this.user);
		this.addVariable("Nosaukums",this.nosaukums);
		this.addVariable("NosaukumsA",this.nosaukumsa);
		ugp_key.setNocase().setOptional().addAscendingField(ugp).addAscendingField(kods);
		this.addKey(ugp_key);
	}
}
