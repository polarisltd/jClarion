package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Arm_k extends ClarionSQLFile
{
	public ClarionDecimal kods=Clarion.newDecimal(3,0);
	public ClarionDecimal lb=Clarion.newDecimal(3,0);
	public ClarionString nos_p=Clarion.newString(71);
	public ClarionString saturs1=Clarion.newString(70);
	public ClarionString saturs2=Clarion.newString(70);
	public ClarionString saturs3=Clarion.newString(70);
	public ClarionKey kods_key=new ClarionKey("KODS_KEY");
	public ClarionKey lb_key=new ClarionKey("LB_KEY");

	public Arm_k()
	{
		setPrefix("ARM");
		setCreate();
		setName(Clarion.newString("arm_k"));
		this.addVariable("KODS",this.kods);
		this.addVariable("LB",this.lb);
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("SATURS1",this.saturs1);
		this.addVariable("SATURS2",this.saturs2);
		this.addVariable("SATURS3",this.saturs3);
		kods_key.setNocase().setOptional().addAscendingField(kods);
		this.addKey(kods_key);
		lb_key.setDuplicate().setNocase().addAscendingField(lb);
		this.addKey(lb_key);
	}
}
