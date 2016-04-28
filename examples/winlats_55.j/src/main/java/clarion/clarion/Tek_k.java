package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Tek_k extends ClarionSQLFile
{
	public ClarionString ini=Clarion.newString(15);
	public ClarionString teksts=Clarion.newString(47);
	public ClarionString teksts2=Clarion.newString(47);
	public ClarionString teksts3=Clarion.newString(47);
	public ClarionString tips=Clarion.newString(1);
	public ClarionString att_dok=Clarion.newString(1);
	public ClarionNumber ref_obj=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString par_nos=Clarion.newString(15);
	public ClarionNumber ava_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString ava_nos=Clarion.newString(15);
	public ClarionDecimal nokl_summa=Clarion.newDecimal(11,2);
	public ClarionString d_k1=Clarion.newString(1);
	public ClarionString d_k2=Clarion.newString(1);
	public ClarionString d_k3=Clarion.newString(1);
	public ClarionString d_k4=Clarion.newString(1);
	public ClarionString d_k5=Clarion.newString(1);
	public ClarionString d_k6=Clarion.newString(1);
	public ClarionString bkk_1=Clarion.newString(5);
	public ClarionString bkk_2=Clarion.newString(5);
	public ClarionString bkk_3=Clarion.newString(5);
	public ClarionString bkk_4=Clarion.newString(5);
	public ClarionString bkk_5=Clarion.newString(5);
	public ClarionString bkk_6=Clarion.newString(5);
	public ClarionNumber pvn_1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber pvn_2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber pvn_3=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber pvn_4=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber pvn_5=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber pvn_6=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal k_1=Clarion.newDecimal(6,3);
	public ClarionDecimal k_2=Clarion.newDecimal(6,3);
	public ClarionDecimal k_3=Clarion.newDecimal(6,3);
	public ClarionDecimal k_4=Clarion.newDecimal(6,3);
	public ClarionDecimal k_5=Clarion.newDecimal(6,3);
	public ClarionDecimal k_6=Clarion.newDecimal(6,3);
	public ClarionString pvn_tips=Clarion.newString(1);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Tek_k()
	{
		setName(Clarion.newString("TEK_K"));
		setPrefix("TEK");
		setCreate();
		this.addVariable("INI",this.ini);
		this.addVariable("TEKSTS",this.teksts);
		this.addVariable("TEKSTS2",this.teksts2);
		this.addVariable("TEKSTS3",this.teksts3);
		this.addVariable("TIPS",this.tips);
		this.addVariable("ATT_DOK",this.att_dok);
		this.addVariable("ref_obj",this.ref_obj);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("PAR_NOS",this.par_nos);
		this.addVariable("AVA_NR",this.ava_nr);
		this.addVariable("AVA_NOS",this.ava_nos);
		this.addVariable("NOKL_SUMMA",this.nokl_summa);
		this.addVariable("D_K1",this.d_k1);
		this.addVariable("D_K2",this.d_k2);
		this.addVariable("D_K3",this.d_k3);
		this.addVariable("D_K4",this.d_k4);
		this.addVariable("D_K5",this.d_k5);
		this.addVariable("D_K6",this.d_k6);
		this.addVariable("BKK_1",this.bkk_1);
		this.addVariable("BKK_2",this.bkk_2);
		this.addVariable("BKK_3",this.bkk_3);
		this.addVariable("BKK_4",this.bkk_4);
		this.addVariable("BKK_5",this.bkk_5);
		this.addVariable("BKK_6",this.bkk_6);
		this.addVariable("PVN_1",this.pvn_1);
		this.addVariable("PVN_2",this.pvn_2);
		this.addVariable("PVN_3",this.pvn_3);
		this.addVariable("PVN_4",this.pvn_4);
		this.addVariable("PVN_5",this.pvn_5);
		this.addVariable("PVN_6",this.pvn_6);
		this.addVariable("K_1",this.k_1);
		this.addVariable("K_2",this.k_2);
		this.addVariable("K_3",this.k_3);
		this.addVariable("K_4",this.k_4);
		this.addVariable("K_5",this.k_5);
		this.addVariable("K_6",this.k_6);
		this.addVariable("PVN_TIPS",this.pvn_tips);
		this.addVariable("BAITS",this.baits);
		this.addVariable("BAITS1",this.baits1);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(ini);
		this.addKey(nr_key);
	}
}
