package clarion;

import clarion.Abfile;
import clarion.Dbtextlogfile;
import clarion.Errorclass;
import clarion.Filemanager;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Dblogfilemanager extends Filemanager
{
	public ClarionNumber opened;
	public Dblogfilemanager()
	{
		opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void init(Errorclass ec,ClarionString logFileName)
	{
		Dbtextlogfile dbTextLogFile=new Dbtextlogfile();
		super.init(dbTextLogFile,ec);
		this.filename.setReferenceValue(Abfile.szDbTextLog);
		this.fileNameValue.setValue(logFileName.clip());
		this.buffer=dbTextLogFile;
		this.lazyOpen.setValue(Constants.FALSE);
		this.lockRecover.setValue(10);
	}
}
