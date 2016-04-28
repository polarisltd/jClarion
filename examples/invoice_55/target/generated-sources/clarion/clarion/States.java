package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class States extends ClarionSQLFile
{
	public ClarionString statecode=Clarion.newString(2);
	public ClarionString name=Clarion.newString(25);
	public ClarionKey statecodekey=new ClarionKey("StateCodeKey");

	public States()
	{
		setPrefix("STA");
		setCreate();
		setName(Clarion.newString("states"));
		this.addVariable("StateCode",this.statecode);
		this.addVariable("Name",this.name);
		statecodekey.setNocase().setOptional().addAscendingField(statecode);
		this.addKey(statecodekey);
	}
}
