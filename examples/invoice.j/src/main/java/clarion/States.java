package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class States extends ClarionSQLFile
{
	public ClarionString stateCode=Clarion.newString(2);
	public ClarionString name=Clarion.newString(25);
	public ClarionKey stateCodeKey=new ClarionKey("StateCodeKey");

	public States()
	{
		setName(Clarion.newString("States"));
		setPrefix("STA");
		setCreate();
		this.addVariable("StateCode",this.stateCode);
		this.addVariable("Name",this.name);
		stateCodeKey.setNocase().setOptional().setPrimary().addAscendingField(stateCode);
		this.addKey(stateCodeKey);
	}
}
