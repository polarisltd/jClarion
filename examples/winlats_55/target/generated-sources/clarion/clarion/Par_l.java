package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Par_l extends ClarionSQLFile
{
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber pal_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber l_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString ligums=Clarion.newString(30);
	public ClarionNumber l_cdatums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal l_summa=Clarion.newDecimal(10,2);
	public ClarionDecimal l_summa1=Clarion.newDecimal(10,2);
	public ClarionString l_fails=Clarion.newString(12);
	public ClarionNumber kor=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Par_l()
	{
		setName(Clarion.newString("par_l"));
		setPrefix("PAL");
		setCreate();
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("PAL_NR",this.pal_nr);
		this.addVariable("L_DATUMS",this.l_datums);
		this.addVariable("LIGUMS",this.ligums);
		this.addVariable("L_CDATUMS",this.l_cdatums);
		this.addVariable("L_SUMMA",this.l_summa);
		this.addVariable("L_SUMMA1",this.l_summa1);
		this.addVariable("L_FAILS",this.l_fails);
		this.addVariable("KOR",this.kor);
		this.addVariable("BAITS",this.baits);
		nr_key.setNocase().setOptional().addAscendingField(par_nr).addAscendingField(pal_nr);
		this.addKey(nr_key);
	}
}
