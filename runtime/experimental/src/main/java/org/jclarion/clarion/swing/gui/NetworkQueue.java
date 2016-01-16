package org.jclarion.clarion.swing.gui;

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionQueueEvent;
import org.jclarion.clarion.ClarionQueueListener;
import org.jclarion.clarion.ClarionString;

public class NetworkQueue implements ClarionQueueListener,NetworkMetaData
{
	private ClarionQueue queue;
	private boolean modified=true;
	private int colCount=0;
	
	public NetworkQueue(ClarionQueue queue)
	{
		this.queue=queue;
		queue.addListener(this);
		for (int scan=1;scan<=queue.getVariableCount();scan++) {
			ClarionObject o = queue.flatWhat(scan);
			if (o==null) break;
			colCount++;
		}
	}

	@Override
	public void queueModified(ClarionQueueEvent event) 
	{
		modified=true;
	}
	
	public boolean isModified() {
		return modified;
	}

	@Override
	public Object getMetaData() {
		if (!modified) return null;
		
		// encoding is:
		//   1 : colcount
		//   x : current buffer
		//   r : row data
		
		int rec = queue.records();
		
		int size = 1 + colCount*(1+rec);
		Object result[] = new Object[size];
		result[0]=colCount;
		for (int scan=1;scan<=colCount;scan++) {
			result[scan]=queue.flatWhat(scan);
		}
		for (int scan=1;scan<=rec;scan++) {
			ClarionObject co[] = queue.getRecord(scan);
			for (int c=0;c<colCount;c++) {
				Object value=null;
				ClarionObject cvalue = co[c];
				if (cvalue!=null) {
					if (cvalue instanceof ClarionNumber) {
						value=cvalue.intValue();
					} else if (cvalue instanceof ClarionBool) {
						value=cvalue.boolValue();
					} else if (cvalue instanceof ClarionString) {
						value=cvalue.getString().clip().toString();
					} else {
						value=cvalue.toString();
					}
				}
				result[scan*colCount+c+1]=value;
			}
		}
		
		modified=false;
		return result;
	}

	public static ClarionQueue reconstruct(ClarionQueue base,Object[] val)
	{
		if (val==null) return base;
		int colCount=(Integer)val[0];
		if (base==null) {
			base=new ClarionQueue();
			for (int scan=1;scan<=colCount;scan++) {
				base.addVariable("v"+scan,val[scan]);
			}
		}
		
		int records = base.records();
		int new_records = (val.length-1-colCount)/colCount;
		
		for (int rscan=1;rscan<=new_records;rscan++) {
			boolean changed=false;
			if (rscan<=records) {
				base.get(rscan);
			} else {
				changed=true;
			}
			for (int c=1;c<=colCount;c++) {
				Object o = val[rscan*colCount+c];
				if (!changed) {
					if (!base.flatWhat(c).equals(o)) {
						changed=true;
					}
				}
				if (changed) {
					base.flatWhat(c).setValue(o);
				}
			}
			if (changed) {
				if (rscan<=records) {
					base.put();
				} else {
					base.add();
				}
			}
		}
		
		for (int scan=records;scan>new_records;scan--) {
			base.get(scan);
			base.delete();
		}
		return base;
	}
	
	public void dispose()
	{
		queue.removeListener(this);
	}
}
