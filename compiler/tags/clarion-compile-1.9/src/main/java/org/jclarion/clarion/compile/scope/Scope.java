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
package org.jclarion.clarion.compile.scope;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;


import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DanglingExprType;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.AliasVariable;
import org.jclarion.clarion.compile.var.RemoteRoutineVariable;
import org.jclarion.clarion.compile.var.UseVariable;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.util.EmptyIterable;

public abstract class Scope {

    private static Logger log = Logger.getLogger(Scope.class.getName()); 
    
    // ordering of variables important - hence use of linked hash map
    private Map<String,Variable>         variables=new LinkedHashMap<String, Variable>();
    private Map<String,Variable>         localVariables=new HashMap<String, Variable>();
    private Map<String,AliasVariable>    aliasVariables=new LinkedHashMap<String, AliasVariable>();
    private boolean variableDisorder=false;

    private List<Procedure>         procedures=new ArrayList<Procedure>();
    
    // ordering of types not important. hashmap only will suffice
    private Map<String,ExprType>    types=new HashMap<String, ExprType>(); 
    
    
    private Scope _parent;

    private JavaClass   javaClass;

    private static IdentityHashMap<Scope,Boolean> disorderedScopes=new IdentityHashMap<Scope, Boolean>();
    
    public static void clean()
    {
        disorderedScopes.clear();
    }
    
    public static void fixDisorderedScopes()
    {
        for ( Scope s : disorderedScopes.keySet()) {
            s.fixDisorder();
        }
        disorderedScopes.clear();
    }
    
    
    public Scope getParent()
    {
        return _parent;
    }
    
    public Scope getStackParent()
    {
        return getParent();
    }
    
    public void setParent(Scope parent)
    {
        this._parent=parent;
    }
    
    public void addVariable(Variable aVariable)
    {
        
        if (aVariable instanceof AliasVariable) {
            
            AliasVariable av = (AliasVariable)aVariable; 
            // do not add alias if it is the same name as variable
            // it is aliasing!
            if (variables.get(getLookupVariableName(av)) == av.getBase()) return;
            aliasVariables.put(getLookupVariableName(aVariable),(AliasVariable) aVariable);
            aVariable.setScope(this);
            return;
        }
    
        if (this instanceof StaticScope) {
            aVariable.setScope(this);
            MainScope.main.registerStaticVariable(aVariable);
            simpleAddVariable(aVariable);
        }
        
        if (aVariable.isStatic() && !(this instanceof StaticScope)) {
            
            Scope scan = this;
            while (!(scan instanceof StaticScope)) {
                aVariable.addPrefixedJavaName(scan.getName()+"_");
                scan=scan.getParent(); 
            };

            ((StaticScope)scan).addStaticVariable(aVariable);
            aVariable.setScope(scan);
            
            localVariables.put(getLookupVariableName(aVariable),aVariable);
            
            MainScope.main.registerStaticVariable(aVariable);

            return;
        }

        simpleAddVariable(aVariable);
        aVariable.setScope(this);
    }
    
    protected void simpleAddVariable(Variable aVariable)
    {
        variables.put(getLookupVariableName(aVariable),aVariable);
        if (variables.size()>1) {
            variableDisorder=true;
            disorderedScopes.put(this,true);
        }
    }
    
    public Variable getVariableThisScopeOnly(String name)
    {
        Variable v = variables.get(name.toLowerCase());
        if (v==null) v = localVariables.get(name.toLowerCase());
        return v;
    }

    public Variable getVariable(String name)
    {
        Variable v = getVariableThisScopeOnly(name);
        if (v!=null) return v;
        if (getParent()!=null) {
            return getParent().getVariable(name);
        }
        return null;
    }

    public Variable getAliasVariableThisScopeOnly(String name)
    {
        AliasVariable av = aliasVariables.get(name.toLowerCase());
        if (av==null) return null;
        return av.getBase();
    }

