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

import org.jclarion.clarion.compile.*;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.java.ExprJavaCode;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.LinearJavaBlock;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.ProcedureScope;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.var.ClassExprType;
import org.jclarion.clarion.lang.ClarionCompileError;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class Parser extends AbstractParser
{
    ExprParser      expr;
    VariableParser  var;
    PrototypeParser prototype;
    StatementParser stmt;
    EquateParser    equate;
    TargetParser    target;
    
    private ParserMode mode;
    
    public Parser(ClarionCompiler compiler,String input)
    {
        this(compiler,new Lexer(new CharArrayReader(input.toCharArray())));
    }

    public Parser(String input)
    {
        this(null,new Lexer(new CharArrayReader(input.toCharArray())));
    }

    public Parser(ClarionCompiler compiler,Lexer input)
    {
        super(compiler,input);
        setParser(this);
        expr=new ExprParser(compiler,this);
        var=new VariableParser(compiler,this);
        prototype=new PrototypeParser(compiler,this);
        stmt=new StatementParser(compiler,this);
        equate=new EquateParser(compiler,this);
        target=new TargetParser(compiler,this);
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
    	compileProgram(true);
    }
    
    public void compileProgram(boolean fullCompile)
    {
    	WarningCollator.get().set(compiler,lexer());
    	
        try {
            
        // look for equates.clw
        if (compiler.source()!=null) {
            if (compiler.source().getLexer("equates.clw")!=null) {
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

        setIgnoreWhiteSpace(true);
        if (!next().value.equalsIgnoreCase("code")) error("Expected 'code'");

        setMode(ParserMode.PROCEDURE);
        
        emptyAll();
        
        JavaCode jc = stmt.code();

        Procedure mp = new Procedure("main",new Param[] { 
                new Param("args",ExprType.rawastring,
                        false,false,null,false)
            });
        mp.setStatic();
        compiler.getScope().addProcedure(mp,true);
        
        Expr m_init = new SimpleExpr(JavaPrec.POSTFIX,null,
        "try { if (!__is_init) { __static_init(); } begin(args); CRun.shutdown(); } catch (Throwable t) { Crash c = Crash.getInstance(); c.log(t);c.crash(); } finally { __static_destruct(); }");
        m_init=new DependentExpr(m_init,ClarionCompiler.CLARION+".crash.Crash");
        
        mp.setCode(new ExprJavaCode(m_init));
        
        Procedure p = new Procedure("begin",new Param[] { 
            new Param("args",ExprType.rawastring,
                    false,false,null,false)
        });
        p.setStatic();
        
        compiler.getScope().addProcedure(p,true);
        
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
        
        if (fullCompile) {
        	compileModules();
        }
        
        compiler.stack().fixDisorderedScopes();
        } catch (AccumulatingClarionCompileError ex) {
            throw new AccumulatingClarionCompileError(ex);
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
    	WarningCollator.get().set(compiler,lexer());    	
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

        ((ModuleScope)compiler.getScope()).getModuleClass().calculateSingleFunctionModule();
        
        emptyAny();

        // read procedures etc
        procedureImplementation();
        
        if (next().type!=LexType.eof) error("Expected eof");
        if (lexer().getBeginCount()>0) error("Code has open begin blocks");

        } catch (AccumulatingClarionCompileError ex) {
            throw new AccumulatingClarionCompileError(ex);
        } catch (RuntimeException ex) {
            ex.printStackTrace();
            if (!(ex instanceof ClarionCompileError)) {
                error(ex.getMessage(),ex);
            } 
            throw(new ClarionCompileError(ex));
        }
    }
    
    public void recompileModule(String moduleName)
    {
    	ModuleScope module = compiler.main().get(moduleName);
        if (module==null) return;
        
        module.clean();        
        module.getJavaClass().setCompiled();
        compiler.stack().setScope(compiler.main());
        compiler.stack().pushScope(module);
        compiler.collator().associate(compiler.source().cleanName(moduleName),module);
        compileModuleFile();
    }
    
    
    public void compileModules() 
    {
        while ( true ) {
            ModuleScope module = compiler.main().getNextUncompiledModule();
            if (module==null) break;
            module.getJavaClass().setCompiled();
            
            compiler.stack().setScope(compiler.main());
            compiler.stack().pushScope(module);
            
            String name = module.getFile();
            compiler.collator().associate(compiler.source().cleanName(name),module);            
            Lexer l = compiler.source().getLexer(name);
            if (l==null) error("Cannot load:"+name+" ("+module.getProcedures()+")");
            Parser p = new Parser(compiler,l);
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
                
                ExprType et = compiler.getScope().getType(clazzName);
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
                scopeToScan=compiler.getScope();
            }
            
            // find a match - try exact match first
            Procedure match = scopeToScan.matchProcedureImplementation(label,params);

            if (match==null ) {
                
                // try for remapping method to a procedure def
                if (clazz!=null) {
                    Param cp[] = new Param[params.length+1];
                    System.arraycopy(params,0,cp,1,params.length);
                    cp[0]=new Param("SELF",clazz,false,false,null,false);
                    match = compiler.getScope().matchProcedureImplementation(label,cp);
                }
                
                //
            }
            
            if (match==null) {
                error("Procedure prototype unknown: "+label);
            }

            if (match.getCode()!=null && match.isRecycled()) WarningCollator.get().warning("Procedure already implemented.: "+match.getName());
            match.clearRecycled();
            
            ProcedureScope imp=match.getImplementationScope();
            imp.reset();
            compiler.stack().pushScope(imp);
            
            // read variables
            while ( var.getVariable() ) { };

            // read code
            emptyAny();

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

                
                RoutineScope rs = match.getRoutine(compiler,routine);
                compiler.stack().pushScope(rs);
                
                // check for data block
                if ((la().type==LexType.ws && la(1).value.equalsIgnoreCase("data")) || la().value.equalsIgnoreCase("data")) {
                    setIgnoreWhiteSpace(true);
                    if (!next().value.equalsIgnoreCase("data")) error("expected data");
                    emptyAll();
                    while ( var.getVariable() ) { }
                    setIgnoreWhiteSpace(true);
                    if (!next().value.equalsIgnoreCase("code")) error("expected code");
                    emptyAll();
                }

                JavaCode rc = stmt.code();
                
                rs.setCode(rc);
                
                compiler.stack().popScope();
            }

            if (match.getUndefinedRoutines().iterator().hasNext()) {
                error("Missing Routine : "+match.getUndefinedRoutines().iterator().next().getName());
            }
            
            compiler.stack().popScope();
            
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
