package clarion;

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
	public static ClarionNumber translateString_string_Recurse;

	public static ClarionString addDollar(ClarionString src)
	{
		ClarionString hold=Clarion.newString(255);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber tp=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		for (sp.setValue(1);sp.compareTo(src.len())<=0;sp.increment(1)) {
			if (src.stringAt(sp).equals("$")) {
				hold.setStringAt(tp,tp.add(2),"$$$");
				tp.increment(2);
			}
			hold.setStringAt(tp,src.stringAt(sp));
			tp.increment(1);
		}
		return hold.sub(1,tp.subtract(1).intValue());
	}
	public static ClarionString removeDollar(ClarionString src)
	{
		ClarionString hold=Clarion.newString(255);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber tp=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		for (sp.setValue(1);sp.compareTo(src.len())<=0;sp.increment(1)) {
			if (src.stringAt(sp,sp.add(2)).equals("$$$")) {
				hold.setStringAt(tp,"$");
				sp.increment(2);
			}
			else {
				hold.setStringAt(tp,src.stringAt(sp));
			}
			tp.increment(1);
		}
		return hold.sub(1,tp.subtract(1).intValue());
	}
}
