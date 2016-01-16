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

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.memory.CMem;
import org.jclarion.clarion.runtime.OverGlue;
import org.jclarion.clarion.runtime.ref.RefVariable;

/**
 * Model a group of parameters
 * 
 * @author barney
 *
 */
public class ClarionGroup extends ClarionMemoryModel implements ClarionCloneable
{

    private String prefix;
    private boolean threaded;
    
    @Override
    public void initThread()
    {
        super.initThread();
        if (!threaded) {
            threaded=true;
            for (GroupEntry ge  : map.values()) {
                if (ge.value instanceof ClarionMemoryModel) {
                    ((ClarionMemoryModel)ge.value).initThread();
                }
            }
        }
    }

    public ClarionGroup getThread()
    {
        initThread();
        return this;
    }
    
    /**
     * Set file prefix as specified in clarion source code. 
     * File prefix is required because there are alot of runtime
     * structures will refer to it - particularly view "order" and "filter"
     * attributes.
     * 
     * @param prefix
     */
    public void setPrefix(String prefix)
    {
        this.prefix=prefix;
    }
    
    public String getPrefix()
    {
        return prefix;
    }
    
    protected static class GroupEntry
    {
        protected Object value;
        
        protected String name;
        
        public GroupEntry(String name,Object value) {
            this.name=name;
            this.value=value;
        }
    }

    protected LinkedHashMap<String,GroupEntry>map = new LinkedHashMap<String, GroupEntry>();  

    private ClarionMemoryChangeListener notifyChildChange = new ClarionMemoryChangeListener() {
        @Override
        public void objectChanged(ClarionMemoryModel model) {
            notifyChange();
        }
    };

    /**
     *  Add a variable to group
     *  
     * @param name
     * @param object
     */
    public void addVariable(String name,Object object) {
        map.put(name.toLowerCase(),new GroupEntry(name,object));
        if (object instanceof ClarionMemoryModel) {
            ClarionMemoryModel cmm = (ClarionMemoryModel)object;
            if (isThreaded()) cmm.initThread();
            cmm.addChangeListener(notifyChildChange);
        }
        if (object instanceof ClarionObject) {
            ((ClarionObject)object).setOwner(this);
        }
    }

    public int getVariableCount()
    {
        return map.size();
    }
    
    /**
     * Add a dimensioned variable to group
     * @param name
     * @param object
     */
    public void addVariable(String name,Object object[]) {
        map.put(name.toLowerCase(),new GroupEntry(name,object));
        
        for (int scan=1;scan<object.length;scan++) {
            if (object[scan]!=null) {
                if (object[scan] instanceof ClarionMemoryModel) {
                    ((ClarionMemoryModel)object[scan]).addChangeListener(notifyChildChange);
                }
            }
        }
    }

    /**
     *  Overload this object with another clarion memory object
     * @param cmm
     */
    private OverGlue glue;
    public ClarionGroup setOver(ClarionMemoryModel cmm)
    {
        if (glue!=null) {
            glue.destroy();
            glue=null;
        }
        glue = new OverGlue(this,cmm);
        glue.objectChanged(cmm);
        return this;
    }

    
    /**
     * Clear group
     * @param method 0 = clear values to zero/null/empty. 
     *    -1 = clear values to smallest comparator value
     *    +1 = clear values to largest comparator value
     */
    public void clear(int method) {
        
        for ( GroupEntry ge : map.values() ) {
            if (ge.name.startsWith("__padding:")) continue;
            if (ge.value!=null) {
                if (ge.value instanceof ClarionAny) {
                    ((ClarionAny) ge.value).setReferenceValue(null);
                    continue;
                }
                if (ge.value instanceof ClarionCloneable) {
                    ((ClarionCloneable) ge.value).clear(method);
                    continue;
                }
            }
        }
    }

    public void clear() {
        clear(0);
    }

