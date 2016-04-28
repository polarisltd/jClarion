package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Teksti1 extends ClarionSQLFile
{
	public ClarionNumber nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString teksts1=Clarion.newString(60);
	public ClarionString teksts2=Clarion.newString(60);
	public ClarionString teksts3=Clarion.newString(60);
	public ClarionString tex_a=Clarion.newString(5);
	public ClarionDecimal km=Clarion.newDecimal(6,1);
	public ClarionString rik_tips=Clarion.newString(1);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey tex_key=new ClarionKey("TEX_KEY");

	public Teksti1()
	{
		setName(Main.filename1);
		setPrefix("TEX1");
		setCreate();
		this.addVariable("NR",this.nr);
		this.addVariable("TEKSTS1",this.teksts1);
		this.addVariable("TEKSTS2",this.teksts2);
		this.addVariable("TEKSTS3",this.teksts3);
		this.addVariable("TEX_A",this.tex_a);
		this.addVariable("KM",this.km);
		this.addVariable("RIK_TIPS",this.rik_tips);
		this.addVariable("BAITS",this.baits);
		nr_key.setNocase().addAscendingField(nr);
		this.addKey(nr_key);
		tex_key.setDuplicate().setNocase().addAscendingField(tex_a);
		this.addKey(tex_key);
	}
}
