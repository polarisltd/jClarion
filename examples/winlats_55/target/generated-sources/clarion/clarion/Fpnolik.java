package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Fpnolik extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionDecimal kods=Clarion.newDecimal(13,0);
	public ClarionString kods_plus=Clarion.newString(1);
	public ClarionString nom_tips=Clarion.newString(1);
	public ClarionString nos_p=Clarion.newString(50);
	public ClarionString mervien=Clarion.newString(7);
	public ClarionDecimal daudzums=Clarion.newDecimal(10,3);
	public ClarionDecimal summa=Clarion.newDecimal(7,2);
	public ClarionNumber pvn_pr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal atlaide_pr=Clarion.newDecimal(3,1);
	public ClarionNumber mak_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionDecimal apd_summa=Clarion.newDecimal(7,2);
	public ClarionNumber dak_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber iest_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString rec_nr=Clarion.newString(10);
	public ClarionNumber rec_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString diag_k=Clarion.newString(6);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber seciba=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Fpnolik()
	{
		setName(Main.fpnolikname);
		setPrefix("FPN");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("KODS",this.kods);
		this.addVariable("KODS_PLUS",this.kods_plus);
		this.addVariable("NOM_TIPS",this.nom_tips);
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("MERVIEN",this.mervien);
		this.addVariable("DAUDZUMS",this.daudzums);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("PVN_PR",this.pvn_pr);
		this.addVariable("ATLAIDE_PR",this.atlaide_pr);
		this.addVariable("MAK_NR",this.mak_nr);
		this.addVariable("APD_SUMMA",this.apd_summa);
		this.addVariable("DAK_NR",this.dak_nr);
		this.addVariable("IEST_NR",this.iest_nr);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("REC_NR",this.rec_nr);
		this.addVariable("REC_DATUMS",this.rec_datums);
		this.addVariable("DIAG_K",this.diag_k);
		this.addVariable("BAITS",this.baits);
		this.addVariable("SECIBA",this.seciba);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(u_nr).addDescendingField(seciba);
		this.addKey(nr_key);
	}
}
