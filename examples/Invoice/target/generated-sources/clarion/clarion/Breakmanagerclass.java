package clarion;

import clarion.Breaksqueue;
import clarion.Levelmanagerclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;

public class Breakmanagerclass
{
	public Breaksqueue qb;
	public ClarionNumber breakId;
	public Breakmanagerclass()
	{
		qb=null;
		breakId=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		construct();
	}

	public ClarionNumber getBreak()
	{
		return this.breakId.like();
	}
	public ClarionNumber getLevel(ClarionNumber breakId)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			return this.qb.thisBreak.get().getLevel();
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber getRecords(ClarionNumber breakId)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			return this.qb.thisBreak.get().getRecords();
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber getRecords(ClarionNumber breakId,ClarionNumber levelId)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			return this.qb.thisBreak.get().getRecords(levelId.like());
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber getLevel()
	{
		this.qb.get(this.breakId);
		if (!(CError.errorCode()!=0)) {
			return this.qb.thisBreak.get().getLevel();
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber getRecords()
	{
		this.qb.get(this.breakId);
		if (!(CError.errorCode()!=0)) {
			return this.qb.thisBreak.get().getRecords();
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber getRecordsOnLevel(ClarionNumber levelId)
	{
		this.qb.get(this.breakId);
		if (!(CError.errorCode()!=0)) {
			return this.qb.thisBreak.get().getRecords(levelId.like());
		}
		return Clarion.newNumber(0);
	}
	public void init()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		this.breakId.setValue(0);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.qb.records())<=0;lOCIndex.increment(1)) {
			this.qb.get(lOCIndex);
			if (!(CError.errorCode()!=0)) {
				this.qb.thisBreak.get().kill();
				this.qb.thisBreak.get().destruct();
			}
		}
		this.qb.free();
	}
	public void kill()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.qb.records())<=0;lOCIndex.increment(1)) {
			this.qb.get(lOCIndex);
			if (!(CError.errorCode()!=0)) {
				this.qb.thisBreak.get().kill();
				this.qb.thisBreak.get().destruct();
			}
		}
		this.qb.free();
		this.breakId.setValue(0);
	}
	public void reset()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.qb.records())<=0;lOCIndex.increment(1)) {
			this.qb.get(lOCIndex);
			if (!(CError.errorCode()!=0)) {
				this.breakId.setValue(this.qb.id);
				this.qb.thisBreak.get().reset();
			}
		}
	}
	public void reset(ClarionNumber breakId)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().reset();
		}
	}
	public void addBreak()
	{
		this.qb.clear();
		this.qb.thisBreak.set(new Levelmanagerclass());
		this.qb.id.setValue(this.qb.records()+1);
		this.qb.add();
		this.breakId.setValue(this.qb.id);
		this.qb.thisBreak.get().init(this,this.breakId.like());
	}
	public void addLevel()
	{
		if (this.breakId.compareTo(0)>0) {
			this.addLevel(this.breakId.like());
		}
		else {
			if (this.qb.records()!=0) {
				this.addLevel(Clarion.newNumber(1));
			}
		}
	}
	public void addLevel(ClarionNumber breakId)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().addLevel();
		}
	}
	public void addResetField(ClarionObject levelField)
	{
		if (this.breakId.compareTo(0)>0) {
			this.addResetField(this.breakId.like(),levelField);
		}
		else {
			if (this.qb.records()!=0) {
				this.addResetField(Clarion.newNumber(1),levelField);
			}
		}
	}
	public void addHotField(ClarionObject levelField)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lOCActualId=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (this.qb.records()!=0) {
			lOCActualId.setValue(this.breakId);
		}
		else {
			lOCActualId.setValue(0);
		}
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.qb.records())<=0;lOCIndex.increment(1)) {
			this.qb.get(lOCIndex);
			if (!(CError.errorCode()!=0)) {
				this.breakId.setValue(this.qb.id);
				this.qb.thisBreak.get().addField(levelField);
			}
		}
		if (lOCActualId.boolValue()) {
			this.breakId.setValue(lOCActualId);
			this.qb.get(this.breakId);
			if (CError.errorCode()!=0) {
				this.breakId.setValue(0);
			}
		}
	}
	public void addField(ClarionObject levelField)
	{
		if (this.breakId.compareTo(0)>0) {
			this.addField(this.breakId.like(),levelField);
		}
		else {
			if (this.qb.records()!=0) {
				this.addField(Clarion.newNumber(1),levelField);
			}
		}
	}
	public void addField(ClarionNumber breakId,ClarionObject levelField)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().addField(levelField);
		}
	}
	public void addTotal(ClarionObject target,ClarionObject source,ClarionNumber type,ClarionNumber resetOnLevel)
	{
		if (this.breakId.compareTo(0)>0) {
			this.addTotalToBreak(this.breakId.like(),target,source,type.like(),resetOnLevel.like());
		}
		else {
			if (this.qb.records()!=0) {
				this.addTotalToBreak(Clarion.newNumber(1),target,source,type.like(),resetOnLevel.like());
			}
		}
	}
	public void addTotal(ClarionObject target,ClarionObject source,ClarionNumber type,ClarionNumber resetOnLevel,ClarionString condition)
	{
		if (this.breakId.compareTo(0)>0) {
			this.addTotalToBreak(this.breakId.like(),target,source,type.like(),resetOnLevel.like(),condition.like());
		}
		else {
			if (this.qb.records()!=0) {
				this.addTotalToBreak(Clarion.newNumber(1),target,source,type.like(),resetOnLevel.like(),condition.like());
			}
		}
	}
	public void addTotal(ClarionObject target,ClarionNumber resetOnLevel)
	{
		if (this.breakId.compareTo(0)>0) {
			this.addTotalToBreak(this.breakId.like(),target,resetOnLevel.like());
		}
		else {
			if (this.qb.records()!=0) {
				this.addTotalToBreak(Clarion.newNumber(1),target,resetOnLevel.like());
			}
		}
	}
	public void addTotal(ClarionObject target,ClarionNumber resetOnLevel,ClarionString condition)
	{
		if (this.breakId.compareTo(0)>0) {
			this.addTotalToBreak(this.breakId.like(),target,resetOnLevel.like(),condition.like());
		}
		else {
			if (this.qb.records()!=0) {
				this.addTotalToBreak(Clarion.newNumber(1),target,resetOnLevel.like(),condition.like());
			}
		}
	}
	public void addResetField(ClarionNumber breakId,ClarionObject levelField)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.qb.thisBreak.get().addResetField(levelField);
		}
	}
	public void addTotalToBreak(ClarionNumber breakId,ClarionObject target,ClarionObject source,ClarionNumber type,ClarionNumber resetOnLevel)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().addTotal(target,source,type.like(),resetOnLevel.like());
		}
	}
	public void addTotalToBreak(ClarionNumber breakId,ClarionObject target,ClarionObject source,ClarionNumber type,ClarionNumber resetOnLevel,ClarionString condition)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().addTotal(target,source,type.like(),resetOnLevel.like(),condition.like());
		}
	}
	public void addTotalToBreak(ClarionNumber breakId,ClarionObject target,ClarionNumber resetOnLevel)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().addTotal(target,resetOnLevel.like());
		}
	}
	public void addTotalToBreak(ClarionNumber breakId,ClarionObject target,ClarionNumber resetOnLevel,ClarionString condition)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().addTotal(target,resetOnLevel.like(),condition.like());
		}
	}
	public void askBreak()
	{
		askBreak(Clarion.newNumber(0));
	}
	public void askBreak(ClarionNumber force)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.qb.records())<=0;lOCIndex.increment(1)) {
			this.qb.get(lOCIndex);
			if (!(CError.errorCode()!=0)) {
				this.breakId.setValue(this.qb.id);
				this.qb.thisBreak.get().askLevel(force.like());
			}
		}
	}
	public void takeStart(ClarionNumber breakId,ClarionNumber levelId)
	{
	}
	public void takeEnd(ClarionNumber breakId,ClarionNumber levelId)
	{
	}
	public void updateTotal(ClarionNumber breakId,ClarionNumber levelId)
	{
		this.qb.get(breakId);
		if (!(CError.errorCode()!=0)) {
			this.breakId.setValue(this.qb.id);
			this.qb.thisBreak.get().updateTotal(levelId.like());
		}
	}
	public void construct()
	{
		this.qb=new Breaksqueue();
		this.breakId.setValue(0);
	}
	public void destruct()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.qb.records())<=0;lOCIndex.increment(1)) {
			this.qb.get(lOCIndex);
			if (!(CError.errorCode()!=0)) {
				this.qb.thisBreak.get().kill();
				this.qb.thisBreak.get().destruct();
			}
		}
		this.qb.free();
		// destroy this.qb;
	}
}
