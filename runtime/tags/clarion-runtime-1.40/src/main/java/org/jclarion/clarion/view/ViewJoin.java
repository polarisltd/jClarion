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
package org.jclarion.clarion.view;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionObject;

public class ViewJoin
{
    List<ViewJoin>      joins=new ArrayList<ViewJoin>();
    List<ViewProject>   fields=new ArrayList<ViewProject>();
    ClarionFile         table;
    
    ClarionKey          joinKey;
    ClarionObject       joinKeyFields[];
    
    String              joinExpression;
    
    boolean             inner;
    
    public void add(ViewJoin aTable)
    {
        joins.add(aTable);
    }
    
    public void add(ViewProject aProject)
    {
        fields.add(aProject);
    }
    
    public void setTable(ClarionFile aFile) 
    {
        this.table=aFile;
    }
    
    public ViewJoin setKey(ClarionKey key) {
        this.joinKey=key;
        return this;
    }
    
    public ViewJoin setFields(ClarionObject fields[]) {
        this.joinKeyFields=fields;
        return this;
    }
    
    public ViewJoin setInnerJoin()
    {
        this.inner=true;
        return this;
    }

    public ViewJoin setJoinExpression(String aExpression)
    {
        this.joinExpression=aExpression;
        return this;
    }
    
}
