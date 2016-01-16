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
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.Iterator;

import org.jclarion.clarion.memory.CMem;
import org.jclarion.clarion.runtime.CErrorImpl;
import org.jclarion.clarion.runtime.SimpleStringDecoder;
import org.jclarion.clarion.runtime.ref.RefVariable;
import org.jclarion.clarion.ClarionQueueEvent.EventType;
import org.jclarion.clarion.constants.*;

/**
 * Model a queue
 * 
 *  A queue is like an Array collection in Java. Queues have following properties
 *  
 *  public fields define what is actually being stored on the queue. Works sortof
 *  like files in Clarion in that there current record which may not represent what
 *  is actually stored, and what is currently stored.
 *  
 *  Queues have what is known as sort orders. Records are sorted and you can
 *  quickly retrieve values on pre-gen sort orders.
 *  
 *  The active sort order defines the default ordering of records in a queue. 
 *  i.e. record #1, record #2, record #3 retrievals may indicate a specific ordering
 *
 *  One thing I am not clear on with respect to how clarion queues work is
 *  the fact that a queue is either list or sorted - how clarion intermixes
 *  commands of a list nature vs a sort nature. Will assume that lists are
 *  allowed to fall into disorder in event of any operation that changes
 *  ordering of elements in active sort order
 *  
 * 
 * @author barney
 *
 */
public class ClarionQueue extends ClarionGroup implements ClarionQueueReader
{
    /**
     * Helper to construct an order object
     *  
     * @return
     */
    public DefaultOrder ORDER() {
        return new DefaultOrder(this);
    }
    
    protected static class QueueEntry implements Comparable<QueueEntry>
    {
        private Object value;
        
        public QueueEntry() { }
        
        public void copyFromGroup(GroupEntry base) 
        {
            value=base.value;
            
            if (value!=null) {
                if (value instanceof ClarionCloneable) {
                    value=((ClarionCloneable)value).clarionClone();
                    return;
                }
            }
        }

        public void copyToGroup(GroupEntry base) 
        {
            if (base.value!=null) {
                if (base.value.getClass()!=value.getClass()) {
                    CMem sos = CMem.create();
                    ((ClarionMemoryModel)value).serialize(sos);
                    ((ClarionMemoryModel)base.value).deserialize(sos);
                    return;
                }
                
                if (base.value instanceof ClarionAny) {
                    ((ClarionAny)base.value).setReferenceValue((ClarionAny)value);
                    return;
                }
                
                if (base.value instanceof ClarionCloneable) {
                    ((ClarionCloneable)base.value).setValue(value);
                    return;
                }
            }
        }
        
        @SuppressWarnings("unchecked")
        @Override
        public int compareTo(QueueEntry qe) {

        	Object v=value;
        	Object v2=qe.value;
        
        	if (v!=null && v instanceof RefVariable<?>) {
        		v=((RefVariable<?>)v).get();
        	}
        	if (v2!=null && v2 instanceof RefVariable<?>) {
        		v2=((RefVariable<?>)v2).get();
        	}

            if (v==null && v2==null) {
                return 0;
            }
            if (v==null) return -1;
            if (v2==null) return 1;
            
            if (v instanceof ClarionObject) {
                return ((ClarionObject) v).compareTo(v2);
            }

            if (v instanceof Comparable) {
                return ((Comparable<Object>) v).compareTo(v2);
            }
            
            return v.toString().compareTo(v2.toString());
        }
    }

    /**
     * Model parameter ordering
     * 
     * @author barney
     *
     */
    public static abstract class Order implements Comparator<Record>
    {
        public abstract boolean equalsPartial(Object o);        
        public abstract int getFieldCount();
        public abstract void clear(Record r,int pos);
    }
    
    public static abstract class FunctionOrder extends Order
    {
    	public FunctionOrder()
    	{
    	}

		@Override
		public boolean equalsPartial(Object o) {
			return equals(o);
		}

		@Override
		public int compare(Record o1, Record o2) {
			return compare(toGroup(o1),toGroup(o2));
		}

		public ClarionGroup toGroup(Record o)
		{
			ClarionGroup g=  new ClarionGroup();
			int count=0;
			for (QueueEntry e : o.fields ) {
				count++;
				g.addVariable("f"+count,e.value);
			}
			return g;
		}
		
		public abstract int compare(ClarionGroup cg1,ClarionGroup cg2);
    }
    

    
    
