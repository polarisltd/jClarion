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

public class ScopeStack 
{
    private static Scope scope=null;
    
    public static Scope getScope()
    {
        if (ScopeStack.scope==null) return MainScope.main;
        return ScopeStack.scope;
    }
    
    public static void pushScope(Scope scope)
    {
        scope.setParent(getScope());
        ScopeStack.scope=scope;
    }

    public static void setScope(Scope scope)
    {
        ScopeStack.scope=scope;
    }

    public static void popScope()
    {
        if (ScopeStack.scope==null) throw new IllegalStateException("Want to pop scope to null");
        ScopeStack.scope=ScopeStack.scope.getStackParent();
    }

    public static void clearScope()
    {
        ScopeStack.scope=null;
    }
}
