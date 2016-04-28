package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class States extends ClarionSQLFile
{
	public ClarionString state=Clarion.newString(2);
	public ClarionString stateName=Clarion.newString(30);
	public ClarionKey keyState=new ClarionKey("KeyState");

	public States()
	{
		setName(Clarion.newString("STATES"));
		setPrefix("STA");
		setCreate();
		this.addVariable("State",this.state);
		this.addVariable("StateName",this.stateName);
		keyState.setNocase().setOptional().addAscendingField(state);
		this.addKey(keyState);
	}
}
