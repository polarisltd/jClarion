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

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.var.Variable;

public class BlockJavaCode extends JavaCode 
{
    private Expr        in;
    private JavaCode    block;
    
    public BlockJavaCode(JavaCode block)
    {
        this.block=block;
    }
    
    public BlockJavaCode(String in,JavaCode block)
    {
        this(new SimpleExpr(JavaPrec.LABEL,null,in),block);
    }
    
    public BlockJavaCode(Expr in,JavaCode block)
    {
        this.in=in;
        this.block=block;
    }

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) 
    {
        preWrite(out);
        writeIndent(out,indent,unreachable);
        if (in!=null) {
            in.toJavaString(out);
            out.append(" {");
        } else {
            out.append("{");
        }
        postWrite(out);
        
        block.write(out,indent+1,unreachable);
        
        preWrite(out);
        writeIndent(out,indent,unreachable);
        out.append("}");
        postWrite(out);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        block.collate(collector);
        if (in!=null) in.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        if (block.utilises(vars)) return true;
        if (in!=null && in.utilises(vars)) return true;
        return false;
    }
    
    public boolean utilisesReferenceVariables()
    {
        if (block.utilisesReferenceVariables()) return true;
        if (in!=null && in.utilisesReferenceVariables()) return true;
        return false;
    }
    
    @Override
    public boolean isCertain(JavaControl control) {
        return block.isCertain(control);
    }

    @Override
    public boolean isPossible(JavaControl control) {
        return block.isPossible(control);
    }

}
