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
package org.jclarion.clarion.compile.prototype;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.ReturningExpr;
import org.jclarion.clarion.compile.java.DependentJavaCode;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.java.RoutineCallJavaCode;
import org.jclarion.clarion.compile.scope.InterfaceMethodScope;
import org.jclarion.clarion.compile.scope.MethodScope;
import org.jclarion.clarion.compile.scope.ProcedureScope;
import org.jclarion.clarion.compile.scope.RemoteRoutineScope;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.var.ClassConstruct;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.InterfaceImplementationConstruct;
import org.jclarion.clarion.compile.var.RemoteRoutineVariable;
import org.jclarion.clarion.compile.var.Variable;

public class Procedure {
    private String      name;
    private ReturningExpr    result; // if null result is void
    private Param[]     params;
    
    private String      extname;
    private Set<String> modifiers;
    
    private Scope       scope;
    
    private ProcedureScope  implementationScope;

    private boolean     noRelabel;
    
    public Procedure(String name,ReturningExpr result,Param[] params)
    {
        this.name=name;
        this.result=result;
        this.params=params;
    }

    public Procedure(String name,Param[] params)
    {
        this.name=name;
        this.params=params;
    }
    
    public String getName() {
        return name;
    }
    public ReturningExpr getResult() {
        return result;
    }
    
    public Param[] getParams() {
        return params;
    }
    
    public void setResult(ReturningExpr type)
    {
        this.result=type;
    }

    public void setExternalName(String name)
    {
        this.extname=name;
    }

    public String getExternalName()
    {
        return this.extname;
    }
    
    public void setModifier(String mod)
    {
        if (modifiers==null) modifiers=new HashSet<String>();
        modifiers.add(mod.toLowerCase());
    }
    
    public boolean isModifierSet(String mod)
    {
        if (modifiers==null) return false;
        return modifiers.contains(mod.toLowerCase());
    }
    
    public int getModifierCount()
    {
        if (modifiers==null) return 0;
        return modifiers.size();
    }
    
    public static final int MATCH_EXACT=1;
    public static final int MATCH_EXACT_DEFAULTS=2;
    public static final int MATCH_DERIVABLE=3;
    public static final int MATCH_CASTABLE=4;
    
    public boolean matches(Procedure test,int mode)
    {
        return matches(new ParamExprTypeIterator(test.getParams()),
                test.getParams().length,mode);
    }

    public boolean matches(Param in[],int mode)
    {
        return matches(new ParamExprTypeIterator(in),in.length,mode);
    }

    public boolean matches(ExprType in[],int mode)
    {
        return matches(new ExprTypeIterator(in),in.length,mode);
    }
    
    
    public boolean matches(Expr in[],int mode)
    {
        return matches(new ExprExprTypeIterator(in),in.length,mode);
    }
    
    public boolean matches(Iterator<ExprType> test,int testLength,int mode)
    {
        // will never match
        if (testLength>this.params.length) return false;

        // only match differing param counts if not exact
        if (testLength<this.params.length && mode==MATCH_EXACT) return false;
        
        int opt_count=0;
        for (int scan=0;scan<params.length;scan++) {
            if (params[scan].isOptional()) opt_count++;
        }
        
        int missing_params = this.params.length-testLength;
        // too many missing params
        if (missing_params>opt_count) return false;
        
        for (int scan=0;scan<params.length;scan++) {
            
            if (params[scan].isOptional()) {
                opt_count--;
                if (opt_count<missing_params) {
                    missing_params--;
                    continue;
                }
            }
            
            if (!test.hasNext()) throw new IllegalStateException("Did not expect this");
            ExprType t = test.next();
            if (t==null) {
                // implementation type match.
                continue;
            }
            
            if (mode<=MATCH_EXACT_DEFAULTS) {
                if (!params[scan].getType().same(t)) return false;
            }
            
            if (mode==MATCH_DERIVABLE) {
                if (!t.isa(params[scan].getType())) return false;
            }

            if (mode==MATCH_CASTABLE) {
                if (!t.isa(params[scan].getType())) {
                    
                    // special exemption - group can be cast to string
                    if (params[scan].getType().isa(ExprType.string)) {
                        if (t.isa(ExprType.group)) continue;
                    }

                    if (!t.isRaw() && !t.isa(ExprType.any)) return false;
                    
                    if (!params[scan].getType().isa(ExprType.any)) return false;
                }
            }
        }
        if (test.hasNext()) throw new IllegalStateException("Did not expect this");
        
        return true;
    }
    
