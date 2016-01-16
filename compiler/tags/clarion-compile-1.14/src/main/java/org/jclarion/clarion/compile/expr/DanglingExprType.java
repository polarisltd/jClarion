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
package org.jclarion.clarion.compile.expr;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.scope.Scope;

public class DanglingExprType extends ExprType {

    private static Map<String,DanglingExprType> dangles=new HashMap<String, DanglingExprType>();
    
    public static void clean()
    {
        dangles.clear();
    }
    
    private String name;

    public static DanglingExprType find(String name)
    {
        return dangles.get(name.toLowerCase());
    }
    
    public static DanglingExprType get(String name)
    {
        DanglingExprType det = dangles.get(name.toLowerCase());
        if (det==null) {
            det=new DanglingExprType(name);
            dangles.put(name.toLowerCase(),det);
        }
        return det;
    }
    
    private DanglingExprType(String name)
    {
        this.name=name;
    }

    private ExprType real;
    
    public void fulfill(ExprType real)
    {
        if (real instanceof DanglingExprType) throw new IllegalArgumentException("Cannot fulfill a dangler with another dangler!");
        this.real=real;
    }
    
    public ExprType getReal()
    {
        return real;
    }
    
    @Override
    public void generateDefinition(StringBuilder out) {
        if (getReal()==null) {
            out.append("Object"); 
        } else {
            getReal().generateDefinition(out);
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        if (getReal()==null) return; 
        getReal().collate(collector);
    }

    @Override
    public Expr array(Expr in, Expr subscript) {
        return getReal().array(in, subscript);
    }

    @Override
    public Expr cast(Expr in) {
        return getReal().cast(in);
    }

    @Override
    public ExprType changeArrayIndexCount(int count) {
        return getReal().changeArrayIndexCount(count);
    }

    @Override
    public Expr field(Expr in, String field) {
        return getReal().field(in, field);
    }

    @Override
    public String generateDefinition() {
        return getReal().generateDefinition();
    }

    @Override
    public int getArrayDimSize() {
        if (getReal()==null) return 0;
        return getReal().getArrayDimSize();
    }

    @Override
    public String getName() {
        if (getReal()==null) return name;
        return getReal().getName();
    }

    @Override
    public boolean isa(ExprType test) {
        return getReal().isa(test);
    }

    @Override
    public boolean isRaw() {
        return getReal().isRaw();
    }

    @Override
    public boolean isSystem() {
        return getReal().isSystem();
    }

    @Override
    public Expr method(Expr in, String field, Expr[] params) {
        return getReal().method(in, field, params);
    }

    @Override
    public Expr property(Expr in, Expr[] keys) {
        if (getReal()==null) return null; 
        return getReal().property(in, keys);
    }

    @Override
    public boolean same(ExprType test) {
        
        
        if (getReal()==null) {
            if (test instanceof DanglingExprType) {
                return test.getName().equals(getName());
            }
            return false;
        }
        return getReal().same(test);
    }

    @Override
    public Expr splice(Expr in, Expr left, Expr right) {
        return getReal().splice(in, left, right);
    }

    @Override
    public String toString() {
        return name;
    }

    @Override
    public ExprType getBase() {
        return getReal().getBase();
    }

    @Override
    public Expr prototype(Expr in, String field) {
        return getReal().prototype(in,field);
    }

    @Override
    public Scope getDefinitionScope() {
        return getReal().getDefinitionScope();
    }

    @Override
    public Expr destroy(Expr in) {
        // TODO Auto-generated method stub
        return getReal().destroy(in);
    }

    @Override
    public boolean isDestroyable() {
        // TODO Auto-generated method stub
        return getReal().isDestroyable();
    }

}
