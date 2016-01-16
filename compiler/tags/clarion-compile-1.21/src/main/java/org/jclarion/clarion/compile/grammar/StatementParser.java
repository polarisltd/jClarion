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
package org.jclarion.clarion.compile.grammar;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.CallExpr;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.ExprTypeExpr;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.JoinExpr;
import org.jclarion.clarion.compile.expr.PotentialAssignmentExpr;
import org.jclarion.clarion.compile.expr.ReturningExpr;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.SystemCallExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.*;
import org.jclarion.clarion.compile.scope.PolymorphicScope;
import org.jclarion.clarion.compile.scope.ReturningScope;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

/**
 * Construct java code blocks & statements
 * 
 * @author barney
 */
public class StatementParser extends AbstractParser {
    private static Set<String> nonStatementLabels = GrammarHelper.list(
            "procedure", "function", "routine");

    public StatementParser(Parser parser) {
        super(parser);
    }

    public JavaCode code() {
        JavaCode block = block();

        // if there is not certain return result
        // and it is not certain that end is enforced
        
        if (!block.isCertain(JavaControl.RETURN)
                && !block.isCertain(JavaControl.END)) {
            Scope s = ScopeStack.getScope();
            ReturningExpr ret = null;
            if ((s instanceof ReturningScope) && !(s instanceof RoutineScope)) {
                ret = ((ReturningScope) s).getReturnValue();
            }
            if (ret != null) {
                JavaCode result = returnStatement(null, ret);
                LinearJavaBlock ljb = new LinearJavaBlock();
                ljb.add(block);
                ljb.add(result);
                block = ljb;
            }

        }
        return block;
    }

    private JavaCode block() {
        LinearJavaBlock block = new LinearJavaBlock();

        while (true) {
            JavaCode stmt = statement();
            if (stmt == null)
                break;
            emptyEnd();
            block.add(stmt);
        }
        return block;
    }
    
    private int decodeHexit(char c)
    {
        if (c>='0' && c<='9') return c-'0';
        if (c>='a' && c<='f') return c-'a'+10;
        if (c>='A' && c<='F') return c-'A'+10;
        return 0;
    }

