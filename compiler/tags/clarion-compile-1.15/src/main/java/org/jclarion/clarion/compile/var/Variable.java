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
package org.jclarion.clarion.compile.var;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.JavaDependencies;
import org.jclarion.clarion.compile.java.JavaDependency;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.java.SimpleCollector;
import org.jclarion.clarion.compile.java.VariableUtiliser;
import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.ProcedureScope;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;

/**
 * Model a clarion variable
 * 
 * Clarion variables have following properties:
 * 
 *  * an expression type when variable is used in an expression context 
 *  * a label
 *  * Their owning scope
 *  * initialisation settings :
 *       + reference
 *       + field specific init parameters (i.e. string 10, default value), dim sizing
 *       
 * And the following abilities
 *  * ability to define Expr that references the variable from a given scope 
 *    (not necessarily the same scope that defined the variable)
 *  * ability to render construction and instantiation source code      
 * 
 * @author barney
 */
public abstract class Variable implements JavaDependency,VariableUtiliser
{
    private String      name;
    private Scope       scope;
    private ExprType    type;
    private boolean     reference;
    private boolean     Static;
    private boolean     external;
    private boolean     initConstructionMode;
    private boolean     escalatedReference=false;
    
    public Variable(String name,ExprType type,boolean reference,boolean st)
    {
        init(name,type,reference,st);
    }
    
    public Variable()
    {
    }
    
    public void escalateReference()
    {
        escalatedReference=true;
    }
    
    public boolean isEscalatedReference()
    {
        return escalatedReference;
    }

    public void init(String name,ExprType type,boolean reference,boolean st)
    {
        this.name=name;
        this.type=type;
        this.reference=reference;
        this.Static=st;
    }
    
    public void setScope(Scope scope)
    {
        if (this.scope!=null) {
            if (this.scope.isAncestorOf(scope)) return;
        }
        this.scope=scope;
    }
    
    public Scope getScope()
    {
        return scope;
    }
    
    public String getName()
    {
        return name;
    }
    
    private String prefixedName;
    
    public void addPrefixedJavaName(String prefix)
    {
        if (prefixedName==null) {
            prefixedName=prefix;
        } else {
            prefixedName=prefix+prefixedName;
        }
            
    }

    public String getPrefixedName()
    {
        if (prefixedName==null) return "";
        return prefixedName;
    }
    
    public String getJavaName()
    {
        if (prefixedName!=null) {
            return Labeller.get(prefixedName+getName(),false);
        } else {
            return Labeller.get(getName(),false);
        }
    }
    
    public ExprType getType()
    {
        return type;
    }
    
    public String getEscalatedJavaName(Scope useScope)
    {
        return getJavaName();
    }
    
    public boolean isEscalatedScope(Scope callingScope)
    {
        if (callingScope==getScope()) return false;
        
        if (callingScope instanceof RoutineScope) {
            if (callingScope.getParent() == getScope() ) {
                if (getScope() instanceof ProcedureScope) {
                    if (getScope().getParent() instanceof ModuleScope) {
                        if ( ( (ModuleScope) getScope().getParent() ).getModuleClass().isSingleFunctionModule() ) {
                            return false;
                        }
                    }
                }
            }
        }
        
        return true;
    }
    
