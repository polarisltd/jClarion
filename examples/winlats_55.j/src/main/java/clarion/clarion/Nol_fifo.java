package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nol_fifo extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString d_k=Clarion.newString(2);
	public ClarionNumber nol_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal daudzums=Clarion.newDecimal(11,3);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Nol_fifo()
	{
		setName(Clarion.newString("NOL_FIFO"));
		setPrefix("FIFO");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("D_K",this.d_k);
		this.addVariable("NOL_NR",this.nol_nr);
		this.addVariable("DAUDZUMS",this.daudzums);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("BAITS",this.baits);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(u_nr).addAscendingField(datums).addAscendingField(d_k);
		this.addKey(nr_key);
	}
}
