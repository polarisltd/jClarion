package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Au_bilde extends ClarionSQLFile
{
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber plkst_p=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionArray<ClarionNumber> pav_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG).dim(22);
	public ClarionArray<ClarionString> aut_text=Clarion.newString(10).dim(22);
	public ClarionArray<ClarionNumber> statuss=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(22);
	public ClarionArray<ClarionNumber> baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(22);
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");

	public Au_bilde()
	{
		setName(Main.aubname);
		setPrefix("AUB");
		setCreate();
		this.addVariable("DATUMS",this.datums);
		this.addVariable("PLKST_P",this.plkst_p);
		this.addVariable("PAV_NR",this.pav_nr);
		this.addVariable("AUT_TEXT",this.aut_text);
		this.addVariable("STATUSS",this.statuss);
		this.addVariable("BAITS",this.baits);
		dat_key.setNocase().setOptional().addAscendingField(datums).addAscendingField(plkst_p);
		this.addKey(dat_key);
	}
}
