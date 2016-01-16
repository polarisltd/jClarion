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
package org.jclarion.clarion.runtime;

import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

/*
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
*/

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
//import org.jclarion.clarion.antlr.ClarionExprLexer;
//import org.jclarion.clarion.antlr.ClarionExprParser;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprError;
import org.jclarion.clarion.runtime.expr.CExprType;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;

public class CExprImpl {

    private static CExprImpl instance;
    

    private Map<String,BindProcedure> bindings;
    
    private Stack<Map<String,BindProcedure>> stack;
    
    
    public static CExprImpl getInstance()
    {
        if (instance==null) {
            synchronized(CExprImpl.class) {
                if (instance==null) {
                    instance=new CExprImpl();
                }
            }
        }
        return instance;
    }

    private Map<String,BindProcedure> systemBindings=new HashMap<String, BindProcedure>();
    
    public CExprImpl() {
        stack=new Stack<Map<String, BindProcedure>>();
        bindings=new HashMap<String, BindProcedure>();
        
        systemBindings.put("upper",new SQLBindProcedure("UPPER",CExprType.STRING,CExprType.STRING) {
            @Override
            public ClarionObject execute(ClarionString[] p) {
                return p[0].upper();
            }  
        });

        CRun.addShutdownHook(new Runnable() { 
            public void run()
            {
                instance=null;
            }
        } );
    }

    public CExpr compile(String aString)
    {
        CErrorImpl.getInstance().clearError();
        
        StringReader sr = new StringReader(aString);
        Lexer l = new Lexer(sr);
        l.setJavaMode(false);
        l.setIgnoreWhitespace(true);
        Parser p = new Parser(l);
        
        try {
            return p.expr();
        } catch (ParseException e) { 
            CErrorImpl.getInstance().setError(800,e.getMessage());
            return null;
        } catch (CExprError e) {
            CErrorImpl.getInstance().setError(801,e.getMessage());
            return null;
        }
    
        /*
        ClarionExprLexer lex = new ClarionExprLexer(new ANTLRStringStream(aString.trim()));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        ClarionExprParser cep = new ClarionExprParser(tokens);
        try {
            return cep.expr();
        } catch (RecognitionException e) {
            CErrorImpl.getInstance().setError(800,e.getMessage());
            return null;
        } catch (CExprError e) {
            CErrorImpl.getInstance().setError(801,e.getMessage());
            return null;
        }
        */
    }
    
    public ClarionString evaluate(String aString)
    {
        CExpr exp = compile(aString);
        if (exp==null) {
            return new ClarionString("");
        }

        CErrorImpl.getInstance().clearError();

        try {
            ClarionObject o = exp.eval();
            if (o instanceof ClarionBool) {
                return new ClarionString(o.boolValue() ? "1" : "0");
            }
            return o.getString();
        } catch (CExprError e) {
            CErrorImpl.getInstance().setError(801,e.getMessage());
            return new ClarionString("");
        }
    }
    
    public void pushBind(boolean keep)
    {
        Map<String, BindProcedure> newBindings = new HashMap<String, BindProcedure>();
        
        if (keep) {
            for ( Map.Entry<String, BindProcedure> me : bindings.entrySet() ) {
                newBindings.put(me.getKey(),me.getValue());
            }
        }
        
        stack.push(bindings);
        bindings=newBindings;
    }

    public void popBind()
    {
        if (stack.isEmpty()) {
            throw new RuntimeException("Nothing to pop!");
        }
        
        bindings=stack.pop();
    }

    public void bind(String name,BindProcedure procedure)
    {
        bindings.put(name.toLowerCase(),procedure);
    }
    
    public void bind(String name,ClarionObject object)
    {
        bindings.put(name.toLowerCase(),new ObjectBindProcedure(object));
    }

    public void bind(String name,ClarionObject object,String sqlColumn,int sqlType)
    {
        bindings.put(name.toLowerCase(),new ViewObjectBindProcedure(object,sqlColumn,sqlType));
    }
    
    public void bind(ClarionGroup group)
    {
        for (int scan=1;scan<=group.getVariableCount();scan++) {
            ClarionObject co = group.flatWhat(scan);
            if (co==null) continue;
    
            bind(group.flatWho(scan),co);
        }
    }

    public void unbind(String name)
    {
        bindings.remove(name.toLowerCase());
    }

    public void unbind(ClarionGroup group)
    {
        for (int scan=1;scan<=group.getVariableCount();scan++) {
            ClarionObject co = group.flatWhat(scan);
            if (co==null) continue;
            
            unbind(group.flatWho(scan));
        }
    }
    
    public BindProcedure resolveBind(String name,boolean mustBeProcedure)
    {
        
        BindProcedure result = bindings.get(name.toLowerCase());

        if (result==null) {
            result = systemBindings.get(name.toLowerCase());
        }

        if (result==null) {
            throw new CExprError("Binding not found");
        }
        
        if (mustBeProcedure && !result.isProcedure()  ) {
            throw new CExprError("Cannot Access Variable as procedure");
        }
        
        return result;
    }
    
    public String toString()
    {
        return bindings.toString();
    }
}
