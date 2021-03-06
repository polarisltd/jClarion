package clarion.abwindow;

import clarion.Recordprocessor;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionBlob;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;

@SuppressWarnings("all")
public class Imagemanager
{
	public ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionAny fld=Clarion.newAny();
	public ClarionBlob blb=null;

	private static class _Recordprocessor_Impl extends Recordprocessor
	{
		private Imagemanager _owner;
		public _Recordprocessor_Impl(Imagemanager _owner)
		{
			this._owner=_owner;
		}
		public ClarionNumber takerecord()
		{
			if (_owner.blb==null) {
				Clarion.getControl(_owner.control).setClonedProperty(Prop.TEXT,_owner.fld);
			}
			else {
				Clarion.getControl(_owner.control).setProperty(Prop.IMAGEBITS,Clarion.getControl(_owner.blb).getProperty(Prop.HANDLE));
			}
			return Clarion.newNumber(Level.BENIGN);
		}
		public ClarionNumber takeclose()
		{
			return Clarion.newNumber(Level.BENIGN);
		}
	}
	private Recordprocessor _Recordprocessor_inst;
	public Recordprocessor recordprocessor()
	{
		if (_Recordprocessor_inst==null) _Recordprocessor_inst=new _Recordprocessor_Impl(this);
		return _Recordprocessor_inst;
	}
	public Imagemanager()
	{
		control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		fld=Clarion.newAny();
		blb=null;
	}

	public void additem(ClarionNumber ctrl,ClarionObject fld)
	{
		this.control.setValue(ctrl);
		this.fld.setReferenceValue(fld);
	}
	public void additem(ClarionNumber ctrl,ClarionBlob fld)
	{
		this.control.setValue(ctrl);
		this.blb=fld;
	}
}
