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
package org.jclarion.clarion.compile.hook;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.scope.Scope;

/**
 * Hooks are used for allowing java namespaces to merge and access namespaces defined in
 * clarion
 * 
 * For example Clarion defines interface TEST with method 
 *    a procedure(long)
 *    
 * A hook causes the resulting Java class to inherit a java defined function which
 * java can use to 'hook' into the clarion defined class. i.e. A hook may insert
 * following:
 * 
 *   public void aHook(ClarionNumber value)
 *   { 
 *       a(value);
 *   }
 *  
 * It allows java to call into clarion code. 
 * 
 * But hooks do not allow clarion code to build on, or hook into java code. See 
 * TypeSubstitiation if you want to do something like this.
 * 
 * @author barney
 */
public class HookFactory {

    private static HookFactory instance;
    
    public static HookFactory getInstance()
    {
        if (instance==null) instance=new HookFactory();
        return instance;
    }
    
    private HookFactory()
    {
        init();
    }
    
    private Map<String,HookEntry> entries=new HashMap<String, HookEntry>(); 
    
    public void addHook(HookEntry he)
    {
        entries.put(he.getLookupKey().toLowerCase(),he);
    }
    
    public HookEntry getHook(Scope s)
    {
        HookEntry he = entries.get(s.getName().toLowerCase());
        if (he==null) return null;
        if (he.matches(s)) return he;
        return null;
    }
    
    public void init()
    {
        addHook(HookEntry.create("Params","Main")
        .setHook(ClarionCompiler.CLARION+".hooks.FilecallbackParams"));

        addHook(HookEntry.create("FilecallbackInterface","Main")
        .setHook(ClarionCompiler.CLARION+".hooks.Filecallbackinterface")
        .setContents(
          "      @Override\n",
          "      public void functionCalled(ClarionNumber newNumber,\n",
          "              $clarion$.hooks.FilecallbackParams params, ClarionString newString,\n",
          "              ClarionString newString2) {\n",

          "          functionCalled(newNumber,($type:params$)params,newString,newString2);\n",
          "      }\n",

          "      @Override\n",
          "      public void functionDone(ClarionNumber newNumber,\n",
          "              $clarion$.hooks.FilecallbackParams params, ClarionString newString,\n",
          "              ClarionString newString2) {\n",
          "          functionDone(newNumber,($type:params$)params,newString,newString2);\n",
          "      }\n"
        )
        );
    }
}
