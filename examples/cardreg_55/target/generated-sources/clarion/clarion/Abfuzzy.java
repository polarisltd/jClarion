package clarion;

import clarion.Fuzzyclass;
import org.jclarion.clarion.ClarionString;

public class Abfuzzy
{
	public static Fuzzyclass fuzzyObject;

	public static ClarionString fuzzyMatch(ClarionString query,ClarionString document)
	{
		return Abfuzzy.fuzzyObject.match(document.like(),query.like()).getString();
	}
}
