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

public class Print implements Runnable
{

    @Override
    public void run() 
    {
        SystemRegistry.getInstance().register(
         PatternRewriter.create(null,"cancelprint","$.cancelPrint()",ExprType.report).call()
        ,PatternRewriter.create(ExprType.rawstring,"getPDF","$.getPDF()",ExprType.report).call()
        ,PatternRewriter.create(ExprType.rawstring,"getPDF","$.getPDF($)",ExprType.report,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.rawstring,"getPDF","$.getPDF($,$)",ExprType.report,ExprType.rawint,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.rawint,"pageCount","$.getPageCount()",ExprType.report).call()
        ,PatternRewriter.create(ExprType.rawstring,"writePDF","$.writePDF()",ExprType.report).call() // %%%%% attempt to store pdf.
        ,PatternRewriter.create(ExprType.rawstring,"previewPDF","$.previewPDF()",ExprType.report).call() // %%%%% attempt to preview pdf.
        );
    }
}
