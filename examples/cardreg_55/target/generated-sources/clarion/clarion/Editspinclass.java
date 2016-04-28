package clarion;

import clarion.Editclass;
import clarion.equates.Create;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.runtime.CWin;

public class Editspinclass extends Editclass
{
	public Editspinclass()
	{
	}

	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.SPIN,null,null));
		Clarion.getControl(this.feq).setProperty(Prop.STEP,1);
		Clarion.getControl(this.feq).setProperty(Prop.RANGELOW,(int)0x80000001l);
		Clarion.getControl(this.feq).setProperty(Prop.RANGEHIGH,0x7fffffff);
	}
}