    private JavaCode statement() {
        int pos = begin();

        boolean newline = !isIgnoreWhiteSpace();

        String label = null;
        JavaCode result = null;

        if (newline) {
            if (la().type == LexType.label) {
                label = parser().var.variableLabel();
            }
            if (la().type != LexType.ws) {
                rollback(pos);
                return null;
            }
            setIgnoreWhiteSpace(true);
        }

        if (result == null && la().type == LexType.semicolon) {
            next();
            commit(pos);
            result = new EmptyJavaCode();
        }

        if (la().type==LexType.java) {
            if (la().value.equals("@java-dependency")) {
                commit(pos);
                next();
                Lex dep = next();
                if (dep.type!=LexType.string) error("Expected string");
                return new SimpleJavaCode("",dep.value.substring(1,dep.value.length()-1));
            }
            if (la().value.equals("@java-code")) {
                commit(pos);
                next();
                Lex code = next();
                if (code.type!=LexType.string) error("Expected string");
                Expr[] params;
                if (la().type==LexType.lparam) {
                    next();
                    params = parser().expressionList(LexType.rparam);
                    if (next().type!=LexType.rparam) error("Expected ')'");
                } else {
                    params=new Expr[0];
                }

                JavaControl jc[]=null;
                if (la().type==LexType.param) {
                    
                    List<JavaControl> jc_list = new ArrayList<JavaControl>();
                    while (la().type==LexType.param) {
                        next();
                        if (la().type!=LexType.label) error("Expected label");
                        JavaControl newControl = JavaControl.valueOf(next().value);
                        jc_list.add(newControl);
                    }
                    
                    jc=new JavaControl[jc_list.size()];
                    jc_list.toArray(jc);
                }
                
                StringBuilder deformatted = new StringBuilder();
                String javacode = code.value.substring(1,code.value.length()-1);
                int deformatScan=0;
                while (deformatScan<javacode.length()) {
                    char c = javacode.charAt(deformatScan++);
                    if (c=='\\') {
                        char c2 = javacode.charAt(deformatScan++);
                        if (c2=='"' || c2=='\\') {
                            c=c2;
                        }
                        if (c2=='n') c='\n';
                        if (c2=='r') c='\r';
                        if (c2=='u') {
                            javacode.charAt(deformatScan++);
                            javacode.charAt(deformatScan++);
                            char b3=javacode.charAt(deformatScan++);
                            char b4=javacode.charAt(deformatScan++);
                            c=(char)((decodeHexit(b3)<<4)+decodeHexit(b4));
                        }
                    }
                    deformatted.append(c);
                }
                javacode=deformatted.toString();
                
                
                // splice it
                ExprBuffer buffer = new ExprBuffer(JavaPrec.LABEL,null);
                int next_param=0;
                int code_pos=0;
                
                while (next_param<params.length) {
                    int next = javacode.indexOf('$',code_pos);
                    if (next==-1) break;
                    
                    buffer.add(javacode.substring(code_pos,next));
                    code_pos=next+1;
                    buffer.add(params[next_param++]);
                }
                buffer.add(javacode.substring(code_pos));

                ExprJavaCode ejc = new ExprJavaCode(buffer);
                
                if (jc!=null) {
                    ejc.setCertain(jc);
                }
                return ejc;
            }
        }
        
        boolean implicit = la(1).type==LexType.implicit;
        
        
        if (result == null && !implicit && la().value.equalsIgnoreCase("if")) {
            commit(pos);
            result = ifStatement();
        }

        if (result == null && !implicit  && la().value.equalsIgnoreCase("case")) {
            commit(pos);
            result = caseStatement();
        }

        if (result == null && !implicit  && la().value.equalsIgnoreCase("loop")) {
            commit(pos);
            result = loopStatement(label);
            if (result!=null) {
            	label=null;
            }
        }

        if (result == null && !implicit  && la().value.equalsIgnoreCase("begin")) {
            commit(pos);
            next();
            emptyAll();
            result = block();
            end();
        }

        if (result == null && !implicit  && la().value.equalsIgnoreCase("execute")) {
            commit(pos);
            result = executeStatement();
        }

        if (result == null && !implicit  && la().value.equalsIgnoreCase("accept")) {
            commit(pos);
            next();

            emptyEnd();
            JavaCode blocks = block();
            emptyEnd();
            end();

            LinearJavaBlock base = new LinearJavaBlock();
            base.add(blocks);
            base.add(new SimpleJavaCode(
                    "Clarion.getWindowTarget().consumeAccept();",
                    ClarionCompiler.CLARION + ".Clarion"));
            result = new BlockJavaCode(
                    "while (Clarion.getWindowTarget().accept())", base);
        }

        // start - starting a new thread
        if (result == null && !implicit  && la().value.equalsIgnoreCase("start") && la(1).type==LexType.lparam) {
            int spos=begin();
            next();
            next();
            
            String start_label = next().value;

            if (la().type==LexType.param) {
                next();
                parser().expression();
            }

            Expr params[]=null;
            
            if (la().type==LexType.param) {
                next();
                params=parser().expressionList(LexType.rparam);
            } else {
                params=new Expr[0];
            }
            
            if (next().type==LexType.rparam) {

                Expr[] fparams=new Expr[params.length];
                for (int scan=0;scan<fparams.length;scan++) {
                    fparams[scan]=new SimpleExpr(JavaPrec.LABEL,params[scan].type(),"_f"+scan);
                }
                
                Expr e = parser().expr.callProcedure(start_label,fparams,false);
                if (e!=null) {
                    
                    LinearJavaBlock ljb=new LinearJavaBlock();
                    for (int scan=0;scan<params.length;scan++) {
                        ExprBuffer eb = new ExprBuffer(JavaPrec.LABEL,null);
                        eb.add("final ");
                        eb.add(new ExprTypeExpr(params[scan].type()));
                        eb.add(" _f");
                        eb.add(String.valueOf(scan));
                        eb.add("=");
                        eb.add(params[scan]);
                        eb.add(";");
                        ljb.add(new ExprJavaCode(eb));
                    }
                    
                    ExprBuffer bcall = new ExprBuffer(JavaPrec.LABEL,null);
                    bcall.add("CRun.start(new Runnable() { public void run() { ");
                    bcall.add(e);
                    bcall.add("; } } );");
                    Expr call=bcall;
                    call=new DependentExpr(call,ClarionCompiler.CLARION+".runtime.CRun");
                    
                    ljb.add(new ExprJavaCode(call));
                    
                    commit(spos);
                    commit(pos);
                    result = new BlockJavaCode(ljb); 
                }
            }
            
            if (result==null) {
                rollback(spos);
            }
        }
        
        
        // return statements
        if (result == null && !implicit  && la().value.equalsIgnoreCase("return")) {
            commit(pos);
            result = returnStatement();
        }

        // exit statement
        if (result == null && !implicit  && la().value.equalsIgnoreCase("exit")) {
            commit(pos);
            next();
            if (!(ScopeStack.getScope() instanceof RoutineScope))
                error("Exit can only be called within a routine");
            result = (new SimpleJavaCode("return;")).setCertain(
                    JavaControl.END, JavaControl.RETURN);
        }

        // proc call
        if (result == null && !implicit  && la().value.equalsIgnoreCase("do")) {
            commit(pos);
            result = routineStatement();
        }

        // break statement
        if (result == null && !implicit  && la().value.equalsIgnoreCase("break")) {
            commit(pos);
            next();
            String break_label = parser().var.variableLabel();
            if (break_label != null) {
                result = (new SimpleJavaCode("break "
                        + Labeller.get(break_label, false) + ";").setCertain(
                        JavaControl.BREAK, JavaControl.END));
            } else {
                result = (new SimpleJavaCode("break;").setCertain(
                        JavaControl.BREAK, JavaControl.END));
            }
        }

        // cycle statement
        if (result == null && !implicit  && la().value.equalsIgnoreCase("cycle")) {
            commit(pos);
            next();
            String break_label = parser().var.variableLabel();
            if (break_label != null) {
                result = (new SimpleJavaCode("continue "
                        + Labeller.get(break_label, false) + ";").setCertain(
                        JavaControl.CONTINUE, JavaControl.END));
            } else {
                result = (new SimpleJavaCode("continue;").setCertain(
                        JavaControl.CONTINUE, JavaControl.END));
            }
        }

        // last resort - fetch an expression
        // if result is variable - check for assignments
        // if result is procedure call - good as is
        // if result is potential assignment expr - recast it as an assignment
        if (result == null //&& la().type == LexType.label
                && !nonStatementLabels.contains(la().value.toLowerCase())) {
            
            Expr e = parser().expression();
            
            if (e != null) {

                if (e instanceof CallExpr) {
                    commit(pos);
                    result = new ExprJavaCode(new DecoratedExpr(JavaPrec.LABEL,
                            e, ";"));
                }

                if (e instanceof SystemCallExpr) {
                    commit(pos);
                    result = new ExprJavaCode(new DecoratedExpr(JavaPrec.LABEL,
                            e, ";"));
                }

                if (e instanceof PotentialAssignmentExpr) {
                    commit(pos);
                    result = new ExprJavaCode(((PotentialAssignmentExpr) e).getAssignExpr());
                }

                if ((e instanceof VariableExpr)
                        && (la().type == LexType.assign)) {
                    commit(pos);
                    String assignType = next().value;

                    Expr right = parser().expression();

                    if (assignType.equals(":=:")) {
                        result = assignComplexScope(e,right);
                    }

                    if (assignType.equals("+=")) {
                        result = new ExprJavaCode(new JoinExpr(
                                JavaPrec.POSTFIX, null, e, ".increment(",
                                right, ");"));
                    }

                    if (assignType.equals("-=")) {
                        result = new ExprJavaCode(new JoinExpr(
                                JavaPrec.POSTFIX, null, e, ".decrement(",
                                right, ");"));
                    }

                    if (result == null) {
                        if (assignType.equals("%="))
                            assignType = ".modulus(";
                        if (assignType.equals("/="))
                            assignType = ".divide(";
                        if (assignType.equals("*="))
                            assignType = ".multiply(";
                        if (assignType.equals("^="))
                            assignType = ".power(";

                        right = new JoinExpr(JavaPrec.POSTFIX, ExprType.any, e,
                                assignType, right, ")");

                        result = new ExprJavaCode(new JoinExpr(
                                JavaPrec.POSTFIX, null, e, ".setValue(", right,
                                ");"));
                    }
                }

                if ((e instanceof VariableExpr) && (result==null)) {
                    Expr ne=parser().expr.callProcedure(
                        ((VariableExpr)e).getVariable().getName(),
                        new Expr[0],false);
                    if (ne!=null) {
                        commit(pos);
                        result = new ExprJavaCode(new DecoratedExpr(JavaPrec.LABEL,
                                ne, ";"));
                    }
                }
                
                if (result == null) {
                    error("Undefined Naked Expression");
                }
            }
        }

        if (result == null) {
            rollback(pos);
            if (newline)
                setIgnoreWhiteSpace(false);
        } else {
            if (label != null) {
                LinearJavaBlock labelledCode = new LinearJavaBlock();
                labelledCode.add(new SimpleJavaCode(Labeller.get(label, false)
                        + ":"));
                labelledCode.add(result);
                result = labelledCode;
            }
        }
        return result;
    }

