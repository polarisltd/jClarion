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

import java.io.StringReader;
import java.util.Set;

import org.jclarion.clarion.compile.SystemRegistry;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaExprTypeMapper;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeSnapshot;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.lang.ClarionCompileError;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexStream;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;


public class AbstractParser 
{
    private Lexer           _lex;
    private Parser          parser;

    public AbstractParser(Lexer input)
    {
        _lex=input;
    }
    
    public AbstractParser(Parser parser)
    {
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
    
    protected final Lexer lexer()
    {
        if (_lex!=null) {
            return _lex;
        } else {
            return parser.lexer();
        }
    }
    
    protected final Lex la()
    {
        return lexer().lookahead();
    }

    protected final Lex la(int offset)
    {
        return lexer().lookahead(offset);
    }
    
    protected final int begin()
    {
        return lexer().begin();
    }
    
    protected final void commit(int pos)
    {
        lexer().commit(pos);
    }
    
    protected final void rollback(int pos)
    {
        lexer().rollback(pos);
    }
    
    protected final Lex next()
    {
        return lexer().next();
    }
    
    protected final void consume(String key)
    {
        if (next().value.equals(key)) return;
        error("Could not consume : "+key);
    }
    
    protected final boolean isIgnoreWhiteSpace()
    {
        return lexer().isIgnoreWhitespace();
    }
    
    protected final void setIgnoreWhiteSpace(boolean i)
    {
        lexer().setIgnoreWhitespace(i);
    }
    
    protected final void error(String errmsg)
    {
        lexer().error(errmsg);
    }

    protected final void error(String errmsg,Throwable t)
    {
        lexer().error(errmsg,t);
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
                lexer().skipUntilMarker(until);
            } else {
                lexer().addIncludeMarker(until);
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
                lexer().addIncludeMarker(until);
            } else {
                lexer().skipUntilMarker(until);
            }

            return true;
        }

        if (la.value.equalsIgnoreCase("pragma")) {
            next();
            setIgnoreWhiteSpace(true);

            boolean lp = la().type==LexType.lparam;
            
            if (lp) {
                if (next().type!=LexType.lparam) error("expected '('");
            }
            
            if (next().type!=LexType.string) error("expected string");
            
            if (lp) {
                if (next().type!=LexType.rparam) error("expected ')'");
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
            name=name.substring(1,name.length()-1);
            
            String section= null;
            
            if (lp) {

                if (la().type==LexType.param && la(1).type==LexType.string) {
                    next();
                    section=next().value;
                    section=section.substring(1,section.length()-1);
                }
                
                
                if (next().type!=LexType.rparam) error("expected ')'");
            }
            
            //boolean once=false;
            
            if (la(0).type==LexType.param && la(1).type==LexType.label && la(1).value.equalsIgnoreCase("once")) {
                next();
                next();
                //once=true;
            }
         
            if (section!=null) {
                // lexical include

                Lexer sub = LexerSource.getInstance().getLexer(name);
                sub.getStream().setName(name);
                if (sub==null) error("Could not include:"+name);
                lexer().setStream(new JoinedLexStream(
                        new SectionLimitedLexStream(sub.getStream(),section),
                        new LexStream(new StringReader("\n")),
                        lexer().getStream()));
            } else {
                // syntactic include
                include(name);
            }
            
            return true;
        }
        
        return false;
    }
    
    protected void include(String name) {
        
        
        if (ScopeStack.getScope().isIncludedAlready(name)) {
            LocalIncludeCache.alsoInclude(name);
            return;
        }
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

            LocalIncludeCache.enterInclude();
            
            try {
                if (pm==ParserMode.DATA)        p.compileData();
                if (pm==ParserMode.MAP)         p.compileMap();
                if (pm==ParserMode.MODULE)      p.compileModule();
                if (pm==ParserMode.PROCEDURE)   p.compileProcedure();
            } catch (RuntimeException ex) {
                ex.printStackTrace();
                if (!(ex instanceof ClarionCompileError)) {
                    p.error(ex.getMessage(),ex);
                } 
                throw(new ClarionCompileError(ex));
            }
            
            if (ScopeStack.getScope()!=scope) error("Change in Scope on include!");

            ss=scope.getSnapshot();
            ss.remove(old_ss);
            
            for ( String names : LocalIncludeCache.getNestedIncludes() ) {
                ScopeSnapshot nss = LocalIncludeCache.getIncludeSnapshot(names);
                if (nss!=null) {
                    ss.add(nss);
                }
            }

            LocalIncludeCache.exitInclude();
            
            
            LocalIncludeCache.setIncludeSnapshot(name,ss);
        } else {
            LocalIncludeCache.alsoInclude(name);
            ScopeStack.getScope().mergeinSnapshot(ss);
        }
    }

    private ExprType importJava(Class<?> clazz)
    {
        return JavaExprTypeMapper.importJava(clazz);
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
