package clarion.aberror;

import clarion.Main;
import clarion.aberror.Defaulterrors;
import clarion.aberror.Errorclass;
import clarion.aberror.Stderrorfile;
import clarion.aberror.Window;
import clarion.equates.Level;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Aberror
{
	public static Defaulterrors defaulterrors;
	public static Window window;
	public static Stderrorfile stderrorfile;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		Main.__register_destruct(new Runnable() { public void run() { __static_destruct(); } });
		__static_init();
	}

	public static void __static_init() {
		defaulterrors=new Defaulterrors();
		window=new Window();
		stderrorfile=new Stderrorfile();
	}

	public static void __static_destruct() {
		Aberror.window.close();
	}


	public static void replace(ClarionString find,ClarionString replace,ClarionString into)
	{
		ClarionNumber locate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		while (true) {
			locate.setValue(into.upper().inString(find.upper().toString(),1,1));
			if (!locate.boolValue()) {
				return;
			}
			into.setValue(into.sub(1,locate.subtract(1).intValue()).concat(replace,into.sub(locate.add(find.len()).intValue(),into.len())));
		}
	}
	public static ClarionNumber setid(Errorclass self,ClarionNumber id,ClarionNumber startpos)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(startpos);i.compareTo(1)>=0;i.increment(-1)) {
			self.errors.get(i);
			if (self.errors.id.equals(id)) {
				return Clarion.newNumber(Level.BENIGN);
			}
		}
		return Clarion.newNumber(Level.NOTIFY);
	}
}
