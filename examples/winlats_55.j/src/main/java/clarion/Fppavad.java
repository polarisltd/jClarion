package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Fppavad extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber ceka_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber nol_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber rs=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber av=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber rt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber es=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber laiks=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString nos_p=Clarion.newString(35);
	public ClarionString adrese=Clarion.newString(40);
	public ClarionString reg_nr=Clarion.newString(13);
	public ClarionString ban_kods=Clarion.newString(10);
	public ClarionString ban_nr=Clarion.newString(21);
	public ClarionString teksts=Clarion.newString(40);
	public ClarionDecimal katlaide=Clarion.newDecimal(7,2);
	public ClarionDecimal apd_summa=Clarion.newDecimal(7,2);
	public ClarionDecimal kr3_summa=Clarion.newDecimal(7,2);
	public ClarionDecimal kr2_summa=Clarion.newDecimal(7,2);
	public ClarionDecimal kar_summa=Clarion.newDecimal(7,2);
	public ClarionDecimal ksumma=Clarion.newDecimal(7,2);
	public ClarionString val=Clarion.newString(3);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Fppavad()
	{
		setName(Main.fppavadname);
		setPrefix("FPP");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("CEKA_NR",this.ceka_nr);
		this.addVariable("NOL_NR",this.nol_nr);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("RS",this.rs);
		this.addVariable("AV",this.av);
		this.addVariable("RT",this.rt);
		this.addVariable("ES",this.es);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("LAIKS",this.laiks);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("ADRESE",this.adrese);
		this.addVariable("REG_NR",this.reg_nr);
		this.addVariable("BAN_KODS",this.ban_kods);
		this.addVariable("BAN_NR",this.ban_nr);
		this.addVariable("TEKSTS",this.teksts);
		this.addVariable("KATLAIDE",this.katlaide);
		this.addVariable("APD_SUMMA",this.apd_summa);
		this.addVariable("KR3_SUMMA",this.kr3_summa);
		this.addVariable("KR2_SUMMA",this.kr2_summa);
		this.addVariable("KAR_SUMMA",this.kar_summa);
		this.addVariable("KSUMMA",this.ksumma);
		this.addVariable("VAL",this.val);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setNocase().setOptional().setPrimary().addAscendingField(u_nr);
		this.addKey(nr_key);
	}
}