    public Variable getAliasVariable(String name)
    {
        Variable v = getAliasVariableThisScopeOnly(name);
        if (v!=null) return v;
        if (getParent()!=null) {
            return getParent().getAliasVariable(name);
        }
        return null;
    }
    
    private static class OrderedImprint
    {
        private Variable[] order;
        private int hash;
        
        public OrderedImprint(Variable order[])
        {
            this.order=new Variable[order.length];
            hash=0;
            for (int scan=0;scan<this.order.length;scan++) {
                this.order[scan]=order[scan];
                hash=hash*17+(this.order[scan].hashCode()%17);
            }
        }

        @Override
        public boolean equals(Object obj) {
            OrderedImprint oi = (OrderedImprint)obj;
            for (int scan=0;scan<order.length;scan++) {
                if (order[scan]!=oi.order[scan]) return false;
            }
            return true;
        }

        @Override
        public int hashCode() {
            return hash;
        }
    }
    
    public void fixDisorder()
    {
        getVariables();
    }

    public Iterable<Variable> getVariables()
    {
        if (variableDisorder) {
     
            Set<OrderedImprint> priorPasses=new HashSet<OrderedImprint>();
            
            Variable order[]=new Variable[variables.size()];
            variables.values().toArray(order);
            for (int scan=0;scan<order.length;scan++) {
                order[scan].setInitConstructionMode(false);
            }
            
            Set<Variable> test=new HashSet<Variable>();
            Set<Variable> single=new HashSet<Variable>(1);
            
            while (variableDisorder) {
                
                variableDisorder=false;
                
                test.clear();
                
                // scan backwards adding one item at a time. As soon as we add an item
                // that has dependencies on previously added items we have an ordering problem
                
                for (int scan=order.length-1;scan>=0;scan--) {
                
                    // using init construction mode, no need to test order for this one
                    if (order[scan].isInitConstructionMode()) {
                        continue;
                    }

                    test.add(order[scan]);

                    if (!order[scan].constructionUtilises(test)) {
                        continue;
                    }

                    
                    variableDisorder = true;

                    Set<Variable> dependent=new HashSet<Variable>();
                    dependent.add(order[scan]);
                    
                    Iterator<Variable> tscan = test.iterator();
                    while (tscan.hasNext()) {
                        Variable verify = tscan.next(); 
                        if (dependent.contains(verify)) continue;
                        
                        single.clear();
                        single.add(verify);
                        
                        for ( Variable tscan2 : dependent ) {
                            if (tscan2.constructionUtilises(single)) {
                                dependent.add(verify);
                                break;
                            }
                        }
                    }
                        
                    int reorder[] = new int[dependent.size()];
                    int pos = 0;
                    // add the remaining objects
                    for (int tscan2 = scan; tscan2 < order.length; tscan2++) {
                        Variable dependency=order[tscan2];
                        if (dependent.contains(dependency)) {
                            reorder[pos++] = tscan2;
                        }
                    }

                    // reorganise objects in the original slots
                    Variable move = order[scan];
                    for (int shift = 0; shift < reorder.length - 1; shift++) {
                        order[reorder[shift]] = order[reorder[shift + 1]];
                    }
                    order[reorder[reorder.length - 1]] = move;

                    // check if we are not looping indefinitely
                    OrderedImprint oi = new OrderedImprint(order);
                    if (priorPasses.contains(oi)) {
                        move.setInitConstructionMode(true);
                        move.getType().getDefinitionScope().getJavaClass().setInitConstructionMode(true);
                    } else {
                        priorPasses.add(oi);
                    }

                    // try again from the top
                    break;
                }
            }
            
            // rebuild list anew
            variables.clear();
            for (int scan=0;scan<order.length;scan++) {
                variables.put(getLookupVariableName(order[scan]),order[scan]);
            }
            
        }
        
        return variables.values();
    }

