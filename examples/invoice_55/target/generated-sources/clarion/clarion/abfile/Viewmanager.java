package clarion.abfile;

import clarion.Filterqueue;
import clarion.Sortorder;
import clarion.abfile.Abfile;
import clarion.abfile.Relationmanager;
import clarion.abutil.Bufferedpairsclass;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Limit;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Record;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Viewmanager
{
	public ClarionNumber disposeorder=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Sortorder order=null;
	public ClarionNumber pagesahead=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber pagesbehind=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber pagesize=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Relationmanager primary=null;
	public ClarionNumber timeout=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionView view=null;
	public Viewmanager()
	{
		disposeorder=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		order=null;
		pagesahead=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pagesbehind=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pagesize=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		primary=null;
		timeout=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		view=null;
	}

	public void addrange(ClarionObject field)
	{
		this.order.limittype.setValue(Limit.CURRENT);
		this.limitmajorcomponents(field);
		this.order.rangelist.get().additem(field);
		this.setfreeelement();
	}
	public void addrange(ClarionObject field,ClarionObject value)
	{
		this.order.limittype.setValue(Limit.SINGLE);
		this.limitmajorcomponents(field);
		this.order.rangelist.get().additem(value);
		this.setfreeelement();
	}
	public void addrange(ClarionObject field,ClarionObject low,ClarionObject high)
	{
		this.order.limittype.setValue(Limit.PAIR);
		this.limitmajorcomponents(field);
		this.order.rangelist.get().additem(low);
		this.order.rangelist.get().additem(high);
		this.setfreeelement();
	}
	public void addrange(ClarionObject field,Relationmanager myfile,Relationmanager hisfile)
	{
		this.order.limittype.setValue(Limit.FILE);
		hisfile.listlinkingfields(myfile,this.order.rangelist.get());
		this.setfreeelement();
	}
	public ClarionNumber addsortorder()
	{
		return addsortorder((ClarionKey)null);
	}
	public ClarionNumber addsortorder(ClarionKey k)
	{
		this.order.clear();
		this.order.mainkey.set(k);
		this.order.rangelist.set(new Bufferedpairsclass());
		this.order.rangelist.get().init();
		if (!(this.order.mainkey.get()==null) && this.primary.me.getcomponents(k).boolValue()) {
			this.order.freeelement.setReferenceValue(this.primary.me.getfield(k,Clarion.newNumber(1)));
		}
		this.order.add();
		this.setorder(this.primary.me.keytoorder(this.order.mainkey.get(),Clarion.newNumber(1)));
		return Clarion.newNumber(this.order.records());
	}
	public void appendorder(ClarionString f)
	{
		if (this.order.order.get()==null) {
			this.setorder(f.like());
		}
		else if (f.boolValue() && f.stringAt(1).equals("*")) {
			this.setorder(f.stringAt(2,f.len()));
		}
		else {
			this.setorder(Clarion.newString(this.order.order.get().concat(",",f)));
		}
	}
	public void applyfilter()
	{
		ClarionString rangefilter=Clarion.newString(5000).setEncoding(ClarionString.CSTRING);
		ClarionString fieldname=Clarion.newString(500).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rrl=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rrl.setValue(this.order.rangelist.get().list.records());
		{
			ClarionNumber case_1=this.order.limittype;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Limit.CURRENT)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Limit.SINGLE)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Limit.FILE)) {
				final ClarionNumber loop_1=rrl.like();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
					this.order.rangelist.get().list.get(i);
					fieldname.setValue(this.primary.me.getfieldname(this.order.mainkey.get(),i.like()));
					rangefilter.setValue(rangefilter.concat(i.equals(1) ? Clarion.newString("") : Clarion.newString(" AND "),fieldname," = ",Abfile.casedvalue(fieldname.like(),this.order.rangelist.get().list.left,this.order.rangelist.get().list.right.like())));
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Limit.PAIR)) {
				final ClarionObject loop_2=rrl.subtract(1);for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
					this.order.rangelist.get().list.get(i);
					fieldname.setValue(this.primary.me.getfieldname(this.order.mainkey.get(),i.like()));
					{
						ClarionNumber case_2=i;
						boolean case_2_break=false;
						if (case_2.equals(rrl.subtract(1))) {
							rangefilter.setValue(rangefilter.concat(rangefilter.equals("") ? Clarion.newString("") : Clarion.newString(" AND "),fieldname," >= ",Abfile.casedvalue(fieldname.like(),this.order.rangelist.get().list.left,this.order.rangelist.get().list.right.like())));
							case_2_break=true;
						}
						if (!case_2_break) {
							rangefilter.setValue(rangefilter.concat(i.equals(1) ? Clarion.newString("") : Clarion.newString(" AND "),fieldname," = ",Abfile.casedvalue(fieldname.like(),this.order.rangelist.get().list.left,this.order.rangelist.get().list.right.like())));
						}
					}
				}
				this.order.rangelist.get().list.get(rrl);
				rangefilter.setValue(rangefilter.concat(" AND ",fieldname," <= ",Abfile.casedvalue(fieldname.like(),this.order.rangelist.get().list.left,this.order.rangelist.get().list.right.like())));
				case_1_break=true;
			}
		}
		if (!(this.order.filter.get()==null)) {
			final int loop_3=this.order.filter.get().records();for (i.setValue(1);i.compareTo(loop_3)<=0;i.increment(1)) {
				this.order.filter.get().get(i);
				rangefilter.setValue(rangefilter.concat(rangefilter.equals("") ? Clarion.newString("(") : Clarion.newString(" AND ("),this.order.filter.get().filter.get(),")"));
			}
		}
		this.view.setClonedProperty(Prop.FILTER,rangefilter);
		if (CError.errorCode()!=0) {
			this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
		}
	}
	public void applyorder()
	{
		this.view.setClonedProperty(Prop.ORDER,this.order.order.get());
		if (CError.errorCode()!=0) {
			this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
		}
	}
	public ClarionNumber applyrange()
	{
		{
			ClarionNumber case_1=this.order.limittype;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Limit.PAIR)) {
				this.order.rangelist.get().list.get(this.order.rangelist.get().list.records()-1);
				if (!this.order.rangelist.get().list.left.equals(this.order.rangelist.get().list.right)) {
					this.order.rangelist.get().list.right.setValue(this.order.rangelist.get().list.left);
					this.order.rangelist.get().list.put();
					this.order.rangelist.get().list.get(this.order.rangelist.get().list.records());
					this.order.rangelist.get().list.right.setValue(this.order.rangelist.get().list.left);
					this.order.rangelist.get().list.put();
					this.applyfilter();
					return Clarion.newNumber(1);
				}
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Limit.SINGLE)) {
				this.order.rangelist.get().list.get(this.order.rangelist.get().list.records());
				if (!this.order.rangelist.get().list.left.equals(this.order.rangelist.get().list.right)) {
					this.order.rangelist.get().list.right.setValue(this.order.rangelist.get().list.left);
					this.order.rangelist.get().list.put();
					this.applyfilter();
					return Clarion.newNumber(1);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Limit.FILE)) {
				if (!this.order.rangelist.get().equalrightbuffer().boolValue()) {
					this.order.rangelist.get().assignrighttobuffer();
					this.applyfilter();
					return Clarion.newNumber(1);
				}
				case_1_break=true;
			}
		}
		return Clarion.newNumber(0);
	}
	public void close()
	{
		if (this.opened.boolValue()) {
			this.view.close();
		}
		this.opened.setValue(0);
	}
	public ClarionString getfreeelementname()
	{
		ClarionNumber fep=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fep.setValue(this.getfreeelementposition());
		if (fep.boolValue()) {
			return this.primary.me.getfieldname(this.order.mainkey.get(),fep.like());
		}
		return Clarion.newString("");
	}
	public ClarionNumber getfreeelementposition()
	{
		ClarionNumber fep=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fep.setValue(this.order.rangelist.get().list.records());
		if (!this.order.limittype.equals(Limit.PAIR)) {
			fep.increment(1);
		}
		return (!(this.order.mainkey.get()==null) && fep.compareTo(this.primary.me.getcomponents(this.order.mainkey.get()))<=0 ? fep : Clarion.newNumber(0)).getNumber();
	}
	public void init(ClarionView p0,Relationmanager p1)
	{
		init(p0,p1,(Sortorder)null);
	}
	public void init(ClarionView v,Relationmanager f,Sortorder s)
	{
		this.view=v;
		this.primary=f;
		if (s==null) {
			this.order=new Sortorder();
			this.disposeorder.setValue(1);
		}
		else {
			this.order=s;
			this.disposeorder.setValue(0);
		}
		this.pagesize.setValue(20);
		this.pagesbehind.setValue(2);
		this.pagesahead.setValue(0);
		this.timeout.setValue(60);
		this.useview();
	}
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (this.order==null) {
			return;
		}
		final int loop_2=this.order.records();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
			this.order.get(i);
			this.order.rangelist.get().kill();
			//this.order.rangelist.get();
			if (!(this.order.filter.get()==null)) {
				final int loop_1=this.order.filter.get().records();for (j.setValue(1);j.compareTo(loop_1)<=0;j.increment(1)) {
					this.order.filter.get().get(j);
					//this.order.filter.get().filter.get();
				}
			}
			//this.order.filter.get();
			//this.order.order.get();
			this.order.freeelement.setReferenceValue(null);
			this.order.put();
		}
		if (this.disposeorder.boolValue()) {
			//this.order;
		}
	}
	public void limitmajorcomponents(ClarionObject field)
	{
		ClarionAny f=Clarion.newAny();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.order.rangelist.get().init();
		final ClarionNumber loop_1=this.primary.me.getcomponents(this.order.mainkey.get());for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			f.setReferenceValue(this.primary.me.getfield(this.order.mainkey.get(),i.like()));
			if (f.getValue()==field) {
				break;
			}
			this.order.rangelist.get().additem(f);
		}
	}
	public ClarionNumber next()
	{
		while (true) {
			this.view.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(Level.NOTIFY);
				}
				else {
					this.primary.me._throw(Clarion.newNumber(Msg.ABORTREADING));
					return Clarion.newNumber(Level.FATAL);
				}
			}
			else {
				{
					ClarionNumber case_1=this.validaterecord();
					boolean case_1_break=false;
					if (case_1.equals(Record.OK)) {
						return Clarion.newNumber(Level.BENIGN);
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Record.OUTOFRANGE)) {
						return Clarion.newNumber(Level.NOTIFY);
						// UNREACHABLE! :case_1_break=true;
					}
				}
			}
		}
	}
	public void open()
	{
		if (!this.opened.boolValue()) {
			this.view.open();
			if (CError.errorCode()!=0) {
				this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
			}
			this.view.buffer(this.pagesize.intValue(),this.pagesbehind.intValue(),this.pagesahead.intValue(),this.timeout.intValue());
			this.opened.setValue(1);
		}
		this.applyorder();
		this.applyfilter();
	}
	public ClarionNumber previous()
	{
		while (true) {
			this.view.previous();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(Level.NOTIFY);
				}
				else {
					this.primary.me._throw(Clarion.newNumber(Msg.ABORTREADING));
					return Clarion.newNumber(Level.FATAL);
				}
			}
			else {
				{
					ClarionNumber case_1=this.validaterecord();
					boolean case_1_break=false;
					if (case_1.equals(Record.OK)) {
						return Clarion.newNumber(Level.BENIGN);
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Record.OUTOFRANGE)) {
						return Clarion.newNumber(Level.NOTIFY);
						// UNREACHABLE! :case_1_break=true;
					}
				}
			}
		}
	}
	public ClarionNumber primerecord()
	{
		return primerecord(Clarion.newNumber(0));
	}
	public ClarionNumber primerecord(ClarionNumber sc)
	{
		ClarionAny f=Clarion.newAny();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber delta=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionFile fr=null;
		if (!sc.boolValue()) {
			final ClarionObject loop_1=this.view.getProperty(Prop.FILES);for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				fr=this.view.getFile(i.intValue());
				fr.clear();
			}
		}
		{
			ClarionNumber case_1=this.order.limittype;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Limit.PAIR)) {
				delta.setValue(-2);
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Limit.CURRENT)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Limit.SINGLE)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Limit.FILE)) {
				final ClarionObject loop_2=Clarion.newNumber(this.order.rangelist.get().list.records()).add(delta);for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
					this.order.rangelist.get().list.get(i);
					f.setReferenceValue(this.primary.me.getfield(this.order.mainkey.get(),i.like()));
					f.setValue(this.order.rangelist.get().list.right);
				}
			}
		}
		return this.primary.me.primerecord(Clarion.newNumber(1));
	}
	public void reset(ClarionNumber locatepos)
	{
		this.open();
		this.view.set(locatepos.intValue());
		if (CError.errorCode()!=0) {
			this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
		}
	}
	public void reset()
	{
		this.reset(Clarion.newNumber(0));
	}
	public void setfilter(ClarionString f)
	{
		this.setfilter(f.like(),Clarion.newString("5 Standard"));
	}
	public void setfilter(ClarionString f,ClarionString id)
	{
		if (this.order.filter.get()==null) {
			this.order.filter.set(new Filterqueue());
			this.order.put();
		}
		this.order.filter.get().id.setValue(id);
		this.order.filter.get().get(this.order.filter.get().ORDER().descend(this.order.filter.get().id));
		if (!(CError.errorCode()!=0)) {
			//this.order.filter.get().filter.get();
		}
		else {
			this.order.filter.get().add(this.order.filter.get().ORDER().descend(this.order.filter.get().id));
		}
		if (f.boolValue()) {
			this.order.filter.get().filter.set(Abfile.dupstring(f.like()));
			this.order.filter.get().put();
		}
		else {
			this.order.filter.get().delete();
		}
	}
	public void setfreeelement()
	{
		ClarionNumber fep=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fep.setValue(this.getfreeelementposition());
		if (fep.boolValue()) {
			this.order.freeelement.setReferenceValue(this.primary.me.getfield(this.order.mainkey.get(),fep.like()));
		}
		this.setorder(this.primary.me.keytoorder(this.order.mainkey.get(),Clarion.newNumber(1)));
		this.order.put();
	}
	public void setorder(ClarionString f)
	{
		//this.order.order.get();
		if (f.boolValue()) {
			this.order.order.set(Abfile.dupstring(f.like()));
		}
		this.order.put();
	}
	public ClarionNumber setsort(ClarionNumber b)
	{
		if (b.equals(0)) {
			b.setValue(1);
		}
		if (b.equals(this.order.getPointer())) {
			return Clarion.newNumber(0);
		}
		else {
			this.order.get(b);
			return Clarion.newNumber(1);
		}
	}
	public void useview()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionFile fr=null;
		final ClarionObject loop_1=this.view.getProperty(Prop.FILES);for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			fr=this.view.getFile(i.intValue());
			Abfile.filesmanager.getfilemapping(Abfile.filesmanager.getfileid(fr));
			if (Abfile.filemapping.filemanager.get().usefile().boolValue()) {
				return;
			}
		}
	}
	public ClarionNumber validaterecord()
	{
		return Clarion.newNumber(Record.OK);
	}
}
