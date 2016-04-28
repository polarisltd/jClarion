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
import java.util.logging.Logger;

/*
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
*/

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.BindProcedure2;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.lang.LexType;
//import org.jclarion.clarion.antlr.ClarionExprLexer;
//import org.jclarion.clarion.antlr.ClarionExprParser;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.primative.ActiveThreadMap;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprError;
import org.jclarion.clarion.runtime.expr.CExprType;
import org.jclarion.clarion.runtime.expr.LabelExprResult;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;
import org.jclarion.clarion.view.ClarionView;

public class CExprImpl {
	private static Logger log = Logger.getLogger(CExprImpl.class.getName());
	
    private static ActiveThreadMap<CExprImpl> instance =new ActiveThreadMap<CExprImpl>();
    

    private Map<String,LabelExprResult> bindings;
    
    private Stack<Map<String,LabelExprResult>> stack;
    
    
    public static CExprImpl getInstance()
    {
    	CExprImpl i = instance.get(Thread.currentThread());
    	if (i==null) {
    		i=new CExprImpl();
    		instance.put(Thread.currentThread(),i);
    	}
        return i;
    }

    private Map<String,LabelExprResult> systemBindings=new HashMap<String, LabelExprResult>();
    
    public CExprImpl() {
        stack=new Stack<Map<String, LabelExprResult>>();
        bindings=new HashMap<String, LabelExprResult>();
        
        systemBindings.put("upper",new SQLBindProcedure("UPPER",CExprType.STRING,CExprType.STRING) {        	
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				log.fine("UPPER() execute "+p[0].getString());
				return p[0].getString().upper();
			}
        });
        systemBindings.put("sub",new SQLBindProcedure("SUB",CExprType.STRING,CExprType.NUMERIC,CExprType.NUMERIC) {        	
			@Override
			public ClarionObject execute(ClarionObject[] p) {
				log.fine("SUB() execute "+p[0].getString());
				return p[0].getString();
			}
        });
        
        
        
        CRun.addShutdownHook(new Runnable() { 
            public void run()
            {
            	instance.clear();
            }
        } );
    }

    public CExpr compile(String aString)
    {
    	aString = aString.replaceAll("\\u000A", "");
    	log.fine("compile(String) "+aString+" ENTRY");
    	CErrorImpl.getInstance().clearError();
        
        StringReader sr = new StringReader(aString);
        Lexer l = new Lexer(sr);
        l.setJavaMode(false);
        l.setIgnoreWhitespace(true);   
        CExpr expr = compile(aString,l,LexType.eof);
        log.fine("compile(String) "+aString+" RETURN");
        return expr;
    }

    public CExpr compile(String aString,Lexer l,LexType end)
    {

     	log.fine("compile(String,Lexer,LexType) "+aString+" ENTRY");
    	Parser p = new Parser(l);
        
        try {
            return p.expr(end);
        } catch (ParseException e) { 
        	log.fine("CExprError error 800, "+aString+" := "+e.getMessage());
            CErrorImpl.getInstance().setError(800,e.getMessage());
            return null;
        } catch (CExprError e) {
        	log.fine("CExprError error 801, "+aString+" := "+e.getMessage());
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
    	log.fine("evaluate() "+aString+" ENTRY");
    	CExpr exp = compile(aString);
        if (exp==null) {
            return new ClarionString("");
        }

        CErrorImpl.getInstance().clearError();

        try {
            ClarionObject o = exp.eval();
            if (o instanceof ClarionBool) {
            	log.fine("evaluate() "+aString + " := "+o.boolValue());
                return new ClarionString(o.boolValue() ? "1" : "0");
            }
            log.fine("evaluate() "+aString + " := "+o.getString());
            return o.getString();
        } catch (CExprError e) {
        	log.fine("CExprError error 801 "+aString+" := "+e.getMessage());
            CErrorImpl.getInstance().setError(801,e.getMessage());
            return new ClarionString("");
        }
    }
    
    public void pushBind(boolean keep)
    {
        Map<String, LabelExprResult> newBindings = new HashMap<String, LabelExprResult>();
        
        if (keep) {
            for ( Map.Entry<String, LabelExprResult> me : bindings.entrySet() ) {
                newBindings.put(me.getKey(),me.getValue());
            }
        }
        
        stack.push(bindings);
        bindings=newBindings;
    }

    public void popBind()
    {
        if (stack.isEmpty()) {
        	log.fine("!!! Nothing to pop!");
            throw new RuntimeException("Nothing to pop!");
        }
        
        bindings=stack.pop();
    }

    public void bind(String name,LabelExprResult procedure)
    {
    	log.fine("bind() "+name+" procedure:LabelExprResult: "+procedure);
        bindings.put(name.toLowerCase(),procedure);
    }
    
    public void bind(String name,ClarionObject object)
    {
    	log.fine("bind() "+name+" ClarionObject: "+object);
    	bindings.put(name.toLowerCase(),new ObjectBindProcedure(object));
    }

    public void bind(String name,ClarionObject object,String sqlColumn,int sqlType)
    {
    	log.fine("bind() "+name+" ClarionObject: "+object+" sqlColumn: "+sqlColumn+" sqlType: "+sqlType);
    	bindings.put(name.toLowerCase(),new ViewObjectBindProcedure(object,sqlColumn,sqlType));
    }
    
    public void bind(ClarionGroup group)
    {
    	log.fine("bind() ClarionGroup: "+group);
        for (int scan=1;scan<=group.getVariableCount();scan++) {
            ClarionObject co = group.flatWhat(scan);
            if (co==null) continue;
    
            bind(group.flatWho(scan),co);
        }
    }

    public void unbind(String name)
    {
    	log.fine("unbind() name: "+name);
    	bindings.remove(name.toLowerCase());
    }

    public void unbind(ClarionGroup group)
    {
       	log.fine("unbind() ClarionGroup: "+group);
    	for (int scan=1;scan<=group.getVariableCount();scan++) {
            ClarionObject co = group.flatWhat(scan);
            if (co==null) continue;
            
            unbind(group.flatWho(scan));
        }
    }
    
    public LabelExprResult resolveBind(String name,boolean mustBeProcedure)
    {
    	LabelExprResult result = bindings.get(name.toLowerCase());
        if (result==null) {
            result = systemBindings.get(name.toLowerCase());
        }

        log.fine("resolveBind()  bindings.get() name: "+name+" = "+result);
        
        if (result==null) {
            log.fine("resolveBind !!!binding not found "+name);        	
            throw new CExprError("Binding not found "+name);
        }
        
        if (mustBeProcedure) {
        	if (!(result instanceof BindProcedure) && !(result instanceof BindProcedure2)) {
        		log.fine("resolveBind !!!throwing cannot Access Variable as procedure: "+result.getClass());
        		throw new CExprError("Cannot Access Variable as procedure: "+result.getClass());
        	}
        }
        
        return result;
    }
    @Override
    public String toString()  // hopefully we are allowed to update this?
    {
        String items = "";
    	for(String s :bindings.keySet()){
        	items += (s+"  ");
        }
    	return bindings.toString()+" "+items;
    }
}
