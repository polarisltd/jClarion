package clarion;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Core
{

	public ClarionNumber pathSplit(ClarionString p0,ClarionString p1,ClarionString p2,ClarionString p3)
	{
		return pathSplit(p0,p1,p2,p3,(ClarionString)null);
	}
	public ClarionNumber pathSplit(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		return pathSplit(p0,p1,p2,(ClarionString)null);
	}
	public ClarionNumber pathSplit(ClarionString p0,ClarionString p1)
	{
		return pathSplit(p0,p1,(ClarionString)null);
	}
	public ClarionNumber pathSplit(ClarionString p0)
	{
		return pathSplit(p0,(ClarionString)null);
	}
	public ClarionNumber pathSplit(ClarionString path,ClarionString drive,ClarionString dir,ClarionString file,ClarionString ext)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