    private JavaCode code;
    
    public JavaCode getCode()
    {
        return code;
    }
    
    private boolean called;
    
    private boolean isAbstract;
    
    public void setCalled()
    {
        this.called=true;
    }
    
    public void setAbstract()
    {
        this.isAbstract=true;
    }
    
    public void setCode(JavaCode code)
    {
        this.code=code;
    }
    
    public boolean isStatic;

    public boolean isStatic()
    {
        return isStatic;
    }
    
    public void setStatic()
    {
        isStatic=true;
    }
    
    public void write(StringBuilder main, JavaDependencyCollector collector) 
    {
        write("\t",main,collector);
    }
        // write optionals
        
     public void write(String indent,StringBuilder main, JavaDependencyCollector collector) 
     {
        if (!called && getCode()==null && !isAbstract) return; 
        
        int opt_count=0;
        for (int scan=0;scan<params.length;scan++) {
            if (params[scan].isOptional()) opt_count++;
        }

        if (opt_count>0) {
            StringBuilder prefix=new StringBuilder();
            String label = Labeller.get(getName(),false); 
            
            prefix.append(indent);
            prefix.append("public ");
            if (isStatic()) {
                prefix.append("static ");
            }
            
            if (getResult()!=null) {
                getResult().getType().generateDefinition(prefix);
                prefix.append(' ');
            } else {
                prefix.append("void ");
            }
            prefix.append(label);
            prefix.append('(');

            int skip=0;
            
            for (int oscan=opt_count-1;oscan>=0;oscan--) {
                
                int oWrite;
                
                Param[] p = getParams();
                
                Param[] clashTest = new Param[p.length-opt_count+oscan];
                int clashPos=0;
                oWrite=oscan;
                for (int scan=0;scan<p.length;scan++) {
                    if (p[scan].isOptional()) {
                        oWrite--;
                        if (oWrite<0) continue;
                    }
                    clashTest[clashPos++]=p[scan];
                }

                if (getScope().isClashingProcedure(getName(),clashTest)) {
                    skip++;
                    continue;
                }

                main.append(prefix);
                
                oWrite=oscan;
                boolean any=false;
                for (int scan=0;scan<p.length;scan++) {
                    if (p[scan].isOptional()) {
                        oWrite--;
                        if (oWrite<0) continue;
                    }
                    if (any) {
                        main.append(',');
                    } else {
                        any=true;
                    }
                
                    p[scan].getType().generateDefinition(main);
                    main.append(' ');
                    main.append("p");
                    main.append(scan);
                }

                main.append(")\n");
                main.append(indent);
                main.append("{\n");
                
                main.append(indent);
                main.append("\t");
                
                if (getResult()!=null) {
                    main.append("return ");
                }
                
                main.append(label);
                main.append('(');
                
                oWrite=oscan+skip;
                any=false;

                for (int scan=0;scan<p.length;scan++) {
                    if (p[scan].isOptional()) {
                        oWrite--;
                        if (oWrite>=-1 && oWrite<=-1+skip) {
                            if (any) {
                                main.append(',');
                            } else {
                                any=true;
                            }
                            
                            if (p[scan].getDefaultValue()==null) {
                                main.append("(");
                                p[scan].getType().generateDefinition(main);
                                main.append(")null");
                            } else {
                                p[scan].getDefaultValue().toJavaString(main);
                                p[scan].getDefaultValue().collate(collector);
                            }
                        }
                        if (oWrite-skip<0) continue;
                    }
                    if (any) {
                        main.append(',');
                    } else {
                        any=true;
                    }
                    main.append("p");
                    main.append(scan);
                }
                main.append(");\n");
                
                main.append(indent);
                main.append("}\n");
                
                skip=0;
            }
            
        }
        
        main.append(indent);
        main.append("public ");
        if (isAbstract) {
            main.append("abstract ");
        }
        if (isStatic()) {
            main.append("static ");
        }
        
        if (getResult()!=null) {
            getResult().getType().generateDefinition(main);
            getResult().getType().collate(collector);
            main.append(' ');
        } else {
            main.append("void ");
        }
        main.append(Labeller.get(getName(),false));
        main.append('(');
        
        Param[] p = getParams();
        for (int scan=0;scan<p.length;scan++) {
            if (scan>0) {
                main.append(',');
            }
            
            p[scan].getType().generateDefinition(main);
            p[scan].getType().collate(collector);
            
            main.append(' ');
            
            if (p[scan].getName()==null) p[scan].setName("_p"+scan);
            
            main.append(Labeller.get(p[scan].getName(),false));
        }
        
        if (isAbstract) {
            main.append(");\n");
            return;
        }
        
        main.append(")\n");
        main.append(indent);
        main.append("{\n");

        if (!suppressConstructFields) {        
            for (Variable var : getImplementationScope().getVariables()) {
                if (var instanceof EquateVariable) continue;
                main.append(indent);
                main.append("\t");
                var.generateInitCapable(main);
                var.collate(collector);
                main.append(";\n");
            }

            for (Variable var : getImplementationScope().getVariables()) {
                if (var instanceof EquateVariable) continue;
                if (var.isInitConstructionMode()) {
                    var.generateInit("\t\t",main,collector);
                }
            }
            
        } else {
            for (int scan=0;scan<params.length;scan++) {
                String l = Labeller.get(params[scan].getName(),false);
                main.append(indent);
                main.append("\tthis.");
                main.append(l);
                main.append("=");
                main.append(l);
                main.append(";\n");
            }
            
            for (Variable var : getImplementationScope().getVariables()) {
                if (var instanceof EquateVariable) continue;
                if (var.isInitConstructionMode()) {
                    var.generateInit("\t\t",main,collector);
                }
            }
        }
        
        if (getCode()!=null) {
            getCode().write(main,indent.length()+1,false);
            getCode().collate(collector);
        } else {
            main.append(indent);
            main.append("\tthrow new RuntimeException(\"Procedure/Method not defined\");\n");
        }
        main.append(indent);
        main.append("}\n");
        
        
        // write routines

        writeRoutines(indent,main,collector);
     }

