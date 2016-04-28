package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Par_a extends ClarionSQLFile
{
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber adr_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString tips=Clarion.newString(1);
	public ClarionString grupa=Clarion.newString(6);
	public ClarionString adrese=Clarion.newString(60);
	public ClarionString kontakts=Clarion.newString(25);
	public ClarionString darbalaiks=Clarion.newString(25);
	public ClarionString telefax=Clarion.newString(25);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Par_a()
	{
		setPrefix("ADR");
		setName(Clarion.newString("par_a"));
		setCreate();
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("ADR_NR",this.adr_nr);
		this.addVariable("TIPS",this.tips);
		this.addVariable("GRUPA",this.grupa);
		this.addVariable("ADRESE",this.adrese);
		this.addVariable("KONTAKTS",this.kontakts);
		this.addVariable("DARBALAIKS",this.darbalaiks);
		this.addVariable("TELEFAX",this.telefax);
		nr_key.setNocase().setOptional().addAscendingField(par_nr).addAscendingField(adr_nr);
		this.addKey(nr_key);
	}
}
