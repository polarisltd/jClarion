package org.jclarion.clarion.compile.java;

import java.util.Set;

import org.jclarion.clarion.compile.var.Variable;

public class FinalizeBlock extends JavaCode
{
    private JavaCode tryBlock;
    private JavaCode finalizeBlock;

    public FinalizeBlock(JavaCode tryBlock,JavaCode finalizeBlock)
    {
        this.tryBlock=tryBlock;
        this.finalizeBlock=finalizeBlock;
    }

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) 
    {
        writeIndent(out,indent,unreachable);
        out.append("try {\n");
        tryBlock.write(out,indent+1,unreachable);
        writeIndent(out,indent,unreachable);
        out.append("} finally {\n");
        finalizeBlock.write(out,indent+1,unreachable);
        writeIndent(out,indent,unreachable);
        out.append("}\n");
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        tryBlock.collate(collector);
        finalizeBlock.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        if (tryBlock.utilises(vars)) return true;
        if (finalizeBlock.utilises(vars)) return true;
        return false;
    }

    @Override
    public boolean utilisesReferenceVariables() {
        if (tryBlock.utilisesReferenceVariables()) return true;
        if (finalizeBlock.utilisesReferenceVariables()) return true;
        return false;
    }

    @Override
    public boolean isCertain(JavaControl control) {
        return tryBlock.isCertain(control);
    }

    @Override
    public boolean isPossible(JavaControl control) {
        return tryBlock.isPossible(control);
    }
}