    public VariableExpr getExpr(Scope callingScope)
    {
        Expr e= new SimpleExpr(
                JavaPrec.LABEL,getType(),getJavaName());
        
        if (callingScope!=getScope() && getScope()!=null) {
    
            boolean escalate=true;
            
            if ((getScope()==MainScope.main) || (getScope() instanceof ModuleScope) ) {
                // main scope is easy to deal with because all static publics
                e = new DecoratedExpr(JavaPrec.POSTFIX,getScope().getJavaClass().getName()+".",e);
                e = new DependentExpr(e,getScope().getJavaClass());
                escalate=false;
            }

            if (escalate) {
                
                while ( true ) {
                    // escalate single module mode reference if applicable
                    if (!(getScope() instanceof ProcedureScope)) break;
                    if (!(getScope().getParent() instanceof ModuleScope)) break;
                    
                    ModuleScope ms = (ModuleScope)getScope().getParent();
                    if (!ms.getModuleClass().isSingleFunctionModule()) break;

                    if ((callingScope instanceof RoutineScope) && callingScope.getParent().getParent()==ms) break;
                    
                    escalate=false;
                    e = new DecoratedExpr(JavaPrec.POSTFIX,"_owner.",e);
                    Scope scan=callingScope;
                    while ( true ) {
                        
                        if (scan==getScope())           break;
                        if (scan==null)                 break;
                        if (!isEscalatedScope(scan))    break;
                        if (!scan.escalateModule(ms))   break;
                        scan=scan.getParent();
                    }
                
                    break;
                }
            }

            if (escalate) {
                // escalate variable
                Scope scan=callingScope;
                while ( true ) {
                    
                    if (scan==getScope())           break;
                    if (scan==null)                 break;
                    if (!isEscalatedScope(scan))    break;
                    
                    if (!scan.escalateVariable(this)) break;
                    scan=scan.getParent();
                }
            }
        }
        
        return new VariableExpr(e,this);
    }

    private JavaDependency getEscalatedDependency(JavaDependency dep)
    {
        if (isEscalatedReference()) {
            return new JavaDependencies(dep,new SimpleCollector(ClarionCompiler.CLARION+".runtime.ref.RefVariable"));
        }
        return dep;
        
    }

    public final JavaDependency getDefinitionDependency()
    {
        return getEscalatedDependency(getType());
    }
    
    public final JavaDependency getConstructionDependency()
    {
        return getEscalatedDependency(getConstructionExpr());
    }
    
    public final void generateDefinition(StringBuilder buffer) 
    {
        // Generate definition
        if (isEscalatedReference()) {
            buffer.append("RefVariable<");
        }
        getType().generateDefinition(buffer);
        if (isEscalatedReference()) {
            buffer.append(">");
        }
        buffer.append(' ');
        buffer.append(getJavaName());
    }

    public final void generateType(StringBuilder buffer) 
    {
        // Generate definition
        if (isEscalatedReference()) {
            buffer.append("RefVariable<");
        }
        getType().generateDefinition(buffer);
        if (isEscalatedReference()) {
            buffer.append(">");
        }
    }
    
    private Expr constructionExpr       = null;
    private Expr simpleConstructionExpr = null;
    private Expr initExpr               = null;
    private boolean made                = false;
    
    protected final void make()
    {
        if (made) return;
        made=true;
        Expr[] r = makeConstructionExpr();
        if (r==null) return;
        constructionExpr=r[0];
        if (r.length>=2) simpleConstructionExpr=r[1];
        if (simpleConstructionExpr==null) simpleConstructionExpr=constructionExpr;
        if (r.length>=3) initExpr=r[2]; 
    }
    
    protected final Expr getConstructionExpr()
    {
        make();
        if (isEscalatedReference()) {
            ExprBuffer eb;
            if (isThread()) {
                eb = new ExprBuffer(JavaPrec.POSTFIX,constructionExpr.type());
                eb.add("(new ");
            } else {
                eb = new ExprBuffer(JavaPrec.CREATE,constructionExpr.type());
                eb.add("new ");
            }
            eb.add("RefVariable");
            eb.add("<");
            if (getType().getReal()==null) {
                eb.add("Object");
            } else {
                eb.add(getType().generateDefinition());
            }
            eb.add(">(");
            eb.add(constructionExpr);
            eb.add(")");
            if (isThread()) {
                eb.add(").setThread()");
            }
            return eb;
        }
        return constructionExpr;
    }
    
    protected boolean isThread()
    {
        return false;
    }
    
