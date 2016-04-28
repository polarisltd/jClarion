package clarion;

import clarion.Editclass;
import clarion.equates.Create;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CWin;

public class Editcheckclass extends Editclass
{
	public Editcheckclass()
	{
	}

	public void init(ClarionNumber fieldNo,ClarionNumber listBox,ClarionObject useVar)
	{
		super.init(fieldNo.like(),listBox.like(),useVar);
		Clarion.getControl(this.feq).setProperty(Prop.TEXT,Clarion.getControl(listBox).getProperty(Proplist.HEADER,fieldNo));
	}
	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.CHECK,null,null));
	}
}
