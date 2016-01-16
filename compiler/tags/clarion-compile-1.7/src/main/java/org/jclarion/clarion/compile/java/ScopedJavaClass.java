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

import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.StaticScope;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.util.JoinedIterable;

public class ScopedJavaClass extends JavaClass 
{
    private Scope scope;
    private String pkg;
    
    public ScopedJavaClass(Scope c,String pkg)
    {
        this.scope=c;
        this.pkg=pkg;
        c.setJavaClass(this);
    }


    @SuppressWarnings("unchecked")
    @Override
    public Iterable<Variable> getFields() {
        
        Iterable<Variable> bits;
        if (scope instanceof StaticScope) {
            bits=new JoinedIterable<Variable>(scope.getVariables(),((StaticScope)scope).getStaticVarIterable());
        } else {
            bits= scope.getVariables();
        }

        return new FieldIterable(scope,bits);
    }

    
    public static class ProcedureIterator implements Iterator<Procedure>
    {
        private Iterator<Procedure> proc;
        private Procedure match;
        private Scope scope;
        
        public ProcedureIterator(Iterator<Procedure> proc,Scope scope)
        {
            this.proc=proc;
            this.match=null;
            this.scope=scope;
        }

        @Override
        public boolean hasNext() {
            
            while ( match==null ) {
                if (!proc.hasNext()) return false;
                Procedure t = proc.next();
                if (t.getScope()!=scope) continue;
                match=t;
            }
            return true;
        }

        @Override
        public Procedure next() {
            if (!hasNext()) return null;
            Procedure ret = match;
            match=null;
            return ret;
        }

        @Override
        public void remove() {
        }
    }
    
    @Override
    public Iterable<Procedure> getMethods() {
        return new Iterable<Procedure>() {
            @Override
            public Iterator<Procedure> iterator() {
                return new ProcedureIterator(scope.getProcedures().iterator(),scope);
            } };
    }

    @Override
    public String getPackage() {
        return pkg;
    }

    @Override
    public void appendFieldModifier(StringBuilder out) {
        out.append("static ");
    }
    
    public Scope getScope()
    {
        return scope;
    }
    
}