    public static class DefaultOrder extends Order
    {
        private ArrayList<Integer> order=new ArrayList<Integer>();
        private ClarionQueue base;
        
        public DefaultOrder(ClarionQueue base)
        {
            this.base=base;
        }
        
        public DefaultOrder(ClarionQueue base,String s) {
            this.base=base;
            s=s.trim();
            SimpleStringDecoder decoder=new SimpleStringDecoder(s);
            while ( !decoder.end() ) {
                int dir=1;
                if (decoder.pop('+')) {
                    dir=1;
                } else if (decoder.pop('-')) {
                    dir=-1;
                }
                
                String field = decoder.popString(',');
                if (field.length()>0) {
                    int pos =0;
                    pos = field.indexOf(":");
                    if (pos==-1) {
                        pos = field.indexOf(".");
                    }
                    
                    int p =base.getGroupParamPosition(field.substring(pos+1));
                    if (p==0) throw new IllegalStateException("Unknown sort field:"+field);
                    order.add(p*dir);
                }
                decoder.pop(',');
            }
            
        }

        public DefaultOrder ascend(ClarionObject object)
        {
            if (object==null) throw new RuntimeException("Looking for null");
            int r = base.flatWhere(object);
            if (r==0) {
                throw new RuntimeException("Sort field indeterminite");
            }
            order.add(r);
            return this;
        }

        public DefaultOrder descend(ClarionObject object)
        {
            int r = base.flatWhere(object);
            if (r==0) {
                throw new RuntimeException("Sort field indeterminite");
            }
            order.add(-r);
            return this;
        }

        private int cacheHash=-1;
        
        public int hashCode() {
            if (cacheHash==-1) {
                cacheHash=order.hashCode();
            }
            return cacheHash; 
        }
        
        public boolean equalsPartial(Object o) {
        	if (!(o instanceof DefaultOrder)) return false;
            DefaultOrder oo = (DefaultOrder)o;
            
            if (order.size()>oo.order.size()) return false;
            
            for (int scan=0;scan<order.size();scan++) {
                if (order.get(scan).intValue()!=oo.order.get(scan).intValue()) return false;
            }
            return true;
        }
        
        public boolean equals(Object o) {
        	if (!(o instanceof DefaultOrder)) return false;
            return order.equals(((DefaultOrder)o).order);
        }

        @Override
        public int compare(Record o1, Record o2) {
            
            for ( Integer scan : order ) {

                int pos=scan;
                int diff=0;
                if (pos>0) {
                    diff=o1.fields[pos-1].compareTo(o2.fields[pos-1]);
                } else {
                    diff=o2.fields[(-pos)-1].compareTo(o1.fields[(-pos)-1]);
                }
                
                if (diff!=0) return diff;
            }
            
            if (o1.id==-1 || o2.id==-1) return 0;
            return o1.id-o2.id;
        }

		@Override
		public void clear(Record r, int pos) {			
			if (pos>=order.size()) return;
			int i = order.get(pos);
			int cv=-1;
			if (i<0) {
				i=-i;
				cv=1;
			}
			Object o = r.fields[i-1].value;
			if (o!=null && o instanceof ClarionCloneable) {
				((ClarionCloneable)o).clear(cv);
			}
		}

		@Override
		public int getFieldCount() {
			return order.size();
		}
    }
    
    public static class SpecialRecord extends Record
    {
        public Object anchor;
    }
    
    public static class Record
    {
        public int id;
        public QueueEntry[] fields;
        
        public int pos=-1;
        public int posCalculated;

        @Override
        public int hashCode() {
            return id;
        }
        
        @Override
        public boolean equals(Object o) {
            return ((Record)o).id==id;
        }
    }

    private static class QueueData
    {
        private int                         lastMutate=0;
        private List<Record>                indexedSort=null;
        private TreeSet<Record>             activeSort=null;
        private Map<Order,TreeSet<Record>>  sorts=null;
        private Record                      current;
        private int                         currentPos;
        private int                         lastID;
        private Object                      anchor;
    }
    
    private QueueData data;
    
    public ClarionQueue()
    {
        data=new QueueData();
    }
    
    private List<Record> getList()
    {
        if (data.activeSort!=null && data.indexedSort==null) {
            data.indexedSort=new ArrayList<Record>(data.activeSort);
        }
        if (data.indexedSort==null) {
            data.indexedSort=new ArrayList<Record>();
        }
        return data.indexedSort;
    }
    
