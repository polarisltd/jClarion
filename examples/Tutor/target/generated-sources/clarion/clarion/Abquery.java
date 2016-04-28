package clarion;

import clarion.equates.Query;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Abquery
{

	public static ClarionString makeOperator(ClarionString opers,ClarionString leadOpers)
	{
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionString op=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		Abquery.makeOperator(opers.like(),leadOpers.like(),op,res);
		return Clarion.newString(op.concat(res));
	}
	public static void makeOperator(ClarionString opers,ClarionString leadOpers,ClarionString sym,ClarionString left)
	{
		ClarionString symb=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		sym.setValue("");
		for (i.setValue(1);i.compareTo(leadOpers.len())<=0;i.increment(1)) {
			if (Clarion.newString("=<>~").inString(leadOpers.stringAt(i).toString(),1,1)!=0) {
				symb.setValue(symb.concat(leadOpers.stringAt(i)));
			}
			else {
				break;
			}
		}
		left.setValue(leadOpers.sub(i.intValue(),Clarion.newNumber(leadOpers.len()).subtract(i).add(1).intValue()));
		{
			ClarionString case_1=opers;
			boolean case_1_break=false;
			if (case_1.equals(Query.CONTAINS)) {
				left.setValue(ClarionString.staticConcat("*",left));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Query.BEGINS)) {
				left.setValue(left.concat("*"));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Query.NOTEQUALS)) {
				symb.setValue(symb.concat("<>"));
				case_1_break=true;
			}
			if (!case_1_break) {
				symb.setValue(symb.concat(opers));
			}
		}
		for (j.setValue(1);j.compareTo(symb.len())<=0;j.increment(1)) {
			if (Clarion.newString("<>~").inString(symb.stringAt(j).toString())!=0 && !(sym.inString(symb.stringAt(j).toString())!=0)) {
				sym.setValue(sym.concat(symb.stringAt(j)));
			}
		}
		if (symb.inString("=")!=0 && (!(symb.inString("<")!=0) || !(symb.inString(">")!=0))) {
			sym.setValue(sym.concat("="));
		}
	}
}
