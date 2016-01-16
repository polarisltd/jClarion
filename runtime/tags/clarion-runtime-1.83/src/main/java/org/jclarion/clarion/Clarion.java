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

import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.ref.RefVariable;

/**
 * Helper entry point for construction of objects etc. 
 * 
 * @author barney
 */
public class Clarion 
{
    public static ClarionKey newKey(String label)
    {
        return new ClarionKey(label);
    }

    public static ClarionBool newBool()
    {
        return new ClarionBool();
    }

    public static ClarionBool newBool(int val)
    {
        return new ClarionBool(val);
    }

    public static ClarionBool newBool(boolean val)
    {
        return new ClarionBool(val);
    }
    
    
    public static ClarionNumber newNumber()
    {
        return new ClarionNumber();
    }

    public static ClarionReal newReal()
    {
        return new ClarionReal(0);
    }

    public static ClarionNumber newNumber(int value)
    {
        return new ClarionNumber(value);
    }

    public static ClarionNumber newNumber(boolean value)
    {
        return new ClarionNumber(value?1:0);
    }

    public static ClarionNumber newNumber(String value)
    {
        return new ClarionNumber(value);
    }

    public static ClarionDecimal newDecimal()
    {
        return new ClarionDecimal();
    }

    public static ClarionDecimal newDecimal(int value)
    {
        return new ClarionDecimal(value);
    }

    public static ClarionDecimal newDecimal(int size,int precision)
    {
        return new ClarionDecimal(size,precision);
    }

    public static ClarionDecimal newDecimal(int size,int precision,Object value)
    {
        return new ClarionDecimal(size,precision,value);
    }

    public static ClarionDecimal newDecimal(String value)
    {
        return new ClarionDecimal(value);
    }

    public static ClarionAny newAny()
    {
        return new ClarionAny();
    }
    
    public static ClarionString newString()
    {
        return new ClarionString();
    }

    public static ClarionString newString(int size)
    {
        return new ClarionString(size);
    }

    public static ClarionString newString(String content)
    {
        return new ClarionString(content);
    }
    
    public static ClarionString newString(ClarionObject init)
    {
        if (init instanceof ClarionNumber) {
            return newString(init.intValue());
        } else {
            return new ClarionString(init.toString());
        }
    }
    
    /**
     *  Get window target
     * @return
     */
    public static AbstractWindowTarget getWindowTarget()
    {
        return CWin.getInstance().getTarget();
    }
    
    public static PropertyObject getControl(Object control)
    {
        ClarionObject co = Clarion.getClarionObject(control);
        if (co!=null) return getControl(co);
        throw new RuntimeException("Not yet implemented");
    }

    public static PropertyObject getControl(int control)
    {
        return CWin.getControl(control);
    }

    /**
     *  Get current control based on target setting
     * @param control
     * @return
     */
    public static PropertyObject getControl(ClarionObject control)
    {
        return CWin.getControl(control);
    }
    
    public static ClarionObject getClarionObject(Object o) {
        if (o == null) return null;
        
        if (o instanceof ClarionObject) return (ClarionObject)o;
        if (o instanceof String) {
            return new ClarionString((String)o);
        }
        if (o instanceof java.math.BigDecimal) {
            return new ClarionDecimal((java.math.BigDecimal)o);
        }
        if (o instanceof Number) {
            return new ClarionNumber(((Number)o).intValue());
        }
        if (o instanceof Boolean) {
            return new ClarionBool(((Boolean)o).booleanValue());
        }
        if (o instanceof ClarionGroup) {
            ((ClarionGroup)o).getString();
        }
        if (o instanceof RefVariable<?>) {
        	return getClarionObject(((RefVariable<?>)o).get());
        }
        
        return new ClarionString(o.toString());
    }
}
