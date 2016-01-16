package org.jclarion.clarion.swing.gui;

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionQueueEvent;
import org.jclarion.clarion.ClarionQueueListener;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractListControl;
import org.jclarion.clarion.control.ListColumn;

public class NetworkQueue implements ClarionQueueListener,NetworkMetaData
{
	private ClarionQueue queue;
	private boolean modified=true;
	private int colCount=0;
	private AbstractListControl list;
	
	public NetworkQueue(ClarionQueue queue,AbstractListControl lc)
	{
		this.list=lc;
		this.queue=queue;
		queue.addListener(this);
		calcCol();
	}

	public void checkFormatChange()
	{
		int xc = colCount;
		calcCol();
		if (xc!=colCount) {
			modified=true;
		}
	}
	
	private void calcCol()
	{
		ListColumn lc[] = list!=null ? ListColumn.construct(list.getProperty(Prop.FORMAT).toString()) : null;
		if (lc!=null && lc.length>0) {
			ListColumn last = lc[lc.length-1];
			colCount = last.getFieldNumber();
			if (last.isColor()) colCount+=4;
			if (last.isTree()) colCount+=1;
			if (last.isStyle()) colCount+=1;
			if (last.isIcon() || last.isTransparantIcon()) colCount+=1;
		} else {
			for (int scan=1;scan<=queue.getVariableCount();scan++) {
				ClarionObject o = queue.flatWhat(scan);
				if (o==null) break;
				colCount++;
			}
		}
		if (list!=null) {
			ClarionObject mark = list.getRawProperty(Prop.MARK);
			if (mark!=null) {
				int pos = mark.intValue();
				if (pos>colCount) colCount=pos;
			}
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
		}
		
		boolean resize=false;
		
		for (int scan=base.getVariableCount()+1;scan<=colCount;scan++) {
			base.addVariable("v"+scan,val[scan]);
			resize=true;
		}
		
		if (resize) {
			base.free();			
		}
		
		int records = base.records();
		int new_records = (val.length-1-colCount)/colCount;
		
		for (int rscan=1;rscan<=new_records;rscan++) {
			boolean changed=resize;
			if (rscan<=records) {
				base.get(rscan);
			} else {
				changed=true;
			}
			for (int c=1;c<=colCount;c++) {
				Object o = val[rscan*colCount+c];
				ClarionObject co = base.flatWhat(c);
				//if (co==null) continue;
				if (!changed) {
					if (!co.equals(o)) {
						changed=true;
					}
				}
				if (changed) {
					co.setValue(o);
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
