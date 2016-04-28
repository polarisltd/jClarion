package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Au_tex extends ClarionSQLFile
{
	public ClarionString aut_text=Clarion.newString(10);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString par_nos_p=Clarion.newString(35);
	public ClarionString par_tel=Clarion.newString(25);
	public ClarionString par_aut0=Clarion.newString(30);
	public ClarionString saturs1=Clarion.newString(45);
	public ClarionString saturs2=Clarion.newString(45);
	public ClarionString saturs3=Clarion.newString(45);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey aut_key=new ClarionKey("AUT_KEY");

	public Au_tex()
	{
		setName(Main.aubtexname);
		setPrefix("AUX");
		setCreate();
		this.addVariable("AUT_TEXT",this.aut_text);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("PAR_NOS_P",this.par_nos_p);
		this.addVariable("PAR_TEL",this.par_tel);
		this.addVariable("PAR_AUT0",this.par_aut0);
		this.addVariable("SATURS1",this.saturs1);
		this.addVariable("SATURS2",this.saturs2);
		this.addVariable("SATURS3",this.saturs3);
		this.addVariable("BAITS",this.baits);
		aut_key.setDuplicate().setNocase().setOptional().addAscendingField(aut_text);
		this.addKey(aut_key);
	}
}
