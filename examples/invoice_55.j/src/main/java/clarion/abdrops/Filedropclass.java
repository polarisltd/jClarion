package clarion.abdrops;

import clarion.Windowcomponent;
import clarion.abfile.Relationmanager;
import clarion.abfile.Viewmanager;
import clarion.abutil.Fieldpairsclass;
import clarion.abwindow.Windowmanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Filedropclass extends Viewmanager
{
	public Fieldpairsclass displayfields=null;
	public Fieldpairsclass updatefields=null;
	public Windowmanager window=null;
	public ClarionNumber defaultfill=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber initsyncpair=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber allowreset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber listcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber listfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionQueue listqueue=null;
	public ClarionNumber loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewposition=null;

	private static class _Windowcomponent_Impl extends Windowcomponent
	{
		private Filedropclass _owner;
		public _Windowcomponent_Impl(Filedropclass _owner)
		{
			this._owner=_owner;
		}
		public void kill()
		{
			throw new RuntimeException("Procedure/Method not defined");
		}
		public void reset(ClarionNumber force)
		{
			throw new RuntimeException("Procedure/Method not defined");
		}
		public ClarionNumber resetrequired()
		{
			throw new RuntimeException("Procedure/Method not defined");
		}
		public void setalerts()
		{
			throw new RuntimeException("Procedure/Method not defined");
		}
		public ClarionNumber takeevent()
		{
			throw new RuntimeException("Procedure/Method not defined");
		}
		public void update()
		{
			throw new RuntimeException("Procedure/Method not defined");
		}
		public void updatewindow()
		{
			throw new RuntimeException("Procedure/Method not defined");
		}
	}
	private Windowcomponent _Windowcomponent_inst;
	public Windowcomponent windowcomponent()
	{
		if (_Windowcomponent_inst==null) _Windowcomponent_inst=new _Windowcomponent_Impl(this);
		return _Windowcomponent_inst;
	}
	public Filedropclass()
	{
		displayfields=null;
		updatefields=null;
		window=null;
		defaultfill=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		initsyncpair=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		allowreset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		listcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		listfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		listqueue=null;
		loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		viewposition=null;
	}

	public void addfield(ClarionObject source,ClarionObject destination)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber addrecord()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void addupdatefield(ClarionObject source,ClarionObject destination)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber buffermatches()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(ClarionNumber listbox,ClarionString position,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber resetqueue()
	{
		return resetqueue(Clarion.newNumber(0));
	}
	public ClarionNumber resetqueue(ClarionNumber force)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setqueuerecord()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takeaccepted()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takeevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takenewselection()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takenewselection(ClarionNumber field)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber validaterecord()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
