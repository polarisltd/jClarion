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
package org.jclarion.clarion.compile.setting;

public class SettingResult<T> 
{
    private String name;
    private T value;

    public SettingResult(String name)
    {
        this.name=name;
    }
    
    public SettingResult<T> setValue(T value)
    {
        this.value=value;
        return this;
    }
    
    
    public SettingResult(String name,T value)
    {
        this.name=name;
        this.value=value;
    }
    
    public String getName()
    {
        return name;
    }
    
    public T getValue()
    {
        return value;
    }
    
    public static Object get(SettingResult<?> bits[],String key)
    {
        for (int scan=0;scan<bits.length;scan++) {
            if (bits[scan].name.equals(key)) return bits[scan].value;
        }
        return null;
    }
}
