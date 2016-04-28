package clarion;

import clarion.Filetime;
import clarion.Systemtime;
import clarion.Win32_find_data;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

public class Win32
{

	public ClarionNumber findFirstFile(ClarionString lpFileName,Win32_find_data _p1)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionBool findClose(ClarionNumber hFindFile)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getLastError()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber findWindow(ClarionString p1)
	{
		return findWindow((ClarionString)null,p1);
	}
	public ClarionNumber findWindow(ClarionString _p0,ClarionString _p1)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionBool fileTimeToSystemTime(Filetime lpFileTime,Systemtime lpSystemTime)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionBool fileTimeToLocalFileTime(Filetime lpFileTime,Filetime lpLocalFileTime)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionBool closeHandle(ClarionNumber hObject)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber wNetGetUser(ClarionString p1,ClarionNumber p2)
	{
		return wNetGetUser((ClarionString)null,p1,p2);
	}
	public ClarionNumber wNetGetUser(ClarionString lpName,ClarionString lpUserName,ClarionNumber lpnLength)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber createEvent(ClarionBool p1,ClarionBool p2,ClarionString p3)
	{
		return createEvent((ClarionObject)null,p1,p2,p3);
	}
	public ClarionNumber createEvent(ClarionObject _p0,ClarionBool bManualReset,ClarionBool bInitialState,ClarionString lpName)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getSystemMetrics(ClarionNumber nIndex)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getTempPath(ClarionNumber nBufferLength,ClarionObject lpBuffer)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getTempFileName(ClarionString lpPathName,ClarionString lpPrefixString,ClarionNumber uUnique,ClarionString lpTempFileName)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber systemParametersInfo(ClarionNumber uAction,ClarionNumber uParam,ClarionObject lpvParam,ClarionNumber fuWinIni)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
