package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.crash.Crash;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Main
{

	private static java.util.List<Runnable> __static_init_list = new java.util.ArrayList<Runnable>();
	public static void __register_init(Runnable r) {
		__static_init_list.add(r);
	}

	private static java.util.List<Runnable> __static_destruct_list = new java.util.ArrayList<Runnable>();
	public static void __register_destruct(Runnable r) {
		__static_destruct_list.add(r);
	}

	private static boolean __is_init=false;
	static {
		__static_init();
	}

	public static void __static_init() {
		__is_init=true;
		java.util.List<Runnable> __init_list = new java.util.ArrayList<Runnable>(__static_init_list);
		for (Runnable __scan : __init_list) { __scan.run(); };
	}

	public static void __static_destruct() {
		__is_init=false;
		java.util.List<Runnable> __destruct_list = new java.util.ArrayList<Runnable>(__static_destruct_list);
		for (Runnable __scan : __destruct_list) { __scan.run(); };
	}


	public static void main(String[] args)
	{
		try { if (!__is_init) { __static_init(); } begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { __static_destruct(); }
	}
	public static void begin(String[] args)
	{
		CRun.init(args);
		CWin.message(Clarion.newString("Hello World"),Clarion.newString("Example"));
	}
}
