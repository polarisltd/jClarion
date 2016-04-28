package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Val_k extends ClarionSQLFile
{
	public ClarionString val=Clarion.newString(3);
	public ClarionString v_kods=Clarion.newString(2);
	public ClarionString valsts=Clarion.newString(20);
	public ClarionString valsts_a=Clarion.newString(20);
	public ClarionString dzimte=Clarion.newString(1);
	public ClarionString rubli=Clarion.newString(20);
	public ClarionString rubli_a=Clarion.newString(20);
	public ClarionString kapiki=Clarion.newString(7);
	public ClarionString kapiki_a=Clarion.newString(7);
	public ClarionString bkk=Clarion.newString(5);
	public ClarionString bkkk=Clarion.newString(5);
	public ClarionString tips=Clarion.newString(1);
	public ClarionDecimal test=Clarion.newDecimal(14,10);
	public ClarionString gnet_flag=Clarion.newString(2);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");
	public ClarionKey kods_key=new ClarionKey("KODS_KEY");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Val_k()
	{
		setName(Clarion.newString("VAL_K"));
		setPrefix("VAL");
		setCreate();
		this.addVariable("VAL",this.val);
		this.addVariable("V_KODS",this.v_kods);
		this.addVariable("VALSTS",this.valsts);
		this.addVariable("VALSTS_A",this.valsts_a);
		this.addVariable("DZIMTE",this.dzimte);
		this.addVariable("RUBLI",this.rubli);
		this.addVariable("RUBLI_A",this.rubli_a);
		this.addVariable("KAPIKI",this.kapiki);
		this.addVariable("KAPIKI_A",this.kapiki_a);
		this.addVariable("BKK",this.bkk);
		this.addVariable("BKKK",this.bkkk);
		this.addVariable("Tips",this.tips);
		this.addVariable("TEST",this.test);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nos_key.setOptional().addAscendingField(val);
		this.addKey(nos_key);
		kods_key.setNocase().setOptional().addAscendingField(v_kods);
		this.addKey(kods_key);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
