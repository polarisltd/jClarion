package clarion.abpopup;

import clarion.equates.Constants;
import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Popupitemqueue extends ClarionQueue
{
	public ClarionNumber controlid=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber depth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber event=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber mimicmode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber disabled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber check=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber ontoolbox=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString icon=Clarion.newString(File.MAXFILENAME).setEncoding(ClarionString.CSTRING);
	public ClarionString name=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
	public ClarionString text=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);

	public Popupitemqueue()
	{
		this.addVariable("ControlID",this.controlid);
		this.addVariable("Depth",this.depth);
		this.addVariable("Event",this.event);
		this.addVariable("MimicMode",this.mimicmode);
		this.addVariable("Disabled",this.disabled);
		this.addVariable("Check",this.check);
		this.addVariable("OnToolbox",this.ontoolbox);
		this.addVariable("Icon",this.icon);
		this.addVariable("Name",this.name);
		this.addVariable("Text",this.text);
	}
}
