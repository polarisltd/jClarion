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

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Set;

import org.jclarion.clarion.compile.SystemRegistry;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.ReturningExpr;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeSnapshot;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.JavaClassConstruct;
import org.jclarion.clarion.compile.var.JavaVariable;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.lang.NotClarionVisible;


public class AbstractParser 
{
    private Lexer lex;
    private Parser parser;
    
    public AbstractParser(Lexer input)
    {
        lex=input;
    }
    
    public AbstractParser(Parser parser,Lexer input)
    {
        lex=input;
        this.parser=parser;
    }
    
    protected final void setParser(Parser p)
    {
        this.parser=p;
    }

    protected final Parser parser()
    {
        return parser;
    }
    
    protected final Lex la()
    {
        return lex.lookahead();
    }

    protected final Lex la(int offset)
    {
        return lex.lookahead(offset);
    }
    
    protected final int begin()
    {
        return lex.begin();
    }
    
    protected final void commit(int pos)
    {
        lex.commit(pos);
    }
    
    protected final void rollback(int pos)
    {
        lex.rollback(pos);
    }
    
    protected final Lex next()
    {
        return lex.next();
    }
    
    protected final void consume(String key)
    {
        if (next().value.equals(key)) return;
        error("Could not consume : "+key);
    }
    
    protected final boolean isIgnoreWhiteSpace()
    {
        return lex.isIgnoreWhitespace();
    }
    
    protected final void setIgnoreWhiteSpace(boolean i)
    {
        lex.setIgnoreWhitespace(i);
    }
    
    protected final void error(String errmsg)
    {
        lex.error(errmsg);
    }

    static Set<String> numberTypes = GrammarHelper.list(
            "date","time","signed","byte","long","short",
            "unsigned","ushort","ulong");

    static Set<String> stringTypes = GrammarHelper.list(
        "astring","string","pstring","cstring" );

    static Set<String> decimalTypes = GrammarHelper.list(
        "decimal","pdecimal" );

    public String getAliasType(String type)
    {
        String alias = ScopeStack.getScope().getAlias(type);
        if (alias!=null) return alias;
        return type;
    }
    
    public String collapseType(String type) {
        
        type=getAliasType(type);
        type=type.toLowerCase();
        
        if (numberTypes.contains(type)) return "number";
        if (stringTypes.contains(type)) return "string";
        if (decimalTypes.contains(type)) return "decimal";
        
        return type;
    }
    
    
    public void emptyAny() {
        while (empty()) { }
    }
    
    public void emptyAll()
    {
        if (!empty()) {
            if (la().type!=LexType.eof) error("Expected EOL");
        }
        while (empty()) {}
    }
    
    public boolean emptyEnd()
    {
        int pos = begin();
        
        while ( emptyLex() ) { }
        
        Lex la = la();
        if (la.type==LexType.eof) {
            commit(pos);
            return true;
        }

        if (la.type==LexType.nl) {
            emptyAll();
            commit(pos);
            return true;
        }
        
        if (la.type==LexType.dot || la.type==LexType.semicolon || la.value.equalsIgnoreCase("end")) {
            commit(pos);
            return true;
        }
        
        rollback(pos);
        return false;
    }

    public boolean empty()
    {
        if (la().type==LexType.eof) return false;
        
        int pos = begin();
        
        while ( emptyLex() ) { }
        
        Lex la = la();
        if (la.type==LexType.eof) {
            commit(pos);
            return true;
        }

        if (la.type!=LexType.nl) {
            rollback(pos);
            return false;
        }
        next();
        commit(pos);
        
        setIgnoreWhiteSpace(false);
        
        // debug mode
        while (la().type==LexType.use) {
            while (true) {
                Lex n=next();
                if (n.type==LexType.eof) break;
                if (n.type==LexType.nl) break;
            }
        }
        
        return true;
    }
    
