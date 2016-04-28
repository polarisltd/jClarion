package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Auto extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString v_nr=Clarion.newString(12);
	public ClarionString v_nr2=Clarion.newString(7);
	public ClarionString marka=Clarion.newString(30);
	public ClarionNumber mmyyyy=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString virsb_nr=Clarion.newString(20);
	public ClarionString dzinejs=Clarion.newString(20);
	public ClarionString dzineja_k=Clarion.newString(20);
	public ClarionString krasa=Clarion.newString(20);
	public ClarionNumber par_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber gar_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber gar_km=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber pap_kods=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString piezimes=Clarion.newString(40);
	public ClarionString servisagram=Clarion.newString(8);
	public ClarionNumber segr_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal paterins=Clarion.newDecimal(4,1);
	public ClarionDecimal paterins_a=Clarion.newDecimal(4,1);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString par_nos=Clarion.newString(15);
	public ClarionNumber vad_id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString vaditajs=Clarion.newString(35);
	public ClarionString perskods=Clarion.newString("@P######-#####P");
	public ClarionString telefons=Clarion.newString(20);
	public ClarionString gnet_flag=Clarion.newString(2);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey par_key=new ClarionKey("Par_key");
	public ClarionKey v_nr_key=new ClarionKey("V_Nr_key");
	public ClarionKey virsb_key=new ClarionKey("Virsb_key");
	public ClarionKey mark_key=new ClarionKey("MARK_KEY");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Auto()
	{
		setName(Clarion.newString("AUTO"));
		setPrefix("AUT");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("V_Nr",this.v_nr);
		this.addVariable("V_Nr2",this.v_nr2);
		this.addVariable("MARKA",this.marka);
		this.addVariable("MMYYYY",this.mmyyyy);
		this.addVariable("Virsb_Nr",this.virsb_nr);
		this.addVariable("Dzinejs",this.dzinejs);
		this.addVariable("Dzineja_K",this.dzineja_k);
		this.addVariable("Krasa",this.krasa);
		this.addVariable("PAR_DAT",this.par_dat);
		this.addVariable("GAR_DAT",this.gar_dat);
		this.addVariable("Gar_km",this.gar_km);
		this.addVariable("Pap_kods",this.pap_kods);
		this.addVariable("Piezimes",this.piezimes);
		this.addVariable("SERVISAGRAM",this.servisagram);
		this.addVariable("SEGR_DAT",this.segr_dat);
		this.addVariable("PATERINS",this.paterins);
		this.addVariable("PATERINS_A",this.paterins_a);
		this.addVariable("Par_Nr",this.par_nr);
		this.addVariable("Par_nos",this.par_nos);
		this.addVariable("VAD_ID",this.vad_id);
		this.addVariable("Vaditajs",this.vaditajs);
		this.addVariable("PERSKODS",this.perskods);
		this.addVariable("Telefons",this.telefons);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setNocase().addAscendingField(u_nr);
		this.addKey(nr_key);
		par_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr);
		this.addKey(par_key);
		v_nr_key.setDuplicate().setNocase().setOptional().addAscendingField(v_nr);
		this.addKey(v_nr_key);
		virsb_key.setDuplicate().setNocase().setOptional().addAscendingField(virsb_nr);
		this.addKey(virsb_key);
		mark_key.setDuplicate().setNocase().setOptional().addAscendingField(marka);
		this.addKey(mark_key);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
