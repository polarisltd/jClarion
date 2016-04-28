package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Autotex extends ClarionSQLFile
{
	public ClarionNumber pav_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString pazime=Clarion.newString(1);
	public ClarionString teksts=Clarion.newString(110);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Autotex()
	{
		setName(Main.atexname);
		setPrefix("APX");
		setCreate();
		this.addVariable("PAV_NR",this.pav_nr);
		this.addVariable("PAZIME",this.pazime);
		this.addVariable("TEKSTS",this.teksts);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(pav_nr);
		this.addKey(nr_key);
	}
}
