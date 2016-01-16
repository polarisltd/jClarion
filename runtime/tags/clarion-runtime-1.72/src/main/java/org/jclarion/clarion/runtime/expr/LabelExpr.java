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

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExprImpl;
import org.jclarion.clarion.runtime.ObjectBindProcedure;
import org.jclarion.clarion.runtime.SQLBindProcedure;
import org.jclarion.clarion.runtime.ViewObjectBindProcedure;

public class LabelExpr extends CExpr {

    private String name;
    private List<CExpr> params;
    
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
        this.params=params;
    }

    private BindProcedure resolveProcedure()
    {
        return CExprImpl.getInstance().resolveBind(name,params!=null);
    }
    
    @Override
    public ClarionObject eval() {
        
        ClarionString r[];
        if (params==null) {
            r=new ClarionString[0];
        } else {
            r=new ClarionString[params.size()];
            int scan=0;
            for ( CExpr param : params ) {
                r[scan++]=param.eval().getString();
            }
        }
        
        ClarionObject co = resolveProcedure().execute(r);
        if (co==null) return new ClarionBool(false);
        return co;
    }

    @Override
    public int precendence() {
        return 9;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return new ZeroIterator();
    }
    
    public boolean generateString(StringBuilder out, boolean strict) {

        BindProcedure bp = resolveProcedure();
        
        if (bp instanceof ViewObjectBindProcedure) {
            ViewObjectBindProcedure vobp=(ViewObjectBindProcedure)bp;
            out.append(vobp.sqlColumn);
            return true;
        }

        if (bp instanceof ObjectBindProcedure) {
            ClarionObject o = eval();
            
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
                r=new CExpr[params.size()];
                params.toArray(r);
            }
            if (sbp.generateString(out,strict,r)) return true;
        }

        if (strict) return false;
        out.append("?");
        return true;
    }

    private CExprType type;


    @Override
    public void cast(CExprType type) {
        BindProcedure bp = resolveProcedure();
        if (bp instanceof ViewObjectBindProcedure) {
            throw new RuntimeException("Label casting not yet supported");
        }
        this.type=type;
    }
    
    @Override
    public CExprType getType() {
        if (type!=null) return type;
        
        BindProcedure bp = resolveProcedure();

        if (bp instanceof SQLBindProcedure) {
            return ((SQLBindProcedure)bp).getReturnType();
        }

        int sqlType=-1;
        
        if (bp instanceof ViewObjectBindProcedure) {
            sqlType=((ViewObjectBindProcedure)bp).sqlType;
        }

        
        ClarionObject obj=null;
        if (sqlType==-1) {
            obj = eval();
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
        }

        if (obj==null) obj=eval();
        
        if (obj instanceof ClarionNumber) return CExprType.NUMERIC;
        if (obj instanceof ClarionDecimal) return CExprType.DECIMAL;
        return CExprType.STRING;
    }

    @Override
    public boolean isRecastableType() {
        BindProcedure bp = resolveProcedure();
        if (bp instanceof ViewObjectBindProcedure) return false;
        if (bp instanceof SQLBindProcedure) return false;
        return true;
    }
    
}
