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
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber uNameLen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString uniqueName=Clarion.newString(Constants.MAXMENUITEMLEN+1).setEncoding(ClarionString.CSTRING);
		if (thisItem.equals("-")) {
			uniqueName.setValue("Separator");
		}
		else {
			for (c.setValue(1);c.compareTo(thisItem.clip().len())<=0;c.increment(1)) {
				{
					ClarionString case_1=thisItem.stringAt(c);
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
						uniqueName.setValue(uniqueName.concat(thisItem.stringAt(c)));
					}
				}
			}
		}
		uNameLen.setValue(uniqueName.len());
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
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber t=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber sLen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
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