    private JavaCode assignComplexScope(Expr left, Expr right) {

        if (left.type().getArrayDimSize()>0 && right.type().getArrayDimSize()>0) {
            String loop = ScopeStack.getScope().createTemporaryLabel("_arr_scan");

            SimpleExpr eloop = new SimpleExpr(JavaPrec.LABEL,ExprType.rawint,loop);
            
            JavaCode jc = assignComplexScope(
                left.type().array(left,eloop),
                right.type().array(right,eloop));
            if (jc==null) return null;

            ExprBuffer forloop = new ExprBuffer(JavaPrec.LABEL,null);
            forloop.add("for (int ").add(loop).add("=1;");
            forloop.add(loop).add("<=").add(left).add(".length() && ");
            forloop.add(loop).add("<=").add(right).add(".length();");
            forloop.add(loop).add("++)");
            
            return new BlockJavaCode(forloop,jc);
        }
        
        if ((left instanceof VariableExpr) && (right instanceof VariableExpr)) {
            Variable left_var = ((VariableExpr)left).getVariable();
            Variable right_var = ((VariableExpr)right).getVariable();

            if (left_var.isReference() && right_var.isReference() && right.type().isa(left.type())) {
                ExprBuffer eb = new ExprBuffer(JavaPrec.ASSIGNMENT,null);
                eb.add(left);
                eb.add("=");
                eb.add(right);
                eb.add(";");
                return new ExprJavaCode(eb);
            }
        }
        
        if (left.type().isa(ExprType.any) && right.type().isa(ExprType.any)) {
            ExprBuffer eb = new ExprBuffer(JavaPrec.ASSIGNMENT,null);
            eb.add(left);
            eb.add(".setValue(");
            eb.add(right);
            eb.add(");");
            return new ExprJavaCode(eb);
        }
        
        // merge type
        if (left.type().isa(ExprType.group)
                && right.type().isa(ExprType.group)) {

            return new ExprJavaCode(new JoinExpr(null,left
                    .wrap(JavaPrec.POSTFIX), ".merge(", right,
                    ");", JavaPrec.POSTFIX, null));

        } else {
            // more complex assignment
            
            Scope leftScope=left.type().getDefinitionScope();
            if (leftScope==null) error("Left side has no scope"); 

            Scope rightScope=right.type().getDefinitionScope();
            if (rightScope==null) error("Right side has no scope"); 
            
            LinearJavaBlock ljb = new LinearJavaBlock();
            
            Iterable<Variable> list;
            
            if (leftScope instanceof PolymorphicScope) {
                list = ((PolymorphicScope)leftScope).getAllFields();
            } else {
                list = leftScope.getVariables();
            }
            
            for ( Variable v : list ) {
                
                Expr i_left = left.type().field(left,v.getName());
                if (i_left==null) error("Did not expect this to happen");
                Expr i_right = right.type().field(right,v.getName());
                if (i_right==null) continue;
                if (!(i_right instanceof VariableExpr)) continue;
                
                ljb.add( assignComplexScope(i_left,i_right) );
            }
            
            return ljb;
        }
    }

