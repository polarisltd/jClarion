package clarion.abeip;

import clarion.abeip.Editclass;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.File;
import clarion.equates.Icon;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Editfileclass extends Editclass
{
	public ClarionString title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	public ClarionString filepattern=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
	public ClarionString filemask=Clarion.newString(15).setEncoding(ClarionString.CSTRING);
	public Editfileclass()
	{
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		filepattern=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
		filemask=Clarion.newString(15).setEncoding(ClarionString.CSTRING);
	}

	public void createcontrol()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
		CRun._assert(this.feq.boolValue());
		Clarion.getControl(this.feq).setProperty(Prop.DROP,0);
		Clarion.getControl(this.feq).setProperty(Prop.ICON,Icon.ELLIPSIS);
	}
	public ClarionNumber takeevent(ClarionNumber e)
	{
		ClarionString str=Clarion.newString(File.MAXFILEPATH+1).setEncoding(ClarionString.CSTRING);
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.readonly.boolValue()) {
					str.setValue(this.usevar);
					if (CWin.fileDialog(this.title.toString(),str,this.filepattern.toString(),this.filemask.intValue())) {
						this.usevar.setValue(str);
						CWin.display(this.feq.intValue());
					}
					return Clarion.newNumber(Editaction.IGNORE);
				}
			}
		}
		return super.takeevent(e.like());
	}
}
