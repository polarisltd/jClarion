package clarion;

import clarion.Aberror;
import clarion.Errorloginterface;
import clarion.equates.Constants;
import clarion.equates.Level;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CFile;

public class Standarderrorlogclass
{
	public ClarionNumber usage;

	private static class _Errorloginterface_Impl extends Errorloginterface
	{
		private Standarderrorlogclass _owner;
		public _Errorloginterface_Impl(Standarderrorlogclass _owner)
		{
			this._owner=_owner;
		}
		public ClarionNumber close(ClarionNumber force)
		{
			return _owner.close(force.like());
		}
		public ClarionNumber open(ClarionNumber force)
		{
			return _owner.open(force.like());
		}
		public ClarionNumber take(ClarionString txt)
		{
			if (_owner.usage.boolValue()) {
				Aberror.stdErrorFile.txt.setValue(txt);
				Aberror.stdErrorFile.add();
				return (CError.errorCode()==0 ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.NOTIFY)).getNumber();
			}
			return Clarion.newNumber(Level.NOTIFY);
		}
	}
	private Errorloginterface _Errorloginterface_inst;
	public Errorloginterface errorloginterface()
	{
		if (_Errorloginterface_inst==null) _Errorloginterface_inst=new _Errorloginterface_Impl(this);
		return _Errorloginterface_inst;
	}
	public Standarderrorlogclass()
	{
		usage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		construct();
	}

	public void construct()
	{
		this.usage.setValue(0);
	}
	public void destruct()
	{
		this.close(Clarion.newNumber(Constants.TRUE));
	}
	public ClarionNumber open()
	{
		return open(Clarion.newNumber(Constants.FALSE));
	}
	public ClarionNumber open(ClarionNumber force)
	{
		if (!this.usage.boolValue() || force.boolValue()) {
			if (!CFile.isFile(Aberror.stdErrorFile.getName())) {
				Aberror.stdErrorFile.create();
				if (CError.errorCode()!=0) {
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
			Aberror.stdErrorFile.open(0x42);
			if (CError.errorCode()!=0) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		this.usage.increment(1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber close()
	{
		return close(Clarion.newNumber(Constants.FALSE));
	}
	public ClarionNumber close(ClarionNumber force)
	{
		if (this.usage.equals(1) || force.boolValue()) {
			// destroy Aberror.stdErrorFile;
			if (CError.errorCode()!=0) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			this.usage.setValue(1);
		}
		this.usage.decrement(1);
		return Clarion.newNumber(Level.BENIGN);
	}
}