    private static class ExprAndCode {
        public ExprAndCode(Expr expr, JavaCode code) {
            this.expr = expr;
            this.code = code;
        }

        private Expr expr;
        private JavaCode code;
    }

    private JavaCode ifStatement() {
        if (!next().value.equalsIgnoreCase("if"))
            error("Expected if");

        Expr iftest = parser().expression();

        if (la().value.equalsIgnoreCase("then")) {
            next();
        }

        emptyEnd();

        JavaCode ifcode = block();

        resumeStatement("elsif");

        List<ExprAndCode> elseifBlocks = new ArrayList<ExprAndCode>();

        while (la().value.equalsIgnoreCase("elsif")) {
            next();
            Expr else_expr = parser().expression();
            if (la().value.equalsIgnoreCase("then")) {
                next();
            }
            emptyEnd();
            JavaCode else_code = block();
            elseifBlocks.add(new ExprAndCode(else_expr, else_code));
            resumeStatement("elsif");
        }

        resumeStatement("else");

        JavaCode elseCode = null;

        while (la().value.equalsIgnoreCase("else")) {
            next();
            emptyEnd();
            elseCode = block();
        }
        end();

        // synthesise into a code block

        ForkingJavaBlock block = new ForkingJavaBlock();

        block.add(new BlockJavaCode(new DecoratedExpr(JavaPrec.LABEL, "if (",
                iftest.cast(ExprType.rawboolean), ")"), ifcode));

        for (ExprAndCode elsif : elseifBlocks) {
            block.add(new BlockJavaCode(new DecoratedExpr(JavaPrec.LABEL,
                    "else if (", elsif.expr.cast(ExprType.rawboolean), ")"),
                    elsif.code));
        }

        if (elseCode != null) {
            block.add(new BlockJavaCode(new SimpleExpr(JavaPrec.LABEL, null,
                    "else"), elseCode));
        } else {
            block.add(new EmptyJavaCode());
        }

        return block;
    }

