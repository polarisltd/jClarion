package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Kursi_k extends ClarionSQLFile
{
	public ClarionString val=Clarion.newString(3);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal kurss=Clarion.newDecimal(12,7);
	public ClarionString tips=Clarion.newString(1);
	public ClarionString lb=Clarion.newString(1);
	public ClarionString gnet_flag=Clarion.newString(2);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Kursi_k()
	{
		setName(Clarion.newString("KURSI_K"));
		setPrefix("KUR");
		setCreate();
		this.addVariable("VAL",this.val);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("KURSS",this.kurss);
		this.addVariable("TIPS",this.tips);
		this.addVariable("LB",this.lb);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nos_key.setOptional().addAscendingField(val).addAscendingField(datums);
		this.addKey(nos_key);
		dat_key.setDuplicate().setOptional().addAscendingField(datums).addAscendingField(val);
		this.addKey(dat_key);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
