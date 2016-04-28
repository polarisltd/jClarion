package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nom_a extends ClarionSQLFile
{
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionArray<ClarionDecimal> d_projekts=Clarion.newDecimal(11,3).dim(25);
	public ClarionArray<ClarionDecimal> atlikums=Clarion.newDecimal(11,3).dim(25);
	public ClarionArray<ClarionDecimal> k_projekts=Clarion.newDecimal(11,3).dim(25);
	public ClarionString gnet_flag=Clarion.newString(3);
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Nom_a()
	{
		setName(Clarion.newString("NOM_A"));
		setPrefix("NOA");
		setCreate();
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("D_PROJEKTS",this.d_projekts);
		this.addVariable("ATLIKUMS",this.atlikums);
		this.addVariable("K_PROJEKTS",this.k_projekts);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		nom_key.setNocase().addAscendingField(nomenklat);
		this.addKey(nom_key);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
