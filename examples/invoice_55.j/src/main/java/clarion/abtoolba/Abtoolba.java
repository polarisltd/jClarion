package clarion.abtoolba;

import clarion.Main;
import clarion.abtoolba.Listboxtips;
import clarion.abtoolba.Reltreeboxtips;
import clarion.abtoolba.Updatechangetips;
import clarion.abtoolba.Updateinserttips;
import clarion.abutil.Constantclass;
import clarion.equates.Consttype;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Term;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Abtoolba
{
	public static Listboxtips listboxtips;
	public static Reltreeboxtips reltreeboxtips;
	public static Updateinserttips updateinserttips;
	public static Updatechangetips updatechangetips;
	public Constantclass cnst;
	public ClarionNumber control;
	public ClarionString tip;
	public ClarionString in;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		listboxtips=new Listboxtips();
		reltreeboxtips=new Reltreeboxtips();
		updateinserttips=new Updateinserttips();
		updatechangetips=new Updatechangetips();
	}


	public void settips(ClarionString in)
	{
		this.in=in;
		cnst=new Constantclass();
		control=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		tip=Clarion.newString(255);
		cnst.init(Clarion.newNumber(Term.BYTE));
		cnst.additem(Clarion.newNumber(Consttype.USHORT),control);
		cnst.additem(Clarion.newNumber(Consttype.PSTRING),tip);
		cnst.set(in);
		while (cnst.next().equals(Level.BENIGN)) {
			Clarion.getControl(control).setClonedProperty(Prop.TOOLTIP,tip);
		}
		cnst.kill();
	}
}