    public boolean emptyLex()
    {
        Lex la = la();
        if (la.type==LexType.ws) {
            next();
            return true;
        }
        if (la.type==LexType.comment) {
            next();
            return true;
        }

        if (la.type==LexType.java && la.value.equals("@java-load")) 
        {
            next();
            while (la().type==LexType.ws) next();

            Lex l = next();
            if (l.type!=LexType.string) error("Expected string");
            SystemRegistry.getInstance().load(l.value.replaceAll("\"",""));
            return true;
        }
        
        if (la.type==LexType.java && la.value.equals("@java-import")) 
        {
            next();
            while (la().type==LexType.ws) next();
            
            Lex l = next();
            if (l.type!=LexType.string) error("Expected string");
            
            importJava(l.value.replaceAll("\"",""));
            
            return true;
        }
        
        if (la.type!=LexType.label) return false;
        
        if (la.value.equalsIgnoreCase("omit")) {
            next();
            setIgnoreWhiteSpace(true);
            if (next().type!=LexType.lparam) error("Expected '('");
            String until = next().value;
            boolean expression=true;
            
            if (la().type==LexType.param) {
                next();
                expression=parser().equateDefinition();
            }
            
            if (next().type!=LexType.rparam) error("Expected ')'");
            until=until.replaceAll("\"","");
            
            if (expression) {
                lex.skipUntilMarker(until);
            } else {
                lex.addIncludeMarker(until);
            }

            return true;
        }

        if (la.value.equalsIgnoreCase("compile")) {
            next();
            setIgnoreWhiteSpace(true);
            if (next().type!=LexType.lparam) error("Expected '('");
            String until = next().value;
            boolean expression=true;
            
            if (la().type==LexType.param) {
                next();
                expression=parser().equateDefinition();
            }
            
            if (next().type!=LexType.rparam) error("Expected ')'");
            until=until.replaceAll("\"","");
            
            if (expression) {
                lex.addIncludeMarker(until);
            } else {
                lex.skipUntilMarker(until);
            }

            return true;
        }

        if (la.value.equalsIgnoreCase("include")) {
            next();
            setIgnoreWhiteSpace(true);
            
            boolean lp = la().type==LexType.lparam;
            
            if (lp) {
                if (next().type!=LexType.lparam) error("expected '('");
            }

            String name = next().value;
            name=name.replaceAll("\"","");
            
            if (lp) {
                if (next().type!=LexType.rparam) error("expected ')'");
            }
            
            //boolean once=false;
            
            if (la(0).type==LexType.param && la(1).type==LexType.label && la(1).value.equalsIgnoreCase("once")) {
                next();
                next();
                //once=true;
            }
            
            if (ScopeStack.getScope().isIncludedAlready(name)) return true;
            ScopeStack.getScope().addInclude(name);

            ScopeSnapshot ss = LocalIncludeCache.getIncludeSnapshot(name);
            if (ss==null) {
                Lexer l = LexerSource.getInstance().getLexer(name);
                if (l==null) error("Could not include:"+name);
                Parser p = new Parser(l);
                
                ParserMode pm = parser().getMode();
                p.setMode(pm);

                Scope scope = ScopeStack.getScope();
                
                ScopeSnapshot old_ss=scope.getSnapshot();
                
                if (pm==ParserMode.DATA)        p.compileData();
                if (pm==ParserMode.MAP)         p.compileMap();
                if (pm==ParserMode.MODULE)      p.compileModule();
                if (pm==ParserMode.PROCEDURE)   p.compileProcedure();
                
                if (ScopeStack.getScope()!=scope) error("Change in Scope on include!");

                ss=scope.getSnapshot();
                ss.remove(old_ss);
                
                LocalIncludeCache.setIncludeSnapshot(name,ss);
            } else {
                ScopeStack.getScope().mergeinSnapshot(ss);
            }
            
            return true;
        }
        
        return false;
    }
    
    private ExprType importJava(Class<?> clazz)
    {
        // standard system expr
        ExprType e = ExprType.getJavaMapping(clazz);
        if (e != null) return e;

        // try a lookup of the type
        JavaClassConstruct jcc = new JavaClassConstruct(clazz, 
                importJava(clazz.getSuperclass()));

        ExprType et = ScopeStack.getScope().getType(jcc.getName());
        if (et != null) return et;

        jcc.setParent(ScopeStack.getScope());
        jcc.link();

        // raid methods
        Method[] methods = clazz.getDeclaredMethods();
        for (Method method : methods) {
            if (!Modifier.isPublic(method.getModifiers())) continue;
            if (method.getAnnotation(NotClarionVisible.class)!=null) continue;
            
            Class<?> java_params[] = method.getParameterTypes();
            Param clarion_params[] = new Param[java_params.length];

            for (int scan = 0; scan < java_params.length; scan++) {
                clarion_params[scan] = new Param("v" + scan,
                        importJava(java_params[scan]), true, false, null, false);
            }

            Procedure p;
            Class<?> return_type = method.getReturnType();
            if (return_type != null && return_type != Void.TYPE
                    && return_type != Void.class) {
                ReturningExpr re = new ReturningExpr(importJava(return_type),
                        true);
                p = new Procedure(method.getName(), re, clarion_params);
            } else {
                p = new Procedure(method.getName(), clarion_params);
            }
            p.setNoRelabel(true);
            jcc.addProcedure(p, true);
        }

        // raid fields
        Field fields[] = clazz.getDeclaredFields(); 
        for (final Field field : fields) {
            if (!Modifier.isPublic(field.getModifiers())) continue;
            if (Modifier.isStatic(field.getModifiers())) continue;
            
            Variable v = new JavaVariable(
                    field.getName(),
                    importJava(field.getDeclaringClass()));
            jcc.addVariable(v);
        }
        
        return jcc.getType();
    }
    
    private void importJava(String clazzName) 
    {
        try {
            importJava(getClass().getClassLoader().loadClass(clazzName));
            return;
        } catch (ClassNotFoundException e) { }
        
        try {
            importJava(Thread.currentThread().getContextClassLoader().loadClass(clazzName));
            return;
        } catch (ClassNotFoundException e) { 
            error("Class Not Found:"+clazzName);
        } finally {
        }
    }

    public void end()
    {
        if (la().type==LexType.ws) setIgnoreWhiteSpace(true);
        
        Lex next = next();
        if (next.type==LexType.dot) return;
        if (next.type==LexType.label && next.value.equalsIgnoreCase("end")) return;
        error("Expect '.' or 'end'");
    }
}
