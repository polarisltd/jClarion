package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Cal extends ClarionSQLFile
{
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString stundas=Clarion.newString(1);
	public ClarionKey dat_key=new ClarionKey("DAT_Key");

	public Cal()
	{
		setName(Clarion.newString("CAL"));
		setPrefix("CAL");
		setCreate();
		this.addVariable("DATUMS",this.datums);
		this.addVariable("STUNDAS",this.stundas);
		dat_key.setNocase().setOptional().addAscendingField(datums);
		this.addKey(dat_key);
	}
}
