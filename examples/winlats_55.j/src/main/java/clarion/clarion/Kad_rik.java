package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Kad_rik extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString tips=Clarion.newString(1);
	public ClarionNumber z_kods=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString dok_nr=Clarion.newString(10);
	public ClarionNumber datums1=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber datums2=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString saturs=Clarion.newString(60);
	public ClarionString saturs1=Clarion.newString(60);
	public ClarionString r_fails=Clarion.newString(12);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey id_key=new ClarionKey("ID_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey dat_dkey=new ClarionKey("DAT_DKEY");

	public Kad_rik()
	{
		setPrefix("RIK");
		setName(Clarion.newString("kad_rik"));
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("ID",this.id);
		this.addVariable("TIPS",this.tips);
		this.addVariable("Z_KODS",this.z_kods);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("DOK_NR",this.dok_nr);
		this.addVariable("DATUMS1",this.datums1);
		this.addVariable("DATUMS2",this.datums2);
		this.addVariable("SATURS",this.saturs);
		this.addVariable("SATURS1",this.saturs1);
		this.addVariable("R_FAILS",this.r_fails);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		id_key.setDuplicate().setNocase().addAscendingField(id).addDescendingField(datums);
		this.addKey(id_key);
		dat_key.setDuplicate().setNocase().setOptional().addAscendingField(datums).addAscendingField(dok_nr);
		this.addKey(dat_key);
		dat_dkey.setDuplicate().setNocase().setOptional().addDescendingField(datums).addDescendingField(dok_nr);
		this.addKey(dat_dkey);
	}
}
