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
import java.util.List;

import org.jclarion.clarion.constants.*;

/**
 * Model a sort key in Clarion
 * 
 * @author barney
 *
 */
public class ClarionKey extends PropertyObject 
{
    public static class Order
    {
        public ClarionObject    object;
        public boolean          descend;
        public String           function;
        public int              order;
        
        public Order(ClarionObject object,boolean descend,String function)
        {
            this.object=object;
            this.descend=descend;
            this.function=function;
        }
        
        public boolean equals(Object o)
        {
            if (o==this) return true;
            if (!(o instanceof Order)) return false;
            
            Order o_o = (Order)o;
            
            if (o_o.object!=this.object) return false;
            if (o_o.descend!=this.descend) return false;
            if (o_o.order!=this.order) return false;
            if (o_o.function==null) {
                if (this.function!=null) return false;
            } else {
                if (this.function==null) return false;
                if (!this.function.equals(o_o.function)) return false;
            }
            
            return true;
        }
    }
    
    private String label;
    
    private List<Order> fields = new ArrayList<Order>(); 
   
    public ClarionKey(String label)
    {
        this.label=label;
    }
    
    /**
     *  Key is a primary key
     *  
     * @return
     */
    public ClarionKey setPrimary() {
        setProperty(Prop.PRIMARY,true);
        return this;
    }
    
    /**
     * Key allows duplicate records
     * 
     * @return
     */
    public ClarionKey setDuplicate() {
        setProperty(Prop.DUP,true);
        return this;
    }
    
    /**
     * Key is case insensitive
     * 
     * @return
     */
    public ClarionKey setNocase() {
        setProperty(Prop.NOCASE,true);
        return this;
    }
    
    /**
     * Key is optional, i.e. zero/null values are not keyed
     * 
     * @return
     */
    public ClarionKey setOptional() {
        setProperty(Prop.OPT,true);
        return this;
    }
    
    /** 
     * Specify key name
     * 
     * @param name
     * @return
     */
    public ClarionKey setName(String name) {
        setProperty(Prop.NAME,true);
        return this;
    }
    
    /**
     * Add field that is ascending
     * 
     * @param object
     * @return
     */
    public ClarionKey addAscendingField(ClarionObject object) {
        fields.add(new Order(object,false,null));
        order=null;
        getOrder();
        return this;
    }

    public ClarionKey addField(ClarionObject object,boolean descend,String function) {
        fields.add(new Order(object,descend,function));
        order=null;
        getOrder();
        return this;
    }
    
    public ClarionKey addDescendingField(ClarionObject object) {
        fields.add(new Order(object,true,null));
        order=null;
        getOrder();
        return this;
    }

    /**
     * Set record processing order based on specified key. Start position
     * is based on current settings in key
     */
    public void set()
    {
        reset(getPosition());
    }

    public void set(ClarionKey key)
    {
        reset(getPosition());
    }
    
    
    /**
     * Get string position store for the given key
     * 
     * @return
     */
    public ClarionString getPosition()
    {
        return clarionFile.getPosition(this);
    }
    
    /**
     * Return whether or not adding current record would trigger a duplicate key
     * error
     * 
     * @return true if adding current record would trigger duplicate key
     */
    public boolean duplicateCheck()
    {
        return clarionFile.duplicateCheck(this);
    }
    
    /**
     * Re-fetch record from the database based on position string
     * 
     * @param string
     */
    public void reget(ClarionString string)
    {
        clarionFile.reget(this,string);
    }
    
    /**
     * Re-set sequentual processing from the database based on position string
     * 
     * @param string
     */
    public void reset(ClarionString string)
    {
        clarionFile.reset(this,string);
    }

    /**
     * Set sequentual processing. Setting start position to start of file 
     */
    public void setStart()
    {
        clarionFile.set(this);
    }

    private ClarionFile clarionFile;
    
    public void setFile(ClarionFile clarionFile) {
        this.clarionFile=clarionFile;
    }
    
    public ClarionFile getFile()
    {
        return clarionFile;
    }

    public List<Order> getFields()
    {
        return fields;
    }
    
    private Order[] order;
    
    public Order[] getOrder()
    {
        if (order==null) {
            if (clarionFile==null) return null;
            order=new Order[fields.size()];
            int scan=0;
            for ( Order field : fields ) {
                int w = clarionFile.where(field.object);
                if (w==0) {
                    throw new RuntimeException("Field WHERE result invalid:"+field.object.getName());
                }
                order[scan++]=field;
                field.order=clarionFile.where(field.object)*(field.descend?-1:1);
            }
        }
        return order;    
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        // TODO Auto-generated method stub
        return null;
    }

    public ClarionObject getProperty(ClarionObject key,ClarionObject index) {

        switch (key.intValue()) {
            case Prop.FIELD:
            {
                int indx = index.intValue();
                if (indx<1 || indx>getOrder().length) return Clarion.newNumber(0).getString();
                return Clarion.newNumber(Math.abs(getOrder()[indx-1].order));
            }
            case Prop.ASCENDING:
            {
                int indx = index.intValue();
                if (indx<1 || indx>getOrder().length) return Clarion.newBool(0).getString();
                return Clarion.newBool(getOrder()[indx-1].order>0?1:0);
            }
        }
        
        return super.getProperty(key,index);
    }

    @Override
    public ClarionObject getLocalProperty(int index) {
        if (index==Prop.COMPONENTS) {
            return Clarion.newNumber(fields.size());
        }
        if (index==Prop.LABEL) {
            return new ClarionString(label);
        }
        // TODO Auto-generated method stub
        return super.getLocalProperty(index);
    }
    

    public String toString()
    {
        StringBuilder r = new StringBuilder();
        
        r.append("ClarionKey(");
        r.append(label);
        r.append(")");

        for (Order field : fields) {
            r.append(",");
            r.append(field.descend ? "-" : "+");
            if (field.function!=null) {
                r.append(field.function);
                r.append("(");
            }
            String name=null;
            if (clarionFile!=null) {
                ClarionString s_name = this.clarionFile.who(field.order);
                if (s_name!=null) name=s_name.toString();
            }
            if (name==null) name=field.object.getName();
            r.append(name);
            if (field.function!=null) r.append(")");
        }
        r.append("[").append(System.identityHashCode(this)).append("]");
        return r.toString();
    }
    
    public boolean equals(Object o)
    {
        if (o==this) return true;
        if (!(o instanceof ClarionKey)) return false;
        
        ClarionKey ck_o = (ClarionKey)o;
        if (ck_o.clarionFile!=this.clarionFile) return false;
        
        Order o_order[] = ck_o.getOrder();
        Order order[] = this.getOrder();
        
        if (order.length!=o_order.length) return false;
        for (int scan=0;scan<order.length;scan++) {
            if (!order[scan].equals(o_order[scan])) return false;
        }

        if (ck_o.isProperty(Prop.NOCASE) ^ this.isProperty(Prop.NOCASE) ) return false;
        
        return true;
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        // TODO Auto-generated method stub
        
    }
}
