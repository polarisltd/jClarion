package clarion;

import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Updateinserttips extends ClarionGroup
{
	public ClarionNumber _anon_1=Clarion.newNumber(2).setEncoding(ClarionNumber.BYTE);
	public ClarionNumber _anon_2=Clarion.newNumber(Toolbar.INSERT).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_3=Clarion.newString("Save record and add another").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_4=Clarion.newNumber(Toolbar.DOWN).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_5=Clarion.newString("Save record and add another").setEncoding(ClarionString.PSTRING);

	public Updateinserttips()
	{
		this.addVariable("_anon_1",this._anon_1);
		this.addVariable("_anon_2",this._anon_2);
		this.addVariable("_anon_3",this._anon_3);
		this.addVariable("_anon_4",this._anon_4);
		this.addVariable("_anon_5",this._anon_5);
	}
}
