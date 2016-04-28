package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Ggk_table extends ClarionQueue
{
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString reference=Clarion.newString(14);
	public ClarionString d_k=Clarion.newString(1);
	public ClarionDecimal summa=Clarion.newDecimal(14,5);
	public ClarionDecimal summav=Clarion.newDecimal(14,5);
	public ClarionString bkk=Clarion.newString(5);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber pvn_proc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString pvn_tips=Clarion.newString(1);
	public ClarionString val=Clarion.newString(3);
	public ClarionNumber kk=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Ggk_table()
	{
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("REFERENCE",this.reference);
		this.addVariable("D_K",this.d_k);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("BKK",this.bkk);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("PVN_PROC",this.pvn_proc);
		this.addVariable("PVN_TIPS",this.pvn_tips);
		this.addVariable("VAL",this.val);
		this.addVariable("KK",this.kk);
		this.setPrefix("GGT");
	}
}
