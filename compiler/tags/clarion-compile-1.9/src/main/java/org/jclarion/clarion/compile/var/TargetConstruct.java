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
package org.jclarion.clarion.compile.var;


import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.scope.Scope;

public class TargetConstruct extends Scope 
{
    private TargetJavaClass clazz;
    private ClassedVariable var;
    private ExprType        basetype;
    private TargetExprType  type;

    public TargetConstruct(String label,ExprType basetype)
    {
        this.basetype=basetype;
        
        clazz=new TargetJavaClass(this);
        ClassRepository.add(clazz,label);
        
        type = new TargetExprType(clazz.getName(),basetype,this); 
        
        var=new ClassedVariable(label,type,clazz,false,false,false);
        var.setTargetImplementingScope(this);
    }
    
    public TargetJavaClass getJavaClass()
    {
        return clazz;
    }

    public ExprType getBaseType()
    {
        return basetype; 
    }
    
    public ExprType getType()
    {
        return type;
    }
    
    public Variable getVariable()
    {
        return var;
    }
 
    private int controlID;
    
    public int getNextControlID()
    {
        return ++controlID;
    }
    
    @Override
    public String getName()
    {
        return getType().getName();
    }
}
