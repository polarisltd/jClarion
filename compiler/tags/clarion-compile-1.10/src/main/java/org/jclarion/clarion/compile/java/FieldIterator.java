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
package org.jclarion.clarion.compile.java;

import java.util.Iterator;

import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.Variable;

public class FieldIterator implements Iterator<Variable>
{
    private Iterator<Variable> fields;
    private Variable match;
    
    public FieldIterator(Scope scope,Iterator<Variable> fields)
    {
        this.fields=fields;
        this.match=null;
    }

    @Override
    public boolean hasNext() {
        
        while ( match==null ) {
            if (!fields.hasNext()) return false;
            Variable t = fields.next();
            if (t instanceof EquateVariable) continue;
            match=t;
        }
        return true;
    }

    @Override
    public Variable next() {
        if (!hasNext()) return null;
        Variable ret = match;
        match=null;
        return ret;
    }

    @Override
    public void remove() {
    }
}
