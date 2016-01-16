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

import java.util.Set;

import org.jclarion.clarion.compile.SystemRegistry;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.Variable;

public class CallExpr extends Expr
{
    private Procedure procedure;
    private Expr      paramList;
    private Expr      params[];
    private Expr      _left;
    private boolean   permitAlternative;
    
    public CallExpr(Expr left,Procedure p,boolean permitAlternative,Expr[] params)
    {
        super(JavaPrec.LABEL,p.getResult()!=null?p.getResult().getType():null);
        this.permitAlternative=permitAlternative;
        this.procedure=p;
        this._left=left;
        this.params=params;
        
        //
        p.setCalled();
        
        // params
        Param input[] = procedure.getParams();
        
        int opt_count=0;
        for (int scan=0;scan<input.length;scan++) {
            if (input[scan].isOptional()) opt_count++;
        }
        int missing_count=input.length-params.length;

        int expr_pos=0; 
        for (int input_pos=0;input_pos<input.length;input_pos++) {
            
            Param in = input[input_pos];
            
            if (in.isOptional()) opt_count--;
            if (opt_count<missing_count) {
                missing_count--;
                continue;
            }

            // hardwire in defaults
            if (params[expr_pos] instanceof NullExpr) {
                if (in.getDefaultValue()!=null) {
                    params[expr_pos]=in.getDefaultValue();
                }
            }
            
            params[expr_pos]=params[expr_pos].cast(in.getType());
            
            if ( (params[expr_pos] instanceof VariableExpr) 
               && !in.isPassByReference() 
               && in.getType().isa(ExprType.any)) {
                params[expr_pos]=new DecoratedExpr(JavaPrec.POSTFIX,params[expr_pos].wrap(JavaPrec.POSTFIX),".like()");
            }
            
            expr_pos++;
        }
        
        if (params.length==0) {
            paramList=null;
        } else {
            if (params.length>input.length) {
                Expr new_params[]=new Expr[input.length];
                System.arraycopy(params,0,new_params,0,new_params.length);
                params=new_params;
            }
            paramList=new ListExpr(JavaPrec.LABEL,null,false,",",params);
        }
    }
    
    public Expr getLeft()
    {
        return _left;
    }

    @Override
    public void toJavaString(StringBuilder target) 
    {
        if (needSystemAlternative()) {
            generateSystemAlternative();
            if (systemAlternative!=null) {
                systemAlternative.toJavaString(target);
                return;
            }
        }
        
        if (getLeft()!=null) getLeft().toJavaString(target);
        if (procedure.isNoRelabel()) {
            target.append(procedure.getName());
        } else {
            target.append(Labeller.get(procedure.getName(),false));
        }
        target.append('(');
        if (paramList!=null) paramList.toJavaString(target);
        target.append(')');
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        if (needSystemAlternative()) {
            generateSystemAlternative();
            if (systemAlternative!=null) {
                systemAlternative.collate(collector);
                return;
            }
        }
        
        if (getLeft()!=null) getLeft().collate(collector);
        if (paramList!=null) paramList.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        if (getLeft()!=null && getLeft().utilises(vars)) return true;
        if (paramList!=null && paramList.utilises(vars)) return true;
        return false;
    }
    
    public boolean utilisesReferenceVariables()
    {
        if (getLeft()!=null && getLeft().utilisesReferenceVariables()) return true;
        if (paramList!=null && paramList.utilisesReferenceVariables()) return true;
        return false;
    }

    private Expr systemAlternative;
    private boolean getSystemAlternative;
    
    private void generateSystemAlternative()
    {
        if (getSystemAlternative) return;
        getSystemAlternative=true;
        systemAlternative=SystemRegistry.getInstance().call(procedure.getName(),params);
    }

    private boolean needSystemAlternative()
    {
        return (permitAlternative && procedure.getCode()==null);
    }
    
}
