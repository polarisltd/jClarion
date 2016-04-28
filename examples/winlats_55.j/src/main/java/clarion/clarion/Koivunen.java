package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Koivunen extends ClarionSQLFile
{
	public ClarionString pieg=Clarion.newString(3);
	public ClarionString pieg_kods=Clarion.newString(22);
	public ClarionReal min_iep=Clarion.newReal().setName("MIN_IEP=N(4.0)");
	public ClarionReal cena=Clarion.newReal().setName("CENA=N(7.3)");
	public ClarionString valuta=Clarion.newString(3);
	public ClarionReal vcena=Clarion.newReal();
	public ClarionReal mcena=Clarion.newReal();
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.DATE);
	public ClarionString keksis=Clarion.newString(1);

	public Koivunen()
	{
		setName(Main.filename1);
		setPrefix("KOI");
		setCreate();
		this.addVariable("PIEG",this.pieg);
		this.addVariable("PIEG_KODS",this.pieg_kods);
		this.addVariable("MIN_IEP",this.min_iep);
		this.addVariable("CENA",this.cena);
		this.addVariable("VALUTA",this.valuta);
		this.addVariable("VCENA",this.vcena);
		this.addVariable("MCENA",this.mcena);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("KEKSIS",this.keksis);
	}
}
