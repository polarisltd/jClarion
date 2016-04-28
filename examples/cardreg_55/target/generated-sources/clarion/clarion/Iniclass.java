package clarion;

import clarion.Abutil;
import clarion.Sectorqueue;
import clarion.equates.Constants;
import clarion.equates.File;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

public class Iniclass
{
	public ClarionString fileName;
	public Sectorqueue sectors;
	public Iniclass()
	{
		fileName=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		sectors=null;
	}

	public ClarionString fetch(ClarionString sector,ClarionString name,ClarionString _default,ClarionString fileName)
	{
		return Clarion.newString(CConfig.getProperty(sector.toString(),name.toString(),_default.toString(),fileName.toString()));
	}
	public void update(ClarionString sector,ClarionString name,ClarionString value,ClarionString fileName)
	{
		CConfig.setProperty(sector.toString(),name.toString(),value.toString(),fileName.toString());
	}
	public void addSector(ClarionString sector)
	{
		this.getFamily(sector.like(),this.sectors.family,this.sectors.item,this.sectors.type);
		this.sectors.get(this.sectors.ORDER().ascend(this.sectors.family).ascend(this.sectors.item).ascend(this.sectors.type));
		if (CError.errorCode()!=0) {
			this.sectors.add(this.sectors.ORDER().ascend(this.sectors.family).ascend(this.sectors.item).ascend(this.sectors.type));
		}
	}
	public void deleteSector(ClarionString sector)
	{
		this.getFamily(sector.like(),this.sectors.family,this.sectors.item,this.sectors.type);
		this.sectors.get(this.sectors.ORDER().ascend(this.sectors.family).ascend(this.sectors.item).ascend(this.sectors.type));
		if (!(CError.errorCode()!=0)) {
			this.sectors.delete();
		}
	}
	public void fetch()
	{
	}
	public ClarionString fetch(ClarionString sec,ClarionString name)
	{
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		res.setValue(this.fetch(sec.like(),name.like(),Clarion.newString(Constants.INIUNKNOWN),this.fileName.like()));
		CRun._assert(!res.equals(Constants.INIUNKNOWN),ClarionString.staticConcat("INI Assert: Could not find ",name," in sector ",sec," of ",this.fileName));
		return res.like();
	}
	public void fetch(ClarionString procedureName,ClarionWindow w)
	{
		ClarionNumber maximize=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		maximize.setValue(CRun.inlist(this.tryFetch(procedureName.like(),Clarion.newString("Maximize")).toString(),new ClarionString[] {Clarion.newString("No"),Clarion.newString("Yes")}));
		if (maximize.boolValue()) {
			maximize.decrement(1);
			if (!maximize.boolValue() && w.getProperty(Prop.MAXIMIZE).boolValue()) {
				w.setClonedProperty(Prop.MAXIMIZE,maximize);
			}
			if (this.tryFetch(procedureName.like(),Clarion.newString("XPos")).boolValue()) {
				w.setProperty(Prop.XPOS,this.fetch(procedureName.like(),Clarion.newString("XPos")));
				w.setProperty(Prop.YPOS,this.fetch(procedureName.like(),Clarion.newString("YPos")));
				if (w.getProperty(Prop.RESIZE).boolValue()) {
					w.setProperty(Prop.WIDTH,this.fetch(procedureName.like(),Clarion.newString("Width")));
					w.setProperty(Prop.HEIGHT,this.fetch(procedureName.like(),Clarion.newString("Height")));
				}
			}
			if (!maximize.equals(w.getProperty(Prop.MAXIMIZE))) {
				w.setClonedProperty(Prop.MAXIMIZE,maximize);
			}
		}
	}
	public void fetch(ClarionString sec,ClarionString name,ClarionObject value)
	{
		value.setValue(this.fetch(sec.like(),name.like(),value.getString(),this.fileName.like()));
	}
	public ClarionString fetchField(ClarionString sec,ClarionString name,ClarionNumber field)
	{
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber finger=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		res.setValue(this.fetch(sec.like(),name.like()));
		while (field.compareTo(1)>0) {
			finger.setValue(res.inString(",",1,finger.intValue()));
			CRun._assert(finger.boolValue());
			finger.increment(1);
			field.decrement(1);
		}
		i.setValue(res.inString(",",1,finger.intValue()));
		return res.stringAt(finger,i.equals(0) ? Clarion.newNumber(res.len()) : i.subtract(1));
	}
	public void fetchQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3,ClarionObject p4)
	{
		fetchQueue(p0,p1,p2,p3,p4,(ClarionObject)null);
	}
	public void fetchQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3)
	{
		fetchQueue(p0,p1,p2,p3,(ClarionObject)null);
	}
	public void fetchQueue(ClarionString sector,ClarionString name,ClarionQueue q,ClarionObject f1,ClarionObject f2,ClarionObject f3)
	{
		ClarionNumber nItems=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		nItems.setValue(this.tryFetch(sector.like(),name.like()));
		for (i.setValue(1);i.compareTo(nItems)<=0;i.increment(1)) {
			f1.setValue(this.fetchField(sector.like(),Clarion.newString(name.concat("_",i)),Clarion.newNumber(1)));
			if (!(f2==null)) {
				f2.setValue(this.fetchField(sector.like(),Clarion.newString(name.concat("_",i)),Clarion.newNumber(2)));
			}
			if (!(f3==null)) {
				f3.setValue(this.fetchField(sector.like(),Clarion.newString(name.concat("_",i)),Clarion.newNumber(3)));
			}
			q.add();
		}
	}
	public void getFamily(ClarionString sector,ClarionString family,ClarionString item,ClarionString type)
	{
		ClarionNumber fp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		fp.setValue(sector.inString("$",1,1));
		sp.setValue(sector.inString("$$",1,1));
		while (true) {
			if (sector.stringAt(sp.add(2)).equals("$")) {
				sp.setValue(sector.inString("$$",1,sp.add(3).intValue()));
				continue;
			}
			break;
		}
		family.setValue(sector.stringAt(1,fp.subtract(1)));
		item.setValue(sector.stringAt(fp.add(1),sp.subtract(1)));
		type.setValue(sector.stringAt(sp.add(2),sector.len()));
	}
	public ClarionString getSector(ClarionString family,ClarionString item,ClarionString type)
	{
		return Clarion.newString(family.concat("$",Abutil.addDollar(item.like()),"$$",type));
	}
	public void getSectors(ClarionString p0,ClarionString p1,Sectorqueue p3)
	{
		getSectors(p0,p1,(ClarionString)null,p3);
	}
	public void getSectors(ClarionString p0,Sectorqueue p3)
	{
		getSectors(p0,(ClarionString)null,p3);
	}
	public void getSectors(Sectorqueue p3)
	{
		getSectors((ClarionString)null,p3);
	}
	public void getSectors(ClarionString family,ClarionString item,ClarionString type,Sectorqueue sq)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		sq.free();
		for (i.setValue(1);i.compareTo(this.sectors.records())<=0;i.increment(1)) {
			this.sectors.get(i);
			if (family.boolValue() && !family.equals(this.sectors.family)) {
				continue;
			}
			if (item.boolValue() && !item.equals(this.sectors.item)) {
				continue;
			}
			if (type.boolValue() && !type.equals(this.sectors.type)) {
				continue;
			}
			sq.setValue(this.sectors.getString());
			sq.item.setValue(Abutil.removeDollar(this.sectors.item.like()));
			sq.add();
		}
	}
	public void init(ClarionString s)
	{
		this.fileName.setValue(s);
		this.sectors=new Sectorqueue();
		this.fetch();
		this.fetchQueue(Clarion.newString("__Dont_Touch_Me__"),Clarion.newString("Sectors"),this.sectors,this.sectors.family,this.sectors.item,this.sectors.type);
	}
	public void kill()
	{
		this.update(Clarion.newString("__Dont_Touch_Me__"),Clarion.newString("Sectors"),this.sectors,this.sectors.family,this.sectors.item,this.sectors.type);
		if (!(this.sectors==null)) {
			//this.sectors;
			this.sectors=null;
		}
	}
	public ClarionString tryFetch(ClarionString sec,ClarionString name)
	{
		return this.fetch(sec.like(),name.like(),Clarion.newString(""),this.fileName.like());
	}
	public ClarionString tryFetchField(ClarionString sec,ClarionString name,ClarionNumber field)
	{
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber finger=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		res.setValue(this.tryFetch(sec.like(),name.like()));
		if (!res.boolValue()) {
			return Clarion.newString("");
		}
		while (field.compareTo(1)>0) {
			finger.setValue(res.inString(",",1,finger.intValue()));
			if (!finger.boolValue()) {
				return Clarion.newString("");
			}
			finger.increment(1);
			field.decrement(1);
		}
		i.setValue(res.inString(",",1,finger.intValue()));
		return res.stringAt(finger,i.equals(0) ? Clarion.newNumber(res.len()) : i.subtract(1));
	}
	public void update()
	{
	}
	public void update(ClarionString procedureName,ClarionWindow w)
	{
		ClarionNumber m=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (!w.getProperty(Prop.ICONIZE).boolValue()) {
			m.setValue(w.getProperty(Prop.MAXIMIZE));
			this.update(procedureName.like(),Clarion.newString("Maximize"),(m.equals(Constants.TRUE) ? Clarion.newString("Yes") : Clarion.newString("No")).getString());
			if (!m.boolValue()) {
				this.update(procedureName.like(),Clarion.newString("XPos"),w.getProperty(Prop.XPOS).getString());
				this.update(procedureName.like(),Clarion.newString("YPos"),w.getProperty(Prop.YPOS).getString());
				if (w.getProperty(Prop.RESIZE).boolValue()) {
					this.update(procedureName.like(),Clarion.newString("Height"),w.getProperty(Prop.HEIGHT).getString());
					this.update(procedureName.like(),Clarion.newString("Width"),w.getProperty(Prop.WIDTH).getString());
				}
			}
		}
	}
	public void update(ClarionString sec,ClarionString name,ClarionString value)
	{
		this.update(sec.like(),name.like(),value.like(),this.fileName.like());
	}
	public void update(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3,ClarionObject p4)
	{
		update(p0,p1,p2,p3,p4,(ClarionObject)null);
	}
	public void update(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3)
	{
		update(p0,p1,p2,p3,(ClarionObject)null);
	}
	public void update(ClarionString sector,ClarionString name,ClarionQueue q,ClarionObject f1,ClarionObject f2,ClarionObject f3)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString st=Clarion.newString(5000).setEncoding(ClarionString.CSTRING);
		this.update(sector.like(),name.like(),Clarion.newString(String.valueOf(q.records())));
		for (i.setValue(1);i.compareTo(q.records())<=0;i.increment(1)) {
			q.get(i);
			st.setValue(f1);
			if (!(f2==null)) {
				st.setValue(st.concat(",",f2));
			}
			if (!(f3==null)) {
				st.setValue(st.concat(",",f3));
			}
			this.update(sector.like(),Clarion.newString(name.concat("_",i)),st.like());
		}
	}
}
