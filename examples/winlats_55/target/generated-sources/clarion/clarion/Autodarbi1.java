package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Autodarbi1 extends ClarionSQLFile
{
	public ClarionNumber pav_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionDecimal laiks=Clarion.newDecimal(7,2);
	public ClarionNumber garantija=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey id_key=new ClarionKey("ID_KEY");

	public Autodarbi1()
	{
		setName(Main.filename1);
		setPrefix("APD1");
		setCreate();
		this.addVariable("PAV_NR",this.pav_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("ID",this.id);
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("LAIKS",this.laiks);
		this.addVariable("GARANTIJA",this.garantija);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(pav_nr);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().setOptional().addAscendingField(datums);
		this.addKey(dat_key);
		id_key.setDuplicate().setNocase().setOptional().addAscendingField(id).addAscendingField(datums);
		this.addKey(id_key);
	}
}
