package clarion.abdrops;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Abdrops
{
	public static ClarionString takenewselection_number_lastentry;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		takenewselection_number_lastentry=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	}


	public static ClarionNumber comparefunc(ClarionGroup _p0,ClarionGroup _p1)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public static ClarionNumber casesensitivecompare(ClarionGroup l,ClarionGroup r)
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
	public static ClarionNumber caseinsensitivecompare(ClarionGroup l,ClarionGroup r)
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
