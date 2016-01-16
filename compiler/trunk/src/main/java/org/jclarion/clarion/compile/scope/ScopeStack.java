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

import org.jclarion.clarion.compile.ClarionCompiler;

public class ScopeStack 
{
    private Scope scope=null;
    private MainScope main;
    
    Scope firstDisorderedScope;
    Scope lastDisorderedScope;
    boolean disorderInsertAllowed=true;
	private ClarionCompiler compiler;
    
    
    public ScopeStack(ClarionCompiler compiler)
    {
    	this.compiler=compiler;
    }
    
    public ClarionCompiler compiler()
    {
    	return compiler;
    }
    
    public void fixDisorderedScopes()
    {
    	disorderInsertAllowed=false;
    	Scope scan = firstDisorderedScope;
    	while (scan!=null) {
    		scan.fixDisorder();
    		scan=scan.nextDisorderedScope;
    	}
    	disorderInsertAllowed=true;
    	firstDisorderedScope=null;
    	lastDisorderedScope=null;
    }
    
	public void setMain(MainScope mainScope) 
	{
		this.main=mainScope;
	}    
    
    public Scope getScope()
    {
        if (scope==null) return main;
        return scope;
    }
    
    public String BASE()
    {
    	return getScope().getPackage();
    }
    
    public void pushScope(Scope scope)
    {
        scope.setParent(getScope());
        this.scope=scope;
    }

    public void setScope(Scope scope)
    {
    	this.scope=scope;
    }

    public void popScope()
    {
        if (scope==null) throw new IllegalStateException("Want to pop scope to null");
        scope=scope.getStackParent();
    }

    public void clearScope()
    {
        scope=null;
    }

}