    protected final Expr getSimpleConstructionExpr()
    {
        make();
        if (isEscalatedReference()) {
            ExprBuffer eb = new ExprBuffer(JavaPrec.CREATE,simpleConstructionExpr.type());
            eb.add("new ");
            eb.add(getType().generateDefinition());
            eb.add("(");
            eb.add(simpleConstructionExpr);
            eb.add(")");
            return eb;
        }
        return simpleConstructionExpr;
    }
    
    protected final Expr getInitExpression()
    {
        make();
        return initExpr;
    }

    public Expr[] makeConstructionExpr(boolean thread) {
        if (thread) throw new RuntimeException("Cannot thread this constructor");
        return makeConstructionExpr();
    }
    
    public abstract Expr[] makeConstructionExpr();

    public void generateConstruction(StringBuilder buffer)
    {
        getConstructionExpr().toJavaString(buffer);
    }

    public void generate(StringBuilder buffer)
    {
        generateDefinition(buffer);
        if (getConstructionExpr()!=null) {
            buffer.append('=');
            generateConstruction(buffer);
        }
    }

    public void generateInitCapable(StringBuilder buffer)
    {
        generateDefinition(buffer);
        if (getConstructionExpr()!=null) {
            buffer.append('=');
            if (initConstructionMode && getInitExpression()!=null) {
                getSimpleConstructionExpr().toJavaString(buffer);
            } else {
                generateConstruction(buffer);
            }
        }
    }
    
    public void generateInit(String prefix, StringBuilder main,JavaDependencyCollector collector) {
        if (initConstructionMode && getInitExpression()!=null) {
            main.append(prefix);
            getInitExpression().toJavaString(main);
            getInitExpression().collate(collector);
            main.append(";\n");
        }
        
    }
    
    public String generate()
    {
        StringBuilder out = new StringBuilder();
        generate(out);
        return out.toString();
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        if (getConstructionExpr()!=null) {
            getConstructionExpr().collate(collector);
        }
        if (isEscalatedReference()) {
            collector.add(ClarionCompiler.CLARION+".runtime.ref.RefVariable");
        }
        getType().collate(collector);
    }

    public boolean constructionUtilises(Set<Variable> vars) {
        return getConstructionExpr().utilises(vars);
    }
    
    @Override
    public boolean utilises(Set<Variable> vars) {
        if (vars.contains(this)) return true;
        if (getType() instanceof VariableUtiliser) {
            if (((VariableUtiliser)getType()).utilises(vars)) return true;
        }
        return getConstructionExpr().utilises(vars);
    }
    
    public boolean utilisesReferenceVariables()
    {
        if (this.isReference()) return true;
        if (getType() instanceof VariableUtiliser) {
            if (((VariableUtiliser)getType()).utilisesReferenceVariables()) return true;
        }
        return getConstructionExpr().utilisesReferenceVariables();
    }
    
    public boolean isReference()
    {
        return reference;
    }
    
    public abstract Variable clone();

    public boolean isStatic() {
        return Static;
    }

    public boolean isExternal() {
        return external;
    }

    public void setExternal(boolean external) {
        this.external = external;
    }

    public boolean isInitConstructionMode() {
        return initConstructionMode;
    }

    public void setInitConstructionMode(boolean initConstructionMode) {
        this.initConstructionMode = initConstructionMode;
    }

    public void escalateDeepReferences() 
    {
        Map<Variable,Boolean> ref = new HashMap<Variable, Boolean>();
        escalateDeepReferences(ref);
    }
   
    private void escalateDeepReferences(Map<Variable,Boolean> ref)
    {
        if (ref.containsKey(this)) return;
        ref.put(this,true);
        
        if (isReference()) {
            escalateReference();
        }
        
        Scope s = getType().getDefinitionScope();
        if (s!=null) {
            for (Variable v : s.getVariables() ) {
                v.escalateDeepReferences();
            }
        }
    }
    
}
