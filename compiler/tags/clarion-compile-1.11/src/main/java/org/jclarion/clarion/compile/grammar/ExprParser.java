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

import org.jclarion.clarion.compile.*;
import org.jclarion.clarion.compile.expr.CallExpr;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.EquateExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.JoinExpr;
import org.jclarion.clarion.compile.expr.ListExpr;
import org.jclarion.clarion.compile.expr.NullExpr;
import org.jclarion.clarion.compile.expr.AssignableExpr;
import org.jclarion.clarion.compile.expr.PotentialAssignmentExpr;
import org.jclarion.clarion.compile.expr.ProcCallExpr;
import org.jclarion.clarion.compile.expr.ProcedurePrototypeExprType;
import org.jclarion.clarion.compile.expr.PrototypeExpr;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.SystemCallExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.rewrite.Rewriter;
import org.jclarion.clarion.compile.rewrite.RewrittenExpr;
import org.jclarion.clarion.compile.scope.ReturningScope;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.GroupConstruct;
import org.jclarion.clarion.compile.var.GroupExprType;
import org.jclarion.clarion.compile.var.InterfaceExprType;
import org.jclarion.clarion.compile.var.SimpleVariable;
import org.jclarion.clarion.compile.var.UseVariable;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class ExprParser extends AbstractParser
{
    public ExprParser(Parser p,Lexer input)
    {
        super(p,input);
    }
    
    public Expr expression()
    {
        return expr_xor();
    }
    
    public Expr expr_xor()
    {
        Expr left = expr_or();
        if (left==null) return null;

        ListExpr list = null;
        
        while ( true ) {
            Lex n = la();
            if (n.type!=LexType.label) break;
            if (!n.value.equalsIgnoreCase("xor")) break;
            next();
            
            if (list==null) {
                list=new ListExpr(JavaPrec.BXOR,ExprType.rawboolean,true,left.cast(ExprType.rawboolean));
                left=list;
            }
         
            list.add(" ^ ",expr_or().cast(ExprType.rawboolean));
        }
        return left;
    }

    public Expr expr_or()
    {
        Expr left = expr_and();
        if (left==null) return null;
     
        ListExpr list = null;
        
        while ( true ) {
            Lex n = la();
            if (n.type!=LexType.label) break;
            if (!n.value.equalsIgnoreCase("or")) break;
            next();
            
            if (list==null) {
                list=new ListExpr(JavaPrec.OR,ExprType.rawboolean,true,left.cast(ExprType.rawboolean));
                left=list;
            }
         
            list.add(" || ",expr_and().cast(ExprType.rawboolean));
        }
        return left;
    }

    public Expr expr_and()
    {
        Expr left = expr_not();
        if (left==null) return null;
     
        ListExpr list = null;
        
        while ( true ) {
            Lex n = la();
            if (n.type!=LexType.label) break;
            if (!n.value.equalsIgnoreCase("and")) break;
            next();
            
            if (list==null) {
                list=new ListExpr(JavaPrec.AND,ExprType.rawboolean,true,left.cast(ExprType.rawboolean));
                left=list;
            }
            list.add(" && ",expr_not().cast(ExprType.rawboolean));
        }
        return left;
    }
    
    
    public Expr expr_not()
    {
        boolean negate=false;
        
        if (la().value.equals("~")) negate=true;
        if (la().value.equalsIgnoreCase("not")) negate=true;

        if (negate) next();

        Expr val=expr_conditional();
        if (negate) {
            if (val==null) error("Expected expression");
            val = new DecoratedExpr(JavaPrec.UNARY,ExprType.rawboolean,"!",val.cast(ExprType.rawboolean).wrap(JavaPrec.UNARY),null);
        }
        return val;
    }

    public Expr expr_conditional()
    {
        Expr left = expr_concat();
        if (left==null) return null;
     
        Lex n = la();
            
        boolean not=false;
        if (n.type==LexType.label) {
            if (n.value.equalsIgnoreCase("not")) {
                not=true;
                n=la(1);
            }
        }
        if (n.type!=LexType.comparator) return left;
            
        String op=null;
        String v = n.value;
            
        if (v.equals("<>") || v.equals("~=")) {
            op=not?"eq":"ne";
        }

        if (v.equals("=>") || v.equals(">=") || v.equals("~<")) {
            op=not?"<":">=";
        }

        if (v.equals("=<") || v.equals("<=") || v.equals("~>")) {
            op=not?">":"<=";
        }

        if (v.equals(">")) {
            op=not?"<=":">";
        }
            
        if (v.equals("<")) {
            op=not?">=":"<";
        }
        
        boolean possibleAssignment=false; 

        if (v.equals("=")) {
            if (!not) possibleAssignment=true;
            op=not?"ne":"eq";
        }

        if (v.equals("&=")) {
            if (!not) possibleAssignment=true;
            op=not?"!=":"==";
        }
        
        if (op==null) return left;

        int pos = begin();
        
        if (not) next();
        next();
        
        
        Expr right = expr_concat();
        if (right==null) {
            rollback(pos);
            return left;
        }
        commit(pos);
        return expr_conditional(left,op,right,possibleAssignment);
    }

    private Expr referenceWrap(Expr arg) { 
        Expr d_left=arg;
        d_left=d_left.wrap(JavaPrec.EQUALITY);
        
        if (d_left instanceof NullExpr) return d_left;
        
        if (d_left.type().isa(ExprType.concrete_any)) {
            return new DecoratedExpr(JavaPrec.POSTFIX,ExprType.any,null,d_left.wrap(JavaPrec.POSTFIX),".getValue()");
        }

        return d_left;
    }
    
    
    public Expr expr_conditional(Expr left,String op,Expr right,boolean possibleAssignment)
    {
        if (right==null) {
            error("Right undefined");
        }
        
        if (left.type()==ExprType.rawint && right.type()==ExprType.rawint) {
            if (op.equals("eq")) op="=="; 
            if (op.equals("ne")) op="!=";

            int prec = (op.equals("==") || op.equals("!="))?JavaPrec.EQUALITY:JavaPrec.RELATIONAL; 
            
            return new JoinExpr(null,left.wrap(prec),op,right.wrap(prec),null,
                prec,
                ExprType.rawboolean);
        }

        if (left.type()==ExprType.rawboolean && right.type()==ExprType.rawboolean) {
            if (op.equals("eq")) op="=="; 
            if (op.equals("ne")) op="!=";
        
            if ((op.equals("==") || op.equals("!="))) {
                return new JoinExpr(null,left.wrap(JavaPrec.EQUALITY),op,right.wrap(JavaPrec.EQUALITY),null,
                        JavaPrec.EQUALITY,
                        ExprType.rawboolean);
            }
        }
        

        if (op.equals("==")) {
            
            Expr e = new JoinExpr(null,referenceWrap(left),op,referenceWrap(right),null,
                    JavaPrec.EQUALITY,
                    ExprType.rawboolean);

            if (possibleAssignment && (left instanceof AssignableExpr)) {
                e = new PotentialAssignmentExpr(e,(AssignableExpr)left,right,true);
            }
            return e;
        }
        
        if (op.equals("!=")) {
            return new JoinExpr(null,referenceWrap(left),op,referenceWrap(right),null,
                    JavaPrec.EQUALITY,
                    ExprType.rawboolean);
        }

        Expr original_left=left; 
        left=ExprType.toAny(left);
        
        if (right.type()==null) error("What is this doing here?");
        
//        if (right.type()!=null) {
            if (!right.type().isRaw()) right=ExprType.toAny(right);
//        }

        if (op.equals("eq")) {
            Expr e = new JoinExpr(null,left.wrap(JavaPrec.POSTFIX),".equals(",right,")",
                    JavaPrec.POSTFIX,
                    ExprType.rawboolean);
            
            if (possibleAssignment && (original_left instanceof AssignableExpr)) {
                e = new PotentialAssignmentExpr(e,(AssignableExpr)original_left,right,false);
            }
            return e;
        }

        if (op.equals("ne")) {
            return new JoinExpr("!",left.wrap(JavaPrec.POSTFIX),".equals(",right,")",
                    JavaPrec.UNARY,
                    ExprType.rawboolean);
        }

        /**
        ListExpr le = new ListExpr(JavaPrec.EQUALITY,
                ExprType.rawboolean,true,left);
        le.add(".compareTo(",right,")"+op+"0");
        */
        
        int prec=(op.equals("==") || op.equals("!=")) ? JavaPrec.EQUALITY : JavaPrec.RELATIONAL;
        
        Expr le = new JoinExpr(null,left.wrap(JavaPrec.POSTFIX),".compareTo(",right,")"+op+"0"
                ,prec,ExprType.rawboolean);
        
        return le;
    }

    public Expr expr_concat()
    {
        Expr left = expr_add();
        if (left==null) return null;
        ExprBuffer  buffer = null;
        boolean prefixComma=false;
        
        while ( true ) {
            Lex n = la();
            if (n.type!=LexType.reference) break;
            if (!n.value.equalsIgnoreCase("&")) break;
            next();
            
            if (buffer==null) {
                buffer=new ExprBuffer(JavaPrec.POSTFIX,ExprType.rawstring);
                if (left.type().isa(ExprType.any)) {
                    buffer.add(left);
                    buffer.add(".concat(");
                } else {
                    buffer.add(new DependentExpr(new SimpleExpr(0,null,"ClarionString.staticConcat("),ClarionCompiler.CLARION+".ClarionString"));
                    buffer.add(left);
                    prefixComma=true;
                }
                left=buffer;
            }
            
            if (prefixComma) buffer.add(",");
            prefixComma=true;
            Expr right = expr_add();
            buffer.add(right);
        }
        
        if (buffer!=null) {
            buffer.add(")");
        }
        
        return left;
    }

    public Expr expr_add()
    {
        Expr left = expr_multiply();
        if (left==null) return null;

        ListExpr list = null;

        while ( true ) {
            Lex n = la();
            if (n.type!=LexType.operator) break;
            
            String op = null;
            
            if (n.value.equals("+")) {
                op=n.value;
            }

            if (n.value.equals("-")) {
                op=n.value;
            }

            if (op==null) break;
            next();

            Expr right = expr_multiply();
            if (right==null) error("Expected expression");
            
            ExprType left_cast = arithmeticType(left.type(),right.type());
            //System.out.println("+ Want to cast:"+left.toJavaString()+"["+left.type()+"] to:"+left_cast);
            left=left.cast(left_cast);
            
            String rop=null;
            
            if (left.type()!=ExprType.rawint) {
                switch (op.charAt(0)) {
                    case '+':
                        op=".add(";
                        break;
                    case '-':
                        op=".subtract(";
                        break;
                }
                rop=")";
            }
            
            if (left!=list) {
                if (left.type()!=ExprType.rawint) {
                    list=new ListExpr(JavaPrec.LABEL,ExprType.any,true,left);
                } else {
                    list=new ListExpr(JavaPrec.ADD,left.type(),false,left);
                }
                left=list;
            }
            
            list.add(op,right,rop);
        }
        
        return left;
    }
    
    
    public Expr expr_multiply()
    {
        Expr left = expr_power();
        if (left==null) return null;

        ListExpr list = null;

        while ( true ) {
            Lex n = la();
            if (n.type!=LexType.operator) break;
            
            String op = null;
            
            if (n.value.equals("*")) {
                op=n.value;
            }

            if (n.value.equals("%")) {
                op=n.value;
            }

            if (n.value.equals("/")) {
                op=n.value;
            }
            
            if (op==null) break;
            next();

            Expr right = expr_power();
            ExprType left_cast = arithmeticType(left.type(),right.type());
            // System.out.println("* Want to cast:"+left.toJavaString()+"["+left.type()+"] to:"+left_cast);
            left=left.cast(left_cast);
            
            String rop=null;
            
            if (left.type()!=ExprType.rawint) {
                switch (op.charAt(0)) {
                    case '*':
                        op=".multiply(";
                        break;
                    case '/':
                        op=".divide(";
                        break;
                    case '%':
                        op=".modulus(";
                        break;
                }
                rop=")";
            }
            
            if (left!=list) {
                if (left.type()!=ExprType.rawint) {
                    list=new ListExpr(JavaPrec.LABEL,ExprType.any,true,left);
                } else {
                    list=new ListExpr(JavaPrec.MULTIPLY,left.type(),false,left);
                }
                left=list;
            }
            
            list.add(op,right,rop);
        }
        
        return left;
    }

    public Expr expr_power()
    {
        Expr left = expr_arithmetic_unary();
        if (left==null) return null;

        ListExpr list = null;

        while ( true ) {
            Lex n = la();
            if (n.type!=LexType.operator) break;
            if (!n.value.equals("^")) break;
            next();
            
            if (list==null) {
                left=ExprType.toAny(left);
                list=new ListExpr(JavaPrec.LABEL,ExprType.any,true,left);
                left=list;
            }
            Expr right = expr_arithmetic_unary();
            list.add(".power(",right,")");
        }
        
        return left;
    }
    
    private ExprType arithmeticType(ExprType left,ExprType right)
    {
        left=arithmeticType(left);
        right=arithmeticType(right);

        ExprType result=null;
        
        if (gradeArithmeticType(left)>gradeArithmeticType(right)) {
            result=left;
        } else {
            result=right;
        }
        
        if (result.isa(ExprType.any)) {
            result=ExprType.any;
        }
        
        return result;
    }

    private int gradeArithmeticType(ExprType left)
    {
        if (left==ExprType.rawint) return 1;
        if (left==ExprType.any) return 2;
        if (left==ExprType.decimal) return 3;
        throw new RuntimeException("Invalid type");
    }
    
    private ExprType arithmeticType(ExprType left)
    {
        if (left==ExprType.rawboolean) return ExprType.rawint;
        if (left==ExprType.rawstring) return ExprType.decimal;
        if (left==ExprType.rawint) return ExprType.rawint;
        if (left==ExprType.rawdecimal) return ExprType.decimal;
        return ExprType.any;
    }
    
    public Expr expr_arithmetic_unary()
    {
        Lex n = la();
        boolean negate=false;
        if (n.type==LexType.operator) {
            if (n.value.equals("+")) {
                next(); // ignore
            } else if (n.value.equals("-")) {
                next();
                negate=true;
            }
        }
        
        Expr right = expr_postfixed();
        if (negate) {
            
            right=right.cast(arithmeticType(right.type()));
            if (right.type()==ExprType.rawint) {
                return new DecoratedExpr(JavaPrec.UNARY,ExprType.rawint,"-",right.wrap(JavaPrec.UNARY),null);
            } else {
                return new DecoratedExpr(JavaPrec.POSTFIX,ExprType.any,null,right.wrap(JavaPrec.POSTFIX),".negate()");
            }
        }
        return right;
    }

    public Expr[] expressionList(LexType end)
    {
        if (la().type==end) {
            return new Expr[0];
        }
            
        List<Expr> result=new ArrayList<Expr>();

        while ( true ) {
            Expr n = expression();
            if (n==null) n=new NullExpr();
            result.add(n);
            
            if (la().type==LexType.param) {
                next();
                continue;
            } else {
                return result.toArray(new Expr[result.size()]);
            }
        }
    }

    public Expr expr_postfixed()
    {
        return expr_postfixed(false);
    }
    
    private boolean allowPrototypes;
    
    public void setAllowProtoypes(boolean allow)
    {
        this.allowPrototypes=allow;
    }
    
    public Expr expr_postfixed(boolean noProperty)
    {
        Expr e =  expr_primitive();
        if (e==null) return null;
        
        // clarion postfixing
        
        while ( true ) {
            if (e==null) error("Could not resolve postfix symbol");
            
            Lex l = la();

            if (l.value.equals("$") && e.type().isa(ExprType.target)) {
                next();
                
                Expr right = expr_postfixed(true);

                if (right==null) error("Guessed $ win control wrong");
                if (!right.type().isa(ExprType.number)) {
                    right=ExprType.rawint.cast(right);
                }
                
                e = new JoinExpr(JavaPrec.POSTFIX,ExprType.control,e,".getControl(",right,")");
                continue;
            }
            
            // array or splice
            if (l.type==LexType.lbrack) {
                next();
                
                Expr param1 = expression();
                Expr param2 = null;
                if (param1==null) {
                    error("No param in array");
                }
                
                if (la().type==LexType.colon) {
                    next();
                    param2 = expression();
                    if (param2==null) {
                        error("No param #2 in array");
                    }
                }
                
                if (next().type!=LexType.rbrack) {
                    error("Expected ']'");
                }
        
                if (param2!=null) {
                    e=e.type().splice(e,param1,param2);
                } else {
                    e=e.type().array(e,param1);
                }
                continue;
            }

            // property modifier
            if (l.type==LexType.lcurl && !noProperty) {
                next();

                Expr[] params=expressionList(LexType.rcurl);

                if (params.length==0) error("No param in property");
                if (next().type!=LexType.rcurl) {
                    error("Expected '}'");
                }
        
                Expr ne=e.type().property(e,params);
                if (ne==null) error("Could not work out property:"+e.type().getName());
                e=ne;
                continue;
            }
        
            // field/method
            if (l.type==LexType.dot && la(1).type==LexType.label) {
                next();
                Lex label = next();
                if (label.type!=LexType.label) error("Expected Label");
                
                Expr[] params=null;
                
                Expr ne=null;
                
                if (la().type==LexType.lparam) {
                    next();
                    params=expressionList(LexType.rparam);
                    if (next().type!=LexType.rparam) error("Expected ')'");
                }

                if (params==null) {
                    ne=e.type().field(e,label.value);
                    if (ne==null) {
                        ne=e.type().method(e,label.value,new Expr[0]);
                    }
                } else {
                    ne=e.type().method(e,label.value,params); 
                }
                
                if (ne==null) {
                    // last ditch attempt - try to 'procedureise' the call
                    if (params==null) params=new Expr[0];
                    
                    Expr p_params[]=new Expr[params.length+1];
                    System.arraycopy(params,0,p_params,1,params.length);
                    p_params[0]=e;
                    
                    ne = callProcedure(label.value,p_params,false);
                }
                
                if (ne==null && allowPrototypes) {
                    ne = e.type().prototype(e,label.value);
                }
                
                if (ne==null) {
                    error("Could not postfix resolve:"+label+" from "+e.type());
                }
            
                e=ne;
                
                continue;
            }
            
            break;
        }
        
        return e;
    }
    
    public Expr expr_primitive()
    {
        Lex v = la();
        if (v.type==LexType.eof) return null;
        
        if (v.type==LexType.decimal) {
            next();
            StringBuilder val = new StringBuilder();
            val.append('"');
            val.append(v.value);
            val.append('"');
            return new SimpleExpr(JavaPrec.LABEL,ExprType.rawdecimal,val.toString());
        }

        if (v.type==LexType.integer) {
            next();
            return new SimpleExpr(JavaPrec.LABEL,ExprType.rawint,v.value);
        }

        if (v.type==LexType.string) {
            next();
            return new SimpleExpr(JavaPrec.LABEL,ExprType.rawstring,v.value);
        }

        if (v.type==LexType.picture) {
            next();
            
            String p = v.value;
            p.replace("\"", "\\\"");
            return new SimpleExpr(JavaPrec.LABEL,ExprType.picture,"\""+v.value+"\"");
        }
       
        
        if (v.type==LexType.lparam) {
            consume("(");
            Expr e = expr_xor();
            consume(")");
            return e;
        }

        // resolve implicit variable
        if (v.type==LexType.label && la(1).type==LexType.implicit) {

            // disambiguate implicit from control style settor
            boolean control=false;
            if (la(1).type.equals("$")) {
                Variable tvar = ScopeStack.getScope().getVariable(v.value);
                if (tvar!=null) {
                    if (tvar.getType().isa(ExprType.target)) control=true;
                }
            }
            
            if (!control) {
                Expr result = implicitVariable();
                if (result!=null) return result;
            }
        }

        // new() statement
        if (v.type==LexType.label && v.value.equalsIgnoreCase("new")) {
            next();
            
            boolean parameterized=false;
            if (la().type==LexType.lparam) {
                parameterized=true;
                next();
            }
            
            Variable var = parser().var.dataDefinition();
            if (var==null) error("Expected data definition");
            if (var.getType().getReal()==null) error("Type unknown");
            if (parameterized) {
                if (next().type!=LexType.rparam) error("Expected ')'");
            }
            return var.makeConstructionExpr()[0];
        }

        // address() statement on a prototype
        if (v.type==LexType.label && v.value.equalsIgnoreCase("address") && la(1).type==LexType.lparam) {
            
            int apos=begin();
            
            next();
            next();
            
            Expr name;
            
            setAllowProtoypes(true);
            try {
                name = expression();
            } finally {
                setAllowProtoypes(false);
            }
            
            if (!(name instanceof PrototypeExpr)) name=null;
            
            if (name!=null && next().type==LexType.rparam) {
                
                Procedure match=null;
                if (name.type() instanceof ProcedurePrototypeExprType) {
                    match=((ProcedurePrototypeExprType)name.type()).getProcedure();
                }
                
                if (match!=null) {
                    commit(apos);
                    Expr e;
                    e=new SimpleExpr(JavaPrec.POSTFIX,ExprType.rawint,"CMemory.getAddressPrototype(\""+match.getName()+"\")");
                    e=new DependentExpr(e,ClarionCompiler.CLARION+".runtime.CMemory");
                    return e;
                }
            }
            rollback(apos);
        }
        
        // bind - binding a procedure or a variable
        if (v.type==LexType.label && v.value.equalsIgnoreCase("bind") && la(1).type==LexType.lparam) {
            int bpos=begin();
            next();
            next();
            
            Expr name = parser().expression();
            
            if (name!=null && la().type==LexType.param && la(1).type==LexType.label && la(2).type==LexType.rparam) {
                next();
                String p = next().value;
                next();

                Procedure match=null;
                Scope scan = ScopeStack.getScope();
                while (scan!=null && match==null) {
                    tloop: for ( Procedure test : scan.getProcedures(p)) {
                        if (test.getResult()==null) continue;
                        if (!test.getResult().getType().isa(ExprType.any)) continue;
                        Param param[] = test.getParams();
                        for (int pscan=0;pscan<param.length;pscan++) {
                            if (!param[pscan].getType().isa(ExprType.any)) continue tloop;
                        }
                        match=test;
                        break;
                    }
                
                    scan=scan.getParent();
                }

                Expr call=null;
                
                if (match!=null) {
                    Expr params[] = new Expr[match.getParams().length];
                    for (int pscan=0;pscan<params.length;pscan++) {
                        ExprType outType = match.getParams()[pscan].getType();
                        params[pscan]=outType.cast(new SimpleExpr(JavaPrec.POSTFIX,ExprType.string,"p["+pscan+"]"));
                    }

                    ExprBuffer cbuffer=new ExprBuffer(JavaPrec.POSTFIX,ExprType.object);    
                        
                    cbuffer.add("(new ");
                    cbuffer.add(match.getScope().getJavaClass().getName());
                    cbuffer.add("()).");
                    cbuffer.add(new CallExpr(null,match,false,params));
                        
                    call = cbuffer; 
                    call = new DependentExpr(call,match.getScope().getJavaClass());
                }
                
                if (call==null) {
                    // try a system call

                    Iterable<Rewriter> list = SystemRegistry.getInstance().get(p);
                    if (list!=null) { 
                    for (Rewriter test : list) {
                        if (test.getMax()!=test.getMin()) continue;
                        if (test.getType()==null) continue;
                        if (!test.getType().isa(ExprType.any) && !test.getType().isRaw()) continue;

                        Expr params[] = new Expr[test.getMax()];
                        for (int pscan=0;pscan<params.length;pscan++) {
                            params[pscan]=new SimpleExpr(JavaPrec.POSTFIX,ExprType.string,"p["+pscan+"]");
                        }
                        
                        RewrittenExpr r = test.rewrite(params);
                        if (r==null) continue;
                        call=r.getExpr();
                        if (call!=null) {
                            call=ExprType.toAny(call);
                        }
                    }
                    }
                }
                 
                if (call!=null) {
                    
                    ExprBuffer bind = new ExprBuffer(JavaPrec.POSTFIX,null);
                    
                    bind.add("CExpression.bind(");
                    bind.add(name);
                    bind.add(",");
                    
                    bind.add("new BindProcedure() { ");
                    bind.add("public ClarionObject execute(ClarionString[] p) { ");
                    bind.add("return ");


                    bind.add(call);
                    bind.add("; } })");
                    
                    Expr e = bind;
                    e = new DependentExpr(e,
                        ClarionCompiler.CLARION+".runtime.CExpression",
                        ClarionCompiler.CLARION+".BindProcedure",
                        ClarionCompiler.CLARION+".ClarionObject",
                        ClarionCompiler.CLARION+".ClarionString");

                    commit(bpos);
                    return new SystemCallExpr(e);
                }
            }
            
            rollback(bpos);
            bpos=begin();
            
            next();
            next();

            Expr bits[] = parser().expressionList(LexType.rparam);
            
            if (bits!=null && bits.length==2 && bits[1] instanceof VariableExpr && next().type==LexType.rparam ) {
                ExprBuffer bind = new ExprBuffer(JavaPrec.POSTFIX,null);
                bind.add("CExpression.bind(");
                bind.add(bits[0]);
                bind.add(",");
                
                boolean ref = bits[1].utilisesReferenceVariables();
                if (ref) {
                    bind.add("new ReferenceBindProcedure() { public ClarionObject get() { return ");
                }
                bind.add(bits[1]); // potential problem here, with finalization etc
                if (ref) {
                    bind.add("; } }");
                }
                
                bind.add(")");
                
                Expr e;
                if (ref) {
                    e = new DependentExpr(bind,
                        ClarionCompiler.CLARION+".runtime.CExpression",
                        ClarionCompiler.CLARION+".ReferenceBindProcedure",
                        ClarionCompiler.CLARION+".ClarionObject");
                } else {
                    e = new DependentExpr(bind,
                        ClarionCompiler.CLARION+".runtime.CExpression",
                        ClarionCompiler.CLARION+".ClarionObject");
                }
                
                commit(bpos);
                return new SystemCallExpr(e);
            }

            rollback(bpos);
        }

        // size - equate or prototype
        if (v.type==LexType.label && v.value.equalsIgnoreCase("size") && la(1).type==LexType.lparam) {
            
            int spos=begin();
            next();
            next();
            
            Expr t=parser().expression();

            if (t==null) {
                Variable var = parser().var.dataDefinition();
                if (var!=null) {
                    t=var.makeConstructionExpr()[0];
                }
            }
            
            if (t!=null && next().type==LexType.rparam) {
                commit(spos);
                t=new DecoratedExpr(JavaPrec.POSTFIX,ExprType.rawint,
                    "CMemory.size(",t,")");
                t=new DependentExpr(t,ClarionCompiler.CLARION+".runtime.CMemory");
                return t;
            }
            
            rollback(spos);
        }

        // certain queue functions
        {
            Expr result = queueCommand();
            if (result!=null) return result;
        }
        
        // parameterized procedure
        
        if (v.type==LexType.label && la(1).type==LexType.lparam) {
            
            int pos =begin();
            
            String name = next().value;
            next();
            Expr[] params = parser().expressionList(LexType.rparam);
            if (next().type!=LexType.rparam) {
                error("expected ')'");
            }
        
            Expr r = callProcedure(name,params,false); // pass false - lets not be so hasty now
            if (r!=null) {
                commit(pos);
                return r;
            }
            rollback(pos);
        }
        
        // straight variable or unparameterized procedure

        // null
        if (v.type==LexType.label && v.value.equalsIgnoreCase("null")) {
            next();
            return new NullExpr();
        }

        if (v.type==LexType.label) {
            // lookup variable
            Variable var = ScopeStack.getScope().getVariable(v.value);
            
            if (var!=null) {
                next();
                return var.getExpr(ScopeStack.getScope());
            }
            
            // try <pre>:<field> format
                
            int colonPos = v.value.indexOf(':');
            if (colonPos>0) {
                var = ScopeStack.getScope().getAliasVariable(v.value.substring(0,colonPos));
                if (var==null) {
                    var = ScopeStack.getScope().getVariable(v.value.substring(0,colonPos));
                }
                if (var!=null) {
                    Expr e = var.getExpr(ScopeStack.getScope());
                    e=e.type().field(e,v.value.substring(colonPos+1));
                    if (e!=null) {
                        next();
                        return e;
                    }
                }
            }
            
            // check passed params of scope if returning scope 
            // for interface type exprtypes. If name matches type name
            // return that instead
            
            if (ScopeStack.getScope() instanceof ReturningScope) {

                ReturningScope rs =  (ReturningScope)ScopeStack.getScope();
                
                for (int scan=1;scan<=rs.getParameterCount();scan++) {
                    var = rs.getParameter(scan);
                    if (var.getType() instanceof InterfaceExprType) {
                        if (var.getType().getName().equalsIgnoreCase(v.value)) {
                            next();
                            return var.getExpr(ScopeStack.getScope());
                        }
                    }
                }
            }
            
            
            if (parser().prototype.isProcedureLabel(v.value)) {
                // just ditch - maybe it is a parameterless routine
                //Expr result = callProcedure(next().value,new Expr[0],!EquateExpr.isEquateMode());
                
                Expr result = callProcedure(la().value,new Expr[0],false);
                if (result!=null) {
                    next();
                    return result;
                }
                
                if (EquateExpr.isEquateMode()) {
                    next();
                    return new SimpleExpr(JavaPrec.LABEL,ExprType.rawint,"0");
                }
            }
            
            // try for prototype
            if (allowPrototypes) {
                Scope scope_scan = ScopeStack.getScope();
                while (scope_scan!=null) {
                    for (Procedure test : scope_scan.getProcedures(v.value)) {
                        next();
                        return new PrototypeExpr(test);
                    }
                    scope_scan=scope_scan.getParent();
                }
                
                ExprType et = ScopeStack.getScope().getType(v.value);
                if (et!=null) {
                    next();
                    return new PrototypeExpr(et);
                }
            }
        }

        if (v.type==LexType.use) {
           next();
           
           setIgnoreWhiteSpace(false);
           String label=null;
           if (la().type==LexType.label) {
               label=next().value;
           }
           setIgnoreWhiteSpace(true);
           
           Expr e=null;
           if (label==null) {
               e = new SimpleExpr(JavaPrec.POSTFIX,ExprType.rawint,"CWin.field()");
               e=new DependentExpr(e,ClarionCompiler.CLARION+".runtime.CWin");
           } else {
               UseVariable uv = ScopeStack.getScope().getUseVariable(label);
               if (uv==null) error("usevar not defined:"+label);
               e=uv.getExpr(ScopeStack.getScope());
           }
           return e;
        }
        
        return null;
    }

    private static Set<String> queueCommands=GrammarHelper.list("get","add","sort","put"); 
    
    // special queue command where sort behavour is transmitted to function via enumerating sort variables
    private Expr queueCommand()
    {
        if (la().type!=LexType.label) return null;
        if (!queueCommands.contains(la().value.toLowerCase())) return null;
        if (la(1).type!=LexType.lparam) return null;
        
        int pos = begin();
        String cmd = next().value;
        next();
        
        VariableExpr queue =variableExpr();
        if (queue==null) {
            rollback(pos);
            return null;
        }
        
        if (!queue.type().isa(ExprType.queue)) {
            rollback(pos);
            return null;
        }

        if (queue.type().same(ExprType.queue)) {
            rollback(pos);
            return null;
        }

        GroupConstruct gc = (GroupConstruct) ((GroupExprType)queue.type().getReal()).getGroupConstruct();

        ExprBuffer eb = new ExprBuffer(JavaPrec.POSTFIX,null);
        
        while ( la().type==LexType.param ) {

            next();
            
            boolean dec=false;
            
            if (la().value.equals("+")) {
                next();
            } else if (la().value.equals("-")) {
                dec=true;
                next();
            }
            
            VariableExpr bit= variableExpr();
            if (bit==null) {
                rollback(pos);
                return null;
            }
            
            if (gc.getVariableThisScopeOnly(bit.getVariable().getName())!=bit.getVariable()) {
                rollback(pos);
                return null;
            }

            if (!dec) {
                eb.add(".ascend(");
            } else {
                eb.add(".descend(");
            }
            eb.add(bit);
            eb.add(")");
        }

        if (eb.isEmpty()) {
            rollback(pos);
            return null;
        }
        
        if (next().type!=LexType.rparam) {
            rollback(pos);
            return null;
        }
        
        ExprBuffer result=new ExprBuffer(JavaPrec.POSTFIX,null);
        result.add(queue);
        result.add(".");
        result.add(cmd.toLowerCase());
        result.add("(");
        result.add(queue);
        result.add(".ORDER()");
        result.add(eb);
        result.add(")");
        
        commit(pos);
        return new SystemCallExpr(result);
    }
    
    public VariableExpr variableExpr()
    {
        int pos = begin();
        Expr e = expression();
        if (e==null) {
            rollback(pos);
            return null;
        }
        if (e instanceof VariableExpr) {
            commit(pos);
            return (VariableExpr)e;
        }

        rollback(pos);
        return null;
    }
    
    private Expr implicitVariable() {
        
        int pos = begin();
        String name = next().value;
        setIgnoreWhiteSpace(false);
        if (la().type!=LexType.implicit) {
            setIgnoreWhiteSpace(true);
            rollback(pos);
            return null;
        }
        
        if (la().value.equals("$") && la(1).type==LexType.label) {
            // disambiguate from string implicit and property expression
            setIgnoreWhiteSpace(true);
            rollback(pos);
            return null;
        }

        commit(pos);
        setIgnoreWhiteSpace(true);

        String marker = next().value;
        char type = marker.charAt(0);
        
        if (type=='#') marker="number";
        if (type=='"') marker="string";
        if (type=='$') marker="decimal";
        
        name = "_"+name+"_"+marker;

        Scope base = ScopeStack.getScope();
        if (base instanceof RoutineScope) base=base.getParent();
        
        Variable v = base.getVariable(name);
        if (v==null) {
            ExprType etype=null;
            if (type=='#') etype=ExprType.number;
            if (type=='"') etype=ExprType.string;
            if (type=='$') etype=ExprType.decimal;
            
            Expr construct = new SimpleExpr(JavaPrec.POSTFIX,etype,
            "Clarion.new"+GrammarHelper.capitalise(marker)+"()");
            construct=new DependentExpr(construct,ClarionCompiler.CLARION+".Clarion");
            
            v=new SimpleVariable(name,etype,construct,null,false,null);
            
            base.addVariable(v);
        }
        
        // TODO Auto-generated method stub
        return v.getExpr(ScopeStack.getScope());
    }

    public Expr callProcedure(String name,Expr[] params,boolean reportError)
    {
        if (name.equalsIgnoreCase("choose") && params.length>=3 && (!params[0].type().same(ExprType.rawboolean))) {
            
            ExprType type = params[1].type();
            for (int scan=2;scan<params.length;scan++) {
                ExprType ctype = params[scan].type();
                
                if (ctype.isa(type)) continue;
                if (type.isa(ctype)) {
                    type=ctype;
                    continue;
                }
                type=ExprType.any;
                break;
            }
                
            if (params.length==3) {
                ExprBuffer eb = new ExprBuffer(JavaPrec.TERNARY,type);
                eb.add(params[0].cast(ExprType.rawint).wrap(JavaPrec.EQUALITY));
                eb.add("==1 ?");
                eb.add(params[1].cast(type).wrap(JavaPrec.TERNARY));
                eb.add(":");
                eb.add(params[2].cast(type).wrap(JavaPrec.TERNARY));
                
                return eb;
            } else {

                String s = Labeller.get("__Choose_hold",false);
                
                Variable v = ScopeStack.getScope().getVariableThisScopeOnly("__Choose_hold");
                if (v==null) {
                    v=  new SimpleVariable("__Choose_hold",ExprType.rawint,
                        new SimpleExpr(JavaPrec.LABEL,ExprType.rawint,"0"),
                        null,false,null);
                    ScopeStack.getScope().addVariable(v);
                }

                ExprBuffer eb = new ExprBuffer(JavaPrec.TERNARY,type);
                eb.add("("+s+"=");
                eb.add(params[0].cast(ExprType.rawint).wrap(JavaPrec.TERNARY));
                eb.add(")==1 ?");
                eb.add(params[1].cast(type).wrap(JavaPrec.TERNARY));

                for (int scan=2;scan<params.length-1;scan++) {
                    eb.add(" : "+s+"=="+scan+" ? ");
                    eb.add(params[scan].cast(type).wrap(JavaPrec.TERNARY));
                }

                eb.add(" : ");
                eb.add(params[params.length-1].cast(type).wrap(JavaPrec.TERNARY));
                
                return eb;
            }
            
        }
        
        if (name.equalsIgnoreCase("omitted") && params.length==1) {
            int id = Integer.parseInt(params[0].toJavaString());
            ReturningScope rs = (ReturningScope)ScopeStack.getScope();
            Expr e = rs.getParameter(id).getExpr(ScopeStack.getScope());
            e=new DecoratedExpr(JavaPrec.EQUALITY,ExprType.rawboolean,null,e,"==null");
            
            return e;
        }
        
        Procedure p = ScopeStack.getScope().matchProcedure(name,params);
        if (p!=null) {
            if (p.getScope().getJavaClass()==null) {
                // let system matcher find it
                p=null;
            }
        }
            
        if (p!=null) {
            return new CallExpr(new ProcCallExpr(p),p,true,params);
        }
        
        Expr e = SystemRegistry.getInstance().call(name,params);
        if (e!=null) return e;
        
        // try for method recast
        if (params.length>0 && params[0]!=null && params[0].type()!=null) {
            Expr method_params[]=new Expr[params.length-1];
            System.arraycopy(params,1,method_params,0,method_params.length);
            Expr alt = params[0].type().method(params[0],name,method_params);
            if (alt!=null) return alt;
        }
        
        
        if (reportError) error("Procedure not found:"+name);
        return null;
    }
}
