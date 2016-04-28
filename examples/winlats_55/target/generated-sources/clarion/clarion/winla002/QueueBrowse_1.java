package clarion.winla002;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueBrowse_1 extends ClarionQueue
{
	public ClarionString brw1BanKods=Clarion.newString(15);
	public ClarionString brw1BanNos_s=Clarion.newString(15);
	public ClarionString brw1BanNos_p=Clarion.newString(31);
	public ClarionString brw1BanNos_a=Clarion.newString(4);
	public ClarionNumber brw1Mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString brw1Position=Clarion.newString(512);

	public QueueBrowse_1()
	{
		this.addVariable("BRW1::BAN:KODS",this.brw1BanKods);
		this.addVariable("BRW1::BAN:NOS_S",this.brw1BanNos_s);
		this.addVariable("BRW1::BAN:NOS_P",this.brw1BanNos_p);
		this.addVariable("BRW1::BAN:NOS_A",this.brw1BanNos_a);
		this.addVariable("BRW1::Mark",this.brw1Mark);
		this.addVariable("BRW1::Position",this.brw1Position);
		this.setPrefix("");
	}
}
