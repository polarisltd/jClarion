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

import java.util.Set;

import org.jclarion.clarion.compile.var.Variable;

public interface VariableUtiliser {
    /**
     * Does this dependency component require utilisation of any
     * of the specified variables?
     * 
     * This method is used to assist with re-sorting of variable definition
     * to help resolve issues where we need to push down a variable into
     * deeper scope but definition within parent scope is after structure
     * that requires the push
     *  
     * @param vars
     * @return
     */
    public abstract boolean utilises(Set<Variable> vars);
    
    public abstract boolean utilisesReferenceVariables();
}
