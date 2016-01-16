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

/**
 * Block of java code that is influenced by break/continue statements
 * 
 * @author barney
 *
 */
public class LoopJavaCode extends JavaCode
{
    private boolean infinite;
    private JavaCode block;
    
    /**
     * 
     * @param infinite if true then loop is infinite 
     * and will never end unless there is a definite break statement 
     */
    public LoopJavaCode(JavaCode block,boolean infinite)
    {
        this.infinite=infinite;
        this.block=block;
    }
    
    

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) {
        block.write(out,indent,unreachable);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        block.collate(collector);
    }


    @Override
    public boolean utilises(Set<Variable> vars) {
        return block.utilises(vars);
    }
    
    @Override
    public boolean utilisesReferenceVariables()
    {
        return block.utilisesReferenceVariables();
    }
    
    
    @Override
    public boolean isCertain(JavaControl control) {
        
        if (control==JavaControl.END) {
            if (infinite && !block.isPossible(JavaControl.BREAK)) {
                return true;
            }
            return false;
        }

        if (control==JavaControl.BREAK) {
            return false;
        }
        
        if (control==JavaControl.CONTINUE) {
            return false;
        }
     
        if (control==JavaControl.RETURN) {
            if (infinite &&
                !block.isPossible(JavaControl.BREAK) &&
                block.isPossible(JavaControl.RETURN)) 
            {
                return true;
            }
            return false;
        }
        
        throw new IllegalArgumentException("How did I get here?");
    }



    @Override
    public boolean isPossible(JavaControl control) {

        if (control==JavaControl.END) {
            // generally should never get called
            return isCertain(control);  
        }

        if (control==JavaControl.BREAK) {
            return false;
        }
        
        if (control==JavaControl.CONTINUE) {
            return false;
        }
     
        if (control==JavaControl.RETURN) {
            if (infinite && !block.isCertain(JavaControl.RETURN)) {
                return true;
            }
            return false;
        }
   
        throw new IllegalArgumentException("How did I get here?");
    }


}