    private GroupEntry groupEntryCache[];
    private void initCache()
    {
        if (groupEntryCache==null) {
            groupEntryCache=new GroupEntry[map.size()];
            map.values().toArray(groupEntryCache);
        }
    }
    
    private Record createRecord()
    {
        return createRecord(++data.lastID);
    }
    
    public void setNextAnchor(Object anchor)
    {
        this.data.anchor=anchor;
    }
    
    private Record createRecord(int id)
    {
        initCache();
        Record r;
        if (data.anchor!=null) {
            SpecialRecord sr = new SpecialRecord();
            sr.anchor=this.data.anchor;
            this.data.anchor=null;
            r=sr;
        } else {
            r = new Record();
            
        }
        r.id=id;
        r.fields=new QueueEntry[groupEntryCache.length];
        for (int scan=0;scan<r.fields.length;scan++) {
            r.fields[scan]=new QueueEntry();
            r.fields[scan].copyFromGroup(groupEntryCache[scan]);
        }
        return r;
    }

    private void storeRecord(Record r) {
        initCache();
        for (int scan=0;scan<r.fields.length;scan++) {
            r.fields[scan].copyFromGroup(groupEntryCache[scan]);
        }
    }
    
    private void restoreRecord(Record r)
    {
        initCache();
        for (int scan=0;scan<r.fields.length;scan++) {
            r.fields[scan].copyToGroup(groupEntryCache[scan]);
        }
    }
    
    private int getPosition(Record r)
    {
        if (r.pos==-1 || r.posCalculated!=data.lastMutate) {
            int pos=1;
            for ( Record scan : getList() ) {
                scan.pos=pos++;
                scan.posCalculated=data.lastMutate;
            }
        }
        return r.pos;
    }
    
