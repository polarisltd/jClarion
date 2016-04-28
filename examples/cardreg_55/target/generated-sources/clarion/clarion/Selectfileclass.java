package clarion;

import clarion.Selectfilequeue;
import clarion.equates.Dfl;
import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Selectfileclass
{
	public ClarionString defaultDirectory;
	public ClarionString defaultFile;
	public ClarionNumber flags;
	public ClarionString maskString;
	public ClarionString savePath;
	public ClarionString windowTitle;
	public Selectfileclass()
	{
		defaultDirectory=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		defaultFile=Clarion.newString(File.MAXFILENAME).setEncoding(ClarionString.CSTRING);
		flags=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		maskString=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		savePath=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		windowTitle=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
	}

	public void init()
	{
		this.windowTitle.setValue(Dfl.DEFAULTWINDOWTITLE);
		this.flags.setValue(Dfl.DEFAULTFLAGS);
	}
	public void addMask(ClarionString fileMasks)
	{
		if (fileMasks.boolValue()) {
			if (this.maskString.boolValue()) {
				this.maskString.setValue(this.maskString.clip().concat("|",fileMasks.clip()));
			}
			else {
				this.maskString.setValue(fileMasks);
			}
		}
	}
	public void addMask(ClarionString description,ClarionString pattern)
	{
		this.addMask(Clarion.newString(description.clip().concat("|",pattern)));
	}
	public ClarionString ask()
	{
		return ask(Clarion.newNumber(0));
	}
	public ClarionString ask(ClarionNumber keepDir)
	{
		ClarionString result=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		if (keepDir.boolValue()) {
			this.savePath.setValue(CFile.getPath());
		}
		if (this.defaultDirectory.len()!=0) {
			CFile.setPath(this.defaultDirectory.toString());
		}
		result.setValue(this.defaultFile);
		if (!CWin.fileDialog(this.windowTitle.toString(),result,(this.maskString.equals("") ? Clarion.newString(Dfl.DEFAULTFILEMASK) : this.maskString).toString(),this.flags.intValue())) {
			result.clear();
		}
		if (keepDir.boolValue()) {
			CFile.setPath(this.savePath.toString());
		}
		return result.like();
	}
	public void ask(Selectfilequeue p0)
	{
		ask(p0,Clarion.newNumber(0));
	}
	public void ask(Selectfilequeue dfq,ClarionNumber keepDir)
	{
		ClarionNumber actualFlags=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString found=Clarion.newString(10000).setEncoding(ClarionString.CSTRING);
		ClarionString path=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString separator=Clarion.newString(1);
		ClarionNumber pos=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber nameStart=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		dfq.free();
		if (keepDir.boolValue()) {
			this.savePath.setValue(CFile.getPath());
		}
		if (this.defaultDirectory.len()!=0) {
			CFile.setPath(this.defaultDirectory.toString());
		}
		found.setValue(this.defaultFile);
		actualFlags.setValue(this.flags.intValue() | File.MULTI);
		actualFlags.setValue(actualFlags.intValue() & 255-File.SAVE);
		if (CWin.fileDialog(this.windowTitle.toString(),found,(this.maskString.equals("") ? Clarion.newString(Dfl.DEFAULTFILEMASK) : this.maskString).toString(),actualFlags.intValue())) {
			separator.setValue((actualFlags.intValue() & File.LONGNAME)==0 ? Clarion.newString(" ") : Clarion.newString("|"));
			pos.setValue(found.inString(separator.toString(),1,1));
			if (pos.boolValue()) {
				CRun._assert(pos.compareTo(1)>0);
				path.setValue(!found.stringAt(pos.subtract(1)).equals("\\") ? Clarion.newString(found.stringAt(1,pos.subtract(1)).concat("\\")) : found.stringAt(1,pos.subtract(1)));
				while (true) {
					nameStart.setValue(pos.add(1));
					pos.setValue(found.inString(separator.toString(),1,nameStart.intValue()));
					if (!pos.boolValue()) {
						pos.setValue(found.len()+1);
					}
					dfq.name.setValue(path.concat(found.stringAt(nameStart,pos.subtract(1))));
					ask_GetShortName(dfq,actualFlags);
					dfq.add();
					if (!(pos.compareTo(found.len())<=0)) break;
				}
			}
			else {
				dfq.name.setValue(found);
				ask_GetShortName(dfq,actualFlags);
				dfq.add();
			}
		}
		if (keepDir.boolValue()) {
			CFile.setPath(this.savePath.toString());
		}
	}
	public void ask_GetShortName(Selectfilequeue dfq,ClarionNumber actualFlags)
	{
		dfq.shortName.setValue((actualFlags.intValue() & File.LONGNAME)==0 ? Clarion.newString("") : CFile.getShortPath(dfq.name.toString()));
	}
	public void setMask(ClarionString fileMask)
	{
		this.maskString.clear();
		this.addMask(fileMask.like());
	}
	public void setMask(ClarionString description,ClarionString pattern)
	{
		this.setMask(Clarion.newString(description.clip().concat("|",pattern)));
	}
}
