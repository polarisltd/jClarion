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

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.OverGlue;
import org.jclarion.clarion.runtime.ref.RefVariable;
import org.jclarion.clarion.util.SharedOutputStream;

/**
 * Model a group of parameters
 * 
 * @author barney
 *
 */
public class ClarionGroup extends ClarionMemoryModel 
{
    private static Logger log = Logger.getLogger(ClarionGroup.class.getName());

    protected static class ReferenceVariable {
        Object clazz;
        Field field;
        
        public ReferenceVariable(Object clazz,Field field) {
            this.clazz=clazz;
            this.field=field;
        }
    }

    private String prefix;
    
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
        protected Object[] array;
        
        protected String name;
        
        public GroupEntry(String name,Object value) {
            this.name=name;
            this.value=value;
        }
        
        public GroupEntry(String name,Object value[]) {
            this.name=name;
            this.array=value;
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
            ((ClarionMemoryModel)object).addChangeListener(notifyChildChange);
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
     * Add reference variable to the group
     * @param name
     * @param object
     */
    public void addReference(String name,Object object) {
        
        if (object instanceof RefVariable<?>) {
            addVariable(name,object);
            return;
        }
        
        if (object instanceof Field) {
            object=new ReferenceVariable(this,(Field)object);
        } else {
            try {
                Field f =getClass().getField(name);
                if ((f.getModifiers()&Modifier.PUBLIC)!=0) {
                    object=new ReferenceVariable(this,f);
                }
            } catch (SecurityException e) {
                log.log(Level.SEVERE,"Got Security Exception trying to find reference var",e);
                return;
            } catch (NoSuchFieldException e) {
                // try exhaustive search
                Field[] fields = getClass().getFields();
                boolean match=false;
                for (int scan=0;scan<fields.length;scan++) {
                    if (fields[scan].getName().equalsIgnoreCase(name)) {
                        if ((fields[scan].getModifiers()&Modifier.PUBLIC)!=0) {
                            object=new ReferenceVariable(this,fields[scan]);
                            match=true;
                        }
                    }
                }
                if (!match) {
                    log.log(Level.SEVERE,"Field not found for reference variable",e);
                    return;
                }
            }
        }
        addVariable(name,object);
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
            if (ge.value!=null) {
                if (ge.value instanceof ClarionAny) {
                    ((ClarionAny) ge.value).setReferenceValue(null);
                    continue;
                }
                if (ge.value instanceof ClarionObject) {
                    ((ClarionObject) ge.value).clear(method);
                    continue;
                }
                if (ge.value instanceof ClarionGroup) {
                    ((ClarionGroup) ge.value).clear(method);
                    continue;
                }
                if (ge.value instanceof ReferenceVariable) {
                    ReferenceVariable rv = (ReferenceVariable)ge.value;
                    try {
                        rv.field.set(rv.clazz,null);
                    } catch (IllegalArgumentException e) {
                        throw new IllegalStateException("Could not clear reference",e);
                    } catch (IllegalAccessException e) {
                        throw new IllegalStateException("Could not clear reference",e);
                    }
                }
            }
            if (ge.array!=null) {
                for (int scan=1;scan<ge.array.length;scan++) {
                    if (ge.array[scan] instanceof ClarionObject) {
                        ((ClarionObject) ge.array[scan]).clear(method);
                    }
                    if (ge.array[scan] instanceof ClarionGroup) {
                        ((ClarionGroup) ge.array[scan]).clear(method);
                    }
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
            
            if (scan.array!=null) {
                if (r.array!=null) {
                    int msize = scan.array.length;
                    if (r.array.length>msize) msize=r.array.length;
                    for (int s=1;s<msize;s++) {
                        doMerge(scan.array[s],r.array[s]);
                    }
                } else {
                    // do not merge
                }
            } else {
                doMerge(scan.value,r.value);
            }
        }
    }
    
    private void doMerge(Object to,Object from) {
        
        if (to==null) return;
        
        if (from instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)from;
            try {
                from = rv.field.get(rv.clazz);
            } catch (IllegalArgumentException e) {
                throw new IllegalStateException("Could not merge reference",e);
            } catch (IllegalAccessException e) {
                throw new IllegalStateException("Could not merge reference",e);
            }
        }
        
        if (to instanceof ClarionObject) {
            ((ClarionObject)to).setValue(from);
            return;
        }

        if (to instanceof ClarionGroup) {
            if (from instanceof ClarionGroup) {
                ((ClarionGroup)to).merge((ClarionGroup)from);
            } else {
                ((ClarionGroup)to).setValue(from);
            }
            return;
        }
        
        if (to instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)to;
            try {
                rv.field.set(rv.clazz,from);
            } catch (IllegalArgumentException e) {
                throw new IllegalStateException("Could not merge reference",e);
            } catch (IllegalAccessException e) {
                throw new IllegalStateException("Could not merge reference",e);
            }
            return;
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
        
        if (ge.array!=null) return null;
        Object ret = ge.value;
        if (ret instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)ret;
            try {
                ret = rv.field.get(rv.clazz);
            } catch (IllegalArgumentException e) {
                throw new IllegalStateException("Could not merge reference",e);
            } catch (IllegalAccessException e) {
                throw new IllegalStateException("Could not merge reference",e);
            }
        }
        if (ret==null) return null;
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
        
        if (ge.array!=null) return null;
        Object ret = ge.value;
        if (ret instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)ret;
            try {
                ret = rv.field.get(rv.clazz);
            } catch (IllegalArgumentException e) {
                throw new IllegalStateException("Could not merge reference",e);
            } catch (IllegalAccessException e) {
                throw new IllegalStateException("Could not merge reference",e);
            }
        }
        if (ret==null) return null;
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
        if (ge.value instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)ge.value;
            try {
                Object val = rv.field.get(rv.clazz);
                if (val instanceof ClarionObject) {
                    return (ClarionObject)val;
                }
            } catch (IllegalArgumentException e) {
                throw new IllegalStateException("Could not extract reference",e);
            } catch (IllegalAccessException e) {
                throw new IllegalStateException("Could not extract reference",e);
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
        if (ge.value instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)ge.value;
            try {
                return rv.field.get(rv.clazz);
            } catch (IllegalArgumentException e) {
                throw new IllegalStateException("Could not extract reference",e);
            } catch (IllegalAccessException e) {
                throw new IllegalStateException("Could not extract reference",e);
            }
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
            
            if (search.value instanceof ReferenceVariable) {
                ReferenceVariable rv = (ReferenceVariable)search.value;
                if (rv.field==o) return result;
                try {
                    if (rv.field.get(rv.clazz)==o) return result;
                } catch (IllegalArgumentException e) {
                    throw new IllegalStateException("Could not where reference",e);
                } catch (IllegalAccessException e) {
                    throw new IllegalStateException("Could not where reference",e);
                }
            }
            result++;
        }
        return 0;
    }
    
    
    private boolean findWhere(int offset[],Object o)
    {
        for (GroupEntry search : map.values() ) {
            
            if (search.value==o) return true;
            if (search.value instanceof ReferenceVariable) {
                ReferenceVariable rv = (ReferenceVariable)search.value;
                if (rv.field==o) return true;
                try {
                    if (rv.field.get(rv.clazz)==o) return true;
                } catch (IllegalArgumentException e) {
                    throw new IllegalStateException("Could not where reference",e);
                } catch (IllegalAccessException e) {
                    throw new IllegalStateException("Could not where reference",e);
                }
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

    @Override
    public void deserialize(InputStream os) throws IOException {
        for ( GroupEntry o : map.values() ) {
            if (o.array!=null) {
                for (int scan=1;scan<o.array.length;scan++) {
                    deserialize(os,o.array[scan]);
                }
            }
            if (o.value!=null) deserialize(os,o.value);
        }
    }
    private void deserialize(InputStream is,Object o)  throws IOException {
        if (o instanceof ClarionMemoryModel) {
            ((ClarionMemoryModel)o).deserialize(is);
            return;
        }
        
        ClarionNumber addr = new ClarionNumber();
        addr.deserialize(is);
        
        if (o instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)o;
            try {
                rv.field.set(rv.clazz,CMemory.resolveAddress(addr.intValue()));
            } catch (IllegalArgumentException e) {
                log.log(Level.SEVERE,"Could not get address",e);
            } catch (IllegalAccessException e) {
                log.log(Level.SEVERE,"Could not get address",e);
            }
        }
    }

    @Override
    public void serialize(OutputStream is) throws IOException {
        
        for ( GroupEntry o : map.values() ) {
            if (o.array!=null) {
                for (int scan=1;scan<o.array.length;scan++) {
                    serialize(is,o.array[scan]);
                }
            }
            if (o.value!=null) serialize(is,o.value);
        }
    }
    
    private void serialize(OutputStream is,Object o)  throws IOException {
        
        if (o==null) return;
        if (o instanceof ClarionMemoryModel) {
            ((ClarionMemoryModel)o).serialize(is);
            return;
        }
        
        int addr=0;
        
        if (o instanceof ReferenceVariable) {
            ReferenceVariable rv = (ReferenceVariable)o;
            try {
                addr = CMemory.address(rv.field.get(rv.clazz));
            } catch (IllegalArgumentException e) {
                log.log(Level.SEVERE,"Could not get address",e);
            } catch (IllegalAccessException e) {
                log.log(Level.SEVERE,"Could not get address",e);
            }
        } else {
            addr = 0;
        }
        
        is.write(addr);
        is.write(addr>>8);
        is.write(addr>>16);
        is.write(addr>>24);
    }
        
       
    
    /**
     *  Get string representation of group based on its memory model
     *  
     * @return
     */
    public ClarionString getString()
    {
        try {
            ByteArrayOutputStream baos=new ByteArrayOutputStream();
            serialize(baos);
            byte b[] = baos.toByteArray();
            char c[] = new char[b.length];
            for (int scan=0;scan<c.length;scan++) {
                c[scan]=(char)b[scan];
            }
            return new ClarionString(new String(c));
        } catch (IOException ex ) {
            throw new RuntimeException("Got some sort of IO exception",ex);
        }
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
        
        try {
            SharedOutputStream sos=new SharedOutputStream(size>0 ? size : 256);
            
            this.serialize(sos);
            size = sos.getSize();
            sos.reset();
            object.serialize(sos);
            deserialize(sos.getInputStream(size));
        } catch (IOException ex ) {
            throw new RuntimeException("Got some sort of IO exception",ex);
        }
    }

    public void setValue(Object object)
    {
        setValue(Clarion.getClarionObject(object));
    }
}
