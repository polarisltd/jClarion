package clarion.abfile;

import clarion.aberror.Errorclass;
import clarion.abfile.Abfile;
import clarion.abfile.Dbtextlogfile;
import clarion.abfile.Filemanager;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Dblogfilemanager extends Filemanager
{
	public ClarionNumber opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Dblogfilemanager()
	{
		opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void init(Errorclass ec,ClarionString logfilename)
	{
		Dbtextlogfile dbtextlogfile=new Dbtextlogfile();
		super.init(dbtextlogfile,ec);
		this.filename.setReferenceValue(Abfile.szdbtextlog);
		this.filenamevalue.setValue(logfilename.clip());
		this.buffer=dbtextlogfile;
		this.lazyopen.setValue(Constants.FALSE);
		this.lockrecover.setValue(10);
	}
}
