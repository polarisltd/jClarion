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
import org.jclarion.clarion.compile.var.Variable;

public class FieldIterable implements Iterable<Variable>
{
    private Scope scope;
    private Iterable<Variable> fields;

    public FieldIterable(Scope scope,Iterable<Variable> fields)
    {
        this.scope=scope;
        this.fields=fields;
    }
    
    @Override
    public Iterator<Variable> iterator() {
        return new FieldIterator(scope,fields.iterator()); 
    }
}
