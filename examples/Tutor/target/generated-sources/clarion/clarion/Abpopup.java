package clarion;

import clarion.Popupclass;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CMemory;

public class Abpopup
{

	public static ClarionString getUniqueName(Popupclass self,ClarionString thisItem)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber uNameLen=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString uniqueName=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		if (thisItem.equals("-")) {
			uniqueName.setValue("Separator");
			uNameLen.setValue(9);
		}
		else {
			i.setValue(0);
			for (c.setValue(1);c.compareTo(thisItem.clip().len())<=0;c.increment(1)) {
				{
					int case_1=thisItem.stringAt(c).val();
					boolean case_1_match=false;
					case_1_match=false;
					if (case_1>=Clarion.newString("A").val() && case_1<=Clarion.newString("Z").val()) {
						case_1_match=true;
					}
					if (case_1_match || case_1>=Clarion.newString("a").val() && case_1<=Clarion.newString("z").val()) {
						case_1_match=true;
					}
					if (case_1_match || case_1>=Clarion.newString("0").val() && case_1<=Clarion.newString("9").val()) {
						case_1_match=true;
					}
					if (case_1_match || case_1==Clarion.newString("_").val()) {
						i.increment(1);
						uniqueName.setStringAt(i,thisItem.stringAt(c));
					}
				}
			}
			uniqueName.setStringAt(i.add(1),"\u0000");
			uNameLen.setValue(i);
		}
		c.setValue(0);
		while (true) {
			if (c.compareTo(0)>0) {
				uniqueName.setValue(uniqueName.stringAt(1,uNameLen).concat(c));
			}
			if (!self.locateName(uniqueName.like()).boolValue()) {
				break;
			}
			c.increment(1);
		}
		return uniqueName.like();
	}
	public static ClarionString removeAmpersand(ClarionString itemText)
	{
		ClarionString cleanText=Clarion.newString(100);
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber t=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber sLen=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		sLen.setValue(itemText.clip().len());
		t.setValue(1);
		for (s.setValue(1);s.compareTo(sLen)<=0;s.increment(1)) {
			if (itemText.stringAt(s).equals("&")) {
				if (s.add(1).compareTo(sLen)>0) {
					continue;
				}
				else {
					if (itemText.stringAt(s.add(1)).equals("&")) {
						cleanText.setStringAt(t,"&");
					}
					else {
						continue;
					}
				}
			}
			else {
				cleanText.setStringAt(t,itemText.stringAt(s));
			}
			t.increment(1);
		}
		return cleanText.clip();
	}
	public static void popToolbox(ClarionString s,ClarionString n)
	{
		Popupclass p=null;
		p=(Popupclass)CMemory.resolveAddress(s.add(0).intValue());
		p.askToolbox(n.like());
	}
}
