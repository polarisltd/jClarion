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
package org.jclarion.clarion.runtime;

import org.jclarion.clarion.ClarionObject;

/**
 * Special type of bind - it is a SQLFile parameter
 * which has a known SQL column name and SQL column type 
 * 
 * @author barney
 */

public class ViewObjectBindProcedure extends ObjectBindProcedure
{
    public String          sqlColumn;
    public int             sqlType;
    private ClarionObject value;  // keep it for toString use
        
    public ViewObjectBindProcedure(ClarionObject value,String sqlColumn,int sqlType) {
        super(value);
        this.sqlColumn=sqlColumn;
        this.sqlType=sqlType;
        this.value=value;
    }

    public String toString(){
    	return this.getClass().getName()+""+sqlColumn+":"+sqlType+":"+value;
    }
}
