package clarion;

import clarion.Clibrary;
import clarion.Gfilefind;
import clarion.Gtemplocaltime;
import clarion.Gtempsystemtime;
import clarion.Gtempsystemtime_1;
import clarion.Infile;
import clarion.Outfile;
import clarion.Systemtime;
import clarion.Win32;
import clarion.Win32_find_data;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.File;
import clarion.equates.Icon;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionBlob;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Cwutil
{
	public static ClarionString hexDigitsUp;
	public static ClarionString hexDigitsLow;

	public static ClarionString oSVersion()
	{
		return ClarionSystem.getInstance().getProperty(Prop.WINDOWSVERSION).getString();
	}
	public static ClarionNumber fileExists(ClarionString sFile)
	{
		ClarionNumber bRetVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber hFindHandle=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionString szFindFile=Clarion.newString(File.MAXFILENAME).setEncoding(ClarionString.CSTRING);
		Win32_find_data gFileFind=new Win32_find_data();
		hFindHandle.setValue(0);
		bRetVal.setValue(Constants.FALSE);
		szFindFile.setValue(sFile.clip());
		gFileFind.clear();
		hFindHandle.setValue((new Win32()).findFirstFile(szFindFile,gFileFind));
		bRetVal.setValue(!(hFindHandle.equals(Constants.INVALID_LONG_VALUE) || hFindHandle.compareTo(0)<=0) ? 1 : 0);
		(new Win32()).findClose(hFindHandle.like());
		return bRetVal.like();
	}
	public static ClarionNumber windowExists(ClarionString sWindow)
	{
		ClarionNumber hWnd=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString szWindowName=Clarion.newString(128).setEncoding(ClarionString.CSTRING);
		szWindowName.setValue(sWindow.clip());
		hWnd.setValue((new Win32()).findWindow(null,szWindowName));
		return Clarion.newNumber(!hWnd.equals(0) ? 1 : 0);
	}
	public static ClarionNumber validateOLE(ClarionNumber p0,ClarionString p1)
	{
		return validateOLE(p0,p1,(ClarionString)null);
	}
	public static ClarionNumber validateOLE(ClarionNumber p0)
	{
		return validateOLE(p0,(ClarionString)null);
	}
	public static ClarionNumber validateOLE(ClarionNumber oleControl,ClarionString oleFileName,ClarionString oleCreateName)
	{
		ClarionNumber lCallRet=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (Clarion.getControl(oleControl).getProperty(Prop.OLE).equals(Constants.FALSE) && Clarion.getControl(oleControl).getProperty(Prop.OBJECT).equals("")) {
			if (!(oleFileName==null)) {
				Clarion.getControl(oleControl).setProperty(Prop.CREATE,oleCreateName.clip());
				if (Clarion.getControl(oleControl).getProperty(Prop.OLE).equals(Constants.FALSE) && Clarion.getControl(oleControl).getProperty(Prop.OBJECT).equals("")) {
					if (!(oleCreateName==null)) {
						lCallRet.setValue(CRun.call(oleFileName.clip().toString(),"DllRegisterServer",null));
						if (lCallRet.boolValue()) {
							CWin.message(Clarion.newString(ClarionString.staticConcat("Can not Register OLE Control ",oleFileName.clip()," Error: ",lCallRet.getString().clip(),".  Please re-install Legal Files.")),Clarion.newString("Fatal OLE Error"),Icon.EXCLAMATION);
							return Clarion.newNumber(Constants.FALSE);
						}
						// unload oleFileName.clip().toString();
						Clarion.getControl(oleControl).setProperty(Prop.CREATE,oleCreateName.clip());
					}
					else {
						return Clarion.newNumber(Constants.FALSE);
					}
					if (Clarion.getControl(oleControl).getProperty(Prop.OLE).equals(Constants.FALSE) && Clarion.getControl(oleControl).getProperty(Prop.OBJECT).equals("")) {
						CWin.message(Clarion.newString(ClarionString.staticConcat("Can not Find OLE Control ",oleFileName.clip()," !  Please re-install.")),Clarion.newString("Fatal OLE Error"),Icon.EXCLAMATION);
						return Clarion.newNumber(Constants.FALSE);
					}
					else {
						return Clarion.newNumber(Constants.TRUE);
					}
				}
			}
			else {
				return Clarion.newNumber(Constants.FALSE);
			}
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
		return Clarion.newNumber();
	}
	public static ClarionString getUserName()
	{
		ClarionString sRetUser=Clarion.newString(128).setEncoding(ClarionString.CSTRING);
		ClarionNumber dwUserLen=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
		dwUserLen.setValue(CMemory.size(sRetUser));
		if ((new Win32()).wNetGetUser(null,sRetUser,dwUserLen).equals(0)) {
			return sRetUser.clip();
		}
		else {
			return Clarion.newString("");
		}
	}
	public static ClarionNumber beginUnique(ClarionString sAppName)
	{
		ClarionString szEventName=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionNumber hEvent=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		szEventName.setValue(sAppName.clip().concat("_UEvent"));
		hEvent.clear();
		hEvent.setValue((new Win32()).createEvent(null,Clarion.newBool(0),Clarion.newBool(0),szEventName));
		if (hEvent.equals(0) || (new Win32()).getLastError().equals(183)) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			return hEvent.like();
		}
	}
	public static void endUnique(ClarionNumber hUnique)
	{
		(new Win32()).closeHandle(hUnique.like());
		return;
	}
	public static ClarionNumber isTermServer()
	{
		if (!(new Win32()).getSystemMetrics(Clarion.newNumber(Constants.SM_REMOTESESSION)).equals(0)) {
			return Clarion.newNumber(Constants.TRUE);
		}
		else {
			return Clarion.newNumber(Constants.FALSE);
		}
	}
	public static ClarionNumber getFileTime(ClarionString p0)
	{
		return getFileTime(p0,Clarion.newNumber(0));
	}
	public static ClarionNumber getFileTime(ClarionString iFile,ClarionNumber bType)
	{
		Gtempsystemtime gTempSystemTime=new Gtempsystemtime();
		if (Cwutil.getFileSystemTimeDate(iFile.like(),bType.like(),gTempSystemTime).boolValue()) {
			return Clarion.newString(gTempSystemTime.wHour.concat(":",gTempSystemTime.wMinute,":",gTempSystemTime.wSecond)).deformat("@t4").getNumber();
		}
		return Clarion.newNumber(0);
	}
	public static ClarionNumber getFileDate(ClarionString p0)
	{
		return getFileDate(p0,Clarion.newNumber(0));
	}
	public static ClarionNumber getFileDate(ClarionString iFile,ClarionNumber bType)
	{
		Gtempsystemtime_1 gTempSystemTime=new Gtempsystemtime_1();
		if (Cwutil.getFileSystemTimeDate(iFile.like(),bType.like(),gTempSystemTime).boolValue()) {
			return Clarion.newString(gTempSystemTime.wMonth.concat("/",gTempSystemTime.wDay,"/",gTempSystemTime.wYear)).deformat("@d2").getNumber();
		}
		return Clarion.newNumber(0);
	}
	public static ClarionNumber createDirectory(ClarionString sDirectory)
	{
		ClarionString szDirName=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		szDirName.setValue(sDirectory.clip());
		return (new Clibrary()).mkdir(szDirName);
	}
	public static ClarionNumber removeDirectory(ClarionString sDirectory)
	{
		ClarionString szDirName=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		szDirName.setValue(sDirectory.clip());
		return (new Clibrary()).rmdir(szDirName);
	}
	public static ClarionString getTempPath()
	{
		ClarionString sTmpPath=Clarion.newString(File.MAXFILEPATH);
		ClarionNumber lPathSize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lPathSize.setValue((new Win32()).getTempPath(Clarion.newNumber(CMemory.size(sTmpPath)),sTmpPath));
		if (lPathSize.equals(0) || lPathSize.compareTo(CMemory.size(sTmpPath))>0) {
			return Clarion.newString("");
		}
		else {
			return sTmpPath.stringAt(1,lPathSize);
		}
	}
	public static ClarionString getTempFileName(ClarionString p0)
	{
		return getTempFileName(p0,(ClarionString)null);
	}
	public static ClarionString getTempFileName(ClarionString sPrefix,ClarionString sDirectory)
	{
		ClarionString szPrefix=Clarion.newString(4).setEncoding(ClarionString.CSTRING);
		ClarionString szPath=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString szTempname=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		if (sDirectory==null) {
			szPath.setValue(Cwutil.getTempPath());
			if (szPath.clip().equals("")) {
				szPath.setValue(".");
			}
		}
		else {
			szPath.setValue(sDirectory.clip());
		}
		szPrefix.setValue(sPrefix.clip());
		if (szPrefix.equals("")) {
			szPrefix.setValue("$$$");
		}
		if ((new Win32()).getTempFileName(szPath,szPrefix,Clarion.newNumber(0),szTempname).equals(0)) {
			return Clarion.newString("");
		}
		else {
			return szTempname.clip();
		}
	}
	public static ClarionNumber fullDrag()
	{
		return fullDrag((ClarionNumber)null);
	}
	public static ClarionNumber fullDrag(ClarionNumber lDragSetting)
	{
		ClarionNumber lCurrentSetting=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (!(lDragSetting==null)) {
			// systemparametersinfo(Clarion.newNumber(Constants.SPI_SETDRAGFULLWINDOWS).intValue(),lDragSetting.like().intValue(),lCurrentSetting.intValue(),Clarion.newNumber(Constants.SPIF_SENDWININICHANGE+Constants.SPIF_UPDATEINIFILE).intValue());
			return lDragSetting.like();
		}
		// systemparametersinfo(Clarion.newNumber(Constants.SPI_GETDRAGFULLWINDOWS).intValue(),Clarion.newNumber(0).intValue(),lCurrentSetting.intValue(),Clarion.newNumber(Constants.SPIF_SENDWININICHANGE+Constants.SPIF_UPDATEINIFILE).intValue());
		return lCurrentSetting.like();
	}
	public static ClarionString longToHex(ClarionNumber p0)
	{
		return longToHex(p0,Clarion.newNumber(Constants.FALSE));
	}
	public static ClarionString longToHex(ClarionNumber in,ClarionNumber lowerCase)
	{
		ClarionString out=Clarion.newString(8);
		ClarionArray<ClarionNumber> inb=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(4).setOver(in);
		out.setStringAt(1,2,Cwutil.byteToHex(inb.get(4).like(),lowerCase.like()));
		out.setStringAt(3,4,Cwutil.byteToHex(inb.get(3).like(),lowerCase.like()));
		out.setStringAt(5,6,Cwutil.byteToHex(inb.get(2).like(),lowerCase.like()));
		out.setStringAt(7,8,Cwutil.byteToHex(inb.get(1).like(),lowerCase.like()));
		return out.like();
	}
	public static ClarionString shortToHex(ClarionNumber p0)
	{
		return shortToHex(p0,Clarion.newNumber(Constants.FALSE));
	}
	public static ClarionString shortToHex(ClarionNumber in,ClarionNumber lowerCase)
	{
		ClarionString out=Clarion.newString(4);
		ClarionArray<ClarionNumber> inb=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(2).setOver(in);
		out.setStringAt(1,2,Cwutil.byteToHex(inb.get(2).like(),lowerCase.like()));
		out.setStringAt(3,4,Cwutil.byteToHex(inb.get(1).like(),lowerCase.like()));
		return out.like();
	}
	public static ClarionString byteToHex(ClarionNumber p0)
	{
		return byteToHex(p0,Clarion.newNumber(Constants.FALSE));
	}
	public static ClarionString byteToHex(ClarionNumber in,ClarionNumber lowerCase)
	{
		ClarionString out=Clarion.newString(2);
		ClarionString hex=null;
		if (lowerCase.boolValue()) {
			hex=Cwutil.hexDigitsLow;
		}
		else {
			hex=Cwutil.hexDigitsUp;
		}
		out.setStringAt(1,hex.stringAt(ClarionNumber.shift(in.intValue(),-4)+1));
		out.setStringAt(2,hex.stringAt((in.intValue() & 0xf)+1));
		return out.like();
	}
	public static ClarionNumber fileToBLOB(ClarionString name,ClarionBlob b)
	{
		Infile inFile=new Infile();
		ClarionNumber sz=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber start=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber fetch=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber curErr=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (name.equals("")) {
			return Clarion.newNumber(Constants.BADFILEERR);
		}
		inFile.setClonedProperty(Prop.NAME,name);
		inFile.open();
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(CError.errorCode());
		}
		sz.setValue(inFile.getBytes());
		if (sz.equals(0)) {
			curErr.setValue(Constants.BADFILEERR);
		}
		else {
			inFile.send(ClarionString.staticConcat("FILEBUFFERS=",sz.divide(512).getDecimal().round(1)));
			Clarion.getControl(b).setClonedProperty(Prop.SIZE,sz);
			curErr.setValue(0);
			start.setValue(0);
			while (!sz.equals(0)) {
				fetch.setValue(CMemory.size(inFile.buffer));
				if (fetch.compareTo(sz)>0) {
					fetch.setValue(sz);
				}
				inFile.get(start.add(1).getString(),fetch.intValue());
				curErr.setValue(CError.errorCode());
				if (!curErr.equals(0)) {
					break;
				}
				b.setStringAt(start,start.add(fetch).subtract(1),inFile.buffer.stringAt(1,fetch));
				start.increment(fetch);
				sz.decrement(fetch);
			}
		}
		inFile.close();
		return curErr.like();
	}
	public static ClarionNumber bLOBToFile(ClarionBlob b,ClarionString name)
	{
		Outfile outFile=new Outfile();
		ClarionNumber sz=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber start=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber amount=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber curErr=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (name.equals("")) {
			return Clarion.newNumber(Constants.BADFILEERR);
		}
		sz.setValue(Clarion.getControl(b).getProperty(Prop.SIZE));
		if (sz.equals(0)) {
			return Clarion.newNumber(0);
		}
		outFile.setClonedProperty(Prop.NAME,name);
		outFile.create();
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(CError.errorCode());
		}
		outFile.open();
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(CError.errorCode());
		}
		outFile.send(ClarionString.staticConcat("FILEBUFFERS=",sz.divide(512).getDecimal().round(1)));
		curErr.setValue(0);
		start.setValue(0);
		while (!sz.equals(0)) {
			amount.setValue(CMemory.size(outFile.buffer));
			if (amount.compareTo(sz)>0) {
				amount.setValue(sz);
			}
			outFile.buffer.setStringAt(1,amount,b.getString().stringAt(start,start.add(amount).subtract(1)));
			outFile.add(amount.intValue());
			curErr.setValue(CError.errorCode());
			if (!curErr.equals(0)) {
				break;
			}
			start.increment(amount);
			sz.decrement(amount);
		}
		outFile.close();
		return curErr.like();
	}
	public static void resizeImage(ClarionNumber p0,ClarionNumber p1,ClarionNumber p2,ClarionNumber p3,ClarionNumber p4)
	{
		resizeImage(p0,p1,p2,p3,p4,(ClarionReport)null);
	}
	public static void resizeImage(ClarionNumber pOriginalControl,ClarionNumber pOrigianlXPos,ClarionNumber pOriginalYPos,ClarionNumber pOriginalWidth,ClarionNumber pOriginalHeight,ClarionReport pReport)
	{
		ClarionNumber lLocalImage=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber new_w=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber new_h=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber old_w=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber old_h=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber old_x=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber old_y=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (pOriginalControl.boolValue()) {
			if (!(pReport==null)) {
				CWin.setTarget(pReport);
			}
			lLocalImage.setValue(CWin.createControl(0,Create.IMAGE,Clarion.getControl(pOriginalControl).getProperty(Prop.PARENT).intValue(),null));
			Clarion.getControl(lLocalImage).setProperty(Prop.IMAGEBLOB,Clarion.getControl(pOriginalControl).getProperty(Prop.IMAGEBLOB));
			new_w.setValue(Clarion.getControl(lLocalImage).getProperty(Prop.WIDTH));
			new_h.setValue(Clarion.getControl(lLocalImage).getProperty(Prop.HEIGHT));
			old_x.setValue(pOrigianlXPos);
			old_y.setValue(pOriginalYPos);
			old_w.setValue(pOriginalWidth);
			old_h.setValue(pOriginalHeight);
			CWin.removeControl(lLocalImage.intValue());
			if (new_w.compareTo(old_w)>0 || new_h.compareTo(old_h)>0) {
				while (new_w.compareTo(old_w)>0 || new_h.compareTo(old_h)>0) {
					new_w.setValue(new_w.subtract(new_w.divide(10)));
					new_h.setValue(new_h.subtract(new_h.divide(10)));
				}
			}
			else if (old_w.compareTo(new_w)>0 || old_h.compareTo(new_h)>0) {
				while (old_w.compareTo(new_w.add(new_w.divide(10)))>0 && old_h.compareTo(new_h.add(new_h.divide(10)))>0) {
					new_w.setValue(new_w.add(new_w.divide(10)));
					new_h.setValue(new_h.add(new_h.divide(10)));
				}
			}
			Clarion.getControl(pOriginalControl).setProperty(Prop.XPOS,old_x.add(old_w.subtract(new_w).divide(2)));
			Clarion.getControl(pOriginalControl).setProperty(Prop.YPOS,old_y.add(old_h.subtract(new_h).divide(2)));
			Clarion.getControl(pOriginalControl).setClonedProperty(Prop.WIDTH,new_w);
			Clarion.getControl(pOriginalControl).setClonedProperty(Prop.HEIGHT,new_h);
			if (!(pReport==null)) {
				CWin.setTarget();
			}
		}
	}
	public static ClarionBool getFileSystemTimeDate(ClarionString filename,ClarionNumber which,Systemtime systime)
	{
		ClarionNumber hFindHandle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Gfilefind gFileFind=new Gfilefind();
		ClarionString szFindFile=Clarion.newString(File.MAXFILENAME).setEncoding(ClarionString.CSTRING);
		Gtemplocaltime gTempLocalTime=new Gtemplocaltime();
		hFindHandle.setValue(0);
		szFindFile.setValue(filename.clip());
		gFileFind.clear();
		hFindHandle.setValue((new Win32()).findFirstFile(szFindFile,gFileFind));
		if (hFindHandle.equals(Constants.INVALID_LONG_VALUE) || hFindHandle.compareTo(0)<=0) {
			return Clarion.newBool(Constants.FALSE);
		}
		(new Win32()).findClose(hFindHandle.like());
		{
			ClarionNumber case_1=which;
			boolean case_1_break=false;
			if (case_1.equals(0)) {
				(new Win32()).fileTimeToLocalFileTime(gFileFind.ftLastWriteTime,gTempLocalTime);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(1)) {
				(new Win32()).fileTimeToLocalFileTime(gFileFind.ftCreationTime,gTempLocalTime);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				(new Win32()).fileTimeToLocalFileTime(gFileFind.ftLastAccessTime,gTempLocalTime);
				case_1_break=true;
			}
		}
		(new Win32()).fileTimeToSystemTime(gTempLocalTime,systime);
		return Clarion.newBool(Constants.TRUE);
	}
}
