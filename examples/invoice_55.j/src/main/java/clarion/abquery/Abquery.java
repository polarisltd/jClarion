package clarion.abquery;

import clarion.abquery.equates.Mquery;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Abquery
{

	public static ClarionString makeoperator(ClarionString opers,ClarionString leadopers)
	{
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionString op=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		Abquery.makeoperator(opers.like(),leadopers.like(),op,res);
		return Clarion.newString(op.concat(res));
	}
	public static void makeoperator(ClarionString opers,ClarionString leadopers,ClarionString sym,ClarionString left)
	{
		ClarionString symb=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		sym.setValue("");
		final int loop_1=leadopers.len();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			if (Clarion.newString("=<>~").inString(leadopers.stringAt(i).toString(),1,1)!=0) {
				symb.setValue(symb.concat(leadopers.stringAt(i)));
			}
			else {
				break;
			}
		}
		left.setValue(leadopers.sub(i.intValue(),Clarion.newNumber(leadopers.len()).subtract(i).add(1).intValue()));
		{
			ClarionString case_1=opers;
			boolean case_1_break=false;
			if (case_1.equals(Mquery.CONTAINS)) {
				left.setValue(ClarionString.staticConcat("*",left));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Mquery.BEGINS)) {
				left.setValue(left.concat("*"));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Mquery.NOTEQUALS)) {
				symb.setValue(symb.concat("<>"));
				case_1_break=true;
			}
			if (!case_1_break) {
				symb.setValue(symb.concat(opers));
			}
		}
		final int loop_2=symb.len();for (j.setValue(1);j.compareTo(loop_2)<=0;j.increment(1)) {
			if (Clarion.newString("<>~").inString(symb.stringAt(j).toString())!=0 && !(sym.inString(symb.stringAt(j).toString())!=0)) {
				sym.setValue(sym.concat(symb.stringAt(j)));
			}
		}
		if (symb.inString("=")!=0 && (!(symb.inString("<")!=0) || !(symb.inString(">")!=0))) {
			sym.setValue(sym.concat("="));
		}
	}
}
