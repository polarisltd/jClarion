package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Systemtime extends ClarionGroup
{
	public ClarionNumber wYear=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber wMonth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber wDayOfWeek=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber wDay=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber wHour=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber wMinute=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber wSecond=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber wMilliseconds=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Systemtime()
	{
		this.addVariable("wYear",this.wYear);
		this.addVariable("wMonth",this.wMonth);
		this.addVariable("wDayOfWeek",this.wDayOfWeek);
		this.addVariable("wDay",this.wDay);
		this.addVariable("wHour",this.wHour);
		this.addVariable("wMinute",this.wMinute);
		this.addVariable("wSecond",this.wSecond);
		this.addVariable("wMilliseconds",this.wMilliseconds);
	}
}
