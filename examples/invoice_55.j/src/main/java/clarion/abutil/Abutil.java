package clarion.abutil;

import clarion.Main;
import clarion.abutil.Translation;
import clarion.abutil.Translatortypemappings;
import clarion.equates.Constants;
import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Abutil
{
	public static Translation translation;
	public static Translatortypemappings translatortypemappings;
	public static ClarionString kill_extractfilename;
	public static ClarionNumber translatestring_string_recurse;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		translation=new Translation();
		translatortypemappings=new Translatortypemappings();
		kill_extractfilename=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		translatestring_string_recurse=Clarion.newNumber(Constants.MAXRECURSION).setEncoding(ClarionNumber.SHORT);
	}


	public static ClarionString adddollar(ClarionString src)
	{
		ClarionString hold=Clarion.newString(255);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber tp=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=src.len();for (sp.setValue(1);sp.compareTo(loop_1)<=0;sp.increment(1)) {
			if (src.stringAt(sp).equals("$")) {
				hold.setStringAt(tp,tp.add(2),"$$$");
				tp.increment(2);
			}
			hold.setStringAt(tp,src.stringAt(sp));
			tp.increment(1);
		}
		return hold.sub(1,tp.subtract(1).intValue());
	}
	public static ClarionString removedollar(ClarionString src)
	{
		ClarionString hold=Clarion.newString(255);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber tp=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=src.len();for (sp.setValue(1);sp.compareTo(loop_1)<=0;sp.increment(1)) {
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
