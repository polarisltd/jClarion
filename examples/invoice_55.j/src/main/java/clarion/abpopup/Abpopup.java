package clarion.abpopup;

import clarion.abpopup.Popupclass;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CMemory;

@SuppressWarnings("all")
public class Abpopup
{

	public static ClarionString getuniquename(Popupclass self,ClarionString thisitem)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber unamelen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString uniquename=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		if (thisitem.equals("-")) {
			uniquename.setValue("Separator");
		}
		else {
			final int loop_1=thisitem.clip().len();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
				{
					ClarionString case_1=thisitem.stringAt(c);
					boolean case_1_match=false;
					case_1_match=false;
					if (case_1.compareTo("A")>=0 && case_1.compareTo("Z")<=0) {
						case_1_match=true;
					}
					if (case_1_match || case_1.compareTo("a")>=0 && case_1.compareTo("z")<=0) {
						case_1_match=true;
					}
					if (case_1_match || case_1.compareTo("0")>=0 && case_1.compareTo("9")<=0) {
						case_1_match=true;
					}
					if (case_1_match || case_1.equals("_")) {
						uniquename.setValue(uniquename.concat(thisitem.stringAt(c)));
					}
				}
			}
		}
		unamelen.setValue(uniquename.len());
		c.setValue(0);
		while (true) {
			if (c.compareTo(0)>0) {
				uniquename.setValue(uniquename.stringAt(1,unamelen).concat(c));
			}
			if (!self.locatename(uniquename.like()).boolValue()) {
				break;
			}
			c.increment(1);
		}
		return uniquename.like();
	}
	public static ClarionString removeampersand(ClarionString itemtext)
	{
		ClarionString cleantext=Clarion.newString(100);
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber t=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber slen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		slen.setValue(itemtext.clip().len());
		t.setValue(1);
		final ClarionNumber loop_1=slen.like();for (s.setValue(1);s.compareTo(loop_1)<=0;s.increment(1)) {
			if (itemtext.stringAt(s).equals("&")) {
				if (s.add(1).compareTo(slen)>0) {
					continue;
				}
				else {
					if (itemtext.stringAt(s.add(1)).equals("&")) {
						cleantext.setStringAt(t,"&");
					}
					else {
						continue;
					}
				}
			}
			else {
				cleantext.setStringAt(t,itemtext.stringAt(s));
			}
			t.increment(1);
		}
		return cleantext.clip();
	}
	public static void poptoolbox(ClarionString s,ClarionString n)
	{
		Popupclass p=null;
		p=(Popupclass)CMemory.resolveAddress(s.add(0).intValue());
		p.asktoolbox(n.like());
	}
}
