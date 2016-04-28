package clarion;

import clarion.Breakmanagerclass;
import clarion.Levelsqueue;
import clarion.Resetfieldsqueue;
import clarion.Totalingfieldsqueue;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CWin;

public class Levelmanagerclass
{
	public ClarionNumber bkId;
	public Breakmanagerclass bkManager;
	public Levelsqueue q;
	public Resetfieldsqueue oq;
	public ClarionNumber level;
	public ClarionNumber force;
	public ClarionNumber isOpen;
	public ClarionNumber isSaved;
	public ClarionNumber records;
	public Levelmanagerclass()
	{
		bkId=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		bkManager=null;
		q=null;
		oq=null;
		level=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		force=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		isOpen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		isSaved=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		records=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		construct();
	}

	public ClarionNumber getLevel()
	{
		return this.level.like();
	}
	public ClarionNumber getRecords()
	{
		return this.records.like();
	}
	public ClarionNumber getRecords(ClarionNumber levelId)
	{
		this.q.get(levelId);
		return this.q.records.like();
	}
	public void init(Breakmanagerclass pParent,ClarionNumber breakId)
	{
		this.bkId.setValue(breakId);
		this.bkManager=pParent;
		this.init();
	}
	public void init()
	{
		if (this.isOpen.equals(Constants.TRUE)) {
			return;
		}
		this.level.setValue(0);
		this.force.setValue(Constants.FALSE);
		this.isOpen.setValue(Constants.FALSE);
		this.isSaved.setValue(Constants.FALSE);
		this.records.setValue(0);
	}
	public void kill()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.records())<=0;lOCIndex.increment(1)) {
			this.q.get(lOCIndex);
			this.q.fields.get().free();
			// destroy this.q.fields.get();
			this.q.totals.get().free();
			// destroy this.q.totals.get();
		}
		this.q.free();
		this.oq.free();
		this.level.setValue(0);
		this.force.setValue(Constants.FALSE);
		this.isOpen.setValue(Constants.FALSE);
		this.isSaved.setValue(Constants.FALSE);
	}
	public void reset()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lOCIndex2=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.records())<=0;lOCIndex.increment(1)) {
			this.q.get(lOCIndex);
			this.q.records.setValue(0);
			for (lOCIndex2.setValue(1);lOCIndex2.compareTo(this.q.fields.get().records())<=0;lOCIndex2.increment(1)) {
				this.q.fields.get().get(lOCIndex2);
				this.q.fields.get().lastValue.setValue("");
				this.q.fields.get().savedValue.setValue("");
				this.q.fields.get().put();
			}
			for (lOCIndex2.setValue(1);lOCIndex2.compareTo(this.q.totals.get().records())<=0;lOCIndex2.increment(1)) {
				this.q.totals.get().get(lOCIndex2);
				this.q.totals.get().target.setValue(0);
				this.q.totals.get().auxTarget.setValue(0);
				this.q.totals.get().put();
			}
			this.q.put();
		}
		this.level.setValue(0);
		this.force.setValue(Constants.FALSE);
		this.isOpen.setValue(Constants.FALSE);
		this.isSaved.setValue(Constants.FALSE);
		this.records.setValue(0);
	}
	public void addLevel()
	{
		this.q.clear();
		this.q.fields.set(new Resetfieldsqueue());
		this.q.totals.set(new Totalingfieldsqueue());
		this.q.records.setValue(0);
		this.q.add();
	}
	public void addResetField(ClarionObject levelField)
	{
		ClarionAny localField=Clarion.newAny();
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		localField.setReferenceValue(levelField);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.oq.records())<=0;lOCIndex.increment(1)) {
			this.oq.get(lOCIndex);
			if (localField.getValue()==this.oq.fieldValue.getValue()) {
				this.oq.delete();
			}
		}
		this.q.get(this.q.records());
		this.q.fields.get().clear();
		this.q.fields.get().fieldValue.setReferenceValue(levelField);
		this.q.fields.get().lastValue.setValue("");
		this.q.fields.get().savedValue.setValue("");
		this.q.fields.get().add();
	}
	public void addField(ClarionObject savedField)
	{
		ClarionAny localField=Clarion.newAny();
		ClarionNumber exist=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lOCIndex2=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		exist.setValue(Constants.FALSE);
		localField.setReferenceValue(savedField);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.records())<=0;lOCIndex.increment(1)) {
			this.q.get(lOCIndex);
			for (lOCIndex2.setValue(1);lOCIndex2.compareTo(this.q.fields.get().records())<=0;lOCIndex2.increment(1)) {
				this.q.fields.get().get(lOCIndex2);
				if (localField.getValue()==this.q.fields.get().fieldValue.getValue()) {
					exist.setValue(Constants.TRUE);
					break;
				}
			}
			if (exist.equals(Constants.TRUE)) {
				break;
			}
		}
		if (exist.equals(Constants.FALSE)) {
			for (lOCIndex.setValue(1);lOCIndex.compareTo(this.oq.records())<=0;lOCIndex.increment(1)) {
				this.oq.get(lOCIndex);
				if (localField.getValue()==this.oq.fieldValue.getValue()) {
					exist.setValue(Constants.TRUE);
					break;
				}
			}
		}
		if (exist.equals(Constants.FALSE)) {
			this.oq.clear();
			this.oq.fieldValue.setReferenceValue(savedField);
			this.oq.savedValue.setValue("");
			this.oq.lastValue.setValue("");
			this.oq.add();
		}
	}
	public void addTotal(ClarionObject target,ClarionObject source,ClarionNumber type,ClarionNumber resetOnLevel)
	{
		this.q.get(this.q.records());
		this.q.totals.get().clear();
		this.q.totals.get().source.setReferenceValue(source);
		this.q.totals.get().target.setReferenceValue(target);
		this.q.totals.get().auxTarget.setValue(0);
		this.q.totals.get().type.setValue(type);
		this.q.totals.get().resetOnLevel.setValue(resetOnLevel);
		this.q.totals.get().condition.setValue("");
		this.q.totals.get().add();
	}
	public void addTotal(ClarionObject target,ClarionObject source,ClarionNumber type,ClarionNumber resetOnLevel,ClarionString condition)
	{
		this.q.get(this.q.records());
		this.q.totals.get().clear();
		this.q.totals.get().source.setReferenceValue(source);
		this.q.totals.get().target.setReferenceValue(target);
		this.q.totals.get().auxTarget.setValue(0);
		this.q.totals.get().type.setValue(type);
		this.q.totals.get().resetOnLevel.setValue(resetOnLevel);
		this.q.totals.get().condition.setValue(condition);
		this.q.totals.get().add();
	}
	public void addTotal(ClarionObject target,ClarionNumber resetOnLevel)
	{
		this.q.get(this.q.records());
		this.q.totals.get().clear();
		this.q.totals.get().source.setValue("");
		this.q.totals.get().auxTarget.setValue(0);
		this.q.totals.get().target.setReferenceValue(target);
		this.q.totals.get().type.setValue(1);
		this.q.totals.get().resetOnLevel.setValue(resetOnLevel);
		this.q.totals.get().condition.setValue("");
		this.q.totals.get().add();
	}
	public void addTotal(ClarionObject target,ClarionNumber resetOnLevel,ClarionString condition)
	{
		this.q.get(this.q.records());
		this.q.totals.get().clear();
		this.q.totals.get().source.setValue("");
		this.q.totals.get().auxTarget.setValue(0);
		this.q.totals.get().target.setReferenceValue(target);
		this.q.totals.get().type.setValue(1);
		this.q.totals.get().resetOnLevel.setValue(resetOnLevel);
		this.q.totals.get().condition.setValue(condition);
		this.q.totals.get().add();
	}
	public void askLevel()
	{
		askLevel(Clarion.newNumber(0));
	}
	public void askLevel(ClarionNumber force)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		this.force.setValue(force);
		this.records.increment(1);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.records())<=0;lOCIndex.increment(1)) {
			this.q.get(lOCIndex);
			if (this.evaluateLevel(lOCIndex.like()).boolValue() || this.isOpen.equals(Constants.FALSE) || this.force.equals(Constants.TRUE) && lOCIndex.equals(1)) {
				this.askLevelOff(lOCIndex.like());
				this.askLevelOn(lOCIndex.like());
				break;
			}
		}
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.records())<=0;lOCIndex.increment(1)) {
			if (this.bkId.compareTo(0)>0) {
				this.bkManager.updateTotal(this.bkId.like(),lOCIndex.like());
			}
			else {
				this.updateTotal(lOCIndex.like());
			}
		}
		this.saveBuffer();
	}
	public void askLevelOn(ClarionNumber levelId)
	{
		if (this.force.equals(Constants.TRUE)) {
			return;
		}
		this.refreshFields(levelId.like());
		this.level.setValue(levelId);
		if (this.bkId.compareTo(0)>0) {
			this.bkManager.takeStart(this.bkId.like(),levelId.like());
		}
		else {
			this.takeStart(levelId.like());
		}
		if (levelId.compareTo(this.q.records())<0) {
			this.askLevelOn(levelId.add(1).getNumber());
		}
		else {
			this.isOpen.setValue(Constants.TRUE);
		}
	}
	public void askLevelOff(ClarionNumber levelId)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (this.isOpen.equals(Constants.FALSE)) {
			return;
		}
		this.saveResetBuffer(levelId.like());
		if (levelId.compareTo(this.q.records())<0) {
			this.askLevelOff(levelId.add(1).getNumber());
			for (lOCIndex.setValue(levelId.add(1));lOCIndex.compareTo(this.q.records())<=0;lOCIndex.increment(1)) {
				this.saveResetBuffer(lOCIndex.like());
			}
		}
		this.level.setValue(levelId);
		this.restoreBufferOn();
		if (this.bkId.compareTo(0)>0) {
			this.bkManager.takeEnd(this.bkId.like(),levelId.like());
		}
		else {
			this.takeEnd(levelId.like());
		}
		this.restoreBufferOff();
		for (lOCIndex.setValue(this.q.records());lOCIndex.compareTo(levelId)>=0;lOCIndex.increment(-1)) {
			this.restoreResetBuffer(lOCIndex.like());
		}
		this.resetTotals(levelId.like());
	}
	public void resetTotals(ClarionNumber levelId)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		this.q.get(levelId);
		if (!(CError.errorCode()!=0)) {
			this.q.records.setValue(0);
			this.q.put();
			for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.totals.get().records())<=0;lOCIndex.increment(1)) {
				this.q.totals.get().get(lOCIndex);
				if (this.q.totals.get().resetOnLevel.boolValue()) {
					this.q.totals.get().auxTarget.setValue(0);
					this.q.totals.get().target.setValue(0);
					this.q.totals.get().put();
				}
			}
		}
	}
	public void refreshFields(ClarionNumber levelId)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		this.q.get(levelId);
		if (!(CError.errorCode()!=0)) {
			this.q.records.increment(1);
			for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.fields.get().records())<=0;lOCIndex.increment(1)) {
				this.q.fields.get().get(lOCIndex);
				this.q.fields.get().lastValue.setValue(this.q.fields.get().fieldValue);
				this.q.fields.get().put();
			}
		}
		else {
			CWin.message(Clarion.newString(ClarionString.staticConcat("Error Trying to Fetch the LevelId=",levelId,"|This LevelId does not exist on the this Level manager.|Error:",CError.error(),"|Errorcode=",CError.errorCode())));
		}
	}
	public void saveBuffer()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.oq.records())<=0;lOCIndex.increment(1)) {
			this.oq.get(lOCIndex);
			this.oq.lastValue.setValue(this.oq.fieldValue);
			this.oq.put();
		}
		this.isSaved.setValue(Constants.TRUE);
	}
	public void restoreBufferOn()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (this.isSaved.equals(Constants.FALSE)) {
			return;
		}
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.oq.records())<=0;lOCIndex.increment(1)) {
			this.oq.get(lOCIndex);
			this.oq.savedValue.setValue(this.oq.fieldValue);
			this.oq.fieldValue.setValue(this.oq.lastValue);
			this.oq.put();
		}
	}
	public void restoreBufferOff()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (this.isSaved.equals(Constants.FALSE)) {
			return;
		}
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.oq.records())<=0;lOCIndex.increment(1)) {
			this.oq.get(lOCIndex);
			this.oq.fieldValue.setValue(this.oq.savedValue);
			this.oq.put();
		}
	}
	public void saveResetBuffer(ClarionNumber levelId)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		this.q.get(levelId);
		if (!(CError.errorCode()!=0)) {
			for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.fields.get().records())<=0;lOCIndex.increment(1)) {
				this.q.fields.get().get(lOCIndex);
				this.q.fields.get().savedValue.setValue(this.q.fields.get().fieldValue);
				this.q.fields.get().fieldValue.setValue(this.q.fields.get().lastValue);
				this.q.fields.get().put();
			}
		}
	}
	public void restoreResetBuffer(ClarionNumber levelId)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		this.q.get(levelId);
		if (!(CError.errorCode()!=0)) {
			for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.fields.get().records())<=0;lOCIndex.increment(1)) {
				this.q.fields.get().get(lOCIndex);
				this.q.fields.get().fieldValue.setValue(this.q.fields.get().savedValue);
				this.q.fields.get().put();
			}
		}
	}
	public ClarionNumber evaluateLevel(ClarionNumber levelId)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(Constants.FALSE);
		this.q.get(levelId);
		if (!(CError.errorCode()!=0)) {
			returnValue.setValue(Constants.TRUE);
			for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.fields.get().records())<=0;lOCIndex.increment(1)) {
				this.q.fields.get().get(lOCIndex);
				if (returnValue.boolValue() && !this.q.fields.get().lastValue.equals(this.q.fields.get().fieldValue)) {
					returnValue.setValue(Constants.TRUE);
				}
				else {
					returnValue.setValue(Constants.FALSE);
					break;
				}
			}
		}
		return returnValue.like();
	}
	public void takeStart(ClarionNumber levelId)
	{
		return;
	}
	public void takeEnd(ClarionNumber levelId)
	{
		return;
	}
	public void updateTotal(ClarionNumber levelId)
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber locOk=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.q.get(levelId);
		if (!(CError.errorCode()!=0)) {
			this.q.records.increment(1);
			for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.totals.get().records())<=0;lOCIndex.increment(1)) {
				this.q.totals.get().get(lOCIndex);
				if (this.q.totals.get().condition.boolValue()) {
					locOk.setValue(CExpression.evaluate(this.q.totals.get().condition.clip().toString()));
					if (CError.errorCode()!=0) {
						CWin.message(Clarion.newString("Error in expresion:|"),Clarion.newString(this.q.totals.get().condition.clip().concat("|Result=",locOk)),"Error in Expresion");
					}
					if (locOk.boolValue()) {
						{
							ClarionNumber case_1=this.q.totals.get().type;
							boolean case_1_break=false;
							if (case_1.equals(Constants.EBREAKTOTALCNT)) {
								this.q.totals.get().target.increment(1);
								case_1_break=true;
							}
							if (!case_1_break && case_1.equals(Constants.EBREAKTOTALAVE)) {
								this.q.totals.get().auxTarget.increment(this.q.totals.get().source);
								this.q.totals.get().target.setValue(this.q.totals.get().auxTarget.divide(this.q.records));
								case_1_break=true;
							}
							if (!case_1_break && case_1.equals(Constants.EBREAKTOTALSUM)) {
								this.q.totals.get().target.increment(this.q.totals.get().source);
								case_1_break=true;
							}
						}
						this.q.totals.get().put();
					}
				}
				else {
					{
						ClarionNumber case_2=this.q.totals.get().type;
						boolean case_2_break=false;
						if (case_2.equals(Constants.EBREAKTOTALCNT)) {
							this.q.totals.get().target.increment(1);
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(Constants.EBREAKTOTALAVE)) {
							this.q.totals.get().auxTarget.increment(this.q.totals.get().source);
							this.q.totals.get().target.setValue(this.q.totals.get().auxTarget.divide(this.q.records));
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(Constants.EBREAKTOTALSUM)) {
							this.q.totals.get().target.increment(this.q.totals.get().source);
							case_2_break=true;
						}
					}
					this.q.totals.get().put();
				}
			}
			this.q.put();
		}
		return;
	}
	public void construct()
	{
		this.q=new Levelsqueue();
		this.oq=new Resetfieldsqueue();
		this.bkId.setValue(0);
	}
	public void destruct()
	{
		ClarionNumber lOCIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		for (lOCIndex.setValue(1);lOCIndex.compareTo(this.q.records())<=0;lOCIndex.increment(1)) {
			this.q.get(lOCIndex);
			this.q.fields.get().free();
			// destroy this.q.fields.get();
			this.q.totals.get().free();
			// destroy this.q.totals.get();
		}
		this.q.free();
		this.oq.free();
		// destroy this.q;
		// destroy this.oq;
	}
}
