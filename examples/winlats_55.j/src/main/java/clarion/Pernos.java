package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pernos extends ClarionSQLFile
{
	public ClarionString pazime=Clarion.newString(1);
	public ClarionNumber yyyymm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString ini=Clarion.newString(5);
	public ClarionNumber rik_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber sak_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber bei_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber a_dienas=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal vsumma=Clarion.newDecimal(7,3);
	public ClarionDecimal vsummas=Clarion.newDecimal(7,3);
	public ClarionNumber dienas=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal summa=Clarion.newDecimal(7,2);
	public ClarionNumber dienas0=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber dienas0c=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal summa0=Clarion.newDecimal(7,2);
	public ClarionNumber dienas1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber dienas1c=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal summa1=Clarion.newDecimal(7,2);
	public ClarionNumber dienas2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber dienas2c=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal summa2=Clarion.newDecimal(7,2);
	public ClarionNumber dienass=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal summas=Clarion.newDecimal(7,2);
	public ClarionNumber dienasx=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber dienasxc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal summax=Clarion.newDecimal(7,2);
	public ClarionNumber lock=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey id_key=new ClarionKey("ID_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey ini_key=new ClarionKey("INI_KEY");

	public Pernos()
	{
		setName(Clarion.newString("PERNOS"));
		setPrefix("PER");
		setCreate();
		this.addVariable("PAZIME",this.pazime);
		this.addVariable("YYYYMM",this.yyyymm);
		this.addVariable("ID",this.id);
		this.addVariable("INI",this.ini);
		this.addVariable("RIK_NR",this.rik_nr);
		this.addVariable("SAK_DAT",this.sak_dat);
		this.addVariable("BEI_DAT",this.bei_dat);
		this.addVariable("A_DIENAS",this.a_dienas);
		this.addVariable("VSUMMA",this.vsumma);
		this.addVariable("VSUMMAS",this.vsummas);
		this.addVariable("DIENAS",this.dienas);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("DIENAS0",this.dienas0);
		this.addVariable("DIENAS0C",this.dienas0c);
		this.addVariable("SUMMA0",this.summa0);
		this.addVariable("DIENAS1",this.dienas1);
		this.addVariable("DIENAS1C",this.dienas1c);
		this.addVariable("SUMMA1",this.summa1);
		this.addVariable("DIENAS2",this.dienas2);
		this.addVariable("DIENAS2C",this.dienas2c);
		this.addVariable("SUMMA2",this.summa2);
		this.addVariable("DIENASS",this.dienass);
		this.addVariable("SUMMAS",this.summas);
		this.addVariable("DIENASX",this.dienasx);
		this.addVariable("DIENASXC",this.dienasxc);
		this.addVariable("SUMMAX",this.summax);
		this.addVariable("LOCK",this.lock);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		id_key.setDuplicate().setNocase().setOptional().addAscendingField(id).addAscendingField(pazime).addAscendingField(yyyymm);
		this.addKey(id_key);
		dat_key.setDuplicate().setNocase().setOptional().addAscendingField(pazime).addDescendingField(sak_dat);
		this.addKey(dat_key);
		ini_key.setDuplicate().setNocase().setOptional().addAscendingField(ini).addAscendingField(pazime).addDescendingField(yyyymm);
		this.addKey(ini_key);
	}
}