    private enum CaseType {
        of, orof
    };

    private static class CaseEntry {
        private CaseType type;
        private Expr test;
        private JavaCode code;

        public CaseEntry(CaseType type, Expr test, JavaCode code) {
            this.type = type;
            this.test = test;
            this.code = code;
        }
    }

    private JavaCode caseStatement() {
        if (!next().value.equalsIgnoreCase("case"))
            error("Expected return");

        String label = ScopeStack.getScope().createTemporaryLabel("case_");

        Expr expression = parser().expression();
        emptyEnd();

        Expr var = new SimpleExpr(JavaPrec.LABEL, expression.type(), label);
        Expr vardef = new DependentExpr(new DecoratedExpr(JavaPrec.LABEL, var
                .type().generateDefinition()
                + " ", var), var.type());

        LinearJavaBlock baseBlock = new LinearJavaBlock();
        baseBlock.add(new ExprJavaCode(new JoinExpr(JavaPrec.LABEL, null,
                vardef, "=", expression, ";")));

        List<CaseEntry> cases = new ArrayList<CaseEntry>();

        int ofcount = 0;
        boolean containsOrOf = false;
        boolean track_break = false;
        while (true) {
            resumeStatement("of", "orof");
            Lex la = la();
            if (la.type != LexType.label)
                break;

            CaseType type = null;
            if (la.value.equalsIgnoreCase("of")) {
                ofcount++;
                if (ofcount > 1)
                    track_break = true;
                type = CaseType.of;
            }
            if (la.value.equalsIgnoreCase("orof")) {
                containsOrOf = true;
                type = CaseType.orof;
            }

            if (type == null)
                break;
            next();

            Expr left = parser().expression();
            Expr right = null;

            if (la().type == LexType.label && la().value.equalsIgnoreCase("to")) {
                next();
                right = parser().expression();
            }

            Expr expr = null;

            if (right == null) {
                expr = parser().expr.expr_conditional(var, "eq", left, false);
            } else {
                left = parser().expr.expr_conditional(var, ">=", left, false)
                        .wrap(JavaPrec.AND);
                right = parser().expr.expr_conditional(var, "<=", right, false)
                        .wrap(JavaPrec.AND);
                expr = new JoinExpr(JavaPrec.AND, ExprType.rawboolean, left,
                        " && ", right);
            }

            if (type == CaseType.orof) {
                expr = new DecoratedExpr(JavaPrec.OR, label + "_match || ",
                        expr.wrap(JavaPrec.OR));
            }

            if (type == CaseType.of && track_break) {
                expr = new DecoratedExpr(JavaPrec.AND, "!" + label
                        + "_break && ", expr.wrap(JavaPrec.AND));
            }

            emptyEnd();

            cases.add(new CaseEntry(type, expr, block()));
        }

        resumeStatement("else");

        JavaCode elseCode = null;

        if (la().value.equalsIgnoreCase("else")) {
            next();
            emptyEnd();
            elseCode = block();
            track_break = true;
        }

        emptyEnd();
        end();

        if (track_break) {
            baseBlock.add(new SimpleJavaCode("boolean " + label
                    + "_break=false;"));
        }

        if (containsOrOf) {
            baseBlock.add(new SimpleJavaCode("boolean " + label
                    + "_match=false;"));
        }

        for (int scan = 0; scan < cases.size(); scan++) {
            CaseEntry entry = cases.get(scan);

            if (entry.type == CaseType.of && containsOrOf) {
                baseBlock.add(new SimpleJavaCode(label + "_match=false;"));
            }

            Expr ifstmt = new DecoratedExpr(JavaPrec.LABEL, "if (", entry.test,
                    ")");

            LinearJavaBlock ljb = new LinearJavaBlock();
            ljb.add(entry.code);

            if (track_break) {

                boolean last = (scan + 1) == cases.size();
                if (!last) {
                    last = cases.get(scan + 1).type == CaseType.of;
                }

                if (last) {
                    ljb.add(new SimpleJavaCode(label + "_break=true;"));
                }
            }

            if (containsOrOf) {

                boolean last = (scan + 1) == cases.size();
                if (!last) {
                    last = cases.get(scan + 1).type == CaseType.of;
                }

                if (!last) {
                    ljb.add(new SimpleJavaCode(label + "_match=true;"));
                }
            }

            BlockJavaCode block = new BlockJavaCode(ifstmt, ljb);
            ForkingJavaBlock fjb = new ForkingJavaBlock();
            fjb.add(block);
            fjb.add(new EmptyJavaCode());
            baseBlock.add(fjb);
        }

        // lucky last - else
        if (elseCode != null) {

            ForkingJavaBlock fjb = new ForkingJavaBlock();
            fjb.add(elseCode);
            fjb.add(new EmptyJavaCode());

            BlockJavaCode block = new BlockJavaCode(
                    "if (!" + label + "_break)", fjb);
            baseBlock.add(block);
        }

        return new BlockJavaCode(baseBlock);
    }

