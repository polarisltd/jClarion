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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.setting.DefaultSetting;

public abstract class PropertyObject 
{
    private Map<Integer,ClarionObject> properties = 
        new HashMap<Integer, ClarionObject>();

    public abstract PropertyObject getParentPropertyObject();
    
    private List<PropertyObjectListener> listeners=null;
    private boolean inNotify; 
    private List<PropertyObjectListener> new_listeners=null;
    
    private String id;
    
    public void clearMetaData()
    {
    }

    public void addListener(PropertyObjectListener p)
    {
        if (listeners==null) {
            synchronized(this) {
                if (listeners==null) {
                    listeners=new ArrayList<PropertyObjectListener>();            
                }
            }
        }
        
        synchronized(listeners) {
            if (inNotify) {
                if (new_listeners==null) new_listeners=new ArrayList<PropertyObjectListener>(listeners);
                new_listeners.add(p);
            } else {
                listeners.add(p);
            }
        }
    }

    public void removeListener(PropertyObjectListener p)
    {
        if (listeners==null) return;
        
        synchronized(listeners) {
            if (inNotify) {
                if (new_listeners==null) new_listeners=new ArrayList<PropertyObjectListener>(listeners);
                new_listeners.remove(p);
            } else {
                listeners.remove(p);
            }
        }
    }
    
    public void removeAllListeners()
    {
        if (listeners==null) return;
        
        synchronized(listeners) {
            if (inNotify) {
                new_listeners=new ArrayList<PropertyObjectListener>();
            } else {
                listeners.clear();
            }
        }
    }
    
    private static class PendingNotify
    {
        private int             property;
        private ClarionObject   value;

        public PendingNotify(int property,ClarionObject value)
        {
            this.property=property;
            this.value=value;
        }
    }
    
    private List<PendingNotify> alreadyInNotify;

    private void notifyChange(int property,ClarionObject value)
    {
        if (listeners==null) return;
        
        boolean finished=false;
        
        synchronized (listeners) {
            if (inNotify) {
                if (alreadyInNotify == null) {
                    alreadyInNotify = new ArrayList<PendingNotify>();
                }
                alreadyInNotify.add(new PendingNotify(property, value));
                return; // let current notify thread send notify on this
            }
            inNotify = true;
        }
            
        while ( !finished ) {
            try {
                for ( PropertyObjectListener l : listeners ) {
                    l.propertyChanged(this, property, value);
                }

                synchronized(listeners) {
                    if (alreadyInNotify!=null && !alreadyInNotify.isEmpty()) {
                        PendingNotify pe = alreadyInNotify.remove(0);
                        property=pe.property;
                        value=pe.value;
                    } else {
                        finished=true;
                    }
                }
            } finally {
                
                synchronized(listeners) {
                    inNotify=false;

                    if (new_listeners!=null) {
                        listeners.clear();
                        listeners.addAll(new_listeners);
                        new_listeners = null;
                    }
                }
                
            }
        }
    }
    
    public final void setClonedProperty(Object index,Object value)
    {
        ClarionObject c_index = Clarion.getClarionObject(index);
        ClarionObject c_value = Clarion.getClarionObject(value);
        setClonedProperty(c_index,c_value);
    }

    public final void setClonedProperty(ClarionObject index,ClarionObject value)
    {
        setClonedProperty(index.intValue(),value);
    }

    public Map<Integer,ClarionObject> getProperties()
    {
    	synchronized(properties) {
    		return new HashMap<Integer,ClarionObject>(properties);
    	}
    }
    
    public boolean isSettable(int indx,ClarionObject value)
    {
        return true;
    }
        
    public final void setClonedProperty(int indx,ClarionObject value)
    {
        if (!isSettable(indx,value)) return;
        
        if (value!=null) {
            synchronized(properties) {
                
                ClarionObject existing = properties.get(indx);
                
                if (existing!=null) {
                    if (existing.getClass() != value.getClass()) {
                        existing=null;
                    } else if (existing.isConstrained()) {
                        existing=null;
                    }
                }
                
                if (existing==null) {
                    while (true) {
                        if (value.getClass()==ClarionNumber.class) {
                            existing=new ClarionNumber();
                            existing.setValue(value);
                            break;
                        }
                        if (value.getClass()==ClarionString.class) {
                            existing=new ClarionString();
                            existing.setValue(value);
                            break;
                        }
                        if (value.getClass()==ClarionDecimal.class) {
                            existing=new ClarionDecimal();
                            existing.setValue(value);
                            break;
                        }
                        if (value.getClass()==ClarionBool.class) {
                            existing=new ClarionBool();
                            existing.setValue(value);
                            break;
                        }
                        if (value.getClass()==ClarionReal.class) {
                            existing=new ClarionReal();
                            existing.setValue(value);
                            break;
                        }
                        
                        existing=value.genericLike();
                        break;
                    }
                    
                    properties.put(indx,existing);
                } else {
                    existing.setValue(value);
                }
            }
        } else {
            synchronized(properties) {
                properties.remove(indx);
            }
        }
        
        notifyLocalChange(indx,value);
        notifyChange(indx,value);
    }
    
