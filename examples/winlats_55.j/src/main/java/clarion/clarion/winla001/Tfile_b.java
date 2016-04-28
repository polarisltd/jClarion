package clarion.winla001;

import clarion.winla001.Winla001;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Tfile_b extends ClarionAsciiFile
{
	public ClarionString str=Clarion.newString(200);

	public Tfile_b()
	{
		setName(Winla001.main_tname_b);
		setPrefix("B");
		setCreate();
		this.addVariable("STR",this.str);
	}
}
