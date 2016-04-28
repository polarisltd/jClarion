package clarion;

import clarion.Day_group;
import clarion.Month_group;
import clarion.Translation;
import clarion.Translatortypemappings;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Abutil
{
	public static Translation translation;
	public static Translatortypemappings translatorTypeMappings;
	public static ClarionString kill_ExtractFilename;
	public static Day_group ask_string_number_Day_group;
	public static Month_group ask_string_number_Month_group;

	public static ClarionString addDollar(ClarionString src)
	{
		ClarionString hold=Clarion.newString(1024);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber tp=Clarion.newNumber(0).setEncoding(ClarionNumber.UNSIGNED);
		for (sp.setValue(1);sp.compareTo(src.len())<=0;sp.increment(1)) {
			if (src.stringAt(sp).equals("$")) {
				tp.increment(2);
				hold.setStringAt(tp.subtract(1),"$");
				hold.setStringAt(tp,"$");
			}
			tp.increment(1);
			hold.setStringAt(tp,src.stringAt(sp));
		}
		return hold.stringAt(1,tp);
	}
	public static ClarionString removeDollar(ClarionString src)
	{
		ClarionString hold=Clarion.newString(1024);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber tp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		tp.setValue(0);
		sp.setValue(0);
		l.setValue(src.len());
		while (sp.compareTo(l)<0) {
			tp.increment(1);
			sp.increment(1);
			if (src.stringAt(sp).equals("$")) {
				if (sp.add(2).compareTo(l)<=0) {
					if (src.stringAt(sp.add(1)).equals("$") && src.stringAt(sp.add(2)).equals("$")) {
						sp.increment(2);
					}
				}
			}
			hold.setStringAt(tp,src.stringAt(sp));
		}
		if (tp.equals(0)) {
			return Clarion.newString("");
		}
		return hold.stringAt(1,tp);
	}
}