     public Iterable<RoutineScope> getUndefinedRoutines()
     {
         List<RoutineScope> l=new ArrayList<RoutineScope>();
         
         for ( RoutineScope rs : getRoutines() ) {
             if (rs.getCode()==null) {
                 l.add(rs);
             }
         }
         return l;
     }
     
     private void writeRoutines(String indent, StringBuilder main,
            JavaDependencyCollector collector) {
         
         for ( RoutineScope rs : getRoutines() ) {
             main.append(indent);
             if (isStatic()) {
                 main.append("public static void ");
             } else {
                 main.append("public void ");
             }
             main.append(rs.getName());
             main.append("(");
             rs.renderEscalatedPrototypeList(main,collector);
             main.append(")");
             if (rs.mayReturnToProcedure()) {
                 main.append(" throws ClarionRoutineResult\n");
                 collector.add(ClarionCompiler.CLARION+".ClarionRoutineResult");
             } else {
                 main.append("\n");
             }
             main.append(indent);
             main.append("{\n");
             
             for (Variable var : rs.getVariables()) {
                 if (var instanceof EquateVariable) continue;
                 main.append(indent);
                 main.append("\t");
                 var.generate(main);
                 var.collate(collector);
                 main.append(";\n");
             }
             
             if (rs.getCode()!=null) {
                 rs.getCode().write(main,indent.length()+1,false);
                 rs.getCode().collate(collector);
             }
             
             main.append(indent);
             main.append("}\n");
         }
    }

    public Scope getScope() {
        return scope;
    }

    public void setScope(Scope scope) {
        if (this.scope==null) {
            this.scope = scope;
        }
    }

