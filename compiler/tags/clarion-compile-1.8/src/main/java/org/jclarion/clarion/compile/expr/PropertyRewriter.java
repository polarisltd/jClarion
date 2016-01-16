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

import org.jclarion.clarion.compile.rewrite.PatternRewriter;
import org.jclarion.clarion.compile.rewrite.RewriteFactory;

public class PropertyRewriter 
{
    private static PropertyRewriter instance;
    
    public static PropertyRewriter getInstance()
    {
        if (instance==null) instance=new PropertyRewriter();
        return instance;
    }

    private RewriteFactory factory;
    
    public PropertyRewriter()
    {
        factory=new RewriteFactory();
        
        factory.add(
            PatternRewriter.create(ExprType.key,"prop.key", ":1.getKey(:3)",ExprType.file,ExprType.rawint),
            PatternRewriter.create(ExprType.target,"prop.target", ":1.getTarget()",ExprType.bean,ExprType.rawint).exact(2),
            PatternRewriter.create(ExprType.file,"prop.file", ":1.getFile(:3)",ExprType.view,ExprType.rawint)
        );
    }
    
    public Expr rewrite(Expr left,Expr params[])
    {
        String name = params[0].toJavaString();
        
        if (factory.get(name)==null) return null;
        
        Expr test[] = new Expr[params.length+1];
        test[0]=left;
        System.arraycopy(params,0,test,1,params.length);
        
        return factory.rewrite(name,test);
    }
}
