package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Bankas_k extends ClarionSQLFile
{
	public ClarionString nos_p=Clarion.newString(31);
	public ClarionString nos_s=Clarion.newString(15);
	public ClarionString nos_a=Clarion.newString(4);
	public ClarionString index=Clarion.newString(7);
	public ClarionString kods=Clarion.newString(15);
	public ClarionString kor_k=Clarion.newString(11);
	public ClarionString adrese1=Clarion.newString(31);
	public ClarionString adrese2=Clarion.newString(31);
	public ClarionString spec=Clarion.newString(31);
	public ClarionString maksajuma_taka=Clarion.newString(55);
	public ClarionString gnet_flag=Clarion.newString(2);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey kod_key=new ClarionKey("KOD_KEY");
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Bankas_k()
	{
		setName(Clarion.newString("BANKAS_K"));
		setPrefix("BAN");
		setCreate();
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("NOS_A",this.nos_a);
		this.addVariable("INDEX",this.index);
		this.addVariable("KODS",this.kods);
		this.addVariable("KOR_K",this.kor_k);
		this.addVariable("ADRESE1",this.adrese1);
		this.addVariable("ADRESE2",this.adrese2);
		this.addVariable("SPEC",this.spec);
		this.addVariable("MAKSAJUMA_TAKA",this.maksajuma_taka);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		this.addVariable("BAITS",this.baits);
		kod_key.setNocase().addAscendingField(kods);
		this.addKey(kod_key);
		nos_key.setDuplicate().setNocase().addAscendingField(nos_a);
		this.addKey(nos_key);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
