package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Eirokodi extends ClarionSQLFile
{
	public ClarionDecimal kods=Clarion.newDecimal(9,0);
	public ClarionString nos_s=Clarion.newString(50);
	public ClarionString likme=Clarion.newString(20);
	public ClarionString papild=Clarion.newString(3);
	public ClarionKey keykods=new ClarionKey("Keykods");

	public Eirokodi()
	{
		setName(Clarion.newString("EIROKODI"));
		setPrefix("EIR");
		setCreate();
		this.addVariable("kods",this.kods);
		this.addVariable("nos_s",this.nos_s);
		this.addVariable("likme",this.likme);
		this.addVariable("papild",this.papild);
		keykods.setNocase().setOptional().setPrimary().addAscendingField(kods);
		this.addKey(keykods);
	}
}
