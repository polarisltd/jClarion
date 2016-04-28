package clarion.abfuzzy;

import clarion.Main;
import clarion.abfuzzy.Fuzzyclass;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Abfuzzy
{
	public static Fuzzyclass fuzzyobject;
	public ClarionString query;
	public ClarionString document;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		fuzzyobject=null;
	}


	public ClarionString fuzzymatch(ClarionString query,ClarionString document)
	{
		this.query=query;
		this.document=document;
		return Abfuzzy.fuzzyobject.match(document.like(),query.like()).getString();
	}
}
