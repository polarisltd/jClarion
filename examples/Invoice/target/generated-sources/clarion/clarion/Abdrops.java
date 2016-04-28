package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Abdrops
{
	public static ClarionString takeNewSelection_number_LastEntry;

	public static ClarionNumber caseSensitiveCompare(ClarionGroup l,ClarionGroup r)
	{
		ClarionAny a1=Clarion.newAny();
		ClarionAny a2=Clarion.newAny();
		a1.setReferenceValue(l.what(1));
		a2.setReferenceValue(r.what(1));
		if (a1.compareTo(a2)<0) {
			return Clarion.newNumber(-1);
		}
		else if (a1.compareTo(a2)>0) {
			return Clarion.newNumber(1);
		}
		return Clarion.newNumber(0);
	}
	public static ClarionNumber caseInsensitiveCompare(ClarionGroup l,ClarionGroup r)
	{
		ClarionAny a1=Clarion.newAny();
		ClarionAny a2=Clarion.newAny();
		a1.setReferenceValue(l.what(1));
		a2.setReferenceValue(r.what(1));
		if (a1.getString().upper().compareTo(a2.getString().upper())<0) {
			return Clarion.newNumber(-1);
		}
		else if (a1.getString().upper().compareTo(a2.getString().upper())>0) {
			return Clarion.newNumber(1);
		}
		return Clarion.newNumber(0);
	}
}
