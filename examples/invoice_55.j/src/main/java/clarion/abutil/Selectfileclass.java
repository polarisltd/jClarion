package clarion.abutil;

import clarion.Selectfilequeue;
import clarion.abutil.equates.Mdfl;
import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Selectfileclass
{
	public ClarionString defaultdirectory=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
	public ClarionString defaultfile=Clarion.newString(File.MAXFILENAME).setEncoding(ClarionString.CSTRING);
	public ClarionNumber flags=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString maskstring=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionString savepath=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
	public ClarionString windowtitle=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
	public Selectfileclass()
	{
		defaultdirectory=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		defaultfile=Clarion.newString(File.MAXFILENAME).setEncoding(ClarionString.CSTRING);
		flags=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		maskstring=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		savepath=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		windowtitle=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
	}

	public void init()
	{
		this.windowtitle.setValue(Mdfl.DEFAULTWINDOWTITLE);
		this.flags.setValue(Mdfl.DEFAULTFLAGS);
	}
	public void addmask(ClarionString filemasks)
	{
		if (filemasks.boolValue()) {
			if (this.maskstring.boolValue()) {
				this.maskstring.setValue(this.maskstring.clip().concat("|",filemasks.clip()));
			}
			else {
				this.maskstring.setValue(filemasks);
			}
		}
	}
	public void addmask(ClarionString description,ClarionString pattern)
	{
		this.addmask(Clarion.newString(description.clip().concat("|",pattern)));
	}
	public ClarionString ask()
	{
		return ask(Clarion.newNumber(0));
	}
	public ClarionString ask(ClarionNumber keepdir)
	{
		ClarionString result=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		if (keepdir.boolValue()) {
			this.savepath.setValue(CFile.getPath());
		}
		if (this.defaultdirectory.len()!=0) {
			CFile.setPath(this.defaultdirectory.toString());
		}
		result.setValue(this.defaultfile);
		if (!CWin.fileDialog(this.windowtitle.toString(),result,(this.maskstring.equals("") ? Clarion.newString(Mdfl.DEFAULTFILEMASK) : this.maskstring).toString(),this.flags.intValue())) {
			result.clear();
		}
		if (keepdir.boolValue()) {
			CFile.setPath(this.savepath.toString());
		}
		return result.like();
	}
	public void ask(Selectfilequeue p0)
	{
		ask(p0,Clarion.newNumber(0));
	}
	public void ask(Selectfilequeue dfq,ClarionNumber keepdir)
	{
		ClarionNumber actualflags=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString found=Clarion.newString(10000).setEncoding(ClarionString.CSTRING);
		ClarionString path=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString separator=Clarion.newString(1);
		ClarionNumber pos=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber namestart=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		dfq.free();
		if (keepdir.boolValue()) {
			this.savepath.setValue(CFile.getPath());
		}
		if (this.defaultdirectory.len()!=0) {
			CFile.setPath(this.defaultdirectory.toString());
		}
		found.setValue(this.defaultfile);
		actualflags.setValue(this.flags.intValue() | File.MULTI);
		actualflags.setValue(actualflags.intValue() & 255-File.SAVE);
		if (CWin.fileDialog(this.windowtitle.toString(),found,(this.maskstring.equals("") ? Clarion.newString(Mdfl.DEFAULTFILEMASK) : this.maskstring).toString(),actualflags.intValue())) {
			separator.setValue((actualflags.intValue() & File.LONGNAME)==0 ? Clarion.newString(" ") : Clarion.newString("|"));
			pos.setValue(found.inString(separator.toString(),1,1));
			if (pos.boolValue()) {
				CRun._assert(pos.compareTo(1)>0);
				path.setValue(!found.stringAt(pos.subtract(1)).equals("\\") ? Clarion.newString(found.stringAt(1,pos.subtract(1)).concat("\\")) : found.stringAt(1,pos.subtract(1)));
				while (true) {
					namestart.setValue(pos.add(1));
					pos.setValue(found.inString(separator.toString(),1,namestart.intValue()));
					if (!pos.boolValue()) {
						pos.setValue(found.len()+1);
					}
					dfq.name.setValue(path.concat(found.stringAt(namestart,pos.subtract(1))));
					ask_getshortname(dfq,actualflags);
					dfq.add();
					if (!(pos.compareTo(found.len())<=0)) break;
				}
			}
			else {
				dfq.name.setValue(found);
				ask_getshortname(dfq,actualflags);
				dfq.add();
			}
		}
		if (keepdir.boolValue()) {
			CFile.setPath(this.savepath.toString());
		}
	}
	public void ask_getshortname(Selectfilequeue dfq,ClarionNumber actualflags)
	{
		dfq.shortname.setValue((actualflags.intValue() & File.LONGNAME)==0 ? Clarion.newString("") : CFile.getShortPath(dfq.name.toString()));
	}
	public void setmask(ClarionString filemask)
	{
		this.maskstring.clear();
		this.addmask(filemask.like());
	}
	public void setmask(ClarionString description,ClarionString pattern)
	{
		this.setmask(Clarion.newString(description.clip().concat("|",pattern)));
	}
}