    public final void setProperty(Object index,Object value) {
        setProperty(
                Clarion.getClarionObject(index),   
                Clarion.getClarionObject(value));   
    }

    /**
     * Set property on object. i.e. PROP:TEXT
     *  
     * @param index Property to set
     * @param value Value to set
     */
    public final void setProperty(ClarionObject index, ClarionObject value) 
    {
        setProperty(index.intValue(),value);
    }
        
    public final void setProperty(int indx, ClarionObject value) 
    {
        if (!isSettable(indx,value)) return;
        
        synchronized(properties) {
            properties.put(indx,value);
        }
        notifyLocalChange(indx,value);
        notifyChange(indx,value);
    }
    
    /*
    protected boolean canNotifyLocalChange(int indx)
    {
        return true;
    }
    */
    
    protected void notifyLocalChange(int indx,ClarionObject value) 
    {
    }

    public final void setClonedProperty(Object key,Object index,Object value)
    {
        ClarionObject c_index = Clarion.getClarionObject(index);
        ClarionObject c_key = Clarion.getClarionObject(key);
        ClarionObject c_value = Clarion.getClarionObject(value);
        setClonedProperty(c_key,c_index,c_value);
    }

    public final void setClonedProperty(ClarionObject key,ClarionObject index,ClarionObject value)
    {
        int indx = reMap(key.intValue(),index.intValue());
        if (indx!=0) {
            setClonedProperty(indx,value);
            return;
        }
        
        if (value!=null) value=value.genericLike();
        setProperty(key,index,value);
    }
    
    public final void setProperty(Object index,Object key,Object value) {
        setProperty(
                Clarion.getClarionObject(index),   
                Clarion.getClarionObject(key),   
                Clarion.getClarionObject(value));   
    }

    public int reMap(int ikey,int iindex)
    {
        switch (ikey) {
        case Prop.PAGEBEFORE:
            switch(iindex) {
            	case 2:
            		return Prop.PAGEBEFORENUM;
            }
            break;
        case Prop.PAGEAFTER:
            switch(iindex) {
            	case 2:
            		return Prop.PAGEAFTERNUM;
            }
            break;
        case Prop.VCR:
            switch(iindex) {
            	case 2:
            		return Prop.VCRFEQ;
            }
            break;
        case Prop.FONT:
            switch(iindex) {
                case 1:
                    return Prop.FONTNAME;
                case 2:
                    return Prop.FONTSIZE;
                case 3:
                    return Prop.FONTSTYLE;
                case 4:
                    return Prop.FONTCHARSET;
            }
            break;
        case Prop.AT:
            switch(iindex) {
                case 1:
                    return Prop.XPOS;
                case 2:
                    return Prop.YPOS;
                case 3:
                    return Prop.WIDTH;
                case 4:
                    return Prop.HEIGHT;
            }
            break;
        }
        return 0;
    }
    
    /**
     * Set property on object. i.e. PROP:AT,1
     *  
     * @param key Property to set
     * @param index sub propery to set
     * @param value Value to set
     */
    public void setProperty(ClarionObject key, ClarionObject index,ClarionObject value) 
    {
        int indx = reMap(key.intValue(),index.intValue());
        if (indx!=0) {
            setProperty(indx,value);
            return;
        }
        throw new RuntimeException("Not yet implemented:"+key+" : "+index);
    }

    public final ClarionObject getProperty(Object index) {
        return getProperty(Clarion.getClarionObject(index));
    }

    /**
     *  Retrieve property setting. i.e. PROP:Timer
     *  
     * @param index
     * @return
     */
    public final ClarionObject getProperty(ClarionObject index) {
        ClarionObject result=getRawProperty(index.intValue());
        if (result==null) return new ClarionBool(false);
        return result;    
    }

