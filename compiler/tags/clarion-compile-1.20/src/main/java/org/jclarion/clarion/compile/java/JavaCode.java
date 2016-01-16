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

/**
 * Model java source code
 * 
 * One key function of this object graph is to track reachability of
 * code. Clarion code doesn't enforce reachability checks but java
 * certainly does.
 * 
 * The implementation tracks reachability by carefully tracking whether
 * one of the following four given operations is either certain to happen,
 * may happen or most certainly will not happen. Those operations being
 *     * return;
 *     * break;
 *     * continue;
 *  
 * The forth one is special - 'end'. It tracks whether control flow will
 * fall through it and onto next sequentual statement (if concept of a
 * sequentual statement even applies at this point). 
 * 
 * The implementation currently suffers the following limitations
 * 
 * a) it will not evaluate constant expressions like "if (1==1)" or
 * "while (1==1)"
 * 
 * b) it will not handle labelled breakpoints. continue/break are
 *    assumed to always continue/break the one loop they are in only
 *    and not possibly continue/break loop statements higher up
 * 
 * c) goto statements are not handled
 * 
 * @author barney
 */

public abstract class JavaCode implements JavaDependency,VariableUtiliser
{
    private boolean noPriorLine;
    private boolean noNewLine;
    
    public void setNoPriorLine()
    {
        noPriorLine=true;
    }

    public void setNoNewLine()
    {
        noNewLine=true;
    }
    
    protected void preWrite(StringBuilder out)
    {
        if (noPriorLine) {
            if (out.length()>0) {
                if (out.charAt(out.length()-1)=='\n') {
                    out.setLength(out.length()-1);
                }
            }
        }
    }
    
    protected void postWrite(StringBuilder out)
    {
        if (!noNewLine) out.append('\n');
    }
    
    protected void writeIndent(StringBuilder out,int indent,boolean unreachable)
    {
        if (out.length()>0) {
            if (out.charAt(out.length()-1)!='\n') indent=0;
        }
        while (indent>0) {
            out.append('\t');
            indent--;
        }
        
        if (unreachable) {
            out.append("// UNREACHABLE! :");
        }
    }

    public String write(int indent,boolean unreachable)
    {
        StringBuilder o = new StringBuilder();
        write(o,indent,unreachable);
        return o.toString();
    }
    
    public abstract void write(StringBuilder out,int indent,boolean unreachable);
    
    /**
     * Returns true if given control setting is certain outcome of this call
     * @param control
     * @return
     */
    public boolean isCertain(JavaControl control)
    {
        return false;
    }

    /**
     * Returns true if given control setting is possible outcome of this call
     * @param control
     * @return
     */
    public boolean isPossible(JavaControl control)
    {
        return isCertain(control);
    }
}
