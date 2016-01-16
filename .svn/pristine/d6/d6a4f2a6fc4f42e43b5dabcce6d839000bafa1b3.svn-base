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

import java.io.CharArrayReader;
import java.util.Set;
import java.util.logging.Logger;

import org.jclarion.clarion.compile.*;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.java.ExprJavaCode;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.java.JavaMethodPrototype;
import org.jclarion.clarion.compile.java.LinearJavaBlock;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.ProcedureScope;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.ClassExprType;
import org.jclarion.clarion.lang.ClarionCompileError;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class Parser extends AbstractParser
{
    private static Logger log = Logger.getLogger(Parser.class.getName()); 
    
    ExprParser      expr;
    VariableParser  var;
    PrototypeParser prototype;
    StatementParser stmt;
    EquateParser    equate;
    TargetParser    target;
    
    private ParserMode mode;
    
    public Parser(String input)
    {
        this(new Lexer(new CharArrayReader(input.toCharArray())));
    }

    public Parser(Lexer input)
    {
        super(input);
        setParser(this);
        expr=new ExprParser(this);
        var=new VariableParser(this);
        prototype=new PrototypeParser(this);
        stmt=new StatementParser(this);
        equate=new EquateParser(this);
        target=new TargetParser(this);
        mode=ParserMode.DATA;
    }
    
    public TargetParser getTarget()
    {
        return target;
    }
    
    public Expr expression()
    {
        return expr.expression();
    }
    
    public boolean equateDefinition()
    {
        return equate.equateDefinition();
    }

    public Expr[] expressionList(LexType end)
    {
        return expr.expressionList(end);
    }
    
    public Lexer getLexer()
    {
        return lexer();
    }
    
    public void compileProgram()
    {
        try {
            
        // look for equates.clw
        if (LexerSource.getInstance()!=null) {
            if (LexerSource.getInstance().getLexer("equates.clw")!=null) {
                include("equates.clw");
            }
        }
            
        // step one - get program definition
        emptyAny();
        
        if (next().type!=LexType.ws) error("Expected whitespace");
        setIgnoreWhiteSpace(true);
        
        if (!next().value.equalsIgnoreCase("program")) error("Expected 'program'");

        emptyAll();

        while ( true ) {
            if (prototype.getMap()) continue;
            if (var.getVariable()) continue;
            break;
        }
        
        emptyAny();

        if (next().type!=LexType.ws) error("Expected whitespace");
        setIgnoreWhiteSpace(true);

        if (!next().value.equalsIgnoreCase("code")) error("Expected 'code'");

        setMode(ParserMode.PROCEDURE);
        
        emptyAll();
        
        JavaCode jc = stmt.code();

        Procedure ip = new Procedure("init",new Param[0]) {
            @Override
            public void write(StringBuilder main,JavaDependencyCollector collector, Set<JavaMethodPrototype> dups) {
                super.write(main, collector,dups);
                main.append("\tstatic { init(); }\n\n");
            }
        };
        ip.setStatic();
        ScopeStack.getScope().addProcedure(ip,true);

        Procedure dp = new Procedure("destroy",new Param[0]);
        dp.setStatic();
        ScopeStack.getScope().addProcedure(dp,true);
        
        
        Procedure mp = new Procedure("main",new Param[] { 
                new Param("args",ExprType.rawastring,
                        false,false,null,false)
            });
        mp.setStatic();
        ScopeStack.getScope().addProcedure(mp,true);
        
        Expr m_init = new SimpleExpr(JavaPrec.POSTFIX,null,
        "try { init(); begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { destroy(); }");
        m_init=new DependentExpr(m_init,ClarionCompiler.CLARION+".crash.Crash");
        
        mp.setCode(new ExprJavaCode(m_init));
        
        Procedure p = new Procedure("begin",new Param[] { 
            new Param("args",ExprType.rawastring,
                    false,false,null,false)
        });
        p.setStatic();
        
        ScopeStack.getScope().addProcedure(p,true);
        
        Expr init;
        if (System.getProperty("clarion.compile.forceHardAssert")!=null) {
            init = new SimpleExpr(JavaPrec.POSTFIX,null,"CRun.setHardAssert(true);CRun.init(args);");
        } else {
            init = new SimpleExpr(JavaPrec.POSTFIX,null,"CRun.init(args);");
        }
        
        init=new DependentExpr(init,ClarionCompiler.CLARION+".runtime.CRun");
        
        LinearJavaBlock ljb = new LinearJavaBlock();
        ljb.add(new ExprJavaCode(init));
        ljb.add(jc);
        
        p.setCode(ljb);
        
        emptyAny();

        // read procedures etc
        procedureImplementation();
        
        if (next().type!=LexType.eof) error("Expected eof");
        if (lexer().getBeginCount()>0) error("Code has open begin blocks");
        
        compileModules();
        
        Scope.fixDisorderedScopes();

        ip.setCode(MainScope.main.getMainInitVariables());
        dp.setCode(MainScope.main.getMainDestroyVariables());

        ModuleScope.fixModuleScopes();
        } catch (RuntimeException ex) {
            ex.printStackTrace();
            if (!(ex instanceof ClarionCompileError)) {
                error(ex.getMessage(),ex);
            } 
            throw(new ClarionCompileError(ex));
        }
    }

    public void compileModuleFile()
    {
        try {
        // step one - get program definition
        emptyAny();
        
        if (next().type!=LexType.ws) error("Expected whitespace");
        setIgnoreWhiteSpace(true);
        
        if (!next().value.equalsIgnoreCase("member")) error("Expected 'member'");
        
        if (la().type==LexType.lparam) {
            next();
            if (la().type!=LexType.rparam) next();
            if (next().type!=LexType.rparam) error("Expected ')'");
        }
        
        emptyAll();

        while ( true ) {
            if (prototype.getMap()) continue;
            if (var.getVariable()) continue;
            break;
        }

        ((ModuleScope)ScopeStack.getScope()).getModuleClass().calculateSingleFunctionModule();
        
        emptyAny();

        // read procedures etc
        procedureImplementation();
        
        if (next().type!=LexType.eof) error("Expected eof");
        if (lexer().getBeginCount()>0) error("Code has open begin blocks");
        
        } catch (RuntimeException ex) {
            ex.printStackTrace();
            if (!(ex instanceof ClarionCompileError)) {
                error(ex.getMessage(),ex);
            } 
            throw(new ClarionCompileError(ex));
        }
    }
    
    
    public void compileModules() 
    {
        while ( true ) {
            ModuleScope module = ModuleScope.getNextUncompiledModule();
            if (module==null) break;
            
            ScopeStack.setScope(MainScope.main);
            ScopeStack.pushScope(module);
            
            String name = module.getFile();
            
            Lexer l = LexerSource.getInstance().getLexer(name);
            if (l==null) error("Cannot load:"+name+" ("+module.getProcedures()+")");
            Parser p = new Parser(l);
            p.compileModuleFile();
            
        }
    }

    public void procedureImplementation()
    {
        while ( true ) {
            int pos = begin();

            String clazzName=null;
            String inter=null;
            
            if (la(0).type==LexType.label && la(1).type==LexType.dot) {
                clazzName = var.variableLabel();
                if (clazzName==null) {
                    rollback(pos);
                    break;
                }
                next();
            }

            if (la(0).type==LexType.label && la(1).type==LexType.dot) {
                inter = var.variableLabel();
                if (inter==null) {
                    rollback(pos);
                    break;
                }
                next();
            }
            
            String label  = prototype.procedureLabel();
            if (label==null) {
                rollback(pos);
                break;
            }
            
            setIgnoreWhiteSpace(true);
            
            Lex type = next();
            if (type.type!=LexType.label) {
                setIgnoreWhiteSpace(false);
                rollback(pos);
                break;
            }

            if (!type.value.equalsIgnoreCase("procedure") && !type.value.equalsIgnoreCase("function")) {
                setIgnoreWhiteSpace(false);
                rollback(pos);
                break;
            }        
            commit(pos);
            
            Param[] params = prototype.getParams(true);
            
            emptyAll();
            
            Scope scopeToScan=null;
            ClassExprType clazz=null;
            
            if (scopeToScan==null && clazzName!=null) {
                
                ExprType et = ScopeStack.getScope().getType(clazzName);
                if (et==null) {
                    error("Class could not be found:"+clazzName);
                }
                
                et=et.getReal();
                if (!(et instanceof ClassExprType)) {
                    error("Class could not be found:"+clazzName+" = "+et.getClass());
                }

                clazz = (ClassExprType)et; 
                
                if (inter!=null) {
                    scopeToScan = clazz.getClassConstruct().getInterface(inter);
                    if (scopeToScan==null) {
                        error("interface not found:"+inter);
                    }
                } else {
                    scopeToScan = clazz.getClassConstruct();
                }
            }
            
            if (scopeToScan==null) {
                scopeToScan=ScopeStack.getScope();
            }
            
            // find a match - try exact match first
            Procedure match = scopeToScan.matchProcedureImplementation(label,params);

            if (match==null ) {
                
                // try for remapping method to a procedure def
                if (clazz!=null) {
                    Param cp[] = new Param[params.length+1];
                    System.arraycopy(params,0,cp,1,params.length);
                    cp[0]=new Param("SELF",clazz,false,false,null,false);
                    match = ScopeStack.getScope().matchProcedureImplementation(label,cp);
                }
                
                //
            }
            
            if (match==null) {
                error("Procedure prototype unknown: "+label);
            }

            if (match.getCode()!=null) log.warning("Procedure already implemented.");
            
            ProcedureScope imp=match.getImplementationScope();
            imp.reset();
            ScopeStack.pushScope(imp);
            
            // read variables
            while ( var.getVariable() ) { };

            // read code
            emptyAny();

            if (next().type!=LexType.ws) error("Expected whitespace");
            setIgnoreWhiteSpace(true);

            if (!next().value.equalsIgnoreCase("code")) error("Expected 'code'");
            
            emptyAll();

            JavaCode jc = stmt.code();

            match.setCode(jc);

            // look ahead for routines
            
            while ( true ) {
                if (la().type!=LexType.label) break;
                
                int routine_pos = begin();
                String routine = next().value;
                setIgnoreWhiteSpace(true);
                if (la().type!=LexType.label || !la().value.equalsIgnoreCase("routine")) {
                    rollback(routine_pos);
                    setIgnoreWhiteSpace(false);
                    break;
                }
                commit(routine_pos);
                next(); // eat routine 

                emptyAll();

                
                RoutineScope rs = match.getRoutine(routine);
                ScopeStack.pushScope(rs);
                
                // check for data block
                if (la().type==LexType.ws && la(1).value.equalsIgnoreCase("data")) {
                    setIgnoreWhiteSpace(true);
                    if (!next().value.equalsIgnoreCase("data")) error("expected data");
                    emptyAll();
                    while ( var.getVariable() ) { }
                    if (la().type!=LexType.ws) error("Expected whitespace");
                    setIgnoreWhiteSpace(true);
                    if (!next().value.equalsIgnoreCase("code")) error("expected code");
                    emptyAll();
                }

                JavaCode rc = stmt.code();
                
                rs.setCode(rc);
                
                ScopeStack.popScope();
            }

            if (match.getUndefinedRoutines().iterator().hasNext()) {
                error("Missing Routine : "+match.getUndefinedRoutines().iterator().next().getName());
            }
            
            ScopeStack.popScope();
            
        }
    }

    public ParserMode getMode() {
        return mode;
    }

    public void setMode(ParserMode mode) {
        this.mode = mode;
    }

    public void compileData() {
        
        emptyAny();
        
        while ( true ) {
            if (prototype.getMap()) continue;
            if (var.getVariable()) continue;
            break;
        }
        
        emptyAny();

        Lex next = next();
        if (next.type!=LexType.eof) error("Expected eof got:"+next);
        if (lexer().getBeginCount()>0) error("Code has open begin blocks");
    }

    public void compileMap() {

        emptyAny();
        
        prototype.getMapContents();
        
        emptyAny();

        if (next().type!=LexType.eof) error("Expected eof");
        if (lexer().getBeginCount()>0) error("Code has open begin blocks");
    }

    public void compileModule() {

        emptyAny();
        
        prototype.getModuleContents();
        
        emptyAny();

        if (next().type!=LexType.eof) error("Expected eof");
        if (lexer().getBeginCount()>0) error("Code has open begin blocks");
        
    }

    public void compileProcedure() 
    {
        emptyAny();
        // read procedures etc
        procedureImplementation();
        
        if (next().type!=LexType.eof) error("Expected eof");
        if (lexer().getBeginCount()>0) error("Code has open begin blocks");
    }
}
