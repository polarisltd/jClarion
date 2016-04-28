package clarion;

import clarion.Abfile;
import clarion.Bufferedpairsclass;
import clarion.Buffersqueue;
import clarion.Filemanager;
import clarion.Filterqueue;
import clarion.Relationmanager;
import clarion.Sortorder;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Limit;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Record;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.view.ClarionView;

public class Viewmanager
{
	public ClarionNumber disposeOrder;
	public ClarionNumber opened;
	public Sortorder order;
	public ClarionNumber pagesAhead;
	public ClarionNumber pagesBehind;
	public ClarionNumber pageSize;
	public Relationmanager primary;
	public ClarionNumber timeOut;
	public ClarionView view;
	public Buffersqueue savedBuffers;
	public Viewmanager()
	{
		disposeOrder=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		order=null;
		pagesAhead=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pagesBehind=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pageSize=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		primary=null;
		timeOut=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		view=null;
		savedBuffers=null;
	}

	public void destruct()
	{
		this.close();
	}
	public void addRange(ClarionObject field)
	{
		this.order.limitType.setValue(Limit.CURRENT);
		this.limitMajorComponents(field);
		this.order.rangeList.get().addItem(field);
		this.setFreeElement();
	}
	public void addRange(ClarionObject field,ClarionObject value)
	{
		this.order.limitType.setValue(Limit.SINGLE);
		this.limitMajorComponents(field);
		this.order.rangeList.get().addItem(value);
		this.setFreeElement();
	}
	public void addRange(ClarionObject field,ClarionObject low,ClarionObject high)
	{
		this.order.limitType.setValue(Limit.PAIR);
		this.limitMajorComponents(field);
		this.order.rangeList.get().addItem(low);
		this.order.rangeList.get().addItem(high);
		this.setFreeElement();
	}
	public void addRange(ClarionObject field,Relationmanager myFile,Relationmanager hisFile)
	{
		this.order.limitType.setValue(Limit.FILE);
		hisFile.listLinkingFields(myFile,this.order.rangeList.get());
		this.setFreeElement();
	}
	public ClarionNumber addSortOrder()
	{
		return addSortOrder((ClarionKey)null);
	}
	public ClarionNumber addSortOrder(ClarionKey k)
	{
		this.order.clear();
		this.order.mainKey.set(k);
		this.order.rangeList.set(new Bufferedpairsclass());
		this.order.rangeList.get().init();
		if (!(this.order.mainKey.get()==null) && this.primary.me.getComponents(k).boolValue()) {
			this.order.freeElement.setReferenceValue(this.primary.me.getField(k,Clarion.newNumber(1)));
		}
		this.order.add();
		this.setOrder(this.primary.me.keyToOrder(this.order.mainKey.get(),Clarion.newNumber(1)));
		return Clarion.newNumber(this.order.records());
	}
	public void appendOrder(ClarionString f)
	{
		if (this.order.order.get()==null) {
			this.setOrder(f.like());
		}
		else if (f.boolValue() && f.stringAt(1).equals("*")) {
			this.setOrder(f.stringAt(2,f.len()));
		}
		else {
			this.setOrder(Clarion.newString(this.order.order.get().concat(",",f)));
		}
	}
	public void applyFilter()
	{
		ClarionString rangeFilter=Clarion.newString(5000).setEncoding(ClarionString.CSTRING);
		ClarionString fieldName=Clarion.newString(500).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rrl=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rrl.setValue(this.order.rangeList.get().list.records());
		{
			ClarionNumber case_1=this.order.limitType;
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
				for (i.setValue(1);i.compareTo(rrl)<=0;i.increment(1)) {
					this.order.rangeList.get().list.get(i);
					fieldName.setValue(this.primary.me.getFieldName(this.order.mainKey.get(),i.like()));
					rangeFilter.setValue(rangeFilter.concat(i.equals(1) ? Clarion.newString("") : Clarion.newString(" AND "),fieldName," = ",Abfile.casedValue(fieldName.like(),this.order.rangeList.get().list.left,this.order.rangeList.get().list.right.like())));
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Limit.PAIR)) {
				for (i.setValue(1);i.compareTo(rrl.subtract(1))<=0;i.increment(1)) {
					this.order.rangeList.get().list.get(i);
					fieldName.setValue(this.primary.me.getFieldName(this.order.mainKey.get(),i.like()));
					{
						ClarionNumber case_2=i;
						boolean case_2_break=false;
						if (case_2.equals(rrl.subtract(1))) {
							rangeFilter.setValue(rangeFilter.concat(rangeFilter.equals("") ? Clarion.newString("") : Clarion.newString(" AND "),fieldName," >= ",Abfile.casedValue(fieldName.like(),this.order.rangeList.get().list.left,this.order.rangeList.get().list.right.like())));
							case_2_break=true;
						}
						if (!case_2_break) {
							rangeFilter.setValue(rangeFilter.concat(i.equals(1) ? Clarion.newString("") : Clarion.newString(" AND "),fieldName," = ",Abfile.casedValue(fieldName.like(),this.order.rangeList.get().list.left,this.order.rangeList.get().list.right.like())));
						}
					}
				}
				this.order.rangeList.get().list.get(rrl);
				rangeFilter.setValue(rangeFilter.concat(" AND ",fieldName," <= ",Abfile.casedValue(fieldName.like(),this.order.rangeList.get().list.left,this.order.rangeList.get().list.right.like())));
				case_1_break=true;
			}
		}
		if (!(this.order.filter.get()==null)) {
			for (i.setValue(1);i.compareTo(this.order.filter.get().records())<=0;i.increment(1)) {
				this.order.filter.get().get(i);
				rangeFilter.setValue(rangeFilter.concat(rangeFilter.equals("") ? Clarion.newString("(") : Clarion.newString(" AND ("),this.order.filter.get().filter.get(),")"));
			}
		}
		this.view.setClonedProperty(Prop.FILTER,rangeFilter);
		if (CError.errorCode()!=0) {
			this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
		}
	}
	public void applyOrder()
	{
		this.view.setClonedProperty(Prop.ORDER,this.order.order.get());
		if (CError.errorCode()!=0) {
			this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
		}
	}
	public ClarionNumber applyRange()
	{
		{
			ClarionNumber case_1=this.order.limitType;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Limit.PAIR)) {
				this.order.rangeList.get().list.get(this.order.rangeList.get().list.records()-1);
				if (!this.order.rangeList.get().list.left.equals(this.order.rangeList.get().list.right)) {
					this.order.rangeList.get().list.right.setValue(this.order.rangeList.get().list.left);
					this.order.rangeList.get().list.put();
					this.order.rangeList.get().list.get(this.order.rangeList.get().list.records());
					this.order.rangeList.get().list.right.setValue(this.order.rangeList.get().list.left);
					this.order.rangeList.get().list.put();
					this.applyFilter();
					return Clarion.newNumber(1);
				}
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Limit.SINGLE)) {
				this.order.rangeList.get().list.get(this.order.rangeList.get().list.records());
				if (!this.order.rangeList.get().list.left.equals(this.order.rangeList.get().list.right)) {
					this.order.rangeList.get().list.right.setValue(this.order.rangeList.get().list.left);
					this.order.rangeList.get().list.put();
					this.applyFilter();
					return Clarion.newNumber(1);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Limit.FILE)) {
				if (!this.order.rangeList.get().equalRightBuffer().boolValue()) {
					this.order.rangeList.get().assignRightToBuffer();
					this.applyFilter();
					return Clarion.newNumber(1);
				}
				case_1_break=true;
			}
		}
		return Clarion.newNumber(0);
	}
	public void close()
	{
		this.close(Clarion.newNumber(Constants.FALSE));
	}
	public void close(ClarionNumber force)
	{
		if (this.opened.boolValue() || force.boolValue()) {
			this.view.close();
			this.opened.setValue(0);
		}
	}
	public ClarionString getFreeElementAscending()
	{
		ClarionNumber fep=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fep.setValue(this.getFreeElementPosition());
		if (fep.boolValue()) {
			return this.primary.me.getFieldAscending(this.order.mainKey.get(),fep.like()).getString();
		}
		return Clarion.newString(String.valueOf(1));
	}
	public ClarionString getFreeElementName()
	{
		ClarionNumber fep=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fep.setValue(this.getFreeElementPosition());
		if (fep.boolValue()) {
			return this.primary.me.getFieldName(this.order.mainKey.get(),fep.like());
		}
		return Clarion.newString("");
	}
	public ClarionNumber getFreeElementPosition()
	{
		ClarionNumber fep=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fep.setValue(this.order.rangeList.get().list.records());
		if (!this.order.limitType.equals(Limit.PAIR)) {
			fep.increment(1);
		}
		return (!(this.order.mainKey.get()==null) && fep.compareTo(this.primary.me.getComponents(this.order.mainKey.get()))<=0 ? fep : Clarion.newNumber(0)).getNumber();
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
			this.disposeOrder.setValue(1);
		}
		else {
			this.order=s;
			this.disposeOrder.setValue(0);
		}
		this.savedBuffers=new Buffersqueue();
		this.pageSize.setValue(20);
		this.pagesBehind.setValue(2);
		this.pagesAhead.setValue(0);
		this.timeOut.setValue(60);
		this.useView();
	}
	public ClarionNumber getFieldAscending(ClarionObject fld)
	{
		ClarionFile f=null;
		ClarionNumber fieldIdx=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString fn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		ClarionGroup record=null;
		ClarionAny field=Clarion.newAny();
		ClarionAny parField=Clarion.newAny();
		ClarionNumber pos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber fieldAscending=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fieldAscending.setValue(1);
		parField.setReferenceValue(fld);
		for (fieldIdx.setValue(1);fieldIdx.compareTo(this.view.getProperty(Prop.FIELDS))<=0;fieldIdx.increment(1)) {
			f=this.view.getFileForField(fieldIdx.intValue());
			record=(ClarionGroup)CMemory.resolveAddress(f.getProperty(Prop.RECORD).intValue());
			field.setReferenceValue(record.what(this.view.getFileIndexForField(fieldIdx.intValue())));
			if (field.getValue()==parField.getValue()) {
				fn.setValue(record.who(this.view.getFileIndexForField(fieldIdx.intValue())));
				break;
			}
		}
		if (fn.boolValue()) {
			pos.setValue(this.view.getProperty(Prop.ORDER).getString().strpos(ClarionString.staticConcat("{{{[+-]}{",fn,"}[,]}|{{[+-]}{",fn,"}$}}"),1!=0));
			if (!pos.boolValue()) {
				pos.setValue(this.view.getProperty(Prop.ORDER).getString().strpos(ClarionString.staticConcat("{{{[+-]}{UPPER(",fn,")}[,]}|{{[+-]}{UPPER(",fn,")}$}}"),1!=0));
			}
			if (pos.boolValue()) {
				fieldAscending.setValue(this.view.getProperty(Prop.ORDER).getString().sub(pos.intValue(),1).equals("+") ? Clarion.newNumber(Constants.TRUE) : Clarion.newNumber(Constants.FALSE));
			}
		}
		return fieldAscending.like();
	}
	public ClarionString getFieldName(ClarionObject fld)
	{
		ClarionFile f=null;
		ClarionNumber fieldIdx=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString fn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		ClarionGroup record=null;
		ClarionAny field=Clarion.newAny();
		ClarionAny parField=Clarion.newAny();
		parField.setReferenceValue(fld);
		for (fieldIdx.setValue(1);fieldIdx.compareTo(this.view.getProperty(Prop.FIELDS))<=0;fieldIdx.increment(1)) {
			f=this.view.getFileForField(fieldIdx.intValue());
			record=(ClarionGroup)CMemory.resolveAddress(f.getProperty(Prop.RECORD).intValue());
			field.setReferenceValue(record.what(this.view.getFileIndexForField(fieldIdx.intValue())));
			if (field.getValue()==parField.getValue()) {
				fn.setValue(record.who(this.view.getFileIndexForField(fieldIdx.intValue())));
				break;
			}
		}
		return fn.like();
	}
	public ClarionAny getFirstSortField()
	{
		ClarionFile f=null;
		ClarionNumber fieldIdx=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionAny field=Clarion.newAny();
		ClarionNumber idxStar=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber idxEnd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionGroup record=null;
		if (this.order.order.get().boolValue()) {
			idxEnd.setValue(this.order.order.get().inString(",",1,1));
			if (idxEnd.boolValue()) {
				idxEnd.decrement(1);
			}
			else {
				idxEnd.setValue(this.order.order.get().clip().len());
			}
			if (this.order.order.get().stringAt(1).equals("+") || this.order.order.get().stringAt(1).equals("-")) {
				idxStar.setValue(2);
			}
			else {
				idxStar.setValue(1);
			}
			if (idxEnd.compareTo(idxStar.add(6))>0) {
				if (this.order.order.get().stringAt(idxStar,idxStar.add(5)).upper().equals("UPPER(") && this.order.order.get().stringAt(idxEnd).equals(")")) {
					idxEnd.decrement(1);
					idxStar.increment(6);
				}
			}
			for (fieldIdx.setValue(1);fieldIdx.compareTo(this.view.getProperty(Prop.FIELDS))<=0;fieldIdx.increment(1)) {
				f=this.view.getFileForField(fieldIdx.intValue());
				record=(ClarionGroup)CMemory.resolveAddress(f.getProperty(Prop.RECORD).intValue());
				if (record.who(this.view.getFileIndexForField(fieldIdx.intValue())).upper().equals(this.order.order.get().stringAt(idxStar,idxEnd).upper())) {
					field.setReferenceValue(record.what(this.view.getFileIndexForField(fieldIdx.intValue())));
					break;
				}
			}
		}
		return field;
	}
	public ClarionString getFirstSortFieldName()
	{
		ClarionNumber idxStar=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber idxEnd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString retVal=Clarion.newString(512).setEncoding(ClarionString.CSTRING);
		if (this.order.order.get().boolValue()) {
			idxEnd.setValue(this.order.order.get().inString(",",1,1));
			if (idxEnd.boolValue()) {
				idxEnd.decrement(1);
			}
			else {
				idxEnd.setValue(this.order.order.get().clip().len());
			}
			if (this.order.order.get().stringAt(1).equals("+") || this.order.order.get().stringAt(1).equals("-")) {
				idxStar.setValue(2);
			}
			else {
				idxStar.setValue(1);
			}
			if (idxEnd.compareTo(idxStar.add(6))>0) {
				if (this.order.order.get().stringAt(idxStar,idxStar.add(5)).upper().equals("UPPER(") && this.order.order.get().stringAt(idxEnd).equals(")")) {
					idxEnd.decrement(1);
					idxStar.increment(6);
				}
			}
			retVal.setValue(this.order.order.get().stringAt(idxStar,idxEnd));
		}
		return retVal.like();
	}
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (this.order==null) {
			return;
		}
		for (i.setValue(1);i.compareTo(this.order.records())<=0;i.increment(1)) {
			this.order.get(i);
			this.order.rangeList.get().kill();
			//this.order.rangeList.get();
			if (!(this.order.filter.get()==null)) {
				for (j.setValue(1);j.compareTo(this.order.filter.get().records())<=0;j.increment(1)) {
					this.order.filter.get().get(j);
					//this.order.filter.get().filter.get();
				}
			}
			//this.order.filter.get();
			//this.order.order.get();
			this.order.freeElement.setReferenceValue(null);
			this.order.put();
		}
		if (this.disposeOrder.boolValue()) {
			//this.order;
		}
		if (!(this.savedBuffers==null)) {
			this.savedBuffers.free();
			//this.savedBuffers;
		}
		this.close();
	}
	public void limitMajorComponents(ClarionObject field)
	{
		ClarionAny f=Clarion.newAny();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.order.rangeList.get().init();
		for (i.setValue(1);i.compareTo(this.primary.me.getComponents(this.order.mainKey.get()))<=0;i.increment(1)) {
			f.setReferenceValue(this.primary.me.getField(this.order.mainKey.get(),i.like()));
			if (f.getValue()==field) {
				break;
			}
			this.order.rangeList.get().addItem(f);
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
					ClarionNumber case_1=this.validateRecord();
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
			this.opened.setValue(0);
			this.view.open();
			{
				int case_1=CError.errorCode();
				boolean case_1_break=false;
				if (case_1==Constants.NOERROR) {
					this.opened.setValue(1);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.ISOPENERR) {
					case_1_break=true;
				}
				if (!case_1_break) {
					this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
				}
			}
			this.view.buffer(this.pageSize.intValue(),this.pagesBehind.intValue(),this.pagesAhead.intValue(),this.timeOut.intValue());
		}
		this.applyOrder();
		this.applyFilter();
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
					ClarionNumber case_1=this.validateRecord();
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
	public ClarionNumber primeRecord()
	{
		return primeRecord(Clarion.newNumber(0));
	}
	public ClarionNumber primeRecord(ClarionNumber sc)
	{
		ClarionAny f=Clarion.newAny();
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber delta=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionFile fr=null;
		if (!sc.boolValue()) {
			for (i.setValue(1);i.compareTo(this.view.getProperty(Prop.FILES))<=0;i.increment(1)) {
				fr=this.view.getFile(i.intValue());
				fr.clear();
			}
		}
		{
			ClarionNumber case_1=this.order.limitType;
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
				for (i.setValue(1);i.compareTo(Clarion.newNumber(this.order.rangeList.get().list.records()).add(delta))<=0;i.increment(1)) {
					this.order.rangeList.get().list.get(i);
					f.setReferenceValue(this.primary.me.getField(this.order.mainKey.get(),i.like()));
					f.setValue(this.order.rangeList.get().list.right);
				}
			}
		}
		return this.primary.me.primeRecord(Clarion.newNumber(1));
	}
	public void reset(ClarionNumber locatePos)
	{
		this.open();
		this.view.set(locatePos.intValue());
		if (CError.errorCode()!=0) {
			this.primary.me._throw(Clarion.newNumber(Msg.VIEWOPENFAILED));
		}
	}
	public void reset()
	{
		this.reset(Clarion.newNumber(0));
	}
	public void restoreBuffers()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (!(this.savedBuffers==null)) {
			for (i.setValue(1);i.compareTo(this.savedBuffers.records())<=0;i.increment(1)) {
				this.savedBuffers.get(i);
				if (!(CError.errorCode()!=0)) {
					this.savedBuffers.fm.get().restoreBuffer(this.savedBuffers.buff);
				}
			}
			this.savedBuffers.free();
		}
	}
	public void saveBuffers()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionFile fr=null;
		Filemanager fm=null;
		if (!(this.savedBuffers==null)) {
			this.savedBuffers.free();
			for (i.setValue(1);i.compareTo(this.view.getProperty(Prop.FILES))<=0;i.increment(1)) {
				fr=this.view.getFile(i.intValue());
				fm=Abfile.filesManager.getFileMapping(Abfile.filesManager.getFileID(fr));
				if (!(fm==null)) {
					this.savedBuffers.fm.set(fm);
					this.savedBuffers.buff.setValue(fm.saveBuffer());
					this.savedBuffers.add();
				}
			}
		}
	}
	public void setFilter(ClarionString f)
	{
		this.setFilter(f.like(),Clarion.newString("5 Standard"));
	}
	public void setFilter(ClarionString f,ClarionString id)
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
			this.order.filter.get().filter.set(Abfile.dupString(f.like()));
			this.order.filter.get().put();
		}
		else {
			this.order.filter.get().delete();
		}
	}
	public void setFreeElement()
	{
		ClarionNumber fep=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fep.setValue(this.getFreeElementPosition());
		if (fep.boolValue()) {
			this.order.freeElement.setReferenceValue(this.primary.me.getField(this.order.mainKey.get(),fep.like()));
		}
		this.setOrder(this.primary.me.keyToOrder(this.order.mainKey.get(),Clarion.newNumber(1)));
		this.order.put();
	}
	public void setOrder(ClarionString f)
	{
		//this.order.order.get();
		if (f.boolValue()) {
			this.order.order.set(Abfile.dupString(f.like()));
		}
		this.order.put();
	}
	public ClarionNumber setSort(ClarionNumber b)
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
	public void useView()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionFile fr=null;
		Filemanager fm=null;
		for (i.setValue(1);i.compareTo(this.view.getProperty(Prop.FILES))<=0;i.increment(1)) {
			fr=this.view.getFile(i.intValue());
			fm=Abfile.filesManager.getFileMapping(Abfile.filesManager.getFileID(fr));
			if (!(fm==null) && fm.useFile().boolValue()) {
				return;
			}
		}
	}
	public ClarionNumber validateRecord()
	{
		return Clarion.newNumber(Record.OK);
	}
}
