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

import org.jclarion.clarion.compile.scope.Scope;

public class InterfaceImplementationConstruct extends Scope 
{
    private InterfaceConstruct base;
    private ClassConstruct owner;
    
    public InterfaceImplementationConstruct(InterfaceConstruct base,ClassConstruct owner)
    {
        this.base=base;
        this.owner=owner;
    }
    
    public InterfaceConstruct getBaseInterface()
    {
        return base;
    }
    
    public ClassConstruct getOwnerClass()
    {
        return owner;
    }
    
    @Override
    public String getName()
    {
        return base.getName();
    }
    
}
