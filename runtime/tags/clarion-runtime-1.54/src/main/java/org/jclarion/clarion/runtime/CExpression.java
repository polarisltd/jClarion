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

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

public class CExpression {

    public static ClarionString evaluate(String aString)
    {
        return CExprImpl.getInstance().evaluate(aString);
    }
    
    public static void pushBind()
    {
        pushBind(false);
    }

    public static void pushBind(boolean keep)
    {
        CExprImpl.getInstance().pushBind(keep);
    }

    public static void popBind()
    {
        CExprImpl.getInstance().popBind();
    }

    public static void bind(String name,BindProcedure procedure)
    {
        CExprImpl.getInstance().bind(name,procedure);
    }

    public static void bind(String name,ClarionObject object)
    {
        CExprImpl.getInstance().bind(name,object);
    }

    public static void bind(ClarionGroup group)
    {
        CExprImpl.getInstance().bind(group);
    }

    public static void unbind(String name)
    {
        CExprImpl.getInstance().unbind(name);
    }

    public static void unbind(ClarionGroup group)
    {
        CExprImpl.getInstance().unbind(group);
    }
}