    private JavaCode loopStatement(String breakLabel) {
        if (!next().value.equalsIgnoreCase("loop"))
            error("Expected loop");

        // loop types involving while/until
        Expr condition = null;
        boolean infinite=false;

        // x=1 to y step n type loop
        PotentialAssignmentExpr from = null;
        Expr to = null;
        Expr inc = null;

        // expression times type loop
        Expr count = null;

        if (la().value.equalsIgnoreCase("while")
                || la().value.equalsIgnoreCase("until")) {
            boolean until = next().value.equalsIgnoreCase("until");
            condition = parser().expression();
            if (condition == null)
                error("Expected expression");
            condition=ExprType.rawboolean.cast(condition);
            if (until) {
                condition = new DecoratedExpr(JavaPrec.UNARY, "!", condition
                        .wrap(JavaPrec.UNARY));
            }
        }

        if (condition == null) {
            Expr t = parser().expression();
            if (t != null) {
                if (t instanceof PotentialAssignmentExpr) {
                    from = (PotentialAssignmentExpr) t;
                    if (!next().value.equalsIgnoreCase("to"))
                        error("Expected to");
                    to = parser().expression();
                    if (to == null)
                        error("Expected to expression");
                    if (la().value.equalsIgnoreCase("by")) {
                        next();
                        inc = parser().expression();
                    } else {
                        inc = new SimpleExpr(JavaPrec.LABEL, ExprType.rawint,
                                "1");
                    }
                    if (inc == null)
                        error("Exprected step expression");
                } else {
                    count = t;
                    if (!next().value.equalsIgnoreCase("times"))
                        error("Expected times");
                }
            }
        }

        emptyEnd();
        JavaCode block = block();

        boolean ended = false;
        Expr endCondition=null;

        resumeStatement("until", "while");
        if (la().value.equalsIgnoreCase("while")
                || la().value.equalsIgnoreCase("until")) {
            boolean until = next().value.equalsIgnoreCase("until");
            endCondition = parser().expression();
            if (endCondition == null)
                error("Expected expression");
            endCondition=ExprType.rawboolean.cast(endCondition);
            if (!until) {
                endCondition = new DecoratedExpr(JavaPrec.UNARY, "!", endCondition
                        .wrap(JavaPrec.UNARY));
            }
            ended = true;
        }
        if (!ended) {
            emptyEnd();
            end();
        }

        Expr openExpr=null;
        
        if (condition != null) {
            if (endCondition==null) {
                String s = condition.toJavaString();
                // if looks like constant assume that java
                // may flag code after this loop as unreachable
                infinite=true; 
                for (int scan=0;scan<s.length();scan++) {
                    char c = s.charAt(scan);
                    if ( (c>='a' && c<='z') || (c>='A' && c<='Z') ) {
                        infinite=false;
                        break;
                    }
                }
            }
            openExpr = new DecoratedExpr(
                    JavaPrec.LABEL, "while (", condition, ")");
        }
        
        if (from != null) {
            int direction = 1;

            // VariableExpr var = from.getVariable();
            Expr var = from.getLeftExpr();

            /*
             * Expr init = new JoinExpr(JavaPrec.POSTFIX,null,
             * var,".setValue(",from.getRight(),")");
             */
            Expr init = from.getAssignExpr();

            if (inc.toJavaString().startsWith("-")) {
                direction = -1;
            }

            String label = ScopeStack.getScope().createTemporaryLabel("loop_");            

            /*

            Expr increment = new JoinExpr(JavaPrec.POSTFIX, null, var,
                    ".increment(", inc, ")");

            Expr forLoop;
            forLoop = new JoinExpr(JavaPrec.LABEL, null, "for (", init, null,test);
            forLoop = new JoinExpr(JavaPrec.LABEL, null, forLoop, ";",increment, ")");
            */
            
            ExprBuffer forLoop=new ExprBuffer(JavaPrec.LABEL,null);
            
            boolean saved=false;
            if (!(to instanceof SimpleExpr)) {
            	saved=true;
            	Expr to_var = new SimpleExpr(JavaPrec.LABEL, to.type(), label);
            	Expr to_var_def = new DependentExpr(new DecoratedExpr(JavaPrec.LABEL, to_var
                    .type().generateDefinition()+ " ", to_var), to_var.type());

            	forLoop.add("final ");
            	forLoop.add(to_var_def);
            	forLoop.add("=");
            	forLoop.add(to);
            	if (to instanceof VariableExpr && to.type().isa(ExprType.any)) {
            		forLoop.add(".like();");
            	} else {
            		forLoop.add(";");
            	}
            	if (breakLabel!=null) {
            		forLoop.add(breakLabel);            	
            		forLoop.add(":");
            		breakLabel=null;
            	}
            }
            forLoop.add("for (");
            forLoop.add(init);
            forLoop.add(var);
            forLoop.add(".compareTo(");
            if (saved) {
            	forLoop.add(label);
            } else {
            	forLoop.add(to);
            }
            forLoop.add(direction == 1 ? ")<=0" : ")>=0");
            forLoop.add(";");
            forLoop.add(var);
            forLoop.add(".increment(");
            forLoop.add(inc);
            forLoop.add("))");
            
            /*
            Expr test = new JoinExpr(JavaPrec.RELATIONAL, ExprType.rawboolean,
                    var, ".compareTo(", to, direction == 1 ? ")<=0" : ")>=0");

            Expr increment = new JoinExpr(JavaPrec.POSTFIX, null, var,
                    ".increment(", inc, ")");

            Expr forLoop;
            forLoop = new JoinExpr(JavaPrec.LABEL, null, "for (", init, null,test);
            forLoop = new JoinExpr(JavaPrec.LABEL, null, forLoop, ";",increment, ")");
            */

            openExpr=forLoop;
        }

        if (count != null) {
            String label = ScopeStack.getScope().createTemporaryLabel("loop_");

            Expr forLoop = new DecoratedExpr(JavaPrec.LABEL, "for (int "
                    + label + "=", count.cast(ExprType.rawint), ";" + label
                    + ">0;" + label + "--)");

            openExpr=forLoop;
        }

        if (openExpr==null) {
            openExpr=new SimpleExpr(JavaPrec.LABEL,null,"while (true)");
            if (endCondition==null) infinite=true;
        }

        if (endCondition!=null) {
            LinearJavaBlock d_block=new LinearJavaBlock();
            
            d_block.add(block);
            
            endCondition=new DecoratedExpr(JavaPrec.LABEL,null,"if (",endCondition,") break;");
            ExprJavaCode ifs=new ExprJavaCode(endCondition);
            ifs.setCertain(JavaControl.BREAK,JavaControl.END);

            ForkingJavaBlock fjb=new ForkingJavaBlock();
            fjb.add(ifs);
            fjb.add(new EmptyJavaCode());
            
            d_block.add(fjb);
            block=d_block;
        }
        
        JavaCode jc = new LoopJavaCode(new BlockJavaCode(openExpr,block),infinite);
        if (breakLabel!=null) {
        	LinearJavaBlock labelledCode = new LinearJavaBlock();
        	labelledCode.add(new SimpleJavaCode(Labeller.get(breakLabel, false)+ ":"));
        	labelledCode.add(jc);
        	return labelledCode;
        }
        return jc;
    }

