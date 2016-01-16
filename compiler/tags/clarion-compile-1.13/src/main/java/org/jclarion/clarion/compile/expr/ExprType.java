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
package org.jclarion.clarion.compile.expr;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionBlob;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.java.JavaDependency;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.view.ClarionView;

/**
 * Define output types for expressions
 * 
 * This object codifies concerns such as how to apply postfixing 
 * operations
 * 
 * @author barney
 */

public abstract class ExprType implements JavaDependency 
{
    public static final FilledExprType NULL;
    
    public static final FilledExprType object;
    public static final FilledExprType prototype;
    
    public static final FilledExprType rawstring;
    public static final FilledExprType rawint;
    public static final FilledExprType rawboolean;
    public static final FilledExprType rawdecimal;
    
    public static final FilledExprType any;
    public static final FilledExprType concrete_any;
    
    public static final FilledExprType string;
    public static final FilledExprType decimal;
    public static final FilledExprType number;
    public static final FilledExprType bool;
    public static final FilledExprType real;

    public static final FilledExprType blob;
    
    public static final FilledExprType group;
    public static final FilledExprType queue;

    public static final FilledExprType bean;
    
    public static final FilledExprType file;
    public static final FilledExprType key;
    public static final FilledExprType view;
    
    public static final FilledExprType picture;

    public static final FilledExprType target;
    public static final FilledExprType windowtarget;
    public static final FilledExprType window;
    public static final FilledExprType application;
    public static final FilledExprType report;
    public static final FilledExprType control;

    public static final FilledExprType printer;
    public static final FilledExprType system;

    private static Map<String,ExprType> systemTypes=new HashMap<String, ExprType>();

    private static Map<Class<?>,ExprType> javaMappings=new HashMap<Class<?>,ExprType>();
    private static Map<Class<?>,ExprType> extraJavaMappings=new HashMap<Class<?>,ExprType>();
    
    static {
        
        NULL = new NullExprType();
        
        object      = new DumbExprType("javaobject",null);
        prototype   = new DumbExprType("prototype",null);
        rawstring   = new RawExprType("rawstring",".toString()","String");
        rawint      = new RawExprType("rawint",".intValue()","int");
        rawboolean  = new RawExprType("rawboolean",".boolValue()","boolean");
        rawdecimal  = new RawExprType("rawdecimal",".toString()","String");
        picture     = new RawExprType("rawpicture",".toString()","String");

        any             = new SystemExprType("object",object,0,null,null);

        concrete_any    = new SystemExprType("any",any,0,"Clarion.newAny(",null);

        string      = new SystemExprType("string",any,0,"Clarion.newString(",".getString()");
        
        decimal     = new SystemExprType("decimal",any,0,"Clarion.newDecimal(",".getDecimal()");
        number      = new SystemExprType("number",any,0,"Clarion.newNumber(",".getNumber()");
        bool        = new SystemExprType("bool",any,0,"Clarion.newBool(",".getBool()");
        real        = new SystemExprType("real",any,0,"Clarion.newReal(",".getReal()");

        blob        = new SystemExprType("blob",object,0,null,null);

        bean        = new DumbExprType("bean",object);

        target      = new DumbExprType("target",bean);
        windowtarget= new DumbExprType("windowtarget",target);
        
        window      = new SystemExprType("window",windowtarget,0,null,null);
        application = new SystemExprType("application",window,0,null,null);
        report      = new SystemExprType("report",target,0,null,null);

        control     = new DumbExprType("control",bean);

        group       = new SystemExprType("group",object,0,null,null) {
            @Override
            public Expr field(Expr in, String field) {
                return new DecoratedExpr(JavaPrec.POSTFIX,ExprType.any,null,in,".getGroupParam(\""+field+"\")");
            }
        };
        
        queue       = new SystemExprType("queue",group,0,null,null);
        file        = new SystemExprType("file",group,0,null,null);
        key         = new SystemExprType("key",bean,0,null,null);
        view        = new SystemExprType("view",bean,0,null,null);
   
        printer     = new DumbExprType("printer",bean);
        system      = new DumbExprType("system",bean);

        string.add(new DecoratedCastFactory(group,JavaPrec.POSTFIX,null,JavaPrec.POSTFIX,".getString()"));
        string.add(new DecoratedCastFactory(rawint,JavaPrec.POSTFIX,"Clarion.newString(String.valueOf(",JavaPrec.LABEL,"))",ClarionCompiler.CLARION+".Clarion"));
        
        rawstring.add(new DecoratedCastFactory(rawint,JavaPrec.POSTFIX,"String.valueOf(",JavaPrec.POSTFIX,")"));
        rawstring.add(new DecoratedCastFactory(rawdecimal,JavaPrec.POSTFIX,null,JavaPrec.POSTFIX,null));
        rawstring.add(new DecoratedCastFactory(rawboolean,JavaPrec.TERNARY,null,JavaPrec.TERNARY,"?\"1\":\"\""));

        rawdecimal.add(new DecoratedCastFactory(rawint,JavaPrec.POSTFIX,"String.valueOf(",JavaPrec.POSTFIX,")"));
        rawdecimal.add(new DecoratedCastFactory(rawstring,JavaPrec.POSTFIX,null,JavaPrec.POSTFIX,null));
        rawdecimal.add(new DecoratedCastFactory(rawboolean,JavaPrec.TERNARY,null,JavaPrec.TERNARY,"?\"1\":\"0\""));

        rawboolean.add(new DecoratedCastFactory(rawint,JavaPrec.EQUALITY,null,JavaPrec.EQUALITY,"!=0"));
        rawboolean.add(new DecoratedCastFactory(rawstring,JavaPrec.EQUALITY,null,JavaPrec.POSTFIX,".length()!=0"));
        rawboolean.add(new DecoratedCastFactory(rawdecimal,JavaPrec.POSTFIX,"Clarion.newDecimal(",JavaPrec.POSTFIX,").boolValue()"));

        rawint.add(new DecoratedCastFactory(rawboolean,JavaPrec.TERNARY,null,JavaPrec.TERNARY,"?1:0"));
        rawint.add(new DecoratedCastFactory(rawstring,JavaPrec.POSTFIX,"Integer.parseInt(",JavaPrec.POSTFIX,")"));
        rawint.add(new DecoratedCastFactory(rawdecimal,JavaPrec.POSTFIX,"Clarion.newDecimal(",JavaPrec.POSTFIX,").intValue()"));
        
        any.add(new AlternateCastFactory(rawint,number));
        any.add(new AlternateCastFactory(rawstring,string));
        any.add(new AlternateCastFactory(rawdecimal,decimal));
        any.add(new AlternateCastFactory(rawboolean,bool));

        javaMappings.put(Object.class,object);
        javaMappings.put(String.class,rawstring);
        javaMappings.put(int.class,rawint);
        javaMappings.put(Integer.class,rawint);
        javaMappings.put(boolean.class,rawboolean);
        javaMappings.put(Boolean.class,rawboolean);
        // raw decimal not supported
        
        javaMappings.put(ClarionObject.class,any);
        javaMappings.put(ClarionAny.class,concrete_any);

        javaMappings.put(ClarionString.class,string);
        javaMappings.put(ClarionDecimal.class,decimal);
        javaMappings.put(ClarionNumber.class,number);
        javaMappings.put(ClarionBool.class,bool);
        javaMappings.put(ClarionReal.class,real);
        javaMappings.put(ClarionBlob.class,blob);
        javaMappings.put(ClarionGroup.class,group);
        javaMappings.put(ClarionQueue.class,queue);
        javaMappings.put(ClarionFile.class,file);
        javaMappings.put(ClarionKey.class,key);
        javaMappings.put(ClarionView.class,view);

        javaMappings.put(AbstractTarget.class,target);
        javaMappings.put(AbstractWindowTarget.class,windowtarget);
        javaMappings.put(ClarionWindow.class,window);
        javaMappings.put(ClarionApplication.class,window);
        javaMappings.put(ClarionReport.class,report);
    };

