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

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.Variable;

public class EquateClass extends JavaClass {

    private Map<String,Variable> fields = new LinkedHashMap<String, Variable>();
    
    private String pkg;
    
    public EquateClass(String pkg,String name)
    {
        setName(name);
        this.pkg=pkg;
    }
    
    @Override
    public Iterable<Variable> getFields() {
        return fields.values();
    }

    @Override
    public Iterable<Procedure> getMethods() {
        return new ArrayList<Procedure>(0);
    }

    @Override
    public String getPackage() {
        return pkg;
    }

    @Override
    public void appendFieldModifier(StringBuilder out) {
        out.append("static final ");
    }

    public void addVariable(EquateVariable equateVariable) {
        fields.put(equateVariable.getName().toLowerCase(),equateVariable);
    }

    @Override
    protected void buildConstructor(StringBuilder main,
            JavaDependencyCollector collector) {
        // TODO Auto-generated method stub
        
    }
}
