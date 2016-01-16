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
package org.jclarion.clarion.compile.ext;

import org.jclarion.clarion.compile.SystemRegistry;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.rewrite.PatternRewriter;

public class Crash implements Runnable
{

    @Override
    public void run() 
    {
        SystemRegistry.getInstance().register(
          PatternRewriter.create(null,"crashlog","Crash.getInstance().log($)",ExprType.rawstring).call().rt("crash.Crash")
         ,PatternRewriter.create(null,"crash","Crash.getInstance().crash()").call().rt("crash.Crash")
        );
    }
}
