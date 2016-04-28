package clarion;

import clarion.Editclass;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.File;
import clarion.equates.Icon;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Editfileclass extends Editclass
{
	public ClarionString title;
	public ClarionString filePattern;
	public ClarionString fileMask;
	public Editfileclass()
	{
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		filePattern=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
		fileMask=Clarion.newString(15).setEncoding(ClarionString.CSTRING);
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
		ClarionString str=Clarion.newString(File.MAXFILEPATH+1).setEncoding(ClarionString.CSTRING);
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.readOnly.boolValue()) {
					if (!this.title.boolValue()) {
						this.title.setValue(Clarion.getControl(this.listBoxFeq).getProperty(Proplist.HEADER,this.fieldNo));
					}
					CWin.update(this.feq.intValue());
					str.setValue(this.useVar);
					if (CWin.fileDialog(this.title.toString(),str,this.filePattern.toString(),this.fileMask.intValue())) {
						this.useVar.setValue(str);
						CWin.display(this.feq.intValue());
					}
					return Clarion.newNumber(Editaction.IGNORE);
				}
			}
		}
		return super.takeEvent(e.like());
	}
}
