package org.jclarion.clarion.compile.expr;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.JavaClassConstruct;
import org.jclarion.clarion.compile.var.JavaClassExprType;
import org.jclarion.clarion.compile.var.JavaVariable;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.lang.NotClarionVisible;

public class JavaExprTypeMapper {

    public static ExprType importJava(Class<?> clazz)
    {
        // standard system expr
        ExprType e = ExprType.getJavaMapping(clazz);
        if (e != null) {
            if (e instanceof JavaClassExprType) {
                ScopeStack.getScope().addType(e);
            }
            return e;
        }

        // try a lookup of the type
        JavaClassConstruct jcc = new JavaClassConstruct(clazz, 
                importJava(clazz.getSuperclass()));

        ExprType et = ScopeStack.getScope().getType(jcc.getName());
        if (et != null) return et;

        ScopeStack.getScope().addType(jcc.getType());

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
     
        ExprType.addJavaMapping(clazz,jcc.getType());
        return jcc.getType();
    }
    
}