    public final ClarionObject getRawProperty(int index) {
        return getRawProperty(index,true);
    }

    public ClarionObject getLocalProperty(int index)
    {
        return null;
    }
    
    public final  ClarionObject getRawProperty(int index,boolean useListen) 
    {
        if (useListen) {
            ClarionObject locp = getLocalProperty(index);
            if (locp!=null) return locp;
        }
        
        // check listeners maybe they have an opinion on what value is
        if (useListen && listeners!=null ) {
            Object lvalue=null;
            synchronized(listeners) {
                for ( PropertyObjectListener l : listeners ) {
                    lvalue = l.getProperty(this, index);
                    if (lvalue!=null) break;
                }
            }
            if (lvalue!=null) return Clarion.getClarionObject(lvalue);
        }
        
        synchronized(properties) {
            return properties.get(index);
        }
    }

    public final  ClarionObject getInheritedProperty(int index) {
        PropertyObject scan = this;
        while (scan!=null) {
            ClarionObject result = scan.getRawProperty(index,false);
            if (result!=null) return result;
            scan=scan.getParentPropertyObject();
        }
        return null;
    }
    
    public final  ClarionObject getProperty(Object key,Object index) {
        return getProperty(
                Clarion.getClarionObject(key),
                Clarion.getClarionObject(index));
    }

    /**
     * Retrieve property setting. i.e. PROP:Font,1
     * @param key
     * @param index
     * @return
     */
    public ClarionObject getProperty(ClarionObject key,ClarionObject index) {
        int indx = reMap(key.intValue(),index.intValue());
        if (indx!=0) {
            return getProperty(indx);
        }
        throw new RuntimeException("Array Property Not yet implemented: "+Integer.toHexString(key.intValue()));
    }
    
    public final  boolean isProperty(int value)
    {
        ClarionObject co = getRawProperty(value);
        if (co==null) return false;
        return co.boolValue();
    }
    
    public final ClarionObject getPropertyOrDefault(int value,Object def)
    {
        ClarionObject co = getProperty(value);
        if (co==null) return Clarion.getClarionObject(def);
        return co;
    }

    public List<Integer> getSetProperties()
    {
        TreeSet<Integer> r = new TreeSet<Integer>(properties.keySet());
        return new ArrayList<Integer>(r);
    }
    
    public String toString()
    {
        StringBuilder out = new StringBuilder();
        
        String fullname=getClass().getName();
        
        out.append(fullname.substring(fullname.lastIndexOf('.')+1));
        out.append(' ');
        out.append(id);
        out.append(' ');
        out.append("[");
        
        boolean first=true;
        for ( Map.Entry<Integer,ClarionObject> me : properties.entrySet() ) {
            if (first) {
                first=false;
            } else {
                out.append(", ");
            }
            out.append(Prop.getPropString(me.getKey()));
            out.append("=");
            if (me.getValue()!=null) {
                out.append(me.getValue().toString().trim());
            } else {
                out.append("null");
            }
        }
        
        out.append("]");
        return out.toString();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
        DefaultSetting.getInstance().set(this);
    }

    public void getDebugMetaData(StringBuilder sb)
    {
        sb.append(toString());
        debugMetaData(sb);
    }
    
    public String getDebugMetaData()
    {
        StringBuilder sb = new StringBuilder();
        getDebugMetaData(sb);
        return sb.toString();
    }

    protected abstract void debugMetaData(StringBuilder sb);
    
    private final static char[] hex="0123456789abcdef".toCharArray();
    
    protected void debugMetaData(StringBuilder sb,String name,Object o)
    {
        sb.append("\n");
        sb.append(" * ");
        sb.append(name);
        sb.append(' ');
        if (o!=null) {
            
            int code =System.identityHashCode(o); 
            
            sb.append(hex[(code>>28)&0xf]);
            sb.append(hex[(code>>24)&0xf]);
            sb.append(hex[(code>>20)&0xf]);
            sb.append(hex[(code>>16)&0xf]);
            sb.append(hex[(code>>12)&0xf]);
            sb.append(hex[(code>>8)&0xf]);
            sb.append(hex[(code>>4)&0xf]);
            sb.append(hex[(code)&0xf]);
            sb.append(" ");
            sb.append(o);
        } else {
            sb.append("(null)");
        }
    }
}
