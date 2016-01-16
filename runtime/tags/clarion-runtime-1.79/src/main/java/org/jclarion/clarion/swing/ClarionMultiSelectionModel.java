package org.jclarion.clarion.swing;

import java.util.ArrayList;
import java.util.List;

import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueueEvent;
import org.jclarion.clarion.ClarionQueueListener;
import org.jclarion.clarion.control.ListControl;

public class ClarionMultiSelectionModel implements ListSelectionModel, Runnable, ClarionQueueListener
{
	private static final long serialVersionUID = 6792446988355281475L;
	private static final ClarionBool SET=new ClarionBool(true);
	private static final ClarionBool CLEAR=new ClarionBool(false);

	private List<ListSelectionListener> listeners=new ArrayList<ListSelectionListener>();
	private QueueTableModel model;
	private int mark;
	private int anchor=0;
	private int lead;
	private boolean adjusting; 
	
	public ClarionMultiSelectionModel(QueueTableModel mod,int mark) {
		this.model=mod;
		this.mark=mark;
		model.getQueue().addListener(this);
	}
	
	@Override
	public void addListSelectionListener(ListSelectionListener x) {
		listeners.add(x);
	}

	@Override
	public void addSelectionInterval(int start,int end) 
	{
		boolean changed=false;
		try {
			model.setIgnoreModificationEvents(true);
			for (int scan=start;scan<=end;scan++) {
				ClarionObject o = model.getQueue().getValueAt(scan+1,mark);
				if (o!=null && !o.boolValue()) {
					model.setValueAt(scan+1,mark,SET);
					changed=true;
				}
			}
			model.notifyChanges();
		} finally {
			model.setIgnoreModificationEvents(false);
		}
		anchor=start;
		lead=end;
		
		if (changed) fireEvent(start,end,false);
	}

	@Override
	public void clearSelection() 
	{
		if (model.isApplying()) return; 
		removeSelectionInterval(0,model.getRowCount()-1);
	}

	@Override
	public int getAnchorSelectionIndex() {
		return anchor;
	}

	@Override
	public int getLeadSelectionIndex() {
		return lead;
	}

	@Override
	public int getMaxSelectionIndex() {
		int scan=model.getQueue().records();
		while (scan>0) {
			ClarionObject o = model.getQueue().getValueAt(scan,mark);
			scan--;
			if (o!=null && o.boolValue()) return scan;
		}
		return -1;
	}

	@Override
	public int getMinSelectionIndex() {
		int max=model.getQueue().records();
		int scan=1;
		while (scan<=max) {
			ClarionObject o = model.getQueue().getValueAt(scan,mark);
			if (o!=null && o.boolValue()) return scan-1;
			scan++;
		}
		return -1;
	}

	@Override
	public int getSelectionMode() {
		return ListSelectionModel.MULTIPLE_INTERVAL_SELECTION;
	}

	@Override
	public boolean getValueIsAdjusting() {
		return adjusting;
	}

	@Override
	public void insertIndexInterval(int index, int length, boolean before) 
	{
	}

	@Override
	public boolean isSelectedIndex(int index) 
	{
		ClarionObject o = model.getQueue().getValueAt(index+1,mark);
		if (o==null) return false;
		return o.boolValue();
	}

	@Override
	public boolean isSelectionEmpty() {
		return getMaxSelectionIndex()==-1;
	}

	@Override
	public void removeIndexInterval(int start,int end) 
	{
	}

	@Override
	public void removeListSelectionListener(ListSelectionListener x) {
		listeners.remove(x);
	}

	@Override
	public void removeSelectionInterval(int start,int end) {
		try {
			model.setIgnoreModificationEvents(true);
			for (int scan = start; scan <= end; scan++) {
				ClarionObject o = model.getQueue().getValueAt(scan + 1, mark);
				if (o != null && o.boolValue())
					model.setValueAt(scan + 1, mark,CLEAR);
			}
			model.notifyChanges();
		} finally {
			model.setIgnoreModificationEvents(false);
		}
		anchor=start;
		lead=end;
		
		fireEvent(start,end,false);
	}

	@Override
	public void setAnchorSelectionIndex(int index) {
		anchor=index;
	}

	@Override
	public void setLeadSelectionIndex(int index) {
		lead=index;
	}

	@Override
	public void setSelectionInterval(int start, int end) {
		
		int f_start=start;
		int f_end=end;
		boolean changed=false;
		
		try {
			model.setIgnoreModificationEvents(true);
			for (int scan=model.getRowCount();scan>=1;scan--) {
				ClarionObject o = model.getQueue().getValueAt(scan,mark);
				if (o==null) continue;
				ClarionBool set=null;
				if (scan<start+1 || scan>end+1) {
					if (o.boolValue()) set=CLEAR; 
				} else {
					if (!o.boolValue()) set=SET; 
				}
				if (set!=null) {
					model.setValueAt(scan,mark,set);
					changed=true;
					if (scan-1<f_start) f_start=scan-1;
					if (scan-1>f_end) f_end=scan-1;
				}
			}
			model.notifyChanges();
		} finally {
			model.setIgnoreModificationEvents(false);
		}
		anchor=start;
		lead=end;
		
		if (changed) fireEvent(f_start,f_end,false);
	}

	@Override
	public void setSelectionMode(int selectionMode) {
	}

	@Override
	public void setValueIsAdjusting(boolean valueIsAdjusting) {
		adjusting=valueIsAdjusting;
	}

	private void fireEvent(int start,int end,boolean adjusting)
	{
		for (ListSelectionListener lsl : listeners ) {
			if (lsl.getClass().getEnclosingClass()==ListControl.class) {
				lsl.valueChanged(new ListSelectionEvent(this,start,end,adjusting));
			} else {
				lsl.valueChanged(new ListSelectionEvent(this,start,end,false));
			}
		}
	}

	@Override
	public void run() {
		fireEvent(0,model.getRowCount(),true);
	}

	@Override
	public void queueModified(ClarionQueueEvent event) {
        model.getControl().getWindowOwner().addAcceptTask(this,this);
	}	
}