    public void setLabels(Param[] params2) {
        // TODO Auto-generated method stub
        for (int scan=0;scan<params2.length;scan++) {
            params[scan].setName(params2[scan].getName());
        }
        
    }

    public ProcedureScope getImplementationScope() {

        if (implementationScope==null) {
            
            // want to work out whether or not we want to ensure that
            // resultant scope object yielded here is to have a 
            // different 'scope stack' in order to inherit procedure
            // scope stack where it was originally defined

            ProcedureScope origin = null;
            if (getScope().getParent()!=null && (getScope().getParent() instanceof ProcedureScope)) {
                origin = (ProcedureScope)getScope().getParent(); 
            }
        
            if (implementationScope==null) {
                if (getScope() instanceof ClassConstruct) {
                    implementationScope = new MethodScope(this,(ClassConstruct)getScope());
                }
            }

            if (implementationScope==null) {
                if (getScope() instanceof InterfaceImplementationConstruct) {
                    implementationScope = new InterfaceMethodScope(this,(InterfaceImplementationConstruct)getScope());
                }
            }
        
            if (implementationScope==null) {
                implementationScope = new ProcedureScope(this);
            }
            
            implementationScope.setOrigin(origin);
        }
        
        return implementationScope;
    }

    public void setImplementationScope(ProcedureScope implementationScope) {
        this.implementationScope = implementationScope;
    }
    
    public String toString()
    {
        StringBuilder result = new StringBuilder();
        result.append("PROC(");
        result.append(getName());
        for (int scan=0;scan<params.length;scan++) {
            result.append(' ');
            result.append(params[scan].getType().getName());
        }
        
        result.append(")");
        return result.toString();
    }

    public boolean isAbstract() {
        return isAbstract;
    }
    
    private Map<String,RoutineScope> routines = new HashMap<String, RoutineScope>();
 
    public RoutineScope getRoutine(String name)
    {
        String lookup=name.toLowerCase();
        
        RoutineScope rs = routines.get(lookup);
        
        if (rs==null) {
            Scope scan = ScopeStack.getScope();
            if (scan instanceof RoutineScope) scan=scan.getParent();
            while (scan instanceof ProcedureScope) {
                
                ProcedureScope ps_scan = (ProcedureScope)scan;
                Procedure p = ps_scan.getProcedure();
                RoutineScope p_rs = p.routines.get(lookup);
                
                if (p_rs!=null) {

                    rs=new RemoteRoutineScope(Labeller.get(getName()+"_"+name,false),getImplementationScope(),p_rs);
                    routines.put(lookup,rs);

                    Variable v = new RemoteRoutineVariable(p);
                    if (rs.escalateVariable(v)) {
                        rs.setCode(new RoutineCallJavaCode(v.getJavaName()+".",p_rs,false));
                    } else {
                        JavaCode jc = new RoutineCallJavaCode(p.getScope().getJavaClass().getName()+".",p_rs,false);
                        jc=new DependentJavaCode(jc,p.getScope().getJavaClass());
                        rs.setCode(jc);
                    }

                    scan = ScopeStack.getScope();
                    while (scan!=ps_scan) {
                        if (!scan.escalateVariable(v)) break;
                        scan=scan.getParent();
                    }
                    
                    for ( Variable rv : p_rs.getEscalatedVariables() ) {

                        rs.escalateVariable(rv);
                    
                        scan = ScopeStack.getScope();
                        while (scan!=ps_scan) {
                            if (!scan.escalateVariable(rv)) break;
                            scan=scan.getParent();
                        }

                    }
                    
                    break;
                }
                scan=scan.getParent();
            }
        }
        
        if (rs==null) {
            rs=new RoutineScope(Labeller.get(getName()+"_"+name,false),getImplementationScope());
            routines.put(lookup,rs);
        }
        return rs;
    }
    
    public Iterable<RoutineScope> getRoutines()
    {
        return routines.values();
    }

    private boolean suppressConstructFields;
    public void suppressConstructFields() {
        suppressConstructFields=true;
    }

    public boolean isNoRelabel() {
        return noRelabel;
    }

    public void setNoRelabel(boolean noRelabel) {
        this.noRelabel = noRelabel;
    }
}