    public static ExprType getJavaMapping(Class<?> clazz)
    {
        ExprType match = javaMappings.get(clazz);
        if (match==null) match=extraJavaMappings.get(clazz);
        return match;
    }
    
    public static void clear()
    {
        extraJavaMappings.clear();
    }
    
    public static void addJavaMapping(Class<?> clazz,ExprType type) {
        extraJavaMappings.put(clazz,type);
    }
    
    public static ExprType get(String type)
    {
        return systemTypes.get(type);
    }

    static void put(String type,ExprType val)
    {
        systemTypes.put(type,val);
    }
    
    public static Expr toAny(Expr e)
    {
        if (!e.type().getName().startsWith("raw")) {
            if (e.type().isa(group)) return string.cast(e);
            return e;
        }
        if (e.type().same(rawint)) return number.cast(e);
        if (e.type().same(rawstring)) return string.cast(e);
        if (e.type().same(picture)) return string.cast(e);
        if (e.type().same(rawboolean)) return bool.cast(e);
        if (e.type().same(rawdecimal)) return decimal.cast(e);
        
        return e;
    }
    
    protected ExprType()
    {
    }

    public abstract ExprType getReal();
    
    public abstract boolean isRaw();
    
    public abstract String getName();
    
    public abstract int getArrayDimSize();
    
    public abstract ExprType getBase();

    public abstract boolean isSystem();

    public abstract boolean same(ExprType test);
    
    /**
     * Return true if this type can be consider same type as test
     * 
     *  string.isa(any) return true
     *  any.isa(string) return false
     * 
     * @param test
     * @return
     */
    public abstract boolean isa(ExprType test);

    public abstract Expr cast(Expr in);

    public abstract Expr array(Expr in,Expr subscript);
    
    public abstract Expr splice(Expr in,Expr left,Expr right);
    
    public abstract Expr property(Expr in,Expr keys[]); 

    public abstract Expr field(Expr in,String field);

    public abstract Expr prototype(Expr in,String field);
    
    public abstract Expr method(Expr in,String field,Expr params[]);
   
    public abstract boolean isDestroyable();

    public abstract Expr destroy(Expr in);
    
    public abstract ExprType changeArrayIndexCount(int count);
    
    public abstract String generateDefinition();
    
    public abstract void generateDefinition(StringBuilder out);
    
    // for complex types - get scope object that represents definition of typew
    public abstract Scope getDefinitionScope();
    
}
