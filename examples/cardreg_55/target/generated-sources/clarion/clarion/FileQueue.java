package clarion;

import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class FileQueue extends ClarionQueue
{
	public ClarionString name=Clarion.newString(File.MAXFILENAME);
	public ClarionString shortName=Clarion.newString(13);
	public ClarionNumber date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber time=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber size=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber attrib=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public FileQueue()
	{
		this.addVariable("Name",this.name);
		this.addVariable("ShortName",this.shortName);
		this.addVariable("Date",this.date);
		this.addVariable("Time",this.time);
		this.addVariable("Size",this.size);
		this.addVariable("Attrib",this.attrib);
	}
}