    public ClarionGroup genericLike()
    {
        try {
            ClarionGroup cg = (ClarionGroup)getClass().newInstance();
            cg.merge(this);
            return cg;
        } catch (InstantiationException e) {
            e.printStackTrace();
            return null;
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Deep Merge settings from supplied group into this group
     *  
     * @param group
     */
    public void merge(ClarionGroup group)
    {
        for (GroupEntry scan : map.values())  {

            GroupEntry r = group.map.get(scan.name.toLowerCase());
            if (r==null) continue;
            doMerge(scan.value,r.value);
        }
    }
    
    private void doMerge(Object to,Object from) {
        if (to==null) return;
        if (to instanceof ClarionCloneable) {
        	((ClarionCloneable)to).setValue(from);
        }
    }
    
    /**
     *  Return object represented by specified index. Note that indexing
     *  needs to take into account deep scanning of nested groups. i.e numbering
     *  is
     *  
     *  F1 = 1
     *  F2 = 2
     *  F3 = 3
     *  GROUP =4
     *   G1 = 5
     *   G2 = 6
     *   G3 = 7
     *  F4 = 8
     *  
     * @param index
     * @return
     */
    
    private Map<Integer,GroupEntry> whatCache=new HashMap<Integer, GroupEntry>();

    private GroupEntry whatGE(int index) {
        GroupEntry ge = whatCache.get(index);
        if (ge==null) {
            ge=findWhat(new int[] { index });
            if (ge==null) return null;
            whatCache.put(index,ge);
        }
        return ge;
    }
    
    public ClarionObject what(int index)
    {
        GroupEntry ge = whatGE(index);
        if (ge==null) return null;
        
        Object ret = ge.value;
        if (ret==null) return null;
        if (ret instanceof RefVariable<?>) {
        	ret = ((RefVariable<?>)ret).get();
            if (ret==null) return null;
        }
        if (ret instanceof ClarionObject) {
            return (ClarionObject)ret;
        }
        return null;
    }

    private GroupEntry findWhat(int offset[])
    {
        for (GroupEntry search : map.values() ) {
            if (offset[0]==1) return search;
            offset[0]--;
            
            if (search.value instanceof ClarionGroup) {
                search = ((ClarionGroup)search.value).findWhat(offset);
                if (search!=null) return search;
            }
        }
        return null;
    }

    private Map<Integer,GroupEntry> flatWhatCache=new HashMap<Integer, GroupEntry>();

    private GroupEntry flatWhatGE(int index)
    {
        GroupEntry ge = flatWhatCache.get(index);
        if (ge==null) {
            
            Iterator<GroupEntry> it = map.values().iterator();
            int iscan=index;
            while (iscan>1 && it.hasNext()) {
                it.next();
                iscan--;
            }
            if (iscan==1 && it.hasNext()) ge=it.next();
            if (ge==null) return null;
            whatCache.put(index,ge);
        }
        return ge;
    }
    
    public ClarionObject flatWhat(int index)
    {
        GroupEntry ge = flatWhatGE(index);
        if (ge==null) return null;
        
        Object ret = ge.value;
        if (ret==null) return null;
        if (ret instanceof RefVariable<?>) {
        	ret = ((RefVariable<?>)ret).get();
            if (ret==null) return null;
        }
        if (ret instanceof ClarionObject) {
            return (ClarionObject)ret;
        }
        return null;
    }

    public String flatWho(int index)
    {
        GroupEntry ge = flatWhatGE(index);
        if (ge==null) return null;
        if (prefix!=null) return prefix+":"+ge.name;
        return ge.name;
    }
    

    /**
     * Get group parameter based on specified add key. i.e. its 'runtime' name
     * Keys are case insensitive
     * 
     * @param key
     * @return
     */
    
    private Map<String,Integer> positionCache;
    
    public int getGroupParamPosition(String key)
    {
        if (positionCache==null) {
            int scan=1;
            positionCache=new HashMap<String, Integer>();
            for (String k : map.keySet() ) {
                positionCache.put(k,scan);
                scan++;
            }
        }
        Integer i = positionCache.get(key.toLowerCase());
        if (i==null) return 0;
        return i;
    }
    

    /**
     * Get group parameter based on specified add key. i.e. its 'runtime' name
     * Keys are case insensitive
     * 
     * @param key
     * @return
     */
    public ClarionObject getGroupParam(String key)
    {
        GroupEntry ge = map.get(key.toLowerCase());
        if (ge==null) return null;
        if (ge.value instanceof ClarionObject) {
            return (ClarionObject)ge.value;
        }
        if (ge.value instanceof RefVariable<?>) {
        	Object val = ((RefVariable<?>)ge.value).get();
            if (val==null) return null;
            if (val instanceof ClarionObject) {
                return (ClarionObject)val;
            }
        }
        return null;
    }

    /**
     * Get group parameter based on specified add key. i.e. its 'runtime' name
     * Keys are case insensitive
     * 
     * @param key
     * @return
     */
    public Object getGroupObject(String key)
    {
        GroupEntry ge = map.get(key.toLowerCase());
        if (ge==null) return null; 
        if (ge.value instanceof RefVariable<?>) {
        	return ((RefVariable<?>)ge.value).get();
        }
        return ge.value;
    }
    
    /**
     * Return position of a given component within a group. 
     *  
     * @param component
     * @return
     */
    public int where(Object component)
    {
        int offset[] = new int[] { 1 };
        if (findWhere(offset,component)) return offset[0];
        return 0;
    }
    
    private Map<ClarionObject,Integer> flatWhereCache=null;
    
    public int flatWhere(Object o)
    {
        int result=1;
        
        if (flatWhereCache==null) {
            flatWhereCache=new HashMap<ClarionObject,Integer>();
            int count=0;
            for (GroupEntry search : map.values() ) {
                count++;
                if (search.value!=null && (search.value instanceof ClarionObject)) {
                    flatWhereCache.put((ClarionObject)search.value,count);
                }
            }
        }
        
        Integer r = flatWhereCache.get(o);
        if (r!=null) return r;
        
        for (GroupEntry search : map.values() ) {
            if (search.value==o) {
                if (o instanceof ClarionObject) {
                    flatWhereCache.put((ClarionObject)o,result);
                }
                return result;
            }
            
            if (search.value instanceof RefVariable<?>) {
            	if (search.value==o) return result;
            	if (((RefVariable<?>)search.value).get()==o) return result;
            }
            result++;
        }
        return 0;
    }
    
    
    private boolean findWhere(int offset[],Object o)
    {
        for (GroupEntry search : map.values() ) {
            
            if (search.value==o) return true;
            if (search.value instanceof RefVariable<?>) {
            	if (((RefVariable<?>)search.value).get()==o) return true;
            }
            offset[0]++;
            
            if (search.value instanceof ClarionGroup) {
                if (((ClarionGroup)search.value).findWhere(offset,o)) return true;
            }
        }
        return false;
    }

    /**
     * Return runtime name of object at given position. Note comments on what
     * above regarding how positions are worked out
     * 
     * @param index
     * @return
     */
    public ClarionString who(int index) {
        GroupEntry ge = whatGE(index);
        if (ge==null) return null;
        
        if (prefix!=null) return new ClarionString(prefix+":"+ge.name);
        return new ClarionString(ge.name);
    }

    public String whoNoPrefix(int index) {
        GroupEntry ge = whatGE(index);
        if (ge==null) return null;
        return ge.name;
    }

    @Override
    public void deserialize(CMem os) {
        for ( GroupEntry o : map.values() ) {
            if (o.value!=null) deserialize(os,o.value);
        }
    }
    private void deserialize(CMem is,Object o) {
        if (o instanceof ClarionMemoryModel) {
            ((ClarionMemoryModel)o).deserialize(is);
            return;
        }
        
        ClarionNumber addr = new ClarionNumber();
        addr.deserialize(is);
    }

    @Override
    public void serialize(CMem is) {
        
        for ( GroupEntry o : map.values() ) {
            if (o.value!=null) serialize(is,o.value);
        }
    }
    
    private void serialize(CMem is,Object o) {
        
        if (o==null) return;
        if (o instanceof ClarionMemoryModel) {
            ((ClarionMemoryModel)o).serialize(is);
            return;
        }
        is.writeObject(o);
    }
    
    /**
     *  Get string representation of group based on its memory model
     *  
     * @return
     */
    public ClarionString getString()
    {
		CMem baos = size > 0 ? CMem.create(size) : CMem.create();
		serialize(baos);
		if (size == 0)
			size = baos.remaining();
		return new ClarionString(baos.readString(baos.remaining()));
    }

    private int size=-1;

    /**
     *  Set grou from string based on its memory model
     *  
     * @return
     */
    public void setValue(ClarionObject object)
    {
        if (object==null) return;
        
		CMem sos = size > 0 ? CMem.create(size) : CMem.create();

		if (size == -1) {
			this.serialize(sos);
			size = sos.remaining();
			sos.resetWrite();
		}

		object.serialize(sos);
		if (size > 0) {
			int writeMore = size - sos.remaining();
			while (writeMore > 0) {
				sos.writeChar(' '); // pad with spaces
				writeMore--;
			}
		}
		deserialize(sos);
    }

    public void setValue(Object object)
    {
    	if (object instanceof ClarionGroup) {
    		merge((ClarionGroup)object);
    	} else {
    		setValue(Clarion.getClarionObject(object));
    	}
    }

    public void setNull(ClarionObject clarionObject) 
    {
    }

    public void clearNull(ClarionObject clarionObject) {
    }

    public boolean isNull(ClarionObject clarionObject) {
    	return false;
    }

    @Override
    public Object getLockedObject(Thread t) {
        try {
            ClarionGroup cg = (ClarionGroup)getClass().newInstance();
            cg.lock(this,t);
            
            Iterator<GroupEntry> orig=map.values().iterator();
            Iterator<GroupEntry> lock=cg.map.values().iterator();
            
            while (orig.hasNext() && lock.hasNext()) {
                GroupEntry g_orig=orig.next();
                GroupEntry g_lock=lock.next();
                if (g_orig.value instanceof Threaded) {
                    g_lock.value=((Threaded)g_orig.value).getLockedObject(t);
                }
            }
            return cg;
        } catch (InstantiationException e) {
            e.printStackTrace();
            return null;
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            return null;
        }
    }

	@Override
	public Object clarionClone() {
		return this.genericLike();
	}
}
