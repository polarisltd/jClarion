package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nom_k extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString kataloga_nr=Clarion.newString(22);
	public ClarionDecimal muitas_kods=Clarion.newDecimal(10,0);
	public ClarionString izc_v_kods=Clarion.newString(2);
	public ClarionString analogs=Clarion.newString(7);
	public ClarionString ean=Clarion.newString(1);
	public ClarionDecimal kods=Clarion.newDecimal(13,0);
	public ClarionString kods_plus=Clarion.newString(1);
	public ClarionString tips=Clarion.newString(1);
	public ClarionString nos_p=Clarion.newString(50);
	public ClarionString nos_s=Clarion.newString(16);
	public ClarionString nos_a=Clarion.newString(8);
	public ClarionString mervien=Clarion.newString(7);
	public ClarionNumber redzamiba=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber neatl=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString bkk=Clarion.newString(5);
	public ClarionString okk6=Clarion.newString(5);
	public ClarionNumber pvn_proc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal svarskg=Clarion.newDecimal(10,5);
	public ClarionDecimal koef_esknpm=Clarion.newDecimal(6,3);
	public ClarionDecimal skaits_i=Clarion.newDecimal(9,4);
	public ClarionNumber der_term=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionArray<ClarionDecimal> krit_dau=Clarion.newDecimal(7,2).dim(25);
	public ClarionArray<ClarionDecimal> max_dau=Clarion.newDecimal(7,2).dim(25);
	public ClarionDecimal muita=Clarion.newDecimal(9,3);
	public ClarionDecimal akcize=Clarion.newDecimal(9,3);
	public ClarionArray<ClarionDecimal> realiz=Clarion.newDecimal(11,4).dim(5);
	public ClarionNumber arpvnbyte=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionArray<ClarionString> val=Clarion.newString(3).dim(5);
	public ClarionDecimal proc5=Clarion.newDecimal(3,0);
	public ClarionDecimal minrc=Clarion.newDecimal(11,4);
	public ClarionDecimal pic=Clarion.newDecimal(11,4);
	public ClarionNumber pic_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString cits_tekstspz=Clarion.newString(21);
	public ClarionString rinda2pz=Clarion.newString(50);
	public ClarionString statuss=Clarion.newString(25);
	public ClarionString gnet_flag=Clarion.newString(2);
	public ClarionNumber atbildigais=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber etiketes=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal punkti=Clarion.newDecimal(9,3);
	public ClarionNumber dg=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");
	public ClarionKey kod_key=new ClarionKey("KOD_KEY");
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");
	public ClarionKey kat_key=new ClarionKey("KAT_KEY");
	public ClarionKey anal_key=new ClarionKey("ANAL_KEY");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Nom_k()
	{
		setName(Main.nomname);
		setPrefix("NOM");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("KATALOGA_NR",this.kataloga_nr);
		this.addVariable("MUITAS_KODS",this.muitas_kods);
		this.addVariable("IZC_V_KODS",this.izc_v_kods);
		this.addVariable("ANALOGS",this.analogs);
		this.addVariable("EAN",this.ean);
		this.addVariable("KODS",this.kods);
		this.addVariable("KODS_PLUS",this.kods_plus);
		this.addVariable("TIPS",this.tips);
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("NOS_A",this.nos_a);
		this.addVariable("MERVIEN",this.mervien);
		this.addVariable("REDZAMIBA",this.redzamiba);
		this.addVariable("NEATL",this.neatl);
		this.addVariable("BKK",this.bkk);
		this.addVariable("OKK6",this.okk6);
		this.addVariable("PVN_PROC",this.pvn_proc);
		this.addVariable("SVARSKG",this.svarskg);
		this.addVariable("KOEF_ESKNPM",this.koef_esknpm);
		this.addVariable("SKAITS_I",this.skaits_i);
		this.addVariable("DER_TERM",this.der_term);
		this.addVariable("KRIT_DAU",this.krit_dau);
		this.addVariable("MAX_DAU",this.max_dau);
		this.addVariable("MUITA",this.muita);
		this.addVariable("AKCIZE",this.akcize);
		this.addVariable("REALIZ",this.realiz);
		this.addVariable("ARPVNBYTE",this.arpvnbyte);
		this.addVariable("VAL",this.val);
		this.addVariable("PROC5",this.proc5);
		this.addVariable("MINRC",this.minrc);
		this.addVariable("PIC",this.pic);
		this.addVariable("PIC_DATUMS",this.pic_datums);
		this.addVariable("CITS_TEKSTSPZ",this.cits_tekstspz);
		this.addVariable("RINDA2PZ",this.rinda2pz);
		this.addVariable("STATUSS",this.statuss);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		this.addVariable("ATBILDIGAIS",this.atbildigais);
		this.addVariable("ETIKETES",this.etiketes);
		this.addVariable("PUNKTI",this.punkti);
		this.addVariable("DG",this.dg);
		this.addVariable("BAITS1",this.baits1);
		this.addVariable("BAITS2",this.baits2);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nom_key.setNocase().addAscendingField(nomenklat);
		this.addKey(nom_key);
		kod_key.setNocase().setOptional().addAscendingField(kods).addAscendingField(kods_plus);
		this.addKey(kod_key);
		nos_key.setDuplicate().setNocase().addAscendingField(nos_a);
		this.addKey(nos_key);
		kat_key.setDuplicate().setNocase().setOptional().addAscendingField(kataloga_nr);
		this.addKey(kat_key);
		anal_key.setDuplicate().setNocase().setOptional().addAscendingField(analogs);
		this.addKey(anal_key);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
