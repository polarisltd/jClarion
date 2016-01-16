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
import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.DanglingExprType;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.ListExpr;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.EquateClass;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.setting.AbstractPropertySettingParser;
import org.jclarion.clarion.compile.setting.EquateDefSettingParser;
import org.jclarion.clarion.compile.setting.ExprListSettingParser;
import org.jclarion.clarion.compile.setting.ExprSettingParser;
import org.jclarion.clarion.compile.setting.JoinedSettingParser;
import org.jclarion.clarion.compile.setting.LabelPropertySettingParser;
import org.jclarion.clarion.compile.setting.LexSettingParser;
import org.jclarion.clarion.compile.setting.SettingParser;
import org.jclarion.clarion.compile.setting.SettingResult;
import org.jclarion.clarion.compile.setting.SimpleSettingParser;
import org.jclarion.clarion.compile.setting.VariableSettingParser;
import org.jclarion.clarion.compile.var.AliasVariable;
import org.jclarion.clarion.compile.var.ClassConstruct;
import org.jclarion.clarion.compile.var.ClassedVariable;
import org.jclarion.clarion.compile.var.EquateClasses;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.FileConstruct;
import org.jclarion.clarion.compile.var.FileExprType;
import org.jclarion.clarion.compile.var.GroupConstruct;
import org.jclarion.clarion.compile.var.GroupExprType;
import org.jclarion.clarion.compile.var.InterfaceConstruct;
import org.jclarion.clarion.compile.var.InterfaceExprType;
import org.jclarion.clarion.compile.var.JavaClassExprType;
import org.jclarion.clarion.compile.var.KeyVariable;
import org.jclarion.clarion.compile.var.LikeVariable;
import org.jclarion.clarion.compile.var.ReferenceVariable;
import org.jclarion.clarion.compile.var.SimpleVariable;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.compile.var.ViewConstruct;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class VariableParser extends AbstractParser {
    public VariableParser(Parser parser) {
        super(parser);
    }

    private static Set<String> variableLabels = GrammarHelper.list("execute",
            "accept", "break", "cycle", "do", "elsif", "else", "loop", "while",
            "until", "function", "procedure", "end", "routine", "return");

    private static Set<String> numberDef = GrammarHelper.list("date", "time",
            "signed", "byte", "long", "short", "unsigned", "ushort", "ulong",
            "real", "sreal","bool");

    private static Set<String> stringDef = GrammarHelper.list("string",
            "astring", "cstring", "pstring");

    private static SettingParser<?> dataSettings = new JoinedSettingParser(
            new SimpleSettingParser("private", "protected", "auto", "thread",
                    "static", "external"), new ExprSettingParser("name"),
            new ExprListSettingParser("dim",1,10), new ExprSettingParser("dll"),
            new VariableSettingParser("over"));

    private static SettingParser<?> fileSettings = new JoinedSettingParser(
            new SimpleSettingParser("bindable", "thread", "create"),
            new ExprListSettingParser("driver",1,2), new ExprSettingParser("owner"),
            new ExprSettingParser("name"), new LabelPropertySettingParser(
                    "pre", ""));

    private static SettingParser<?> keySettings = new JoinedSettingParser(
            new SimpleSettingParser("dup", "nocase", "opt", "primary"),
            new ExprSettingParser("name"));

    private static SettingParser<String> preSetting = new LabelPropertySettingParser(
            "pre", "");

    public String variableLabel() {
        Lex l = la();
        if (l.type != LexType.label)
            return null;
        if (variableLabels.contains(l.value.toLowerCase()))
            return null;
        return next().value;
    }

    /**
     * Used by tests only
     * 
     * @return
     */

    public Variable dataDefinition() {
        int pos = begin();
        Variable r = dataDefinition("anon", next());
        if (r == null) {
            rollback(pos);
        } else {
            commit(pos);
        }
        return r;
    }

    public Variable dataDefinition(String label, Lex la) {
        if (la.type == LexType.label) {
            la = new Lex(la.type, getAliasType(la.value));
        }

        if (la.type == LexType.label
                && numberDef.contains(la.value.toLowerCase())) {
            Expr init = null;
            if (la().type == LexType.lparam) {
                next();
                init = parser().expression();
                if (next().type != LexType.rparam)
                    error("Expected ')'");
            }

            String encoding = la.value.toLowerCase();
            String type = collapseType(encoding);
            if (encoding.equals(type))
                encoding = null;

            if (init == null) {
                init = new SimpleExpr(JavaPrec.POSTFIX, ExprType.get(type),
                        "Clarion.new" + GrammarHelper.capitalise(type) + "()");
            } else {
                init = new DecoratedExpr(JavaPrec.POSTFIX, ExprType.get(type),
                        "Clarion.new" + GrammarHelper.capitalise(type) + "(",
                        init, ")");
            }
            init = new DependentExpr(init, ClarionCompiler.CLARION + ".Clarion");
            
            return new SimpleVariable(label, init.type(), init, encoding,
                    false, dataSettings.getArray(parser()));
        }

        if (la.type == LexType.label
                && stringDef.contains(la.value.toLowerCase())) {

            Expr init = null;
            if (la().type == LexType.lparam) {
                next();
                init = parser().expression();
                if (next().type != LexType.rparam)
                    error("Expected ')'");
            }

            String encoding = la.value.toLowerCase();
            String type = "string";
            if (encoding.equals(type))
                encoding = null;

            if (init == null) {
                init = new SimpleExpr(JavaPrec.POSTFIX, ExprType.string,
                        "Clarion.newString()");
            } else {
                init = new DecoratedExpr(JavaPrec.POSTFIX, ExprType.string,
                        "Clarion.newString(", init, ")");
            }
            init = new DependentExpr(init, ClarionCompiler.CLARION + ".Clarion");

            SettingResult<?> sr[] = dataSettings.getArray(parser()); 
            
            return new SimpleVariable(label, init.type(), init, encoding,
                    false, sr);
        }

        if (la.type == LexType.label
                && (la.value.equalsIgnoreCase("decimal") || la.value
                        .equalsIgnoreCase("pdecimal"))) {

            Expr init = null;
            if (la().type == LexType.lparam) {
                next();
                Expr[] bits = parser().expressionList(LexType.rparam);
                if (next().type != LexType.rparam)
                    error("Expected ')'");

                if (bits.length > 0) {
                    if (bits.length > 3)
                        error("Invalid initiator on decimal");

                    if (bits.length == 1) {
                        bits = new Expr[] {
                                bits[0],
                                new SimpleExpr(JavaPrec.LABEL, ExprType.rawint,
                                        "0") };
                    }

                    switch (bits.length) {
                    case 3:
                    case 2:
                        bits[1] = bits[1].cast(ExprType.rawint);
                        bits[0] = bits[0].cast(ExprType.rawint);
                    }
                    init = new ListExpr(JavaPrec.LABEL, null, true, ",", bits);
                }

            }

            String encoding = la.value.toLowerCase();
            String type = "decimal";
            if (encoding.equals(type))
                encoding = null;

            if (init == null) {
                init = new SimpleExpr(JavaPrec.POSTFIX, ExprType.decimal,
                        "Clarion.newDecimal()");
            } else {
                init = new DecoratedExpr(JavaPrec.POSTFIX, ExprType.decimal,
                        "Clarion.newDecimal(", init, ")");
            }

            init = new DependentExpr(init, ClarionCompiler.CLARION + ".Clarion");

            return new SimpleVariable(label, init.type(), init, encoding,
                    false, dataSettings.getArray(parser()));
        }

        if (la.type == LexType.label && la.value.equalsIgnoreCase("any")) {
            Expr init = new SimpleExpr(JavaPrec.POSTFIX, ExprType.concrete_any,
                    "Clarion.newAny()");
            init = new DependentExpr(init, ClarionCompiler.CLARION + ".Clarion");
            return new SimpleVariable(label, ExprType.concrete_any, init, null,
                    false, dataSettings.getArray(parser()));
        }

        if (la.type == LexType.label && la.value.equalsIgnoreCase("like")) {
            if (next().type != LexType.lparam)
                error("Expected '('");

            Expr exp = null;
            ExprType et = null;
            Expr et_exp=null;

            exp = parser().expression();
            if (exp == null) {
                et = ScopeStack.getScope().getType(next().value);
                
                while (la().type == LexType.dot) {
                    next();
                    et_exp = et.field(new SimpleExpr(JavaPrec.LABEL,et,"1"),next().value);
                    if (et_exp==null) error("Not what I expected");
                    et=et_exp.type();
                }
            }

            if (next().type != LexType.rparam)
                error("Expected ')'");

            boolean Static=false;
            boolean thread=false;
            VariableExpr	over=null;
            
            for (SettingResult<?> r : dataSettings.getList(parser())) {
                if (ignoreableAttribute(r.getName())) continue;
                if (r.getName().equals("static")) {
                    Static=true;
                    continue;
                }
                if (r.getName().equals("thread")) {
                    thread=true;
                    continue;
                }
                if (r.getName().equals("over")) {
                    over = (VariableExpr) r.getValue();
                    continue;
                }
                error("Unhandled type:" + r.getName());
            }

            if (exp != null) {
                if (exp instanceof VariableExpr) {
                    return new LikeVariable(label, (VariableExpr) exp,true,Static,thread,over);
                }
            }

            if (et != null) {
                if (et instanceof ClassedExprType) {
                    ClassedExprType cet = (ClassedExprType) et;
                    ClassedVariable cv = new ClassedVariable(label, et, cet
                            .getJavaClass(), false,Static,thread,null);
                    cv.setTargetImplementingScope(cet.getDefinitionScope());
                    if (over!=null) {
                    	cv.setOver(over);
                    }
                    return cv;
                }
                
                if (et_exp!=null && (et_exp instanceof VariableExpr)) {
                    return new LikeVariable(label, (VariableExpr) et_exp,true,Static,thread,over);
                }
            }

            error("Unknown Variable/Type");
        }

        if (la.type == LexType.label
                && parser().prototype.isProcedureLabel(la.value)) {

            ExprType et = parser().prototype.getType(la);

            boolean Static=false;
            boolean thread=false;
            List<Expr> dim=null;
            for (SettingResult<?> r : dataSettings.getList(parser())) {
                if (ignoreableAttribute(r.getName())) continue;
                if (r.getName().equals("static")) {
                    Static=true;
                    continue;
                }
                if (r.getName().equals("thread")) {
                    thread=true;
                    continue;
                }
                if (r.getName().equals("dim")) {
                    if (dim==null) dim=new ArrayList<Expr>();
                    for (Expr e : (Expr[])r.getValue()) {
                    	dim.add(e);
                    }
                    continue;
                }
                error("Unhandled type:" + r.getName());
            }

            Expr[] d = null;
        	if (dim!=null) {
        		d = new Expr[dim.size()];
        		dim.toArray(d);
        	}
                       
            if (et != null) {
                if (et instanceof ClassedExprType) {
                    ClassedExprType cet = (ClassedExprType) et;
                    ClassedVariable cv = new ClassedVariable(label, et, cet
                            .getJavaClass(), false,Static,thread,d);
                    cv.setTargetImplementingScope(cet.getDefinitionScope());
                    return cv;
                }

                if (et instanceof DanglingExprType) {
                    DanglingExprType cet = (DanglingExprType) et;
                    ClassedVariable cv = new ClassedVariable(label, cet, false,Static,thread,d);
                    return cv;
                }
            }
            error("Unknown type");
        }

        if (la.type == LexType.reference) {
            ExprType type = parser().prototype.getType();
            if (type == null)
                error("Expected type");

            if (type==ExprType.window && label.equalsIgnoreCase("report")) {
                System.out.println("**** WARNING **** Retyping variable "+label+" from report to window in "+lexer().getStream().getName());
                type=ExprType.report;
            }
            
            List<Expr> dim=null;

            boolean Static=false;
            boolean thread=false;
            for (SettingResult<?> r : dataSettings.getList(parser())) {
                if (ignoreableAttribute(r.getName())) continue;
                
                if (r.getName().equals("dim")) {
                    if (dim==null) dim=new ArrayList<Expr>();
                    for (Expr e : (Expr[])r.getValue()) {
                    	dim.add(e);
                    }
                    continue;
                }
                if (r.getName().equals("static")) {
                    Static=true;
                    continue;
                }
                
                if (r.getName().equals("thread")) {
                    thread=true;
                    continue;
                }
                
                error("Unhandled type:" + r.getName());
            }
            
            ReferenceVariable rv ;
            if (dim!=null) {
                rv=new ReferenceVariable(label, type,Static,dim.toArray(new Expr[dim.size()]));
            } else {
                rv=new ReferenceVariable(label, type,Static,null);
            }
            
            if (thread) {
                rv.setThread();
            }
            return rv;
        }

        return null;

    }

    private static Set<String> ignoreableAttributes = GrammarHelper.list(
            "private", "protected", "public", "auto", "link", "dll");

    public static boolean ignoreableAttribute(String name) {
        return ignoreableAttributes.contains(name.toLowerCase());
    }

    public boolean getVariable() {
        int start = begin();
        String label = variableLabel();
        setIgnoreWhiteSpace(true);
        Lex la = next();

        if (la.type == LexType.label && la.value.equalsIgnoreCase("itemize")) {
            commit(start);
            getItemize(label);
            return true;
        }

        Variable result = null;
        boolean anonymous = false;

        if (label == null) {
            label = ScopeStack.getScope().createTemporaryLabel("_anon_");
            anonymous = true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("file")) {
            commit(start);
            getFileDefinition(label);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("view")) {
            commit(start);
            getViewDefinition(label);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("window")) {
            commit(start);
            parser().target.getWindowDefinition(label, ExprType.window);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("report")) {
            commit(start);
            parser().target.getReportDefinition(label);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("application")) {
            commit(start);
            parser().target.getWindowDefinition(label, ExprType.application);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("group")) {
            commit(start);
            getGroupDefinition(anonymous, label, ExprType.group);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("queue")) {
            commit(start);
            getGroupDefinition(anonymous, label, ExprType.queue);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("class")) {
            commit(start);
            getClassDefinition(label);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("interface")) {
            commit(start);
            getInterfaceDefinition(label);
            return true;
        }

        if (result == null && la.type == LexType.label
                && la.value.equalsIgnoreCase("equate")) {

            commit(start);
            if (next().type != LexType.lparam)
                error("Expected '('");

            Expr e = parser().expression();

            // expression type equate
            if (e != null) {
                if (next().type != LexType.rparam)
                    error("Expected ')'");

                String pkgName[] = EquateClasses.split(label);
                EquateClass ec = EquateClasses.get(pkgName[0]);
                result = new EquateVariable(label, ec, pkgName[1], e);

                ScopeStack.getScope().addVariable(result);
                emptyAll();
                return true;
            }

            // alias equate
            if (la().type == LexType.label) {
                String prototype = next().value;
                if (next().type != LexType.rparam)
                    error("Expected ')'");

                ExprType et = ScopeStack.getScope().getType(prototype);

                if (et != null) {
                    ScopeStack.getScope().addAliasedType(label, et);
                } else {
                    ExprType test = ExprType.get(collapseType(prototype));
                    if (test == null)
                        error("Expected known prototype");

                    if (ExprType.get(collapseType(label)) != null) {
                        // warning - already defined
                    } else {
                        ScopeStack.getScope().addAlias(label, prototype);
                    }
                }

                emptyAll();
                return true;
            }

            error("Dunno!");
            // TODO : picture type equate
        }

        if (result==null) {
            result = dataDefinition(label, la);
        }
        if (result != null) {
            commit(start);
        } else {
            setIgnoreWhiteSpace(false);
            rollback(start);
            return false;
        }

        emptyAll();

        if (result.isExternal()) {
            if (ScopeStack.getScope().getParent()==null) error("Cannot Resolve External");
            if (ScopeStack.getScope().getParent().getVariable(result.getName())==null) error("Cannot resolve external");
            return true;
        }
        
        ScopeStack.getScope().addVariable(result);
        return true;
    }

    private void getItemize(String label) {

        Expr seed = null;
        if (la().type == LexType.lparam) {
            next();
            seed = parser().expression();
            if (next().type != LexType.rparam)
                error("Expected ')'");
        }
        if (seed == null) {
            seed = new SimpleExpr(JavaPrec.LABEL, ExprType.rawint, "1");
        } else {
            seed = seed.cast(ExprType.rawint).wrap(JavaPrec.ADD);
        }

        String pre = null;

        // check for pre(label) statement
        LabelPropertySettingParser preparse = new LabelPropertySettingParser(
                "pre", "");
        SettingResult<String> result[] = preparse.getArray(parser());
        if (result.length == 1) {
            pre = result[0].getValue();
            if (pre.length() == 0)
                pre = label;
        }

        emptyAll();

        int offset = 0;

        while (true) {
            if (la().type != LexType.label)
                break;

            String eqLabel = next().value;
            setIgnoreWhiteSpace(true);

            if (!next().value.equalsIgnoreCase("equate"))
                error("Expected keyword 'equate'");
            if (la().type == LexType.lparam) {
                next();
                Expr newSeed = parser().expression();
                if (newSeed != null) {
                    offset = 0;
                    seed = newSeed.cast(ExprType.rawint).wrap(JavaPrec.ADD);
                }
                if (next().type != LexType.rparam)
                    error("Expected ')'");
            }
            emptyAll();

            Expr val = null;
            if (offset == 0) {
                val = seed;
            } else {
                val = new DecoratedExpr(JavaPrec.ADD, seed, "+" + offset);
            }

            String fullName = pre == null ? eqLabel : pre + ":" + eqLabel;

            String pkgName[] = EquateClasses.split(fullName);
            EquateClass ec = EquateClasses.get(pkgName[0]);
            Variable i = new EquateVariable(fullName, ec, pkgName[1], val);
            ScopeStack.getScope().addVariable(i);

            if (offset == 0) {
                seed = i.getExpr(null);
            }
            offset++;
        }
        emptyEnd();
        end();
        emptyAll();
    }

    private static class ImplementsSettingParser extends
            AbstractPropertySettingParser<InterfaceExprType> {
        public ImplementsSettingParser() {
            super("implements");
        }

        @Override
        protected InterfaceExprType getDefaultValue() {
            return null;
        }

        @Override
        protected InterfaceExprType getValue(Parser p) {
            InterfaceExprType ret = (InterfaceExprType) ScopeStack.getScope()
                    .getType(p.next().value);
            return ret;
        }
    }

    private static class SpecialLinkSettingParser extends
            AbstractPropertySettingParser<Boolean> {
        public SpecialLinkSettingParser() {
            super("link");
        }

        @Override
        protected Boolean getDefaultValue() {
            return null;
        }

        @Override
        protected Boolean getValue(Parser p) {
            if (p.la(0).type != LexType.string)
                return null;
            if (p.la(1).type != LexType.param)
                return null;
            p.next();
            p.next();
            return p.equateDefinition();
        }
    }

    private static SettingParser<?> classSetting = new JoinedSettingParser(
            new SimpleSettingParser("type", "static", "thread", "external"),
            new LexSettingParser("module", null),
            new SpecialLinkSettingParser(), new EquateDefSettingParser("link",
                    false), new EquateDefSettingParser("dll", false),
            new ImplementsSettingParser());

    private void getClassDefinition(String label) {
        ExprType base = null;
        if (la().type == LexType.lparam) {
            next();
            if (la().type == LexType.label) {
                Lex baseName = next();
                if (baseName.type != LexType.label)
                    error("Expected label");
                base = ScopeStack.getScope().getType(baseName.value);
                if (base == null)
                    error("Unknown base type");
                if (!(base instanceof ClassedExprType))
                    error("Base type must be class type");
            }
            if (next().type != LexType.rparam)
                error("expected ')'");
        }
        if (base == null) {
            base = ExprType.object;
        }

        ClassConstruct cc = new ClassConstruct(label, base);
        ScopeStack.pushScope(cc);

        SettingResult<?> settings[] = classSetting.getArray(parser());
        boolean type = false;
        boolean Static=false;
        boolean thread=false;
        for (int scan = 0; scan < settings.length; scan++) {
            String name = settings[scan].getName();
            Object value = settings[scan].getValue();
            
            if (ignoreableAttribute(name)) continue;

            if (name.equals("type")) {
                type = true;
                continue;
            }

            if (name.equals("static")) {
                Static = true;
                continue;
            }

            if (name.equals("thread")) {
                thread = true;
                continue;
            }
            
            if (name.equals("implements")) {
                cc.addInterface((InterfaceExprType) value);
                continue;
            }

            if (name.equals("module")) {
                ModuleScope.get( ((Lex)value).value );
                continue;
            }
            
            error("Unknown Setting:"+name);
        }
        emptyEnd();

        if (!isIgnoreWhiteSpace()) {
            while (true) {
                if (getVariable())
                    continue;
                Procedure p = parser().prototype.getPrototype();
                if (p != null) {
                    ScopeStack.getScope().addProcedure(p, true);
                    continue;
                }
                break;
            }
        }

        ScopeStack.popScope();
        emptyEnd();
        end();

        cc.link();

        emptyAll();
        if (!type) {
            ClassedVariable result = new ClassedVariable(label, cc.getType(),
                    cc.getJavaClass(), false,Static,thread,null);
            result.setTargetImplementingScope(cc);
            ScopeStack.getScope().addVariable(result);
        }
    }

    private void getInterfaceDefinition(String label) {
        ExprType base = null;
        if (la().type == LexType.lparam) {
            next();
            if (la().type == LexType.label) {
                Lex baseName = next();
                if (baseName.type != LexType.label)
                    error("Expected label");
                base = ScopeStack.getScope().getType(baseName.value);
                if (base == null)
                    error("Unknown base type");
                if (!(base instanceof InterfaceExprType) && (!(base instanceof JavaClassExprType)))
                    error("Base type must be class type");
            }
            if (next().type != LexType.rparam)
                error("expected ')'");
        }
        if (base == null) {
            base = ExprType.object;
        }

        SettingParser<Boolean> settingParse = new SimpleSettingParser("type","com");
        settingParse.getArray(parser());

        emptyEnd();

        InterfaceConstruct cc = new InterfaceConstruct(label, base);
        ScopeStack.pushScope(cc);

        if (!isIgnoreWhiteSpace()) {
            while (true) {
                Procedure p = parser().prototype.getPrototype();
                if (p != null) {
                    ScopeStack.getScope().addProcedure(p, true);
                    continue;
                }
                break;
            }
        }

        ScopeStack.popScope();
        emptyEnd();
        end();

        cc.link();

        emptyAll();
    }

    private void getGroupDefinition(boolean anonymous, String label,
            ExprType queue) {
        ExprType base = null;
        
        ExprType raid = null;
        
        if (la().type == LexType.lparam) {
            next();
            if (la().type == LexType.label) {
                Lex baseName = next();
                if (baseName.type != LexType.label)
                    error("Expected label");
                base = ScopeStack.getScope().getType(baseName.value);
                if (base == null) error("Unknown base type");
                
                if (!base.isa(queue)) {
                    raid=base;
                    base=null;
                } else {
                    if (queue==ExprType.group && base.isa(ExprType.queue)) {
                        raid=base;
                        base=null;
                    }
                }
            }
            if (next().type != LexType.rparam)
                error("expected ')'");
        }
        
        if (base == null) {
            base = queue;
        }

        JoinedSettingParser settingParse = new JoinedSettingParser(
                dataSettings, new LabelPropertySettingParser("pre", ""),
                new SimpleSettingParser("type", "static"),
                new ExprListSettingParser("dim",1,10));
        SettingResult<?> settings[] = settingParse.getArray(parser());

        VariableExpr over = null;

        String pre = null;
        boolean type = false;
        
        boolean Static=false;
        boolean thread=false;
        
        List<Expr> dim=null;
        
        for (int scan = 0; scan < settings.length; scan++) {
            
            if (ignoreableAttribute(settings[scan].getName())) continue;
           
            if (settings[scan].getName().equals("dim")) {
                if (dim==null) dim=new ArrayList<Expr>();
                for (Expr e : (Expr[])(settings[scan]).getValue()) {
                	dim.add(e);
                }
                continue;
            }
            
            
            if (settings[scan].getName().equals("static")) {
                Static=true;
                continue;
            }
            if (settings[scan].getName().equals("thread")) {
                thread=true;
                continue;
            }
            
            if (settings[scan].getName().equals("pre")) {
                pre = settings[scan].getValue().toString();
                continue;
            }
            if (settings[scan].getName().equals("type")) {
                type = true;
                continue;
            }

            if (settings[scan].getName().equals("over")) {
                over = (VariableExpr) settings[scan].getValue();
                continue;
            }
            
            error("Unknown Setting:"+settings[scan]);
        }

        emptyEnd();

        GroupConstruct gs = new GroupConstruct(label, base);
        gs.setPre(pre);
        ScopeStack.pushScope(gs);
        
        if (raid!=null) {
            for (Variable v : ((GroupExprType)raid).getGroupConstruct().getVariables() ) {
                gs.addVariable(v.clone());
            }
        }
        
        if (!isIgnoreWhiteSpace()) {
            while (getVariable()) {
            }
        }
        ScopeStack.popScope();

        emptyEnd();
        end();

        gs.link();

        emptyAll();

        if (!type && anonymous) {
            // unroll contents of the group construct into scope
            for (Variable v : gs.getAllFields()) {
                ScopeStack.getScope().addVariable(v.clone());
            }
        }

        if (!type && !anonymous) {
            ClassedVariable result;
            Expr[] d = null;
        	if (dim!=null) {
        		d = new Expr[dim.size()];
        		dim.toArray(d);
        	}
    		result= new ClassedVariable(label, gs.getType(),
                    gs.getJavaClass(), false,Static,thread,d);
    		
            result.setOver(over);
            result.setTargetImplementingScope(gs);
            ScopeStack.getScope().addVariable(result);
            if (pre != null) {
                ScopeStack.getScope().addVariable(
                        new AliasVariable(pre, result,Static));
            }
        }
    }

    private static class KeySortEntry {
        boolean descending;
        String label;

        public KeySortEntry(boolean descending, String label) {
            this.descending = descending;
            this.label = label;
        }
    }

    private static class KeyDef {
        public List<KeySortEntry> columns = new ArrayList<KeySortEntry>();
        public SettingResult<?>[] results;
        public String name;

        public KeyDef(String name) {
            this.name = name;
        }

        public void addColumn(boolean descend, String label) {
            columns.add(new KeySortEntry(descend, label));
        }
    }

    private static ExprSettingParser viewSetting = new ExprSettingParser(
            "order", "filter");

    private void getViewDefinition(String label) {
        ViewConstruct vs = new ViewConstruct(label);

        ScopeStack.pushScope(vs);

        if (next().type != LexType.lparam)
            error("Expected '('");

        VariableExpr file = parser().expr.variableExpr();
        if (file == null)
            error("Expected file");
        if (!file.type().isa(ExprType.file))
            error("Expected file");
        if (next().type != LexType.rparam)
            error("Expected ')'");
        vs.setProperty("setTable", file);

        for (SettingResult<Expr> result : viewSetting.getList(parser())) {
            if (result.getName().equals("filter")) {
                vs.setProperty("setFilter", ExprType.rawstring.cast(result
                        .getValue()));
                continue;
            }
            if (result.getName().equals("order")) {
                vs.setProperty("setOrder", ExprType.rawstring.cast(result
                        .getValue()));
                continue;
            }

            error("Uknown Setting:" + result);
        }

        emptyAll();

        while (suckView(vs, "this", ((FileExprType) file.type())
                .getFileConstruct())) {
        }

        emptyEnd();

        ScopeStack.popScope();

        vs.link();

        end();
        emptyAll();
    }

    private static SimpleSettingParser joinSetting=new SimpleSettingParser("inner"); 
    
    private boolean suckView(ViewConstruct vs, String label,FileConstruct file) {

        if (la().type!=LexType.ws) return false;
        
        setIgnoreWhiteSpace(true);
        
        if (la().type==LexType.label && la().value.equalsIgnoreCase("project")) {
            next();
            if (next().type!=LexType.lparam) error("expected '('");
            Expr bits[] = parser().expressionList(LexType.rparam);
            if (next().type!=LexType.rparam) error("expected ')'");

            ExprBuffer params = new ExprBuffer(JavaPrec.POSTFIX,null);
            params.add(label);
            params.add(".");
            params.add("add((new ViewProject()).setFields(new ClarionObject[] {");

            for (int scan=0;scan<bits.length;scan++) {
                if (!(bits[scan] instanceof VariableExpr)) error("Expected variable");
                if ( ((VariableExpr)bits[scan]).getVariable().getScope()!=file) error("Expected file element");
                
                if (scan>0) {
                    params.add(",");
                }
                params.add(bits[scan]);
            }
            params.add("}));");
            
            vs.addCode(new DependentExpr(params,ClarionCompiler.CLARION+".ClarionObject"));

            emptyAll();
            return true;
        }

        if (la().type==LexType.label && la().value.equalsIgnoreCase("join")) {
            next();
            if (next().type!=LexType.lparam) error("expected '('");
            Expr bits[] = parser().expressionList(LexType.rparam);
            if (next().type!=LexType.rparam) error("expected ')'");

            String vj_label = vs.createTemporaryLabel("vj");
            
            vs.addCode(new SimpleExpr(JavaPrec.ASSIGNMENT,null,"ViewJoin "+vj_label+"=new ViewJoin();"));

            // decode params
            
            FileConstruct child=null;
            
            if (bits.length>0 && bits[0].type().isa(ExprType.key)) {
                
                // key and fields style
                
                VariableExpr ve = (VariableExpr)bits[0];
                KeyVariable  ke = (KeyVariable)ve.getVariable();
                child = (FileConstruct)ke.getScope(); 
                
                vs.setProperty(vj_label+".setKey",bits[0]);

                ExprBuffer params = new ExprBuffer(JavaPrec.POSTFIX,null);
                params.add(vj_label);
                params.add(".");
                params.add("setFields(new ClarionObject[] {");

                for (int scan=1;scan<bits.length;scan++) {
                    if (!(bits[scan] instanceof VariableExpr)) error("Expected variable");
                    if ( ((VariableExpr)bits[scan]).getVariable().getScope()!=file) error("Expected file element");
                    
                    if (scan>1) {
                        params.add(",");
                    }
                    params.add(bits[scan]);
                }
                params.add("});");

                vs.addCode(new DependentExpr(params,ClarionCompiler.CLARION+".ClarionObject"));
            }                

            if (bits.length==2 && bits[0].type().isa(ExprType.file)) {
                child = ((FileExprType)bits[0].type()).getFileConstruct();
                vs.setProperty(vj_label+".setTable",bits[0]);
                vs.setProperty(vj_label+".setJoinExpression",ExprType.rawstring.cast(bits[1]));
            }
            
            if (child==null) error("Join Statement could not be parsed");
            
            if (joinSetting.getList(parser()).size()>0) {
                vs.addCode(new SimpleExpr(JavaPrec.POSTFIX,null,vj_label+".setInnerJoin();"));
            }
            
            emptyAll();

            while (suckView(vs, vj_label,child)) { }

            emptyEnd();
            end();
            
            vs.addCode(new SimpleExpr(JavaPrec.POSTFIX,null,label+".add("+vj_label+");"));
            
            emptyEnd();
            
            return true;
        }            
        
        setIgnoreWhiteSpace(false);
        return false;
    }

    private void getFileDefinition(String label) {

        FileConstruct fs = new FileConstruct(label);
        ScopeStack.pushScope(fs);
        
        for (SettingResult<?> s : fileSettings.getArray(parser())) {
            if (s.getName().equals("name")) {
                fs.setProperty("setName", ExprType.string.cast((Expr) s
                        .getValue()));
            }
            
            if (s.getName().equals("driver")) {
                fs.setDriver(((Expr[]) s.getValue())[0]);
            }
            
            if (s.getName().equals("owner")) {
                fs.setProperty("setSource", ExprType.string.cast((Expr) s
                        .getValue()));
            }

            if (s.getName().equals("pre")) {
                fs.setPre((String) s.getValue());
            }

            if (s.getName().equals("thread")) {
                fs.setThread(true);
            }

            if (s.getName().equals("create")) {
                fs.setCreate();
            }
        }

        emptyAll();

        List<KeyDef> keys = new ArrayList<KeyDef>();

        // keydefs
        while (true) {
            if (la().type != LexType.label)
                break;
            if (la(1).type != LexType.ws)
                break;
            if (la(2).type != LexType.label)
                break;
            if (!la(2).value.equalsIgnoreCase("key"))
                break;

            String keyName = next().value;
            setIgnoreWhiteSpace(true);
            next(); // key

            KeyDef k = new KeyDef(keyName);

            if (next().type != LexType.lparam)
                error("expected '('");

            while (true) {

                boolean d = false;

                if (la().type == LexType.operator && la().value.equals("-")) {
                    next();
                    d = true;
                }
                if (la().type != LexType.label)
                    error("Expected label");
                String keylabel = next().value;
                int prefix = keylabel.indexOf(':');
                if (prefix > -1) {
                    keylabel = keylabel.substring(prefix + 1);
                }
                k.addColumn(d, keylabel);

                if (la().type == LexType.param) {
                    next();
                    continue;
                }
                if (la().type == LexType.rparam) {
                    next();
                    break;
                }
                error("Expected ',' or ')'");
            }

            k.results = keySettings.getArray(parser());
            keys.add(k);
            emptyAll();
        }

        // expect Record
        if (la().type == LexType.label)
            next();
        setIgnoreWhiteSpace(true);
        if (!next().value.equalsIgnoreCase("record"))
            error("Expected record");
        preSetting.getList(parser());

        emptyAll();

        while (getVariable()) {
        }
        ;

        emptyEnd();
        end();

        emptyEnd();
        end();

        // now - reconstruct key objects and register them as variables

        for (KeyDef key : keys) {

            KeyVariable kv = new KeyVariable(key.name, key.results);

            for (KeySortEntry e : key.columns) {

                Variable v = fs.getVariableThisScopeOnly(e.label);
                if (v == null)
                    error("Could not resolve key column:" + e.label);

                if (e.descending) {
                    kv.addDescendingColumn(v);
                } else {
                    kv.addAscendingColumn(v);
                }
            }

            fs.addVariable(kv);
        }

        ScopeStack.popScope();
        emptyAll();

        fs.link();
    }

}