    /**
     * Add new record into queue at end of the queue
     */
    public void add()
    {
        CErrorImpl.getInstance().clearError();
        synchronized(data) { 
            data.current = createRecord();
            getList().add(data.current);
            data.currentPos=data.indexedSort.size();
            if (data.sorts!=null) {
                for (TreeSet<Record> s : data.sorts.values()) {
                    s.add(data.current);
                }
            }
            data.lastMutate++;
        }
        CErrorImpl.getInstance().clearError();
        
        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.ADD,data.currentPos));
    }

    /**
     *  Add record into queue - at specified position
     * @param order
     */
    public void add(ClarionNumber position)
    {
        add(position.intValue());
    }
    
    public void add(int position)
    {
        if (position<1) position=1;
        synchronized(data) { 
            data.current = createRecord();
            if (position-1<=getList().size()) {
                getList().add(position-1,data.current);
                data.currentPos=position;
            } else {
                getList().add(data.current);
                data.currentPos=getList().size();
            }
            if (data.sorts!=null) {
                for (TreeSet<Record> s : data.sorts.values()) {
                    s.add(data.current);
                }
            }
            data.lastMutate++;
            CErrorImpl.getInstance().clearError();
        }
        
        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.ADD,data.currentPos));
    }

    public void add(ClarionObject order)
    {
        if (order instanceof ClarionString) {
            add(order.toString());
        } else {
            add(order.getNumber());
        }
    }

    public void get(ClarionObject order)
    {
        if (order instanceof ClarionString) {
            get(order.getString());
        } else {
            get(order.intValue());
        }
    }
    
    /**
     *  Add new record into queue, at the specified position.
     *  If record already exists at a given position push it 'down'
     *  
     *  If position indicated is invalid, then insert at end
     *  
     * @param order
     */
    public void add(ClarionString order)
    {
        add(order.toString());
    }

    /**
     * Add record into sorted list at specified list location.
     * 
     * String is comma separated with leading '+' or '-' to indicate
     * either ascending or descending order
     * 
     * @param order
     */
    public void add(String order)
    {
        add(new DefaultOrder(this,order));
    }
    
    private TreeSet<Record> getSortOrder(Order order)
    {
        TreeSet<Record> s;
        if (this.data.sorts==null) {
            this.data.sorts=new HashMap<Order, TreeSet<Record>>();
        }
        s=data.sorts.get(order);
        
        if (s==null) {
            for (Map.Entry<Order,TreeSet<Record>> entry : this.data.sorts.entrySet()) {
                if (order.equalsPartial(entry.getKey())) {
                    s=entry.getValue();
                    break;
                }
            }
        }
        
        if (s==null) {
            s=new TreeSet<Record>(order);
            if (data.activeSort!=null) {
                s.addAll(data.activeSort);
            } else if (this.data.indexedSort!=null) {
                s.addAll(data.indexedSort);
            }
            data.sorts.put(order,s);
        }

        return s;
    }

    private void changeActiveSortOrder(Order order)
    {
        TreeSet<Record> s=getSortOrder(order);

        if (this.data.activeSort!=s) {
            data.indexedSort=null;
            this.data.activeSort=s;
            data.lastMutate++;
        } else {
            data.indexedSort=null;
        }
    }

    /**
     * Add record into sorted list at specified list location.
     *
     */
    public void add(Order order)
    {
        synchronized(data) {
            changeActiveSortOrder(order);
            this.data.indexedSort=null;
        
            data.current = createRecord();
            data.currentPos=-1;
            for (TreeSet<Record> s : data.sorts.values()) {
                s.add(data.current);
            }
        }
        CErrorImpl.getInstance().clearError();

        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.ADD,data.currentPos));
    }
    
    /**
     * Put record back into queue in last position as specified by
     * prior get(int) or add().
     * 
     * If last get or add operation was sort based - then put does not 
     * bother trying to insert in specific position
     * 
     * If there are sort orders - reinsert record back into sort, taking
     * into consideration possible change of sort location
     */
    public void put()
    {
        put(true);
    }
    
    public void put(boolean keepIndexedSort)
    {
        if (data.current==null) {
            return;
        }

        synchronized(data) {
            if (data.sorts!=null) {
                // check if record differs significantly enough from any
                // sorting system to merit re-organisation
                boolean disorder=false;
            
                Record r = createRecord(data.current.id);
                for ( TreeSet<Record> sort : data.sorts.values() ) {
                
                    if (sort.contains(r)) continue;
                    SortedSet<Record> ss;
                    ss = sort.headSet(data.current);
                    if (!ss.isEmpty()) {
                        Record prior = ss.last();
                        if (sort.comparator().compare(prior,r)>0) {
                            disorder=true;
                            break;
                        }
                    }
                    ss = sort.tailSet(data.current);
                    Iterator<Record> tscan=ss.iterator();
                    tscan.next();
                    if (tscan.hasNext()) {
                        Record next = tscan.next();
                        if (sort.comparator().compare(next,r)<0) {
                            disorder=true;
                            break;
                        }                      
                    }
                }
            
                if (disorder) {
                    data.lastMutate++;
                    for ( TreeSet<Record> sort : data.sorts.values() ) {
                        sort.remove(data.current);
                    }   
                    storeRecord(data.current);
                    for ( TreeSet<Record> sort : data.sorts.values() ) {
                        sort.add(data.current);
                    }
                    if (!keepIndexedSort) {
                        data.indexedSort=null;
                        data.currentPos=-1;
                    }
                } else {
                    storeRecord(data.current);
                }
            } else {
                storeRecord(data.current);
            }
        }
        
        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.PUT,data.currentPos));
    }

    /**
     * Put record back into queue - using specified sort order
     */
    public void put(Order order)
    {
        changeActiveSortOrder(order);
        put(false);
    }
    
    /**
     * Delete last retrieved record
     */
    public void delete()
    {
        synchronized(data) {
            if (data.current==null) {
                CErrorImpl.getInstance().setError(Constants.NOENTRYERR, "Cannot Delete - no record");
                return;
            }

            if (data.sorts!=null) {
                for ( TreeSet<Record> sort : data.sorts.values() ) {
                    sort.remove(data.current);
                }
            }
        
            if (data.indexedSort!=null) {
                if (data.currentPos>0) {
                    data.indexedSort.remove(data.currentPos-1);
                } else {
                    data.indexedSort.remove(data.current);
                }
            }
            data.current=null;
            data.lastMutate++;
        }
        
        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.DELETE,data.currentPos));
    }
    
    /**
     * Remove all records
     */
    public void free()
    {
        synchronized(data) {
            this.data.activeSort=null;
            this.data.current=null;
            this.data.currentPos=-1;
            this.data.indexedSort=null;
            this.data.lastID=0;
            this.data.sorts=null;
            this.data.lastMutate++;
        }
        
        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.FREE,data.currentPos));
    }

    /**
     * Set active sort order to the specified order
     * 
     * @param order
     */
    public void sort(Order order)
    {
        synchronized(data) {
            changeActiveSortOrder(order);
        }

        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.SORT,data.currentPos));
    }

    public void sort(ClarionString order)
    {
        synchronized(data) {
            changeActiveSortOrder(new DefaultOrder(this,order.toString()));
        }

        notifyChange(new ClarionQueueEvent(this,
                ClarionQueueEvent.EventType.SORT,data.currentPos));
    }
    
    /**
     * Return number of records in the queue
     * 
     * @return
     */
    public int records()
    {
        synchronized(data) {
            if (this.data.indexedSort!=null) {
                return this.data.indexedSort.size();
            } 
            if (this.data.activeSort!=null) {
                return this.data.activeSort.size();
            }
        }
        
        return 0;
    }

    @Override
    public ClarionObject getValueAt(int row, int column) {
        synchronized(data) {
            if (row<=0 || row>records()) return null;
            Record r = getList().get(row-1);
            if (r==null) return null;
            return (ClarionObject)r.fields[column-1].value;
        }
    }

    
    public ClarionObject[] getRecord(int pos)
    {
        synchronized(data) {
            if (pos<=0 || pos>records()) return null;
            Record r = getList().get(pos-1);
            if (r==null) return null;
            ClarionObject result[]=new ClarionObject[r.fields.length];
        
            for (int scan=0;scan<result.length;scan++) {
                result[scan]=Clarion.getClarionObject(r.fields[scan].value);
            }
            return result;
        }
        
    }

    /**
     * Get specified record
     */
    public void get(int pos)
    {
        synchronized(data) {
            if (pos<=0 || pos>records()) {
                CErrorImpl.getInstance().setError(Constants.NOENTRYERR,"Position out of range");
                return;
            }
        
            Record r = getList().get(pos-1);
            if (r==null) {
                CErrorImpl.getInstance().setError(Constants.NOENTRYERR,"Record not found");
                return;
            }
            restoreRecord(r);
            data.current=r;
            data.currentPos=pos;
        }
        CErrorImpl.getInstance().clearError();
    }
    
    /**
     * Get specified record
     */
    public void get(ClarionNumber pos)
    {
        get(pos.intValue());
    }

    /**
     * Get first matching specified record based on order setting
     * If no record is found - call to position() will yield pointer to
     * where record should of been found had there been one 
     */
    public void get(ClarionString order)
    {
        get(new DefaultOrder(this,order.toString()));
    }

    public void get(Order order)
    {
        synchronized(data) {
            TreeSet<Record> s=getSortOrder(order);
        
            Order base = (Order)s.comparator();
            
            Record scan = createRecord(0);

            for (int c=order.getFieldCount();c<base.getFieldCount();c++) {
            	base.clear(scan,c);
            }
        
            SortedSet<Record> tail = s.tailSet(scan);
            if (s==data.activeSort) {
                data.currentPos=records()+1-tail.size();
            } else {
                data.currentPos=-1;
            }
        
            data.current=null;
            if (tail.isEmpty()) {
                data.currentPos=records()+1;
                CErrorImpl.getInstance().setError(30,"Record not found");
                return;
            }
        
            Record candidate = tail.first();
            scan.id=-1;
            
            if (order.compare(candidate,scan)==0) {
                CErrorImpl.getInstance().setError(0,"Record Found");
                data.current=candidate;
                restoreRecord(data.current);
            } else {
                CErrorImpl.getInstance().setError(30,"Record not found");
            }
        }
    }

    /**
     * Not entirely sure what this does... Clarion documentation is very
     * confusing
     * 
     * Returns position in active sort order based on all fields. If no exact
     * match then return next position.
     * 
     * I am choosing to interprete this as thus:
     *  + if there is no active sort order (unsorted) then return getPointer()
     *  + if there is active sort order then return equivalent of get(order);getPointer()
     *    but do not explicitly call those -i.e. do not mess with buffer  
     * 
     * @return
     */
    public int getPosition()
    {
        synchronized(data) {
            if (this.data.activeSort==null) return getPointer();
        
            Record scan = createRecord(0);
            SortedSet<Record> tail = data.activeSort.tailSet(scan);
            return records()+1-tail.size();
        }
    }
    
    /**
     * Return current position from 1 to n for last GET, ADD or PUT operation
     * 
     * @return
     */
    public int getPointer()
    {
        synchronized(data) {
            if (data.currentPos==-1 && data.current!=null) {
                data.currentPos=getPosition(data.current);
            }
            return data.currentPos;
        }
    }

    
    public int getSortCount() {
        if (data.sorts==null) return 0;
        return data.sorts.size();
    }
    
    private List<WeakReference<ClarionQueueListener>> listeners = new 
        ArrayList<WeakReference<ClarionQueueListener>>();
    
    /**
     * Listen for changes to the objects representation. Note that listener
     * is weakly referenced. You need to maintain a strong reference to the
     * listener object in order for it not to be garbage collected 
     * 
     * @param cmcl
     */
    public void addListener(ClarionQueueListener cmcl)
    {
        synchronized(listeners) {
            listeners.add(new WeakReference<ClarionQueueListener>(cmcl));
        }
    }

    /**
     * Stop Listening for changes to the objects representation
     * 
     * @param cmcl
     */
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

    public String debugString()
    {
        StringBuilder out=new StringBuilder();

        Iterable<Record> recs=null;
        if (data.indexedSort!=null) {
            recs =data.indexedSort;
        } else {
            recs =data.activeSort; 
        }
        if (recs==null) return "";
        
        for (Record r : recs) {
            QueueEntry qe[] = r.fields;
            for (int scan=0;scan<qe.length;scan++) {
                if (scan>0) out.append(',');
                out.append(qe[scan].value);
                if (qe[scan].value instanceof ClarionObject) {
                    ClarionObject o= (ClarionObject)qe[scan].value;
                    o=o.getValue();
                    out.append("(");
                    out.append("N:"+o.getName());
                    out.append(" G:"+o.getOwner());
                    out.append(")");
                }
            }
            out.append('\n');
        }
        
        return out.toString();
    }
    
    private int getDepth(int row,int pos)
    {
        Record r = getList().get(row-1);
        return Math.abs((((ClarionObject)r.fields[pos-1].value).intValue()));
    }

    @Override
    public void toggle(int row, int column) {
        synchronized(data) {
            if (row<=0 || row>records()-1) return;
            Record r = getList().get(row-1);
            
            ((ClarionObject)r.fields[column-1].value).setValue(
                    ((ClarionObject)r.fields[column-1].value).negate());
        }
        
        notifyChange(new ClarionQueueEvent(this,EventType.PUT,row));
    }
    
    @Override
    public void setValueAt(int row, int column,ClarionObject value) {
        synchronized(data) {
            if (row<=0 || row>records()-1) return;
            Record r = getList().get(row-1);
            ((ClarionObject)r.fields[column-1].value).setValue(value);
        }
        
        notifyChange(new ClarionQueueEvent(this,EventType.PUT,row));
    }
    
    public boolean hasChildren(int row,int pos)
    {
        synchronized(data) {
            if (row<=0 || row>records()-1) return false;
            return getDepth(row,pos)<getDepth(row+1,pos);
        }
    }
    
    public boolean[] getSiblingTree(int row,int pos)
    {
        synchronized(data) {
            if (row<=0 || row>records()) return null;

            int depth=getDepth(row,pos);
            boolean result[] = new boolean[depth];
        
            while (true) {
                row++;
                if (row>records()) break;
                int s_depth=getDepth(row,pos);
                if (s_depth==depth) {
                    if (depth<=result.length) {
                        if (depth>0) result[depth-1]=true;
                    }
                }
                
                if (s_depth<depth) {
                    depth=s_depth;
                    if (depth>0) result[depth-1]=true;
                }
            }
            
            return result;
        }
    }
    
    public boolean hasSibling(int row,int pos)
    {
        synchronized(data) {
            if (row<=0 || row>records()-1) return false;
            
            int depth=getDepth(row,pos);
            while (true) {
                row++;
                if (row>records()) return false;
                int s_depth=getDepth(row,pos);
                if (s_depth==depth) return true;
                if (s_depth<depth) return false;
            }
        }
    }

    @Override
    public int convertQueueIndexToScreenIndex(int v) 
    {
        return v;
    }

    @Override
    public int convertScreenIndexToQueueIndex(int v) 
    {
        return v;
    }

    @Override
    public ClarionMemoryModel castTo(Class<? extends ClarionMemoryModel> clazz) {
        ClarionMemoryModel n =super.castTo(clazz);
        if (n instanceof ClarionQueue) {
            ((ClarionQueue)n).data=this.data;
        }
        return n;
    }

    
}
