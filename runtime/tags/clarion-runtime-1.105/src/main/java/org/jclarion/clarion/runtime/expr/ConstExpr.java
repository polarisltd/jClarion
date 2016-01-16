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

import java.util.Iterator;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.lang.Constant;

public class ConstExpr extends CExpr 
{
    public static ConstExpr string(String val)
    {
        // simplistic one for now. Will do formal implementation later
        // if required. See Clarion::Constant::string() perl module
        // for reference implementation
        val=val.substring(1,val.length()-1);
        val = Constant.string(val,false);
        
        return new ConstExpr(new ClarionString(val));
    }
    
    private ClarionObject obj;
    private CExprType     type;
    
    public ConstExpr(ClarionObject obj)
    {
        this.obj=obj;
        type=CExprType.STRING;
        if (obj instanceof ClarionNumber) type=CExprType.NUMERIC;
        if (obj instanceof ClarionDecimal) type=CExprType.DECIMAL;
    }

    @Override
    public ClarionObject eval() {
        return obj;
    }

    @Override
    public int precendence() {
        return 9;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return new ZeroIterator();
    }

    @Override
    public boolean generateString(StringBuilder out, boolean strict) {
        
        ClarionObject o = eval();

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

        if (strict) return false;
        out.append("?");
        return true;
    }

    @Override
    public void cast(CExprType type) {
        this.type=type;
    }

    @Override
    public CExprType getType() {
        return type;
    }

    @Override
    public boolean isRecastableType() {
        return true;
    }
}
