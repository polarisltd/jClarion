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
package org.jclarion.clarion.runtime.expr;

import java.sql.Types;
import java.util.Iterator;
import java.util.List;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ObjectBindProcedure;
import org.jclarion.clarion.runtime.SQLBindProcedure;
import org.jclarion.clarion.runtime.ViewObjectBindProcedure;

public class LabelExpr extends CExpr {

    private String name;
    private CExpr params[];
    
    public LabelExpr(String name)
    {
        this.name=name;
    }

    public String getName()
    {
        return name;
    }
    
    public LabelExpr(String name,List<CExpr> params)
    {
        this.name=name;
        if (params!=null) {
        	this.params=new CExpr[params.size()];
        	params.toArray(this.params);
        }
    }

    private LabelExprResult resolveProcedure(CExprScope scope)
    {
        return scope.resolveBind(name,params!=null);
    }

    public CExpr[] getParams()
    {
    	return params;
    }
    
    @Override
    public ClarionObject eval(CExprScope scope) {
    	LabelExprResult bp = resolveProcedure(scope);
        if (bp==null) {
        	throw new NullPointerException("Cannot find bind:"+bp);
        }
        return bp.execute(scope,params);
    }

    @Override
    public int precendence() {
        return 9;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return new ZeroIterator();
    }
    
    public boolean generateString(CExprScope scope,StringBuilder out, boolean strict) {

        LabelExprResult bp = resolveProcedure(scope);
        
        if (bp instanceof ViewObjectBindProcedure) {
            ViewObjectBindProcedure vobp=(ViewObjectBindProcedure)bp;
            out.append(vobp.sqlColumn);
            return true;
        }

        if (bp instanceof ObjectBindProcedure) {
            ClarionObject o = eval(scope);
            
            if (type!=null) {
                if (type==CExprType.STRING) {
                    ClarionSQLFile.encodeValue(out,o,java.sql.Types.VARCHAR);
                    return true;
                }

                if (type==CExprType.NUMERIC) {
                    ClarionSQLFile.encodeValue(out,o,java.sql.Types.BIGINT);
                    return true;
                }

                if (type==CExprType.DECIMAL) {
                    ClarionSQLFile.encodeValue(out,o,java.sql.Types.DECIMAL);
                    return true;
                }

                if (type==CExprType.DATE) {
                    ClarionSQLFile.encodeValue(out,o,java.sql.Types.DATE);
                    return true;
                }

                if (type==CExprType.TIME) {
                    ClarionSQLFile.encodeValue(out,o,java.sql.Types.TIME);
                    return true;
                }

                if (type==CExprType.BOOL) {
                    ClarionSQLFile.encodeValue(out,o,java.sql.Types.BOOLEAN);
                    return true;
                }
            }
        
            if (o instanceof ClarionString) {
                ClarionSQLFile.encodeValue(out,o,java.sql.Types.VARCHAR);
                return true;
            }

            if (o instanceof ClarionNumber) {
                ClarionSQLFile.encodeValue(out,o,java.sql.Types.BIGINT);
                return true;
            }

            if (o instanceof ClarionDecimal) {
                ClarionSQLFile.encodeValue(out,o,java.sql.Types.DECIMAL);
                return true;
            }
        }

        if (bp instanceof SQLBindProcedure) {
            SQLBindProcedure sbp = (SQLBindProcedure)bp;
            
            CExpr r[];
            if (params==null) {
                r=new CExpr[0];
            } else {
                r=params;
            }
            if (sbp.generateString(scope,out,strict,r)) return true;
        }

        if (strict) return false;
        out.append("?");
        return true;
    }

    private CExprType type;


    @Override
    public void cast(CExprScope scope,CExprType type) {
    	LabelExprResult bp = resolveProcedure(scope);
    	if (bp instanceof ViewObjectBindProcedure) {
    	      throw new RuntimeException("Label casting not yet supported");
    	}    	
        this.type=type;
    }
    
    @Override
    public CExprType getType(CExprScope scope) {
        if (type!=null) return type;
        
        LabelExprResult bp = resolveProcedure(scope);

        if (bp instanceof SQLBindProcedure) {
            return ((SQLBindProcedure)bp).getReturnType();
        }

        int sqlType=-1;
        
        if (bp instanceof ViewObjectBindProcedure) {
            sqlType=((ViewObjectBindProcedure)bp).sqlType;
        }

        
        ClarionObject obj=null;
        if (sqlType==-1) {
            obj = eval(scope);
            if (obj.getOwner() instanceof ClarionFile) {
                sqlType = ((ClarionFile)obj.getOwner()).getSQLType(obj);
            }
        }
        
        switch (sqlType) {
            case Types.VARCHAR:
            case Types.VARBINARY:
                return CExprType.STRING;
            case Types.BIGINT:
                return CExprType.NUMERIC;
            case Types.DECIMAL:
                return CExprType.DECIMAL;
            case Types.DATE:
                return CExprType.DATE;
            case Types.TIME:
                return CExprType.TIME;
            case Types.BOOLEAN:
            case Types.BIT:
                return CExprType.BOOL;
        }

        if (obj==null) obj=eval(scope);
        
        if (obj instanceof ClarionNumber) return CExprType.NUMERIC;
        if (obj instanceof ClarionDecimal) return CExprType.DECIMAL;
        return CExprType.STRING;
    }

    @Override
    public boolean isRecastableType(CExprScope scope) {
    	LabelExprResult bp = resolveProcedure(scope);
        if (bp instanceof ViewObjectBindProcedure) return false;
        if (bp instanceof SQLBindProcedure) return false;
        return true;
    }
    
}
