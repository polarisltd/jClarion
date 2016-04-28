package clarion;

import clarion.Ftcreationtime;
import clarion.Ftlastaccesstime;
import clarion.Ftlastwritetime;
import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Win32_find_data extends ClarionGroup
{
	public ClarionNumber dwFileAttributes=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public Ftcreationtime ftCreationTime=new Ftcreationtime();
	public Ftlastaccesstime ftLastAccessTime=new Ftlastaccesstime();
	public Ftlastwritetime ftLastWriteTime=new Ftlastwritetime();
	public ClarionNumber nFileSizeHigh=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber nFileSizeLow=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber dwReserved0=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber dwReserved1=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString cFileName=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
	public ClarionString cAlternateFileName=Clarion.newString(14).setEncoding(ClarionString.CSTRING);

	public Win32_find_data()
	{
		this.addVariable("dwFileAttributes",this.dwFileAttributes);
		this.addVariable("ftCreationTime",this.ftCreationTime);
		this.addVariable("ftLastAccessTime",this.ftLastAccessTime);
		this.addVariable("ftLastWriteTime",this.ftLastWriteTime);
		this.addVariable("nFileSizeHigh",this.nFileSizeHigh);
		this.addVariable("nFileSizeLow",this.nFileSizeLow);
		this.addVariable("dwReserved0",this.dwReserved0);
		this.addVariable("dwReserved1",this.dwReserved1);
		this.addVariable("cFileName",this.cFileName);
		this.addVariable("cAlternateFileName",this.cAlternateFileName);
	}
}
