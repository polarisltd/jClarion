package clarion.winla001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueBrowse_1 extends ClarionQueue
{
	public ClarionString brw1NodU_nr;
	public ClarionNumber brw1NodU_nrNormalfg;
	public ClarionNumber brw1NodU_nrNormalbg;
	public ClarionNumber brw1NodU_nrSelectedfg;
	public ClarionNumber brw1NodU_nrSelectedbg;
	public ClarionString brw1Nos_p;
	public ClarionNumber brw1Nos_pNormalfg;
	public ClarionNumber brw1Nos_pNormalbg;
	public ClarionNumber brw1Nos_pSelectedfg;
	public ClarionNumber brw1Nos_pSelectedbg;
	public ClarionNumber brw1NodSvars;
	public ClarionString brw1NodKods;
	public ClarionNumber brw1Mark;
	public ClarionString brw1Position;

	public QueueBrowse_1(ClarionString nos_p)
	{
		this.brw1NodU_nr=Clarion.newString(2);
		this.addVariable("BRW1::NOD:U_NR",this.brw1NodU_nr);
		this.brw1NodU_nrNormalfg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOD:U_NR:NormalFG",this.brw1NodU_nrNormalfg);
		this.brw1NodU_nrNormalbg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOD:U_NR:NormalBG",this.brw1NodU_nrNormalbg);
		this.brw1NodU_nrSelectedfg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOD:U_NR:SelectedFG",this.brw1NodU_nrSelectedfg);
		this.brw1NodU_nrSelectedbg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOD:U_NR:SelectedBG",this.brw1NodU_nrSelectedbg);
		this.brw1Nos_p=Clarion.newString(97);
		this.addVariable("BRW1::NOS_P",this.brw1Nos_p);
		this.brw1Nos_pNormalfg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOS_P:NormalFG",this.brw1Nos_pNormalfg);
		this.brw1Nos_pNormalbg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOS_P:NormalBG",this.brw1Nos_pNormalbg);
		this.brw1Nos_pSelectedfg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOS_P:SelectedFG",this.brw1Nos_pSelectedfg);
		this.brw1Nos_pSelectedbg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("BRW1::NOS_P:SelectedBG",this.brw1Nos_pSelectedbg);
		this.brw1NodSvars=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("BRW1::NOD:SVARS",this.brw1NodSvars);
		this.brw1NodKods=Clarion.newString(6);
		this.addVariable("BRW1::NOD:KODS",this.brw1NodKods);
		this.brw1Mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("BRW1::Mark",this.brw1Mark);
		this.brw1Position=Clarion.newString(512);
		this.addVariable("BRW1::Position",this.brw1Position);
		this.setPrefix("");
	}
}