    @SuppressWarnings("unused")
    private void logDisorder(Variable[] order) {
        
        Set<Variable> single=new HashSet<Variable>();
        
        for (int s2=0;s2<order.length;s2++) {
            System.out.print(order[s2].getName()+" "+order[s2].getType()+":");
            for (int s3=0;s3<order.length;s3++) {
                if (s2==s3) continue;
                single.clear();
                single.add(order[s3]);
                if (order[s2].constructionUtilises(single)) {
                    System.out.print(" "+order[s3].getName());
                }
            }
            System.out.println("");
        }
    }

    protected String getLookupVariableName(Variable aVariable)
    {
        return aVariable.getName().toLowerCase();
    }
    
    
    /*
    private void logOrder(String prefix,Variable[] v)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(prefix);
        for (int scan=0;scan<v.length;scan++) {
            if (scan>0) sb.append(',');
            sb.append(v[scan].getName());
        }
        System.out.println(sb.toString());
    }
    */

    public void fulfillType(ExprType aType)
    {
        String lookup=aType.getName().toLowerCase();
        
        ExprType et = types.get(lookup);
        if (et!=null && et instanceof DanglingExprType) {
            ((DanglingExprType)et).fulfill(aType);
            //types.put(lookup,aType);
            return;
        }
        
        if (getParent()!=null) getParent().fulfillType(aType);
    }

    public void addAliasedType(String alias,ExprType aType)
    {
        ExprType et = getType(alias.toLowerCase());
        if (et!=null && (et instanceof DanglingExprType)) {
            fulfillType(aType);
        }
        types.put(alias.toLowerCase(),aType);
    }

    public final void addType(ExprType aType)
    {
        addType(aType,this);
    }
    
    public void addType(ExprType aType,Scope originatingScope)
    {
        if (!(aType instanceof DanglingExprType)) {
            DanglingExprType det = DanglingExprType.find(aType.getName());
            if (det!=null) {
                boolean ret=false;
                Scope scan = originatingScope;
                while (scan!=null) {
                    if (scan instanceof ReturningScope) {
                        ret=true;
                        break;
                    }
                    scan=scan.getParent();
                }
            
                if (!ret) {
                    det.fulfill(aType);
                }
            }
        }
        
        types.put(aType.getName().toLowerCase(),aType);
    }
    
    public ExprType getTypeThisScopeOnly(String name)
    {
        return types.get(name.toLowerCase());
    }

    public ExprType getType(String name)
    {
        ExprType v = getTypeThisScopeOnly(name);
        if (v!=null) return v;
        if (getParent()!=null) {
            return getParent().getType(name);
        }
        return null;
    }
    
    public Iterable<ExprType> getTypes()
    {
        return types.values();
    }
    
    
    private Map<String,Integer> temporaryLabels;
    
    public String createTemporaryLabel(String prefix)
    {
        if (temporaryLabels==null) {
            temporaryLabels=new HashMap<String, Integer>();
        }
        
        Integer obj_i = temporaryLabels.get(prefix);
        int i=0;
        if (obj_i!=null) i = obj_i;
        i++;
        temporaryLabels.put(prefix,i);
        return prefix+i;
    }
    
    private Map<String,List<Procedure>> procedureNameCache=new HashMap<String, List<Procedure>>();

    public Procedure addProcedure(Procedure p,boolean reportDuplicates)
    {
        String lookup = p.getName().toLowerCase();
        
        List<Procedure> l = procedureNameCache.get(lookup);
        if (l==null) {
            l=new ArrayList<Procedure>();
            procedureNameCache.put(lookup,l);
        } else {
            // check if it already exists
            
            for ( Procedure test : l ) {
                if (test.matches(p,Procedure.MATCH_EXACT)) {
                    if (reportDuplicates) {
                        log.warning("Duplicate procedure definition:"+p);
                    }
                    return test;
                }
            }
        }
        
        l.add(p);
        procedures.add(p);
        p.setScope(this);
        return p;
    }
    
    public List<Procedure> getProcedures()
    {
        return procedures;
    }
    
