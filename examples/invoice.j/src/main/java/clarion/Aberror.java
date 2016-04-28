package clarion;

import clarion.Defaulterrors;
import clarion.Errorclass;
import clarion.Stderrorfile;
import clarion.Window_1;
import clarion.equates.Level;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Aberror
{
	public static Defaulterrors defaultErrors;
	public static Window_1 window;
	public static Stderrorfile stdErrorFile;

	public static void replace(ClarionString find,ClarionString replace,ClarionString into)
	{
		ClarionNumber locate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (!find.upper().equals(replace.upper())) {
			while (true) {
				locate.setValue(into.upper().inString(find.upper().toString(),1,1));
				if (!locate.boolValue()) {
					return;
				}
				into.setValue(into.sub(1,locate.subtract(1).intValue()).concat(replace,into.sub(locate.add(find.len()).intValue(),into.len())));
			}
		}
	}
	public static ClarionNumber setId(Errorclass self,ClarionNumber id,ClarionNumber startPos)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(startPos);i.compareTo(1)>=0;i.increment(-1)) {
			self.errors.get().get(i);
			if (self.errors.get().id.equals(id)) {
				return Clarion.newNumber(Level.BENIGN);
			}
		}
		return Clarion.newNumber(Level.NOTIFY);
	}
}