    private JavaCode executeStatement() {
        if (!next().value.equalsIgnoreCase("execute"))
            error("Expected execute");

        Expr expr = parser().expression();
        expr = expr.cast(ExprType.rawint);

        String var = ScopeStack.getScope().createTemporaryLabel("execute_");

        LinearJavaBlock block = new LinearJavaBlock();

        Expr init = new DecoratedExpr(JavaPrec.LABEL, "int " + var + "=", expr,
                ";");
        block.add(new ExprJavaCode(init));

        int count = 0;
        while (true) {
            emptyEnd();
            JavaCode subBlock = statement();
            if (subBlock == null)
                break;

            count++;

            ForkingJavaBlock iblock = new ForkingJavaBlock();
            iblock.add(new BlockJavaCode("if (" + var + "==" + count + ")",
                    subBlock));
            iblock.add(new EmptyJavaCode());

            block.add(iblock);
        }

        resumeStatement("else");

        if (la().value.equalsIgnoreCase("else")) {
            next();
            emptyEnd();

            JavaCode elseBlock = block();

            ForkingJavaBlock iblock = new ForkingJavaBlock();
            iblock.add(new BlockJavaCode("if (" + var + "<1 || " + var + ">"
                    + count + ")", elseBlock));
            iblock.add(new EmptyJavaCode());

            block.add(iblock);
        }

        emptyEnd();
        end();

        return new BlockJavaCode(block);
    }