    public Iterable<Procedure> getProcedures(String label)
    {
        List<Procedure> l = procedureNameCache.get(label.toLowerCase());
        if (l!=null) return l; 
        return new EmptyIterable<Procedure>();
    }

    public Procedure matchProcedure(String label,Expr params[])
    {
        Procedure p = matchProcedureThisScopeOnly(label, params);
        if (p!=null) return p;
        
        if (getParent()!=null) {
            return getParent().matchProcedure(label,params);
        } else {
            return null;
        }
    }

    public boolean isClashingProcedure(String label,Param params[])
    {
        List<Procedure> l = procedureNameCache.get(label.toLowerCase());
        if (l!=null) {
            for ( Procedure p : l ) {
                if (p.matches(params,Procedure.MATCH_EXACT)) return true;
            }
        }
        return false;
    }

    public Procedure matchProcedureImplementation(String label,Param params[])
    {
        List<Procedure> l = procedureNameCache.get(label.toLowerCase());
        if (l!=null) {
            for ( Procedure p : l ) {
                if (p.matches(params,Procedure.MATCH_EXACT)) {
                    p.setLabels(params);
                    return p;
                }
            }
            
            // no exact match - try matching by looking at labels only
            boolean labelOnly=true;
            for (int scan=0;scan<params.length;scan++) {
                if (params[scan].getType()!=null) {
                    labelOnly=false;
                    break;
                }
            }
            
            // no exact match - try matching by looking at labels only
            for ( Procedure p : l ) {
                if (p.getParams().length==params.length) {
                    if (!labelOnly) {
                        log.warning("Could not match procedure ("+label+") based on typing: do length only match");
                    }
                    p.setLabels(params);
                    return p;
                }
            }
        }
        
        if (getParent()==null) return null;
        return getParent().matchProcedureImplementation(label,params);
    }
    
    public Procedure matchProcedureThisScopeOnly(String label,Expr params[])
    {
        List<Procedure> l = procedureNameCache.get(label.toLowerCase());
        if (l!=null) {
            for (int scan=Procedure.MATCH_EXACT_DEFAULTS;scan<=Procedure.MATCH_LAST;scan++) {
                for ( Procedure p : l ) {
                    if (p.matches(params,scan)) return p;
                }
            }
        }
        
        return null;
    }

    public JavaClass getJavaClass() {
        return javaClass;
    }

    public void setJavaClass(JavaClass javaClass) {
        this.javaClass = javaClass;
    }

    
    private Map<String,UseVariable> usevariables=new LinkedHashMap<String, UseVariable>();
    
    public void addUseVariable(UseVariable var) {
        usevariables.put(var.getName().toLowerCase(),var);
    }

    public UseVariable getUseVariable(String name) {
        UseVariable uv = usevariables.get(name.toLowerCase());
        if (uv!=null) return uv;
        if (getParent()!=null) return getParent().getUseVariable(name);
        return null;
    }
    
    public Iterable<UseVariable> getUseVariables()
    {
        return usevariables.values();
    }
    
    // variables from a lower scope that need to be escalated to this scope
    // using a linked hash map for purpose of rendering passed parameter lists
    // consistently. 
    private Map<String,Variable> escalatedVariables=new LinkedHashMap<String, Variable>();
    private ModuleScope escalatedModule;
    
    /**
     * 
     * @param v
     * @return true if variable is escalated. False if variable was already escalated previously
     */
    public boolean escalateVariable(Variable v) {
        
        String lookup = v.getName().toLowerCase();
        if (escalatedVariables.containsKey(lookup)) return false;

        if (v instanceof RemoteRoutineVariable) {
            Procedure p = ((RemoteRoutineVariable)v).getProcedure();
            if (p.getScope() instanceof ModuleScope) {
                if ( ! ((ModuleScope)p.getScope()).getModuleClass().isSingleFunctionModule() ) return false;
            }
        }
        
        if (v.isReference()) {
            v.escalateReference();
        }
        
        escalatedVariables.put(lookup,v);
        return true;
    }

