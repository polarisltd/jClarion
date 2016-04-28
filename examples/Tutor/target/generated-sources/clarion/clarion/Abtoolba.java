package clarion;

import clarion.Constantclass;
import clarion.Listboxtips;
import clarion.Reltreeboxtips;
import clarion.Updatechangetips;
import clarion.Updateinserttips;
import clarion.Updatevcrtips;
import clarion.equates.Consttype;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Term;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Abtoolba
{
	public static Listboxtips listBoxTips;
	public static Reltreeboxtips reltreeBoxTips;
	public static Updateinserttips updateInsertTips;
	public static Updatechangetips updateChangeTips;
	public static Updatevcrtips updateVCRTips;

	public static void setTips(ClarionString in)
	{
		Constantclass cnst=new Constantclass();
		ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString tip=Clarion.newString(255);
		cnst.init(Clarion.newNumber(Term.BYTE));
		cnst.addItem(Clarion.newNumber(Consttype.USHORT),control);
		cnst.addItem(Clarion.newNumber(Consttype.PSTRING),tip);
		cnst.set(in);
		while (cnst.next().equals(Level.BENIGN)) {
			Clarion.getControl(control).setClonedProperty(Prop.TOOLTIP,tip);
		}
		cnst.kill();
	}
}