    public JavaCode routineStatement() {
        if (!next().value.equalsIgnoreCase("do"))
            error("Expected do");

        Lex name = next();
        if (name.type != LexType.label)
            error("expected routine label");

        ReturningScope s = (ReturningScope) ScopeStack.getScope();

        RoutineScope rs = s.getProcedure().getRoutine(name.value);

        RoutineScope caller = null;
        if (ScopeStack.getScope() instanceof RoutineScope) {
            caller = (RoutineScope) ScopeStack.getScope();
            rs.addCallingRoutine(caller);
        }

        return new RoutineCallJavaCode(rs, caller == null);
    }

    public JavaCode returnStatement() {
        if (!next().value.equalsIgnoreCase("return"))
            error("Expected return");

        Expr result = parser().expression();

        ReturningExpr expectedType = null;
        if (ScopeStack.getScope() instanceof ReturningScope) {
            expectedType = ((ReturningScope) ScopeStack.getScope())
                    .getReturnValue();
        }

        return returnStatement(result, expectedType);
    }

    public JavaCode returnStatement(Expr result, ReturningExpr expectedType) {
        if (expectedType != null) {
            if (result != null) {
                Expr new_result = result.cast(expectedType.getType());
                result=new_result;
            }
            
            if (result==null) {
                if (expectedType.getType().isa(ExprType.any)) {
                    result = new SimpleExpr(JavaPrec.POSTFIX, expectedType.getType(),
                            "Clarion.new"
                                    + GrammarHelper.capitalise(expectedType
                                            .getType().getName()) + "()");
                    result = new DependentExpr(result, ClarionCompiler.CLARION
                            + ".Clarion");
                } else {
                    result = new SimpleExpr(JavaPrec.LABEL, expectedType.getType(),
                            "null");
                }
            }
            
            if ((result instanceof VariableExpr) && !expectedType.isReference() && result.type().isa(ExprType.any)) {
                result=new DecoratedExpr(JavaPrec.POSTFIX,result,".like()");
            }
        }

        ManipulableJavaCode sjc;

        if (ScopeStack.getScope() instanceof RoutineScope) {

            ((RoutineScope)ScopeStack.getScope()).setMayReturnToProcedure();
            
            if (expectedType != null) {
                result=new DecoratedExpr(JavaPrec.CREATE,null,"throw new ClarionRoutineResult(",result,");");
                result=new DependentExpr(result,ClarionCompiler.CLARION+".ClarionRoutineResult");
                sjc = new ExprJavaCode(result);
            } else {
                sjc = new SimpleJavaCode("throw new ClarionRoutineResult();",ClarionCompiler.CLARION+".ClarionRoutineResult");
            }
            
        } else {
            if (expectedType != null) {
                result = new DecoratedExpr(JavaPrec.LABEL, expectedType.getType(), "return ",
                    result, ";");
                sjc = new ExprJavaCode(result);
            } else {
                sjc = new SimpleJavaCode("return;");
            }
        }
        
        sjc.setCertain(JavaControl.RETURN);
        sjc.setCertain(JavaControl.END);

        return sjc;
    }

    private void resumeStatement(String... tags) {
        if (isIgnoreWhiteSpace())
            return;

        if (la().type != LexType.ws)
            return;
        if (la(1).type != LexType.label)
            return;

        for (int scan = 0; scan < tags.length; scan++) {
            if (la(1).value.equalsIgnoreCase(tags[scan])) {
                setIgnoreWhiteSpace(true);
                return;
            }
        }
    }
}
