/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jclarion.clarion.ClarionQueueEvent.EventType;

public class TreeClarionQueue implements ClarionQueueReader, ClarionQueueListener 
{
    private ArrayList<Integer> view=new ArrayList<Integer>();
    private ArrayList<Integer> rview=new ArrayList<Integer>();
    private boolean stale=true;
    
    private ClarionQueueReader base;
    private int depthColumn;
    
    public TreeClarionQueue(ClarionQueueReader base,int depthColumn)
    {
        this.base=base;
        this.depthColumn=depthColumn;
        
        base.addListener(this);
    }
    
    private List<WeakReference<ClarionQueueListener>> listeners = new 
    ArrayList<WeakReference<ClarionQueueListener>>();

    public void addListener(ClarionQueueListener cmcl)
    {
        synchronized(listeners) {
            listeners.add(new WeakReference<ClarionQueueListener>(cmcl));
        }
    }

    public void removeListener(ClarionQueueListener cmcl)
    {
        synchronized(listeners) {
            Iterator<WeakReference<ClarionQueueListener>> scan;
            scan = listeners.iterator();
            while (scan.hasNext()) {
                WeakReference<ClarionQueueListener> val = scan.next();
                ClarionQueueListener sval = val.get();
                if (sval==cmcl || sval==null) {
                    scan.remove();
                }
            }
        }   
    }

    
    @Override
    public ClarionObject[] getRecord(int pos) {
        synchronized(this) {
            refresh();
            if (pos<1 || pos>view.size()) return null;
            return base.getRecord(view.get(pos-1));
        }
    }

    @Override
    public boolean[] getSiblingTree(int row, int pos) {
        synchronized(this) {
            refresh();
            if (row<1 || row>view.size()) return null;
            return base.getSiblingTree(view.get(row-1),pos);
        }
    }

    @Override
    public boolean hasChildren(int row, int pos) {
        synchronized(this) {
            refresh();
            if (row<1 || row>view.size()) return false;
            return base.hasChildren(view.get(row-1),pos);
        }
    }

    @Override
    public int records() {
        synchronized(this) {
            refresh();
            return view.size();
        }
    }

    @Override
    public void toggle(int record, int column) {
        synchronized(this) {
            refresh();
            base.toggle(view.get(record-1),column);
        }
    }
    
	@Override
	public int getQueueColumn(int col) {
		return col;
	}

	@Override
	public int getQueueRow(int row) {
        synchronized(this) {
            refresh();
            return view.get(row-1);
        }
	}

	@Override
    public ClarionObject getValueAt(int row, int column) {
        synchronized(this) {
            refresh();
            if (row<1 || row>view.size()) return null;
            return base.getValueAt(view.get(row-1),column);
        }
    }
    
    private Object refreshObject=new Object();
    
    private void refresh()
    {
        synchronized(refreshObject) {
            if (stale) {
                view.clear();
                synchronized(base) {
                    int hidden=0;
                    for (int scan=1;scan<=base.records();scan++) {
                        int depth = base.getValueAt(scan,depthColumn).intValue();
                        int aDepth = Math.abs(depth);
                        if (hidden>0) {
                            if (aDepth>hidden) continue;
                            hidden=0;
                        }
                        if (depth<0) {
                            hidden=aDepth;
                        }
                        view.add(scan);
                    }
                }
                
                /*
                 * View indexes from list view back to model view. i.e.
                 * 
                 * list 0 : queue 0
                 * list 1 : queue 5
                 * list 2 : queue 6
                 *
                 * We want to reverse thus:
                 * 
                 * queue 0 : list 0
                 * queue 1 : list 0 (-)
                 * queue 2 : list 0 (-)
                 * queue 3 : list 0 (-)
                 * queue 4 : list 0 (-)
                 * queue 5 : list 1 
                 * queue 6 : list 2 
                 * 
                 */
                rview.clear();
                for (int list_pos=0;list_pos<view.size();list_pos++) {
                    int queue_pos = view.get(list_pos)-1;
                    rview.add(list_pos);
                    while (rview.size()<=queue_pos) {
                        rview.add(list_pos>0?-list_pos:0);
                    }
                }
                
                stale=false;
            }
        }
    }
    
    private void notifyChange(ClarionQueueEvent event) {
        
        List<ClarionQueueListener> notify = new ArrayList<ClarionQueueListener>();
    
        synchronized(listeners) {
            Iterator<WeakReference<ClarionQueueListener>> scan;
            scan = listeners.iterator();
            while (scan.hasNext()) {
                WeakReference<ClarionQueueListener> val = scan.next();
                ClarionQueueListener sval = val.get();
                if (sval==null) {
                    scan.remove();
                } else {
                    notify.add(sval);
                }
            }
        }
    
        for ( ClarionQueueListener scan : notify ) {
            scan.queueModified(event);
        }
    }

    @Override
    public void queueModified(ClarionQueueEvent event) {
        synchronized(refreshObject) {
            stale=true;
        }
    	if (event.event==EventType.TOGGLE) {
    		notifyChange(event);
    	} else {
    		notifyChange(new ClarionQueueEvent(this,EventType.SORT,0));
    	}
    }

    @Override
    public int convertQueueIndexToScreenIndex(int v) {
        synchronized(this) {
            refresh();
            if (v>rview.size()) return v;
            return Math.abs(rview.get(v));
        }
    }

    @Override
    public int convertScreenIndexToQueueIndex(int v) {
        synchronized(this) {
            refresh();
            if (v<0 || v>=rview.size()) return v;
            return view.get(v)-1;
        }
    }
}
