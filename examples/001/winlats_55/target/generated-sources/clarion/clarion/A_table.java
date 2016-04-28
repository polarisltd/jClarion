package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class A_table extends ClarionQueue
{
	public ClarionString reference=Clarion.newString(14);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal summav=Clarion.newDecimal(11,2);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionString val=Clarion.newString(3);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionDecimal summav_t=Clarion.newDecimal(11,2);
	public ClarionString val_t=Clarion.newString(3);
	public ClarionString bkk=Clarion.newString(5);
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber pvn_proc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public A_table()
	{
		this.addVariable("REFERENCE",this.reference);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("VAL",this.val);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("SUMMAV_T",this.summav_t);
		this.addVariable("VAL_T",this.val_t);
		this.addVariable("BKK",this.bkk);
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("PVN_PROC",this.pvn_proc);
		this.setPrefix("A");
	}
}
