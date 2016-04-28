package clarion;

import clarion.Browsequeue;
import clarion.Ilistcontrol;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Standardbehavior
{
	public ClarionQueue q;
	public ClarionString s;
	public ClarionNumber lc;

	private static class _Ilistcontrol_Impl extends Ilistcontrol
	{
		private Standardbehavior _owner;
		public _Ilistcontrol_Impl(Standardbehavior _owner)
		{
			this._owner=_owner;
		}
		public ClarionNumber choice()
		{
			return Clarion.newNumber(CWin.choice(_owner.lc.intValue()));
		}
		public ClarionNumber getControl()
		{
			return _owner.lc.like();
		}
		public ClarionNumber getItems()
		{
			return Clarion.getControl(_owner.lc).getProperty(Prop.ITEMS).getNumber();
		}
		public ClarionNumber getVisible()
		{
			return Clarion.getControl(_owner.lc).getProperty(Prop.VISIBLE).getNumber();
		}
		public void setChoice(ClarionNumber nc)
		{
			Clarion.getControl(_owner.lc).setClonedProperty(Prop.SELSTART,nc);
		}
		public void setControl(ClarionNumber nc)
		{
			_owner.lc.setValue(nc);
		}
	}
	private Ilistcontrol _Ilistcontrol_inst;
	public Ilistcontrol ilistcontrol()
	{
		if (_Ilistcontrol_inst==null) _Ilistcontrol_inst=new _Ilistcontrol_Impl(this);
		return _Ilistcontrol_inst;
	}

	private static class _Browsequeue_Impl extends Browsequeue
	{
		private Standardbehavior _owner;
		public _Browsequeue_Impl(Standardbehavior _owner)
		{
			this._owner=_owner;
		}
		public ClarionNumber records()
		{
			return Clarion.newNumber(_owner.q.records());
		}
		public void insert()
		{
			_owner.q.add();
		}
		public void insert(ClarionNumber rowNum)
		{
			_owner.q.add(rowNum);
		}
		public void fetch(ClarionNumber rowNum)
		{
			_owner.q.get(rowNum);
		}
		public void update()
		{
			_owner.q.put();
		}
		public void delete()
		{
			_owner.q.delete();
		}
		public void free()
		{
			_owner.q.free();
		}
		public ClarionString who(ClarionNumber colNum)
		{
			return _owner.q.who(colNum.intValue());
		}
		public ClarionString getViewPosition()
		{
			return _owner.s.like();
		}
		public void setViewPosition(ClarionString s)
		{
			_owner.s.setValue(s);
		}
	}
	private Browsequeue _Browsequeue_inst;
	public Browsequeue browsequeue()
	{
		if (_Browsequeue_inst==null) _Browsequeue_inst=new _Browsequeue_Impl(this);
		return _Browsequeue_inst;
	}
	public Standardbehavior()
	{
		q=null;
		s=null;
		lc=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	}

	public void init(ClarionQueue q,ClarionString pos,ClarionNumber lc)
	{
		this.q=q;
		this.s=pos;
		this.lc.setValue(lc);
	}
}
