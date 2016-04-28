package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Stylegrp extends ClarionGroup
{
	public ClarionNumber backgroundColor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber backgroundStyle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber borderColor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber borderWidth=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber borderStyle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Stylegrp()
	{
		this.addVariable("BackgroundColor",this.backgroundColor);
		this.addVariable("BackgroundStyle",this.backgroundStyle);
		this.addVariable("BorderColor",this.borderColor);
		this.addVariable("BorderWidth",this.borderWidth);
		this.addVariable("BorderStyle",this.borderStyle);
	}
}
