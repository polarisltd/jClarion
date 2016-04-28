package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Grafiks extends ClarionSQLFile
{
	public ClarionNumber yyyymm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString ini=Clarion.newString(15);
	public ClarionArray<ClarionArray<ClarionString>> g=Clarion.newString(1).dim(48).dim(31);
	public ClarionDecimal diena=Clarion.newDecimal(4,1);
	public ClarionDecimal nakts=Clarion.newDecimal(4,1);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey ini_key=new ClarionKey("INI_KEY");
	public ClarionKey yyyymm_key=new ClarionKey("YYYYMM_KEY");
	public ClarionKey id_dat=new ClarionKey("ID_DAT");

	public Grafiks()
	{
		setPrefix("GRA");
		setName(Clarion.newString("grafiks"));
		setCreate();
		this.addVariable("YYYYMM",this.yyyymm);
		this.addVariable("ID",this.id);
		this.addVariable("INI",this.ini);
		this.addVariable("G",this.g);
		this.addVariable("DIENA",this.diena);
		this.addVariable("NAKTS",this.nakts);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		ini_key.setDuplicate().setNocase().setOptional().addAscendingField(ini).addAscendingField(yyyymm);
		this.addKey(ini_key);
		yyyymm_key.setDuplicate().setNocase().setOptional().addAscendingField(yyyymm).addAscendingField(id);
		this.addKey(yyyymm_key);
		id_dat.setDuplicate().setNocase().setOptional().addAscendingField(id).addAscendingField(yyyymm);
		this.addKey(id_dat);
	}
}
