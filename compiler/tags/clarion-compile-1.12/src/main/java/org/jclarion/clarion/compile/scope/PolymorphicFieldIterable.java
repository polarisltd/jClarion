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
package org.jclarion.clarion.compile.scope;

import java.util.Iterator;
import java.util.LinkedList;

import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.util.FilteredIterator;
import org.jclarion.clarion.util.JoinedIterator;

public class PolymorphicFieldIterable implements Iterable<Variable>
{
    private PolymorphicScope scope;
    
    public PolymorphicFieldIterable(PolymorphicScope scope)
    {
        this.scope=scope;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public Iterator<Variable> iterator() {
        
        LinkedList<Iterator<Variable>> scopes = new LinkedList<Iterator<Variable>>();
        
        PolymorphicScope scan = scope;
        while (scan!=null) {
            scopes.addFirst(new PFilter(this.scope.getScope(),scan.getScope()));
            scan=scan.getBase();
        }
        
        return new JoinedIterator<Variable>((Iterator[])scopes.toArray(new Iterator[scopes.size()]));
    }
    
    private static class PFilter extends FilteredIterator<Variable>
    {
        private Scope top;
        
        public PFilter(Scope top,Scope base)
        {
            super(base.getVariables().iterator());
            this.top=top;
        }
        
        @Override
        public boolean filter(Variable value) {
            Variable fromTop = top.getVariableThisScopeOnly(value.getName());
            if (fromTop==value) return false;
            return true;
        }
    }
}