    public boolean escalateModule(ModuleScope ms) {
        if (escalatedModule!=null) {
            return false;
        }
        escalatedModule=ms;
        return true;
    }
    
    public ModuleScope getEscalatedModule()
    {
        return escalatedModule;
    }
    
    public Iterable<Variable> getEscalatedVariables()
    {
        return escalatedVariables.values();
    }
    
    public boolean anyEscalatedVariables()
    {
        return (!escalatedVariables.isEmpty()) || (getEscalatedModule()!=null);
    }
    
    public void renderPassedEscalatedVars(StringBuilder out)
    {
        boolean first=true;
        
        if (getEscalatedModule()!=null) {
            
            Scope test=this;
            
            if (test instanceof RoutineScope) {
                test=test.getParent();
            } 
            
            if (test.getParent()==test.getEscalatedModule()) {
                out.append("this");
            } else {
                out.append("_owner");
            }
            first=false;
        }
        
        for ( Variable v : getEscalatedVariables() ) {
            if (!first) {
                out.append(",");
            } else {
                first=false;
            }
            
            out.append(v.getEscalatedJavaName(this));
        }
    }
    
    public void renderEscalatedPrototypeList(StringBuilder out,JavaDependencyCollector collector)
    {
        boolean first=true;
        
        if (getEscalatedModule()!=null) {
            out.append(getEscalatedModule().getModuleClass().getName());
            out.append(" _owner");
            getEscalatedModule().getModuleClass().collate(collector);
            first=false;
        }
        
        for ( Variable v : getEscalatedVariables() ) {
            if (!first) {
                out.append(",");
            } else {
                first=false;
            }

            if (v.isEscalatedReference()) {
                collector.add(ClarionCompiler.CLARION+".runtime.ref.RefVariable");
                out.append("RefVariable<");
            }
            v.getType().generateDefinition(out);
            if (v.isEscalatedReference()) {
                out.append(">");
            }
            out.append(' ');
            out.append(v.getEscalatedJavaName(this));
            
            v.getType().collate(collector);
        }
    }

    public ScopeSnapshot getSnapshot()
    {
        return new ScopeSnapshot(variables,procedures,types,true); 
    }

    public void mergeinSnapshot(ScopeSnapshot in)
    {
        for (Variable v : in.getVariables()) {
            addVariable(v);
        }

        for (Procedure p : in.getProcedures()) {
            addProcedure(p,false);
        }

        for (ExprType t : in.getTypes()) {
            addType(t);
        }
    }

    private Map<String,String> alias=new HashMap<String, String>();
    
    public void addAlias(String from,String to)
    {
        alias.put(from.toLowerCase(),to);
    }
    
    public String getLocalAlias(String from)
    {
        return alias.get(from.toLowerCase());
    }
    
    public String getAlias(String from)
    {
        String result = getLocalAlias(from);
        if (result!=null) {
            String a2 = getAlias(result);
            if (a2!=null) return a2;
            return result;
        }
        if (getParent()!=null) return getParent().getAlias(from);
        return null;
    }
    
    /** 
     * are we an ancestor of specified scope?
     * 
     * @param aScope
     * @return
     */
    public boolean isAncestorOf(Scope aScope)
    {
        while (aScope!=null) {
            if (aScope==this) return true;
            aScope=aScope.getParent();
        }
        return false;
    }

    public boolean isDescendantOf(Scope aScope)
    {
        if (aScope==null) return false;
        return aScope.isAncestorOf(this);
    }
    
    public abstract String getName();
    
    private Set<String> includes=new HashSet<String>();
    
    public void addInclude(String include)
    {
        includes.add(include.toLowerCase());
    }
    
    public boolean isIncludedAlready(String include)
    {
        if (includes.contains(include.toLowerCase())) return true;
        if (getParent()!=null) return getParent().isIncludedAlready(include);
        return false;
    }
}
