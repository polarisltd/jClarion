package clarion;

import clarion.Editclass;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Editfontclass extends Editclass
{
	public ClarionString title;
	public Editfontclass()
	{
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	}

	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
		CRun._assert(this.feq.boolValue());
		Clarion.getControl(this.feq).setProperty(Prop.DROP,0);
		Clarion.getControl(this.feq).setProperty(Prop.ICON,Icon.ELLIPSIS);
	}
	public ClarionNumber takeEvent(ClarionNumber e)
	{
		ClarionString fontS=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.readOnly.boolValue()) {
					if (!this.title.boolValue()) {
						this.title.setValue(Clarion.getControl(this.listBoxFeq).getProperty(Proplist.HEADER,this.fieldNo));
					}
					CWin.update(this.feq.intValue());
					fontS.setValue(this.useVar);
					if (CWin.fontDialog(this.title.toString(),fontS,null,null,null,null)) {
						this.useVar.setValue(fontS);
						CWin.display(this.feq.intValue());
					}
					return Clarion.newNumber(Editaction.IGNORE);
				}
			}
		}
		return super.takeEvent(e.like());
	}
}
