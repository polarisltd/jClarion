package clarion;

import clarion.Abutil;
import clarion.Criticalprocedure;
import clarion.Sectorqueue;
import clarion.Windowinfo;
import clarion.equates.Constants;
import clarion.equates.File;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWindowsRegistry;
import org.jclarion.clarion.runtime.concurrent.ICriticalSection;

public class Iniclass
{
	public ClarionString filename;
	public Sectorqueue sectors;
	public ClarionNumber nvType;
	public ClarionNumber extraData;
	public ICriticalSection critSect;
	public Iniclass()
	{
		filename=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		sectors=null;
		nvType=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		extraData=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		critSect=null;
		construct();
	}

	public void construct()
	{
		this.critSect=new ICriticalSection();
	}
	public void destruct()
	{
		this.critSect.Kill();
	}
	public ClarionString fetch(ClarionString sector,ClarionString name,ClarionString _default,ClarionString filename)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionString rVal=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
		try {
			critProc.init(this.critSect);
			{
				ClarionNumber case_1=this.nvType;
				boolean case_1_break=false;
				if (case_1.equals(Constants.NVD_INI)) {
					rVal.setValue(CConfig.getProperty(sector.toString(),name.toString(),_default.toString(),filename.toString()));
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.NVD_REGISTRY)) {
					rVal.setValue(CWindowsRegistry.get((this.extraData.equals(0) ? Clarion.newNumber(Constants.REG_CLASSES_ROOT) : this.extraData).intValue(),(this.filename.equals("") ? sector : Clarion.newString(this.filename.concat("\\",sector))).toString(),name.toString(),null));
					if (rVal.equals("")) {
						rVal.setValue(_default);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.NVD_TABLE)) {
					CRun._assert(Constants.FALSE!=0,"NV_Table: Not Supported Yet");
					rVal.setValue("");
					case_1_break=true;
				}
			}
			return rVal.like();
		} finally {
			critProc.destruct();
		}
	}
	public void update(ClarionString sector,ClarionString name,ClarionString value,ClarionString filename)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			{
				ClarionNumber case_1=this.nvType;
				boolean case_1_break=false;
				if (case_1.equals(Constants.NVD_INI)) {
					CConfig.setProperty(sector.toString(),name.toString(),value.toString(),filename.toString());
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.NVD_REGISTRY)) {
					if (value.equals("")) {
						this.remove(sector.like(),name.like());
					}
					else {
						CWindowsRegistry.put((this.extraData.equals(0) ? Clarion.newNumber(Constants.REG_CLASSES_ROOT) : this.extraData).intValue(),(this.filename.equals("") ? sector : Clarion.newString(this.filename.concat("\\",sector))).toString(),name.toString(),value.toString(),null);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.NVD_TABLE)) {
					CRun._assert(Constants.FALSE!=0,"NV_Table: Not Supported Yet");
					case_1_break=true;
				}
			}
		} finally {
			critProc.destruct();
		}
	}
	public void fetchWindowInfo(ClarionString procedureName,Windowinfo info)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			{
				ClarionString case_1=this.tryFetch(procedureName.like(),Clarion.newString("Maximize"));
				boolean case_1_break=false;
				if (case_1.equals("No")) {
					info.maximized.setValue(Constants.FALSE);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals("Yes")) {
					info.maximized.setValue(Constants.TRUE);
					case_1_break=true;
				}
				if (!case_1_break) {
					info.got.setValue(Constants.FALSE);
					return;
				}
			}
			info.minimized.setValue(Constants.FALSE);
			this.fetch(procedureName.like(),Clarion.newString("Minimize"),info.minimized);
			info.x.setValue(Constants._NOPOS);
			info.y.setValue(Constants._NOPOS);
			info.w.setValue(Constants._NOPOS);
			info.h.setValue(Constants._NOPOS);
			this.fetch(procedureName.like(),Clarion.newString("XPos"),info.x);
			this.fetch(procedureName.like(),Clarion.newString("YPos"),info.y);
			this.fetch(procedureName.like(),Clarion.newString("Width"),info.w);
			this.fetch(procedureName.like(),Clarion.newString("Height"),info.h);
			info.got.setValue(Constants.TRUE);
			return;
		} finally {
			critProc.destruct();
		}
	}
	public void updateWindowInfo(ClarionString procedureName,Windowinfo info)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			this.update(procedureName.like(),Clarion.newString("Maximize"),(!info.maximized.boolValue() ? Clarion.newString("No") : Clarion.newString("Yes")).getString());
			this.update(procedureName.like(),Clarion.newString("Minimize"),(!info.minimized.boolValue() ? Clarion.newString("No") : Clarion.newString("Yes")).getString());
			if (info.x.equals(Constants._NOPOS)) {
				this.remove(procedureName.like(),Clarion.newString("XPos"));
			}
			else {
				this.update(procedureName.like(),Clarion.newString("XPos"),info.x.getString());
			}
			if (info.y.equals(Constants._NOPOS)) {
				this.remove(procedureName.like(),Clarion.newString("YPos"));
			}
			else {
				this.update(procedureName.like(),Clarion.newString("YPos"),info.y.getString());
			}
			if (info.w.equals(Constants._NOPOS)) {
				this.remove(procedureName.like(),Clarion.newString("Width"));
			}
			else {
				this.update(procedureName.like(),Clarion.newString("Width"),info.w.getString());
			}
			if (info.h.equals(Constants._NOPOS)) {
				this.remove(procedureName.like(),Clarion.newString("Height"));
			}
			else {
				this.update(procedureName.like(),Clarion.newString("Height"),info.h.getString());
			}
			return;
		} finally {
			critProc.destruct();
		}
	}
	public void addSector(ClarionString sector)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			this.getFamily(sector.like(),this.sectors.family,this.sectors.item,this.sectors.type);
			this.sectors.get(this.sectors.ORDER().ascend(this.sectors.family).ascend(this.sectors.item).ascend(this.sectors.type));
			if (CError.errorCode()!=0) {
				this.sectors.add(this.sectors.ORDER().ascend(this.sectors.family).ascend(this.sectors.item).ascend(this.sectors.type));
			}
		} finally {
			critProc.destruct();
		}
	}
	public void deleteSector(ClarionString sector)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			this.getFamily(sector.like(),this.sectors.family,this.sectors.item,this.sectors.type);
			this.sectors.get(this.sectors.ORDER().ascend(this.sectors.family).ascend(this.sectors.item).ascend(this.sectors.type));
			if (!(CError.errorCode()!=0)) {
				this.sectors.delete();
			}
		} finally {
			critProc.destruct();
		}
	}
	public void fetch()
	{
	}
	public ClarionString fetch(ClarionString sec,ClarionString name)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		try {
			critProc.init(this.critSect);
			res.setValue(this.fetch(sec.like(),name.like(),Clarion.newString(Constants.INIUNKNOWN),this.filename.like()));
			CRun._assert(!res.equals(Constants.INIUNKNOWN),ClarionString.staticConcat("INI Assert: Could not find ",name," in sector ",sec," of ",this.filename));
			return res.like();
		} finally {
			critProc.destruct();
		}
	}
	public void fetch(ClarionString procedureName,ClarionWindow w)
	{
		Windowinfo info=new Windowinfo();
		ClarionNumber isMax=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.fetchWindowInfo(procedureName.like(),info);
		if (info.got.boolValue()) {
			isMax.setValue(w.getProperty(Prop.MAXIMIZE));
			if (!info.maximized.boolValue() && isMax.boolValue()) {
				w.setProperty(Prop.MAXIMIZE,Constants.FALSE);
			}
			w.setClonedProperty(Prop.XPOS,info.x);
			w.setClonedProperty(Prop.YPOS,info.y);
			if (w.getProperty(Prop.RESIZE).boolValue()) {
				if (!info.w.equals(Constants._NOPOS)) {
					w.setClonedProperty(Prop.WIDTH,info.w);
				}
				if (!info.h.equals(Constants._NOPOS)) {
					w.setClonedProperty(Prop.HEIGHT,info.h);
				}
			}
			if (info.maximized.boolValue() && !isMax.boolValue()) {
				w.setProperty(Prop.MAXIMIZE,Constants.TRUE);
			}
			w.setClonedProperty(Prop.ICONIZE,info.minimized);
		}
	}
	public void fetch(ClarionString sec,ClarionString name,ClarionObject value)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			value.setValue(this.fetch(sec.like(),name.like(),value.getString(),this.filename.like()));
		} finally {
			critProc.destruct();
		}
	}
	public ClarionString fetchField(ClarionString sec,ClarionString name,ClarionNumber field)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber finger=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		try {
			critProc.init(this.critSect);
			res.setValue(this.fetch(sec.like(),name.like()));
			while (field.compareTo(1)>0) {
				finger.setValue(res.inString(",",1,finger.intValue()));
				CRun._assert(finger.boolValue());
				finger.increment(1);
				field.decrement(1);
			}
			i.setValue(res.inString(",",1,finger.intValue()));
			return res.stringAt(finger,i.equals(0) ? Clarion.newNumber(res.len()) : i.subtract(1));
		} finally {
			critProc.destruct();
		}
	}
	public void fetchQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3,ClarionObject p4,ClarionObject p5)
	{
		fetchQueue(p0,p1,p2,p3,p4,p5,(ClarionObject)null);
	}
	public void fetchQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3,ClarionObject p4)
	{
		fetchQueue(p0,p1,p2,p3,p4,(ClarionObject)null);
	}
	public void fetchQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3)
	{
		fetchQueue(p0,p1,p2,p3,(ClarionObject)null);
	}
	public void fetchQueue(ClarionString sector,ClarionString name,ClarionQueue q,ClarionObject f1,ClarionObject f2,ClarionObject f3,ClarionObject f4)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionNumber nItems=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		try {
			critProc.init(this.critSect);
			nItems.setValue(this.tryFetch(sector.like(),name.like()));
			for (i.setValue(1);i.compareTo(nItems)<=0;i.increment(1)) {
				f1.setValue(this.fetchField(sector.like(),Clarion.newString(name.concat("_",i)),Clarion.newNumber(1)));
				if (!(f2==null)) {
					f2.setValue(this.fetchField(sector.like(),Clarion.newString(name.concat("_",i)),Clarion.newNumber(2)));
				}
				if (!(f3==null)) {
					f3.setValue(this.fetchField(sector.like(),Clarion.newString(name.concat("_",i)),Clarion.newNumber(3)));
				}
				if (!(f4==null)) {
					f4.setValue(this.fetchField(sector.like(),Clarion.newString(name.concat("_",i)),Clarion.newNumber(4)));
				}
				q.add();
			}
		} finally {
			critProc.destruct();
		}
	}
	public void fetchQ(ClarionString pSection,ClarionQueue pQ)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionNumber nbrOfRec=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString entryStr=Clarion.newString("ENTRY_");
		ClarionString valueStr=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber fldNdx=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber ndx=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		try {
			critProc.init(this.critSect);
			pQ.free();
			nbrOfRec.setValue(this.fetch(pSection.like(),Clarion.newString("Entries")));
			if (nbrOfRec.boolValue()) {
				for (ndx.setValue(1);ndx.compareTo(nbrOfRec)<=0;ndx.increment(1)) {
					valueStr.setValue(this.fetch(pSection.like(),Clarion.newString(entryStr.concat(ndx))));
					if (valueStr.boolValue()) {
						fldNdx.setValue(1);
						this.parseStr(valueStr.like(),pQ,fldNdx.like());
						pQ.add();
					}
				}
			}
		} finally {
			critProc.destruct();
		}
	}
	public void getFamily(ClarionString sector,ClarionString family,ClarionString item,ClarionString type)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionNumber fp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber sp=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		try {
			critProc.init(this.critSect);
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
		} finally {
			critProc.destruct();
		}
	}
	public ClarionString getSector(ClarionString family,ClarionString item,ClarionString type)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			return Clarion.newString(family.concat("$",Abutil.addDollar(item.like()),"$$",type));
		} finally {
			critProc.destruct();
		}
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
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		try {
			critProc.init(this.critSect);
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
		} finally {
			critProc.destruct();
		}
	}
	public void init(ClarionString s)
	{
		this.init(s.like(),Clarion.newNumber(Constants.NVD_INI));
	}
	public void init(ClarionString p0,ClarionNumber p1)
	{
		init(p0,p1,Clarion.newNumber(0));
	}
	public void init(ClarionString s,ClarionNumber nvType,ClarionNumber extraData)
	{
		this.extraData.setValue(extraData);
		this.nvType.setValue(nvType);
		this.filename.setValue(s);
		this.sectors=new Sectorqueue();
		this.fetch();
		this.fetchQueue(Clarion.newString("__Dont_Touch_Me__"),Clarion.newString("Sectors"),this.sectors,this.sectors.family,this.sectors.item,this.sectors.type);
	}
	public void parseStr(ClarionString szValue,ClarionQueue pQ,ClarionNumber fldNbr)
	{
		ClarionNumber pos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionAny aField=Clarion.newAny();
		aField.setReferenceValue(null);
		aField.setReferenceValue(pQ.what(fldNbr.intValue()));
		if (!(aField.getValue()==null)) {
			if (szValue.stringAt(1).equals("[")) {
				pos.setValue(szValue.inString("]",1,1));
				if (pos.boolValue()) {
					aField.setValue(szValue.stringAt(2,pos.subtract(1)));
					pos.setValue(szValue.inString(",",1,pos.add(1).intValue()));
				}
			}
			else {
				pos.setValue(szValue.inString(",",1,1));
				if (pos.boolValue()) {
					aField.setValue(szValue.stringAt(1,pos.subtract(1)));
				}
				else {
					aField.setValue(szValue);
				}
			}
			if (pos.boolValue()) {
				if (szValue.stringAt(pos.add(1),szValue.len()).boolValue()) {
					this.parseStr(szValue.stringAt(pos.add(1),szValue.len()),pQ,fldNbr.add(1).getNumber());
				}
			}
		}
	}
	public void kill()
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			this.updateQueue(Clarion.newString("__Dont_Touch_Me__"),Clarion.newString("Sectors"),this.sectors,this.sectors.family,this.sectors.item,this.sectors.type);
			if (!(this.sectors==null)) {
				//this.sectors;
				this.sectors=null;
			}
		} finally {
			critProc.destruct();
		}
	}
	public void remove(ClarionString sector,ClarionString name)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			{
				ClarionNumber case_1=this.nvType;
				boolean case_1_break=false;
				if (case_1.equals(Constants.NVD_INI)) {
					CConfig.setProperty(sector.toString(),name.toString(),null,this.filename.toString());
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.NVD_REGISTRY)) {
					CWindowsRegistry.delete((this.extraData.equals(0) ? Clarion.newNumber(Constants.REG_CLASSES_ROOT) : this.extraData).intValue(),(this.filename.equals("") ? sector : Clarion.newString(this.filename.concat("\\",sector))).toString(),name.toString());
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.NVD_TABLE)) {
					CRun._assert(Constants.FALSE!=0,"NV_Table: Not Supported Yet");
					case_1_break=true;
				}
			}
		} finally {
			critProc.destruct();
		}
	}
	public ClarionString tryFetch(ClarionString sec,ClarionString name)
	{
		return this.fetch(sec.like(),name.like(),Clarion.newString(""),this.filename.like());
	}
	public ClarionString tryFetchField(ClarionString sec,ClarionString name,ClarionNumber field)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionString res=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber finger=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		try {
			critProc.init(this.critSect);
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
		} finally {
			critProc.destruct();
		}
	}
	public void update()
	{
	}
	public void update(ClarionString procedureName,ClarionWindow w)
	{
		Windowinfo info=new Windowinfo();
		info.maximized.setValue(!w.getProperty(Prop.MAXIMIZE).equals(0) ? 1 : 0);
		info.minimized.setValue(!w.getProperty(Prop.ICONIZE).equals(0) ? 1 : 0);
		info.x.setValue(Constants._NOPOS);
		info.y.setValue(Constants._NOPOS);
		info.w.setValue(Constants._NOPOS);
		info.h.setValue(Constants._NOPOS);
		if (!info.minimized.boolValue() && !info.maximized.boolValue()) {
			info.x.setValue(w.getProperty(Prop.XPOS));
			info.y.setValue(w.getProperty(Prop.YPOS));
			if (w.getProperty(Prop.RESIZE).boolValue()) {
				info.w.setValue(w.getProperty(Prop.WIDTH));
				info.h.setValue(w.getProperty(Prop.HEIGHT));
			}
		}
		this.updateWindowInfo(procedureName.like(),info);
		return;
	}
	public void update(ClarionString sec,ClarionString name,ClarionString value)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		try {
			critProc.init(this.critSect);
			this.update(sec.like(),name.like(),value.like(),this.filename.like());
		} finally {
			critProc.destruct();
		}
	}
	public void updateQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3,ClarionObject p4,ClarionObject p5)
	{
		updateQueue(p0,p1,p2,p3,p4,p5,(ClarionObject)null);
	}
	public void updateQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3,ClarionObject p4)
	{
		updateQueue(p0,p1,p2,p3,p4,(ClarionObject)null);
	}
	public void updateQueue(ClarionString p0,ClarionString p1,ClarionQueue p2,ClarionObject p3)
	{
		updateQueue(p0,p1,p2,p3,(ClarionObject)null);
	}
	public void updateQueue(ClarionString sector,ClarionString name,ClarionQueue q,ClarionObject f1,ClarionObject f2,ClarionObject f3,ClarionObject f4)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString st=Clarion.newString(5000).setEncoding(ClarionString.CSTRING);
		try {
			critProc.init(this.critSect);
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
				if (!(f4==null)) {
					st.setValue(st.concat(",",f4));
				}
				this.update(sector.like(),Clarion.newString(name.concat("_",i)),st.like());
			}
		} finally {
			critProc.destruct();
		}
	}
	public void updateQ(ClarionString pSection,ClarionQueue pQ)
	{
		Criticalprocedure critProc=new Criticalprocedure();
		ClarionNumber nbrOfRec=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString entryStr=Clarion.newString("ENTRY_");
		ClarionString valueStr=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionAny qField=Clarion.newAny();
		ClarionNumber ndx=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber fldNdx=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		try {
			critProc.init(this.critSect);
			nbrOfRec.setValue(pQ.records());
			this.update(pSection.like(),Clarion.newString("Entries"),nbrOfRec.getString());
			ndx.setValue(1);
			while (true) {
				pQ.get(ndx);
				if (!(CError.errorCode()!=0)) {
					valueStr.setValue("");
					fldNdx.setValue(1);
					while (true) {
						qField.setReferenceValue(null);
						qField.setReferenceValue(pQ.what(fldNdx.intValue()));
						if (!(qField.getValue()==null)) {
							if (valueStr.boolValue()) {
								if (qField.getString().inString(",",1,1)!=0) {
									valueStr.setValue(valueStr.clip().concat(",[",qField.getString().clip(),"]"));
								}
								else {
									valueStr.setValue(valueStr.clip().concat(",",qField));
								}
							}
							else {
								if (qField.getString().inString(",",1,1)!=0) {
									valueStr.setValue(ClarionString.staticConcat("[",qField.getString().clip(),"]"));
								}
								else {
									valueStr.setValue(qField);
								}
							}
							fldNdx.increment(1);
						}
						else {
							break;
						}
					}
					this.update(pSection.like(),Clarion.newString(entryStr.concat(ndx)),valueStr.like());
					ndx.increment(1);
				}
				else {
					break;
				}
			}
		} finally {
			critProc.destruct();
		}
	}
}
